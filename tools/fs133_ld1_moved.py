#!/usr/bin/env python3
"""FS133-LD1 — did a stored statement of the density equality move at the join with the port, and how.

FS133-IPQ1's reader (`tools/fs133_ipq1_moved.py`, copied; its verdicts unchanged), with three more ruled changes
for the join (the recipe, `plans/FS131-KO1-port-plan.md` § 4.5; inventory item 798), each checked, never assumed:
  --axiom-proved=N      N was an `axiom` and is now a `theorem` of the same universe parameters, in any module, its
                        stored type IDENTICAL in the full print (AXIOM-PROVED); a type identical only in the erased
                        print reads AXIOM-PROVED-INSTANCES-ONLY and fails (the recipe's kernel check is then owed);
  --moved-instances=N   N is compiled in another module, its stored type IDENTICAL in the full print, and its value
                        identical in the erased print and not in the full one (MOVED-INSTANCES-ONLY; item 798's
                        three definitions, whose values cite another module's generated proof auxiliaries); the
                        constants each side's value names alone are printed;
  --generated=N         N is a theorem Lean generates on demand (`congr_simp`): absent in the second dump
                        (GENERATED-ABSENT) or IDENTICAL in any module (GENERATED-IDENTICAL); anything else fails.
`--control` adds, per such name, a plant that each must be read as failing: for an axiom proved, the theorem's type
changed in the full print, and the kind left `axiom`; for a moved-instances definition, its type changed in the
full print, its value changed in the erased print, and the module left unchanged; for a generated name, its type
changed.  The dropped-binder plant "the named binder absent from the first print" is made at any binder kind (an
instance binder prints `pi.c`), where FS133-IPQ1's reader made it at `pi.d` only.

FS133-IPQ1's text follows.

FS133-IPQ1 — did a stored statement of `Plane/OneClass` move, and how.

FS133-ICD1's reader (`tools/fs133_icd1_moved.py`), its verdicts unchanged, with one more ruled change:
  --binder-dropped=N:B  the theorem N lost exactly one binder of its stored type, the one named B on the spine of its
                        leading `∀`s, and nothing else: the second dump's FULL print must equal the first's with that
                        `pi` removed and every de Bruijn index beneath it that points past it lowered by one (an index
                        pointing AT it is a failure: the binder was read), and its ERASED print the same with every
                        local `@m` after the binder's position lowered by one (BINDER-DROPPED).  `--control` adds three
                        plants per N: the binder left in (the first dump's print), another change beside the drop (a
                        constant renamed), and the print with the binder's own type changed while dropped elsewhere.

FS133-ICD1's text follows.

FS133-IB2's reader (`tools/fs133_ib2_moved.py`), its verdicts unchanged, with one more ruled change:
  --made-public=P   P is a private declaration (`_private.<module>.0.<name>`) made public: P must be absent from the
                    second dump and `<name>` present, compiled in the same module, its full print identical to P's
                    (MADE-PUBLIC-IDENTICAL); `<name>` is then not listed as NEW.  `--control` adds two plants per P:
                    the public print changed, and the private left in place.

  fs133_icd1_moved.py <before.out> <after.out> [--first-module=M,…] [--moved=NAME,…] [--deleted=NAME,…]
                     [--proof-filled=NAME,…] [--strict] [--ignore-new] [--ignore-module] [--public-only] [--control]

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
A constant only in the second dump is listed as NEW (with `--ignore-new` counted only).  `--ignore-module` reads every
constant's module as unchanged: for a second dump made by a footer on a working copy, whose module is `(this file)`;
`--public-only` drops the private declarations from the first dump (a footer's dump holds none).

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


HEADS = {"Sort", "c", "let", "nat", "str", "proj", "fvar", "mvar"}


def tokens(s):
    """Atoms, '(' and ')'; a '[...]' level list and a '"..."' string are one atom each."""
    out, i, n = [], 0, len(s)
    while i < n:
        ch = s[i]
        if ch.isspace():
            i += 1
        elif ch in "()":
            out.append(ch)
            i += 1
        elif ch == "[":
            d, j = 0, i
            while True:
                if s[j] == "[":
                    d += 1
                elif s[j] == "]":
                    d -= 1
                    if d == 0:
                        break
                j += 1
            out.append(s[i:j + 1])
            i = j + 1
        elif ch == '"':
            j = i + 1
            while s[j] != '"':
                j += 2 if s[j] == "\\" else 1
            out.append(s[i:j + 1])
            i = j + 1
        else:
            j = i
            while j < n and not s[j].isspace() and s[j] not in "()":
                j += 1
            out.append(s[i:j])
            i = j
    return out


def parse(s):
    toks, pos = tokens(s), 0

    def go():
        nonlocal pos
        t = toks[pos]
        pos += 1
        if t != "(":
            return t
        items = []
        while toks[pos] != ")":
            items.append(go())
        pos += 1
        return items

    tree = go()
    if pos != len(toks):
        raise ValueError("trailing tokens")
    return tree


def show(t):
    return t if isinstance(t, str) else "(" + " ".join(show(x) for x in t) + ")"


def is_binder(t):
    return isinstance(t, list) and t and isinstance(t[0], str) and (t[0].startswith("pi.") or t[0].startswith("lam."))


class ReadBinder(Exception):
    pass


def lower(t, cut, erased, k):
    """Remove one binder: full print — `#i` with i > cut becomes `#(i-1)`, `#cut` is a read of it; erased print —
    `@m` with m > k becomes `@(m-1)`, `@k` is a read of it."""
    if isinstance(t, str):
        if not erased and t.startswith("#"):
            i = int(t[1:])
            if i == cut:
                raise ReadBinder(t)
            return f"#{i - 1}" if i > cut else t
        if erased and t.startswith("@"):
            m = int(t[1:])
            if m == k:
                raise ReadBinder(t)
            return f"@{m - 1}" if m > k else t
        return t
    if is_binder(t):
        return [t[0], t[1], lower(t[2], cut, erased, k), lower(t[3], cut + 1, erased, k)]
    if isinstance(t[0], str) and t[0] == "let":
        return [t[0], t[1], lower(t[2], cut, erased, k), lower(t[3], cut, erased, k), lower(t[4], cut + 1, erased, k)]
    if isinstance(t[0], str) and t[0] in ("Sort", "c", "nat", "str", "fvar", "mvar"):
        return t
    if isinstance(t[0], str) and t[0] == "proj":
        return [t[0], t[1], t[2], lower(t[3], cut, erased, k)]
    return [lower(x, cut, erased, k) for x in t]


def drop_binder(s, binder, erased):
    """The print `s` with the leading-spine `pi` named `binder` removed; None if there is no such binder.  FS133-LD1:
    `name#k` names the k-th binder of that name on the spine (two instance binders both print `inst`)."""
    tree = parse(s)
    spine, t = [], tree
    name, _, occ = binder.partition("#")
    want, seen = int(occ or 1), 0
    while isinstance(t, list) and t and isinstance(t[0], str) and t[0].startswith("pi."):
        if t[1] == name:
            seen += 1
        if t[1] == name and seen == want:
            body = lower(t[3], 0, erased, len(spine))
            for b in reversed(spine):
                body = [b[0], b[1], b[2], body]
            return show(body)
        spine.append(t)
        t = t[3]
    return None


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


IGNORE_MODULE = "--ignore-module" in sys.argv


MADE_PUBLIC = []
DROPPED = {}
AXIOM_PROVED = []
MOVED_INSTANCES = []
GENERATED = []


def dropped_verdict(name, b, a, same_mod):
    if a is None:
        return "DROPPED-BUT-MISSING"
    if a["kind"] != b["kind"] or a["levels"] != b["levels"] or not same_mod:
        return "DROPPED-BUT-KIND-OR-MODULE"
    try:
        full = drop_binder(b["type"], DROPPED[name], erased=False)
        er = drop_binder(b["etype"], DROPPED[name], erased=True)
    except ReadBinder:
        return "DROPPED-BUT-BINDER-READ"
    if full is None or er is None:
        return "DROPPED-BUT-NO-SUCH-BINDER"
    if full != show(parse(a["type"])):
        return "DROPPED-BUT-FULL-DIFFERS"
    if er != show(parse(a["etype"])):
        return "DROPPED-BUT-ERASED-DIFFERS"
    return "BINDER-DROPPED"


def public_name(p):
    return p.split(".0.", 1)[1]


def verdicts(before, wb, after, wa, moved, deleted, filled, strict):
    """-> (rows, failures): one row per constant of the first dump."""
    rows, bad = [], []
    for name, b in before.items():
        a = after.get(name)
        v, gone, came = judge(b, a)
        same_mod = a is not None and (IGNORE_MODULE or wa.get(name) == wb.get(name))
        if name in AXIOM_PROVED:
            if a is None:
                verdict = "AXIOM-PROVED-BUT-MISSING"
            elif b["kind"] != "axiom" or a["kind"] != "theorem" or a["levels"] != b["levels"]:
                verdict = f"AXIOM-PROVED-BUT-KIND {b['kind']}->{a['kind']}"
            elif a["type"] == b["type"]:
                verdict = "AXIOM-PROVED"
            elif a["etype"] == b["etype"]:
                verdict = "AXIOM-PROVED-INSTANCES-ONLY"
            else:
                verdict = "AXIOM-PROVED-BUT-DIFFERENT"
            rows.append((wb.get(name), name, b["kind"], verdict, sorted(constants(b["type"]) - constants((a or {}).get("type"))),
                         sorted(constants((a or {}).get("type")) - constants(b["type"])), wa.get(name)))
            if verdict != "AXIOM-PROVED":
                bad.append(f"  {verdict:22s} {name}")
            continue
        if name in MOVED_INSTANCES:
            ok = (a is not None and not same_mod and a["kind"] == b["kind"] == "def" and a["levels"] == b["levels"]
                  and a["type"] == b["type"] and a["evalue"] == b["evalue"] and a["value"] != b["value"])
            verdict = "MOVED-INSTANCES-ONLY" if ok else f"MOVED-INSTANCES-BUT-{v}{'-SAME-MODULE' if same_mod else ''}"
            rows.append((wb.get(name), name, b["kind"], verdict, gone, came, wa.get(name)))
            if not ok:
                bad.append(f"  {verdict:22s} {name}")
            continue
        if name in GENERATED:
            if a is None:
                verdict = "GENERATED-ABSENT"
            elif v == "IDENTICAL":
                verdict = "GENERATED-IDENTICAL"
            else:
                verdict = f"GENERATED-BUT-{v}"
            rows.append((wb.get(name), name, b["kind"], verdict, gone, came, wa.get(name)))
            if not verdict.startswith("GENERATED-") or "-BUT-" in verdict:
                bad.append(f"  {verdict:22s} {name}")
            continue
        if name in MADE_PUBLIC:
            u = public_name(name)
            vp, gone, came = judge(b, after.get(u))
            ok = a is None and vp == "IDENTICAL" and (IGNORE_MODULE or wa.get(u) == wb.get(name))
            verdict = "MADE-PUBLIC-IDENTICAL" if ok else f"MADE-PUBLIC-BUT-{vp}{'-PRIVATE-LEFT' if a is not None else ''}"
            rows.append((wb.get(name), name, b["kind"], verdict, gone, came, wa.get(u)))
            if not ok:
                bad.append(f"  {verdict:22s} {name}")
            continue
        if name in DROPPED:
            verdict = dropped_verdict(name, b, a, same_mod)
            rows.append((wb.get(name), name, b["kind"], verdict, [], [], wa.get(name)))
            if verdict != "BINDER-DROPPED":
                bad.append(f"  {verdict:22s} {name}")
            continue
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
    MADE_PUBLIC.extend(lst("--made-public"))
    AXIOM_PROVED.extend(lst("--axiom-proved"))
    MOVED_INSTANCES.extend(lst("--moved-instances"))
    GENERATED.extend(lst("--generated"))
    for item in lst("--binder-dropped"):
        n, bnd = item.rsplit(":", 1)
        DROPPED[n] = bnd
    strict, ignore_new, control = "--strict" in sys.argv, "--ignore-new" in sys.argv, "--control" in sys.argv
    before, wb = load(read(args[0]))
    after, wa = load(read(args[1]))
    if first_mods:
        keep = {n for n, m in wb.items() if any(m == fm or m.endswith("." + fm) for fm in first_mods)}
        if not keep:
            print(f"FIRST-MODULE FILTER KEEPS NOTHING: {first_mods}")
            return 2
        before = {n: d for n, d in before.items() if n in keep}
    if "--public-only" in sys.argv:
        before = {n: d for n, d in before.items() if not n.startswith("_private.")}
    for n in moved + deleted + filled + MADE_PUBLIC + list(DROPPED) + AXIOM_PROVED + MOVED_INSTANCES + GENERATED:
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
        for n in MADE_PUBLIC:
            u = public_name(n)
            a2 = copy.deepcopy(after)
            a2[u]["type"] = a2[u]["type"] + " "
            expect("a made-public constant's full print changed", n, a2, wa)
            a2 = copy.deepcopy(after)
            a2[n] = copy.deepcopy(before[n])
            expect("a made-public constant's private copy left in", n, a2, wa)
        for n, bnd in DROPPED.items():
            a2 = copy.deepcopy(after)
            a2[n] = copy.deepcopy(before[n])
            expect("a dropped binder left in", n, a2, wa)
            a2 = copy.deepcopy(after)
            cs = sorted(constants(after[n]["etype"]))
            a2[n]["type"] = a2[n]["type"].replace(f"(c {cs[0]} [", f"(c {cs[0]}' [", 1)
            a2[n]["etype"] = a2[n]["etype"].replace(f"(c {cs[0]} [", f"(c {cs[0]}' [", 1)
            expect("another change beside the drop", n, a2, wa)
            b2 = copy.deepcopy(before)
            bname, _, bocc = bnd.partition("#")
            for f_ in ("type", "etype"):
                k_ = [0]

                def ren(m_, k_=k_):
                    k_[0] += 1
                    return f"(pi.{m_.group(1)} {bname}' " if k_[0] == int(bocc or 1) else m_.group(0)
                b2[n][f_] = re.sub(r"\(pi\.(\w) " + re.escape(bname) + " ", ren, b2[n][f_])
            assert b2[n]["type"] != before[n]["type"], "the absent-binder plant changed nothing"
            _, badb = verdicts(b2, wb, after, wa, moved, deleted, filled, strict)
            hit = any(ln.split()[-1] == n for ln in badb)
            print(f"plant 'the named binder absent from the first print' in {n}: "
                  f"{'the run fails and names it' if hit else 'NOT REPORTED'}")
            ok = ok and hit
            bt = parse(before[n]["type"])
            # a bound-variable read of the dropped binder: point the innermost body's first `#` at it
            depth, t = 0, bt
            bname, _, bocc = bnd.partition("#")
            seen_ = 0
            while isinstance(t, list) and t and isinstance(t[0], str) and t[0].startswith("pi."):
                if t[1] == bname:
                    seen_ += 1
                if t[1] == bname and seen_ == int(bocc or 1):
                    break
                depth += 1
                t = t[3]
            def plant_read(u, d):
                if isinstance(u, str):
                    return u
                if is_binder(u):
                    return [u[0], u[1], u[2], plant_read(u[3], d + 1)]
                if isinstance(u, list) and len(u) == 2 and not isinstance(u[0], str):
                    return [u[0], f"#{d - 1}"]
                return u
            planted = show([t[0], t[1], t[2], plant_read(t[3], 1)])
            b3 = copy.deepcopy(before)
            b3[n]["type"] = b3[n]["type"].replace(show(t), planted, 1)
            _, badr = verdicts(b3, wb, after, wa, moved, deleted, filled, strict)
            hit = any(ln.split()[-1] == n for ln in badr) and planted != show(t)
            print(f"plant 'the dropped binder read in the first print' in {n}: "
                  f"{'the run fails and names it' if hit else 'NOT REPORTED'}")
            ok = ok and hit
        plain = [n for n, d in before.items() if n not in moved + deleted + filled + MADE_PUBLIC + list(DROPPED)
                 + AXIOM_PROVED + MOVED_INSTANCES + GENERATED and n in after
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
        for n in AXIOM_PROVED:
            a2 = copy.deepcopy(after)
            a2[n]["type"] = a2[n]["type"] + " "
            expect("a proved axiom's type changed in the full print", n, a2, wa)
            a2 = copy.deepcopy(after)
            a2[n]["kind"] = "axiom"
            expect("a proved axiom left an axiom", n, a2, wa)
        for n in MOVED_INSTANCES:
            a2 = copy.deepcopy(after)
            a2[n]["type"] = a2[n]["type"] + " "
            expect("a moved-instances definition's type changed", n, a2, wa)
            a2 = copy.deepcopy(after)
            a2[n]["evalue"] = (a2[n]["evalue"] or "") + " X"
            expect("a moved-instances definition's erased value changed", n, a2, wa)
            wa2 = dict(wa)
            wa2[n] = wb[n]
            expect("a moved-instances definition left in its old module", n, after, wa2)
        for n in GENERATED:
            if n in after:
                a2 = copy.deepcopy(after)
                a2[n]["etype"] = a2[n]["etype"] + " X"
                expect("a generated theorem's type changed", n, a2, wa)
            else:
                a2 = copy.deepcopy(after)
                a2[n] = copy.deepcopy(before[n])
                a2[n]["etype"] = a2[n]["etype"] + " X"
                expect("a generated theorem present with another type", n, a2, wa)
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
                extra = f" -> {r[6]}" if r[3].startswith(("MOVED", "AXIOM", "GENERATED")) or r[3] == "MODULE-CHANGED" else ""
                print(f"  {r[3]:22s} {r[2]:8s} {r[1]}{extra}")
                if r[4] or r[5]:
                    print(f"      only before: {' '.join(r[4]) or '—'}")
                    print(f"      only after:  {' '.join(r[5]) or '—'}")
    new = sorted(n for n in after if n not in before and not (first_mods and n in wb)
                 and n not in {public_name(p) for p in MADE_PUBLIC})
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
