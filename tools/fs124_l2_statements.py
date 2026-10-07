#!/usr/bin/env python3
"""FS124-L2: "no statement and no definition changed", from the kernel's side.

Reads two dumps made by `data/fs124/l2/StatementDump.lean` (or by FS124-I4's dumper, whose line format it keeps) —
every constant of a module's compiled data with its stored type, a definition's stored value, and for a
decomposition given as data its three data fields — and compares them constant by constant.

  fs124_l2_statements.py compact RAW            print one line per constant: KIND NAME [INTERNAL] TYPE=<sha256 of the
                                                raw stored type> VALUE=<sha256|-> DATA=<sha256|->, under its module
  fs124_l2_statements.py diff BEFORE AFTER [--modules M1,M2,…] [--plant]
        BEFORE and AFTER are raw or compact dumps.  Compared, for every constant that is not INTERNAL (a name Lean
        generates inside a declaration — `_proof_n`, `match_n` — moves with a proof and is not a statement), in the
        modules both dumps hold (or those named):
          LOST / NEW      the two dumps hold the same named constants
          KIND            … of the same kind
          TYPE            … with the same stored type (a theorem's statement; a definition's signature)
          VALUE           a definition's stored value is the same — or, for a decomposition given as data, whose
                          value holds proofs as fields, its three DATA fields are
        Exit 0 when nothing differs, 1 otherwise.  With --plant: four differences are planted in memory, one at a
        time (a type changed, a definition's value changed, a constant dropped, a constant added), each required to
        be reported by its check; the unplanted pair must pass first.  Exit 0 means every plant fired.
"""
import hashlib
import sys


def sha(s):
    return hashlib.sha256(s.encode("utf-8")).hexdigest()[:24]


def read(path):
    """{module: {name: (kind, internal, type, value, data)}} from a raw or a compact dump."""
    out, mod, cur = {}, None, None
    for ln in open(path, encoding="utf-8"):
        ln = ln.rstrip("\n")
        if ln.startswith("## MODULE "):
            mod = ln.split()[2]
            out[mod] = {}
        elif ln.startswith("@@ "):
            p = ln.split()
            cur = [p[1], len(p) > 3 and p[3] == "INTERNAL", "-", "-", "-"]
            out[mod][p[2]] = cur
        elif ln.startswith("TYPE "):
            cur[2] = sha(ln.split(" ", 2)[2])
        elif ln.startswith("VALUE "):
            cur[3] = sha(ln.split(" ", 2)[2])
        elif ln.startswith("DATA "):
            cur[4] = sha(ln.split(" ", 4)[4])
        elif ln.startswith("C "):  # a compact line
            p = ln.split()
            f = dict(x.split("=", 1) for x in p[3:] if "=" in x)
            out[mod][p[2]] = [p[1], "INTERNAL" in p[3:], f["TYPE"], f["VALUE"], f["DATA"]]
    return out


def compact(d):
    for mod, cs in d.items():
        print(f"## MODULE {mod} constants={len(cs)}")
        for n, (k, internal, t, v, da) in cs.items():
            print(f"C {k} {n}{' INTERNAL' if internal else ''} TYPE={t} VALUE={v} DATA={da}")


def diff(a, b, modules):
    bad, n = [], 0
    for mod in modules:
        if mod not in a or mod not in b:
            bad.append(f"MODULE {mod}: absent from {'the first' if mod not in a else 'the second'} dump")
            continue
        ca = {x: y for x, y in a[mod].items() if not y[1]}
        cb = {x: y for x, y in b[mod].items() if not y[1]}
        for x in sorted(set(ca) - set(cb)):
            bad.append(f"LOST {ca[x][0]} {x} ({mod})")
        for x in sorted(set(cb) - set(ca)):
            bad.append(f"NEW {cb[x][0]} {x} ({mod})")
        for x in sorted(set(ca) & set(cb)):
            n += 1
            ka, _, ta, va, da = ca[x]
            kb, _, tb, vb, db = cb[x]
            if ka != kb:
                bad.append(f"KIND {x}: {ka} -> {kb}")
            if ta != tb:
                bad.append(f"TYPE {x}: the stored type differs")
            if ka == "DEF" and kb == "DEF":
                if da != "-" or db != "-":
                    if da != db:
                        bad.append(f"VALUE {x}: the data fields of the decomposition differ")
                elif va != vb:
                    bad.append(f"VALUE {x}: the stored value differs")
    return bad, n


def plants(a, b, modules):
    import copy
    mod = modules[0]
    names = [x for x, y in b[mod].items() if not y[1]]
    thm = next(x for x in names if b[mod][x][0] == "THM")
    dfn = next((x for m in modules for x, y in b[m].items() if y[0] == "DEF" and not y[1] and y[4] == "-"), None)
    dmod = next(m for m in modules if dfn in b[m])
    out = []
    p = copy.deepcopy(b); p[mod][thm][2] = sha("planted"); out.append((f"a theorem's stored type changed ({thm})", "TYPE " + thm, p))
    p = copy.deepcopy(b); p[dmod][dfn][3] = sha("planted"); out.append((f"a definition's stored value changed ({dfn})", "VALUE " + dfn, p))
    p = copy.deepcopy(b); del p[mod][thm]; out.append((f"a constant dropped ({thm})", "LOST THM " + thm, p))
    p = copy.deepcopy(b); p[mod]["zz.planted"] = ["THM", False, sha("x"), "-", "-"]; out.append(("a constant added (zz.planted)", "NEW THM zz.planted", p))
    return out


def main(argv):
    if len(argv) >= 2 and argv[0] == "compact":
        compact(read(argv[1]))
        return 0
    if len(argv) >= 3 and argv[0] == "diff":
        a, b = read(argv[1]), read(argv[2])
        modules = None
        for i, x in enumerate(argv):
            if x == "--modules":
                modules = ["Proofs.HadwigerNelson.Plane." + m for m in argv[i + 1].split(",")]
        if modules is None:
            modules = [m for m in a if m in b]
        if not modules:
            print("UNREADABLE: the two dumps share no module")
            return 2
        bad, n = diff(a, b, modules)
        if "--plant" in argv:
            if bad:
                print(f"PLANT NOT RUN: the unplanted pair already differs ({len(bad)})")
                return 1
            ok = True
            for label, prefix, p in plants(a, b, modules):
                pb, _ = diff(a, p, modules)
                fired = [x for x in pb if x.startswith(prefix)]
                print(f"plant: {label}: {'FIRED' if fired else 'DID NOT FIRE'} — {fired[0] if fired else pb[:2]}")
                ok = ok and bool(fired)
            print("plants: every one of 4 fired; the unplanted pair passes" if ok else "plants: FAILED")
            return 0 if ok else 1
        for m in modules:
            na = sum(1 for y in a.get(m, {}).values() if not y[1])
            print(f"  {m.replace('Proofs.HadwigerNelson.', '')}: {na} named constants in the first dump, "
                  f"{sum(1 for y in b.get(m, {}).values() if not y[1])} in the second")
        for x in bad:
            print("DIFF", x)
        print(f"statements: {'PASS: no statement and no definition changed' if not bad else f'FAIL ({len(bad)})'} — "
              f"{n} named constants compared in {len(modules)} module(s)")
        return 1 if bad else 0
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
