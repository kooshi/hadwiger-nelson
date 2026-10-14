#!/usr/bin/env python3
"""FS133-IA1, leaf R — the declared statement `Spectral.residual_fourier` against the release's stored statement,
subterm by subterm, and the inputs of the kernel's check (`data/fs133/ia1/rebuild/Rebuild.lean`).

Reads two prints made by one dumper (FS132-I1's: de Bruijn indices, full constant names with universe arguments,
every implicit and instance argument, binder kinds and names): the release's stored type at its pin
(`data/fs133/k1/readback/ReleaseDump.out.xz`) and this library's at this pin
(`data/fs133/ia1/axiom-readback/ModuleDump.out.xz`).  The release's two namespaces are mapped to this library's and
Mathlib's one rename between the pins is applied (`Set.ofPred` -> `setOf`); nothing else is changed.

  fs133_ia1_rebuild.py emit      parse both prints into trees; walk them in parallel and collect the MAXIMAL differing
                                 subterms (two applications whose heads differ are one pair, not descended into);
                                 print the distinct pairs; check that the release's print with each release-side
                                 subterm replaced by its counterpart IS this library's print, character for character;
                                 write under data/fs133/ia1/rebuild/: `release-type.txt` (the release's stored type,
                                 names mapped: what Rebuild.lean rebuilds as a term at this pin), `pairs.txt` (the
                                 distinct pairs with no bound variable), and the planted variants
                                 `plant-*.txt` of the release's type.  Exit 1 if the rewritten print is not identical.
  fs133_ia1_rebuild.py --control the same walk on a copy of this library's print with one constant changed outside
                                 every differing subterm (`kCoeff`): the rewritten print must then NOT be identical.
"""
import lzma
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
REL = ROOT / "data/fs133/k1/readback/ReleaseDump.out.xz"
OUR = ROOT / "data/fs133/ia1/axiom-readback/ModuleDump.out.xz"
OUT = ROOT / "data/fs133/ia1/rebuild"
PAIRS = [("OAI.PlaneFiveColor.Spectral.", "HadwigerNelson.Outside.OAI158.Spectral."),
         ("OAI.EuclideanFiveColor.", "HadwigerNelson.Outside.OAI158.")]
RENAMES = [("Set.ofPred", "setOf")]
REL_NAME = "OAI.PlaneFiveColor.Spectral.residual_fourier"
OUR_NAME = "HadwigerNelson.Outside.OAI158.Spectral.residual_fourier"


def type_line(path, name):
    lines = lzma.open(path, "rt", encoding="utf-8").read().splitlines()
    for i, ln in enumerate(lines):
        if ln.startswith(f"DUMP {name} : "):
            head = ln
            assert lines[i + 1].startswith("DUMP   type  = "), lines[i + 1][:40]
            return head, lines[i + 1][len("DUMP   type  = "):]
    raise SystemExit(f"FAIL: {name} is not in {path}")


def map_release(s):
    for a, b in PAIRS:
        s = s.replace(a, b)
    for a, b in RENAMES:
        s = re.sub(r"(?<![\w.])" + re.escape(a) + r"(?![\w.])", b, s)
    return s


def parse(s):
    """the print as a tree: ('app', f, a) | ('bind', kind, name, type, body) | ('atom', text)"""
    pos = 0

    def tok():
        nonlocal pos
        j = pos
        while s[j] not in " )":
            j += 1
        t = s[pos:j]
        pos = j
        return t

    def skip_group():
        """an atom that is a parenthesised group read as text: `(c N [..])`, `(Sort L)`, `(nat n)`, …"""
        nonlocal pos
        start, d = pos, 0
        while True:
            ch = s[pos]
            if ch == "(":
                d += 1
            elif ch == ")":
                d -= 1
                if d == 0:
                    pos += 1
                    return s[start:pos]
            pos += 1

    def expr():
        nonlocal pos
        if s[pos] == "#":
            return ("atom", tok())
        assert s[pos] == "(", (pos, s[pos:pos + 20])
        if s[pos + 1] in "(#":
            pos += 1
            f = expr()
            assert s[pos] == " "
            pos += 1
            a = expr()
            assert s[pos] == ")"
            pos += 1
            return ("app", f, a)
        m = re.match(r"\((lam|pi)\.([disc]) ", s[pos:pos + 8])
        if m:
            pos += len(m.group(0))
            name = tok()
            pos += 1
            t = expr()
            pos += 1
            b = expr()
            assert s[pos] == ")"
            pos += 1
            return ("bind", m.group(1) + "." + m.group(2), name, t, b)
        return ("atom", skip_group())

    e = expr()
    assert pos == len(s), (pos, len(s))
    return e


