#!/usr/bin/env python3
"""FS133-IB1 — did a stored statement of this job's two modules move, and how.

  fs133_ib1_moved.py <before.out> <after.out> [--control] [--ignore-new] [--ruled=NAME,NAME,…]

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

`--ruled=…` names the statements the coordinator ruled changed (Amendments 1–3 of the brief: a binder that neither
the statement nor its proof reads is dropped).  Each must read DIFFERENT **and** be exactly the first dump's stored
type with ONE binder of its telescope removed, that binder occurring nowhere after it (the full prints are parsed;
the bound-variable indices above the removed binder are lowered by one; the result must be the second dump's type,
character for character).  It is then reported RULED-DROP with the binder's kind, name and type.  The run fails on a
ruled statement that is not such a drop (RULED-NOT-A-DROP), on a ruled statement that did not change
(RULED-BUT-IDENTICAL), and on any DIFFERENT or MISSING statement that is not ruled.

`--control` plants, in a copy of the second dump: one constant changed in an ERASED print (must read DIFFERENT), one
changed in a FULL print only (must read INSTANCES-ONLY — a move must never read as identical), one constant removed
(MISSING), one theorem turned into an axiom (DIFFERENT); and, with `--ruled`, three more: a constant changed in an
unruled statement (the run must fail and name it), a second change inside a ruled statement (RULED-NOT-A-DROP), a
ruled statement put back as it was (RULED-BUT-IDENTICAL); exit 0 only if each is read as planted.
Exit 0 iff no DIFFERENT and no MISSING beyond the ruled drops.  Prints may be `.xz`.
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


# ---- the stored term, parsed (FS132-I2's print: de Bruijn indices `#i`, binders `(pi.k name T B)`)

LEAVES = {"Sort", "c", "nat", "str", "p", "S", "max", "imax", "fvar", "mvar"}


def parse(text):
    """The print as nested lists; `[…]` (a constant's universe arguments) and a quoted string are one atom each."""
    pos, n = 0, len(text)
    stack, cur = [], None
    top = None
    while pos < n:
        ch = text[pos]
        if ch.isspace():
            pos += 1
        elif ch == "(":
            new = []
            if cur is not None:
                cur.append(new)
                stack.append(cur)
            cur = new
            pos += 1
        elif ch == ")":
            done = cur
            cur = stack.pop() if stack else None
            if cur is None:
                top = done
            pos += 1
        else:
            start = pos
            if ch == "[":
                depth = 0
                while pos < n:
                    depth += text[pos] == "["
                    depth -= text[pos] == "]"
                    pos += 1
                    if depth == 0:
                        break
            elif ch == '"':
                pos += 1
                while pos < n and text[pos] != '"':
                    pos += 2 if text[pos] == "\\" else 1
                pos += 1
            else:
                while pos < n and not text[pos].isspace() and text[pos] not in "()":
                    pos += 1
            atom = text[start:pos]
            if cur is None:
                top = atom
            else:
                cur.append(atom)
    return top


def show(e):
    return e if isinstance(e, str) else "(" + " ".join(show(x) for x in e) + ")"


class Referenced(Exception):
    pass


def lower(e, d):
    """`e` with the bound variable of index `d` removed: an occurrence raises, the indices above it go down by one."""
    if isinstance(e, str):
        if e.startswith("#"):
            i = int(e[1:])
            if i == d:
                raise Referenced()
            return f"#{i - 1}" if i > d else e
        return e
    head = e[0]
    if isinstance(head, str):
        if head.startswith("pi.") or head.startswith("lam."):
            return [head, e[1], lower(e[2], d), lower(e[3], d + 1)]
        if head == "let":
            return [head, e[1], lower(e[2], d), lower(e[3], d), lower(e[4], d + 1)]
        if head == "proj":
            return [head, e[1], e[2], lower(e[3], d)]
        if head in LEAVES:
            return e
    return [lower(x, d) for x in e]


def without_binder(e, j):
    if not (isinstance(e, list) and isinstance(e[0], str) and e[0].startswith("pi.")):
        raise IndexError
    if j == 0:
        return lower(e[3], 0)
    return [e[0], e[1], e[2], without_binder(e[3], j - 1)]


def one_binder_dropped(btype, atype):
    """-> list of (position, kind, name, type) of the binders of `btype` whose removal gives `atype` exactly."""
    tree = parse(btype)
    if show(tree) != btype or show(parse(atype)) != atype:
        print("BROKEN PARSE: a print does not survive parse-and-print")
        sys.exit(2)
    hits, j, e = [], 0, tree
    while isinstance(e, list) and isinstance(e[0], str) and e[0].startswith("pi."):
        try:
            if show(without_binder(tree, j)) == atype:
                hits.append((j, e[0][3:], e[1], show(e[2])))
        except Referenced:
            pass
        e = e[3]
        j += 1
    return hits


KIND = {"d": "explicit", "i": "implicit", "s": "strict-implicit", "c": "instance"}


def ruled_verdict(b, a):
    """For a statement the coordinator ruled changed: (verdict, the binder dropped or None)."""
    v, _, _ = judge(b, a)
    if v == "IDENTICAL":
        return "RULED-BUT-IDENTICAL", None
    if v != "DIFFERENT" or a is None or a["kind"] != b["kind"] or a["levels"] != b["levels"]:
        return "RULED-NOT-A-DROP", None
    hits = one_binder_dropped(b["type"], a["type"])
    if len(hits) != 1:
        return "RULED-NOT-A-DROP", None
    return "RULED-DROP", hits[0]


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
    ruled = []
    for a in sys.argv[1:]:
        if a.startswith("--ruled="):
            ruled = [x for x in a[len("--ruled="):].split(",") if x]
    before, where = load(read(args[0]))
    after, _ = load(read(args[1]))
    for r in ruled:
        if r not in before:
            print(f"RULED NAME NOT IN THE FIRST DUMP: {r}")
            return 2

    def verdicts(a2):
        """-> (list of failure lines, list of report lines) for the run with the ruled list."""
        bad, rep_ = [], []
        for name, b in before.items():
            if name in ruled:
                v, hit = ruled_verdict(b, a2.get(name))
                if v == "RULED-DROP":
                    j, k, nm, ty = hit
                    rep_.append(f"  RULED-DROP      {name}: binder {j} dropped — {KIND.get(k, k)} `{nm}` : "
                                f"{ty[:150]}{'…' if len(ty) > 150 else ''}")
                else:
                    bad.append(f"  {v:15s} {name}")
            else:
                v, _, _ = judge(b, a2.get(name))
                if v in ("DIFFERENT", "MISSING"):
                    bad.append(f"  {v:15s} {name}  (not ruled)")
        return bad, rep_

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
        if ruled:
            bad0, _ = verdicts(after)
            print(f"the run itself, before any plant: {'no failure' if not bad0 else bad0}")
            ok = ok and not bad0
            # (1) a constant changed in an unruled statement
            un = next(n for n, d in before.items() if n not in ruled and d["kind"] == "theorem"
                      and n in after and "(c " in after[n]["etype"])
            cc = sorted(constants(after[un]["etype"]))[0]
            a2 = {k: dict(v) for k, v in after.items()}
            for f in ("type", "etype"):
                a2[un][f] = a2[un][f].replace(f"(c {cc} [", f"(c {cc}' [", 1)
            bad, _ = verdicts(a2)
            good = any(un in ln and "not ruled" in ln for ln in bad)
            print(f"plant 'a constant changed in an unruled statement' in {un}: "
                  f"{'the run fails and names it' if good else 'NOT REPORTED'}")
            ok = ok and good
            # (2) a second change inside a ruled statement
            r0 = ruled[0]
            cc = sorted(constants(after[r0]["etype"]))[-1]
            a2 = {k: dict(v) for k, v in after.items()}
            for f in ("type", "etype"):
                a2[r0][f] = a2[r0][f].replace(f"(c {cc} [", f"(c {cc}' [", 1)
            v, _ = ruled_verdict(before[r0], a2[r0])
            print(f"plant 'a second change inside a ruled statement' in {r0}: read {v}, planted RULED-NOT-A-DROP — "
                  f"{'as planted' if v == 'RULED-NOT-A-DROP' else 'NOT AS PLANTED'}")
            ok = ok and v == "RULED-NOT-A-DROP"
            # (3) a ruled statement put back as it was
            a2 = {k: dict(v) for k, v in after.items()}
            a2[r0] = dict(before[r0])
            v, _ = ruled_verdict(before[r0], a2[r0])
            print(f"plant 'a ruled statement put back as it was' in {r0}: read {v}, planted RULED-BUT-IDENTICAL — "
                  f"{'as planted' if v == 'RULED-BUT-IDENTICAL' else 'NOT AS PLANTED'}")
            ok = ok and v == "RULED-BUT-IDENTICAL"
        print("CONTROL OK: each plant read as planted" if ok else "CONTROL FAILED")
        return 0 if ok else 1
    rows, counts = run(before, after, where, ignore_new="--ignore-new" in sys.argv)
    if ruled:
        bad, rep_ = verdicts(after)
        print(f"ruled: {len(ruled)}")
        for ln in rep_ + bad:
            print(ln)
        print("MOVED OK: the ruled statements are each one unread binder dropped; nothing else moved outside "
              "instance and proof arguments" if not bad else f"MOVED FAILED: {len(bad)}")
        return 1 if bad else 0
    bad = counts.get("DIFFERENT", 0) + counts.get("MISSING", 0)
    print("MOVED OK: nothing moved outside instance and proof arguments" if not bad else f"MOVED FAILED: {bad}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
