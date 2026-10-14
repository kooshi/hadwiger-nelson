#!/usr/bin/env python3
"""FS131-ICL2: read the axioms printed by `data/fs131/icl2/lean/Axioms.lean` for every declaration of this job's five modules.

Each record is CLEAN (its axioms a subset of the standard three), UPSTREAM (the standard three and `sorryAx`, every constant
its `SORRY-FROM` line names declared outside the five modules — a named leaf of another module), or FAIL (any other axiom,
or a `sorry` source inside the five modules, or a `sorryAx` with no SORRY-FROM line). Exit 1 on any FAIL, on zero records,
or when the printed AXIOMS-COUNT disagrees with the records read.

--plant: the output of `AxiomsPlant.lean` (two planted records, counted as declarations of this job's files — one holding
a `sorry` of its own, one resting on a declared axiom); requires both planted records to read FAIL.
"""
import re
import sys

STD = {"propext", "Classical.choice", "Quot.sound"}
# this job's remaining `sorry` leaves (named in the record): a `sorryAx` reached only through them, or through other
# modules' leaves, reads UPSTREAM
LEAVES = set()
OURS = ("HadwigerNelson.Plane.", "HadwigerNelson.Rigidity.")


def parse(path, ours_names):
    recs, sorry_from, count = {}, {}, None
    for line in open(path, encoding="utf-8"):
        line = line.rstrip("\n")
        m = re.match(r"AXIOMS (public|private) (\S+) : \[(.*)\]$", line)
        if m:
            recs[m.group(2)] = (m.group(1), [a.strip() for a in m.group(3).split(",") if a.strip()])
            continue
        m = re.match(r"SORRY-FROM (\S+) : \[(.*)\]$", line)
        if m:
            sorry_from[m.group(1)] = [a.strip() for a in m.group(2).split(",") if a.strip()]
            continue
        m = re.match(r"AXIOMS-COUNT (\d+)$", line)
        if m:
            count = int(m.group(1))
    return recs, sorry_from, count


def classify(recs, sorry_from, own):
    out = {}
    for n, (kind, axs) in recs.items():
        s = set(axs)
        if s <= STD:
            out[n] = ("CLEAN", "")
        elif s <= STD | {"sorryAx"}:
            src = sorry_from.get(n)
            if src is None:
                out[n] = ("FAIL", "sorryAx with no SORRY-FROM line")
            elif any(x in own and x not in LEAVES for x in src):
                out[n] = ("FAIL", f"a sorry inside this job's modules: {[x for x in src if x in own]}")
            else:
                out[n] = ("UPSTREAM", ", ".join(src))
        else:
            out[n] = ("FAIL", f"axioms {sorted(s - STD - {'sorryAx'})}")
    return out


def main(argv):
    if "--leaves" in argv:
        i = argv.index("--leaves")
        LEAVES.update(a for a in argv[i + 1:] if not a.startswith("--"))
        argv = argv[:i] + [a for a in argv[i + 1:] if a.startswith("--")]
    path = argv[0]
    dump = argv[1]  # the statement dump: the names of the five modules' own constants
    own = set()
    for line in open(dump, encoding="utf-8"):
        if line.startswith("@@ "):
            n = line.split()[2]
            own.add(n)
            m = re.match(r"_private\.[^.]+(?:\.[^.]+)*\.0\.(.*)$", n)
    recs, sf, count = parse(path, own)
    # private names print as their user names: count them as ours when their user name is under the three namespaces
    # and absent from every other module (the dump lists `_private.<module>.0.<name>`)
    own_user = set(own)
    for n in own:
        if n.startswith("_private."):
            parts = n.split(".0.", 1)
            if len(parts) == 2:
                own_user.add(parts[1])
    if "--plant" in argv:
        # the planted records stand for declarations of this job's files: a `sorry` they hold is a `sorry` inside them
        own_user |= {n for n in recs if n.startswith("FS131ICL2Plant.")}
    cls = classify(recs, sf, own_user)
    if not recs:
        print("FAIL: no record read")
        return 1
    bad = 0
    for n in sorted(cls):
        v, why = cls[n]
        print(f"{v:8} {recs[n][0]:7} {n} : {recs[n][1]}" + (f"  <- {why}" if why else ""))
        bad += v == "FAIL"
    tally = {k: sum(1 for v in cls.values() if v[0] == k) for k in ("CLEAN", "UPSTREAM", "FAIL")}
    print(" ".join(f"{k}={v}" for k, v in tally.items()) + f" records={len(recs)} printed-count={count}")
    if count != len(recs):
        print("FAIL: AXIOMS-COUNT disagrees with the records read")
        return 1
    if "--plant" in argv:
        planted = [n for n in recs if n.startswith("FS131ICL2Plant.")]
        fired = [n for n in planted if cls[n][0] == "FAIL"]
        print(f"plant: {len(fired)} of {len(planted)} planted records read FAIL")
        return 0 if planted and len(fired) == len(planted) == 2 else 1
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
