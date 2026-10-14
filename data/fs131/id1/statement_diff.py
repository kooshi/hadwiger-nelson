#!/usr/bin/env python3
"""FS131-ID1 — no statement of `Arith/DyadicQuadratic` changed while its proofs were written.

`before` and `after` are two prints made by elaborating a copy of the file with `lean/StatementFooter.lean` appended
(kind, full name, stored type, and for a definition its stored value) — the skeleton at the base commit and the working
file, both at ONE path (see statements.sh: an instance binder's stored name carries the module's name).  Every constant
of `before` that is not INTERNAL (a name Lean generates inside a declaration) must be in `after` with the same kind, the
same type and, for a definition, the same value, character for character.  Constants only in `after` are listed as NEW:
the helpers.  INTERNAL constants are counted, not compared: they move with a proof.

The file's side: an `example` is elaborated and discarded, so (i) the count of `example` heads at the base commit and in
the working file is printed, and (ii) the file's text from its `/-! ## Spec -/` line to its end — where every `example`
of the skeleton stands — must be byte-identical to the base commit's; and the text of every skeleton theorem's head
(from `theorem <name>` to its `:= by`) must be byte-identical too (a second reading, of the source this time).

Usage:  statement_diff.py <before.txt> <after.txt> [--control]
`--control` plants three faults in `after` (one stored statement changed by one character, one skeleton theorem's kind
changed, one skeleton declaration removed) and must report exactly three; exit 0 only then.
What this does not see: a change to a docstring or a comment (not a statement).
(Pattern: data/fs131/iu1/statement_diff.py on branch fs131-wnf.)
"""
import re, subprocess, sys, pathlib

FILE = "Proofs/HadwigerNelson/Arith/DyadicQuadratic.lean"
BASE = "34d9113b2"
ROOT = pathlib.Path(__file__).resolve().parents[3]
NS = "HadwigerNelson.DyadicQuadratic."


def read_dump(path):
    out, cur = {}, None
    for ln in pathlib.Path(path).read_text().splitlines():
        if ln.startswith("@@ "):
            parts = ln.split(" ")
            cur = {"kind": parts[1], "internal": parts[-1] == "INTERNAL", "type": None, "value": None}
            name = " ".join(parts[2:-1] if cur["internal"] else parts[2:])
            if name in out:
                print(f"DUPLICATE NAME IN DUMP {path}: {name}"); sys.exit(2)
            out[name] = cur
        elif ln.startswith("TYPE ") and cur is not None:
            cur["type"] = ln[5:]
        elif ln.startswith("VALUE ") and cur is not None:
            cur["value"] = ln[6:]
    if not out:
        print(f"EMPTY DUMP: {path} — the reader or the dumper is broken"); sys.exit(2)
    return out


def strip_comments(text):
    return re.sub(r"/-.*?-/", "", text, flags=re.S)


def example_heads(text):
    return [m.start() for m in re.finditer(r"^example\b", strip_comments(text), flags=re.M)]


def theorem_heads(text):
    """name -> the text from `theorem <name>` to the first `:= by` or `:=` that ends its statement."""
    out = {}
    for m in re.finditer(r"^theorem ([A-Za-z0-9_.']+)(.*?):=", strip_comments(text), flags=re.M | re.S):
        out[m.group(1)] = m.group(0)
    return out


def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before, after = read_dump(args[0]), read_dump(args[1])
    bad = []

    if control:
        # plant 1: one character of one stored statement changed in `after`
        victim = NS + "colorable_two_planeOver_sqrt"
        t = after[victim]["type"]
        after[victim]["type"] = t[:-1] + ("!" if t[-1] != "!" else "?")
        # plant 2: one skeleton theorem stored as another kind in `after`
        after[NS + "dyadic_shape_two_mod_four"]["kind"] = "AXIOM"
        # plant 3: one skeleton declaration gone from `after`
        del after[NS + "exists_rat_add_mul_sqrt_eq"]

    n_cmp = n_thm = n_def = 0
    for name, b in before.items():
        if b["internal"]:
            continue
        n_cmp += 1
        n_thm += b["kind"] == "THM"
        n_def += b["kind"] == "DEF"
        a = after.get(name)
        if a is None:
            bad.append(f"MISSING  {b['kind']} {name}: in the first dump, not in the second"); continue
        if a["kind"] != b["kind"]:
            bad.append(f"KIND     {name}: {b['kind']} -> {a['kind']}")
        if a["type"] != b["type"]:
            bad.append(f"TYPE     {b['kind']} {name}: the stored statement differs")
        if b["kind"] == "DEF" and a["value"] != b["value"]:
            bad.append(f"VALUE    DEF {name}: the stored definition differs")
    new = sorted(n for n, a in after.items() if n not in before and not a["internal"])

    # a private declaration's stored name (`_private.<module>.0.<name>`) is flagged INTERNAL by the dumper; list the
    # private declarations this job added by their own names (generated children left out)
    def private_user(n):
        m = re.match(r"_private\.(.*?)\.0\.(.*)$", n)
        if not m:
            return None
        last = m.group(2).split(".")[-1]
        return None if (last.startswith("_") or re.fullmatch(r"(match|eq|proof)_\d+(_\d+)*", last)) else m.group(2)
    new_private = sorted((private_user(n), a["kind"]) for n, a in after.items() if n not in before and private_user(n))
    n_int_b = sum(1 for b in before.values() if b["internal"])
    n_int_a = sum(1 for a in after.values() if a["internal"])

    old = subprocess.run(["git", "show", f"{BASE}:{FILE}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout
    cur = (ROOT / FILE).read_text()
    n_old_ex, n_new_ex = len(example_heads(old)), len(example_heads(cur))
    # the reader's own check: every `theorem <name>` written in the base file is a named constant of `before`
    oldheads, curheads = theorem_heads(old), theorem_heads(cur)
    short = {n.split(".")[-1] for n, b in before.items() if not b["internal"]}
    unseen = [w for w in oldheads if w.split(".")[-1] not in short]
    if unseen or not oldheads:
        print(f"READER BROKEN: {len(oldheads)} declarations written at {BASE}, not in the first dump: {unseen}"); sys.exit(2)
    # the source's side: heads and the Spec section
    if not control:
        for name, head in oldheads.items():
            if curheads.get(name) != head:
                bad.append(f"HEAD     theorem {name}: its text (name to `:=`) differs from {BASE}'s")
        mark = "/-! ## Spec -/"
        if mark not in old or mark not in cur:
            print("READER BROKEN: no Spec marker"); sys.exit(2)
        if old[old.index(mark):] != cur[cur.index(mark):]:
            bad.append(f"SPEC     the text from `{mark}` to the end differs from {BASE}'s (the examples)")

    print(f"compared: {n_cmp} named constants of the first dump ({n_thm} theorems, {n_def} definitions; types, and values of definitions); "
          f"{len(oldheads)} theorems written at {BASE}, each found in the first dump, each head compared as text")
    print(f"internal (not compared): {n_int_b} before, {n_int_a} after")
    print(f"new named constants in the second dump: {len(new)}")
    for n in new:
        print(f"  NEW {after[n]['kind']} {n}")
    print(f"new private declarations in the second dump (counted among the internal): {len(new_private)}")
    for n, k in new_private:
        print(f"  NEW PRIVATE {k} {n}")
    print(f"`example` heads: {n_old_ex} at {BASE}, {n_new_ex} in the working file; the Spec section compared byte for byte")
    for b in bad:
        print(b)
    if control:
        want = 3
        ok = len(bad) == want
        print(f"CONTROL: {len(bad)} of {want} planted faults reported — {'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement changed" if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