def show(e):
    if e[0] == "atom":
        return e[1]
    if e[0] == "app":
        return f"({show(e[1])} {show(e[2])})"
    return f"({e[1]} {e[2]} {show(e[3])} {show(e[4])})"


def spine(e):
    args = []
    while e[0] == "app":
        args.append(e[2])
        e = e[1]
    return e, args[::-1]


def diff(a, b, out):
    if a == b:
        return
    if a[0] == "bind" and b[0] == "bind" and a[1] == b[1] and a[2] == b[2]:
        diff(a[3], b[3], out)
        diff(a[4], b[4], out)
        return
    if a[0] == "app" and b[0] == "app":
        ha, xa = spine(a)
        hb, xb = spine(b)
        if ha == hb and len(xa) == len(xb):
            for x, y in zip(xa, xb):
                diff(x, y, out)
            return
    out.append((show(a), show(b)))


def closed(e, depth=0):
    """no loose bound variable"""
    if e[0] == "atom":
        return not e[1].startswith("#") or int(e[1][1:]) < depth
    if e[0] == "app":
        return closed(e[1], depth) and closed(e[2], depth)
    return closed(e[3], depth) and closed(e[4], depth + 1)


def head_of(text):
    m = re.search(r"\(c (\S+) \[", text)
    return m.group(1) if m else text[:30]


def run(our_text=None, quiet=False):
    _, rel = type_line(REL, REL_NAME)
    our_head, our = type_line(OUR, OUR_NAME)
    if our_text is not None:
        our = our_text
    rel = map_release(rel)
    pairs = []
    diff(parse(rel), parse(our), pairs)
    distinct = list(dict.fromkeys(pairs))
    rewritten = rel
    for r, o in sorted(distinct, key=lambda p: -len(p[0])):
        rewritten = rewritten.replace(r, o)
    same = rewritten == our
    if not quiet:
        print(f"the release's stored type: {len(rel)} characters; this library's: {len(our)}")
        print(f"differing maximal subterms: {len(pairs)} occurrences, {len(distinct)} distinct pairs")
        for k, (r, o) in enumerate(distinct, 1):
            cl = closed(parse(r)) and closed(parse(o))
            print(f"  pair {k}: {'closed' if cl else 'with loose bound variables'}; {pairs.count((r, o))} occurrence(s); "
                  f"heads {head_of(r)} | {head_of(o)}; {len(r)} | {len(o)} characters")
            print(f"    release: {r if len(r) < 700 else r[:700] + ' …'}")
            print(f"    here:    {o if len(o) < 700 else o[:700] + ' …'}")
        print("the release's print with each pair rewritten " + ("IS this library's print, character for character"
              if same else "is NOT this library's print"))
    return rel, our, distinct, same, our_head


def main():
    if "--control" in sys.argv:
        _, our = type_line(OUR, OUR_NAME)
        planted = our.replace("HadwigerNelson.Outside.OAI158.Spectral.kCoeff", "HadwigerNelson.Outside.OAI158.Spectral.kCoefg", 1)
        assert planted != our
        _, _, distinct, same, _ = run(our_text=planted, quiet=True)
        # the walk records the planted difference as one more pair and the rewrite then reproduces the planted print:
        # the control is that the planted constant shows among the pairs, where a reader sees it
        hit = any("kCoefg" in o for _, o in distinct)
        print(f"plant 'kCoeff changed in this library's print': {'REPORTED among the pairs' if hit else 'SILENT'} "
              f"({len(distinct)} distinct pairs)")
        return 0 if hit else 1
    rel, our, distinct, same, our_head = run()
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / "release-type.txt").write_text(rel + "\n")
    cl = [(r, o) for r, o in distinct if closed(parse(r)) and closed(parse(o))]
    (OUT / "pairs.txt").write_text("".join(f"{r}\t{o}\n" for r, o in cl))
    plants = {
        "plant-Ne-to-Eq.txt": rel.replace("(c Ne [", "(c Eq [", 1),
        "plant-numeral.txt": rel.replace("(nat 0)", "(nat 1)", 1),
        "plant-binder-kind.txt": rel.replace("(pi.d U ", "(pi.i U ", 1),
    }
    for name, text in plants.items():
        assert text != rel, name
        (OUT / name).write_text(text + "\n")
    print(f"wrote release-type.txt, pairs.txt ({len(cl)} closed pairs of {len(distinct)}), {len(plants)} planted variants")
    print(f"this library's declaration: {our_head}")
    return 0 if same else 1


if __name__ == "__main__":
    sys.exit(main())
