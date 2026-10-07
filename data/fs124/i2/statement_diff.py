#!/usr/bin/env python3
"""FS124-I2 — no statement and no definition of the two modules changed while their proofs were written.

Two comparisons, both must hold (exit 0), each with a planted fault that must be reported (`--control`):

1. The kernel's side.  `before` and `after` are two outputs of data/fs124/i2/lean/StatementDump.lean (every constant
   stored in the compiled data of Plane/CircleCrossing and Plane/OnePiece: kind, full name, stored type, and for a
   definition its stored value).  Every constant of `before` that is not INTERNAL (a name Lean generates inside a
   declaration) must be in `after` with the same kind, the same type and, for a definition, the same value, character
   for character.  Constants only in `after` are listed as NEW: the helpers.  INTERNAL constants are counted, not
   compared: they move with a proof.

2. The file's side, for what the environment does not keep: an `example` is elaborated and discarded, so its statement
   is compared as text — each `example` head (from the keyword to its `:=`), whitespace-normalized: every head of the
   base commit's file (`git show <base>:<path>`) must be in the working file, in the base's order. A head only in the
   working file is an example this job added; it is listed as NEW EXAMPLE.

Usage:  statement_diff.py <before.txt> <after.txt> <base-commit> [--control]
What this does not see: a change to a docstring or a comment (not a statement); an `example` moved past another one
with an identical head.
"""
import re, subprocess, sys, pathlib

FILES = ["Proofs/HadwigerNelson/Plane/CircleCrossing.lean", "Proofs/HadwigerNelson/Plane/OnePiece.lean"]
ROOT = pathlib.Path(__file__).resolve().parents[3]


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


def example_heads(text):
    """every `example` head: from the keyword at the start of a line to the first ` :=` (the statement, as text)"""
    heads = []
    for m in re.finditer(r"^example\b", text, flags=re.M):
        j = text.index(":=", m.start())
        heads.append(re.sub(r"\s+", " ", text[m.start():j]).strip())
    return heads


def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before, after, base = read_dump(args[0]), read_dump(args[1]), args[2]
    bad = []

    if control:
        # plant 1: one character of one stored statement changed in `after`
        victim = "HadwigerNelson.Plane.tight_straddle"
        t = after[victim]["type"]
        i = t.index("Ne")
        after[victim]["type"] = t[:i] + "Eq" + t[i + 2:]
        # plant 2: one definition's value changed in `after`
        vdef = "HadwigerNelson.Plane.quadPt"
        after[vdef]["value"] = after[vdef]["value"] + " x"

    n_cmp = 0
    for name, b in before.items():
        if b["internal"]:
            continue
        n_cmp += 1
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
    n_int_b = sum(1 for b in before.values() if b["internal"])
    n_int_a = sum(1 for a in after.values() if a["internal"])

    n_ex = 0
    added = []
    for f in FILES:
        old = subprocess.run(["git", "show", f"{base}:{f}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout
        new_text = (ROOT / f).read_text()
        ho, hn = example_heads(old), example_heads(new_text)
        if control and f.endswith("OnePiece.lean"):
            # plant 3: one example's statement changed
            hn[0] = hn[0].replace("≠", "=", 1)
        # every head of the base file must be in the working file, in order; a head only in the working file is an
        # example this job added, and is listed
        pos = 0
        for k, x in enumerate(ho):
            n_ex += 1
            try:
                pos = hn.index(x, pos) + 1
            except ValueError:
                bad.append(f"EXAMPLE  {f} #{k + 1}: its statement is not in the working file (in order)\n    was: {x[:160]}")
        for y in hn:
            if y not in ho:
                added.append(f"  NEW EXAMPLE {f}: {y[:150]}")
        if not ho:
            bad.append(f"EXAMPLES {f}: none found at {base} — the reader is broken")

    print(f"compared: {n_cmp} named constants of the first dump (types; values of definitions), {n_ex} example heads")
    print(f"internal (not compared): {n_int_b} before, {n_int_a} after")
    print(f"new named constants in the second dump: {len(new)}")
    for n in new:
        print(f"  NEW {after[n]['kind']} {n}")
    print(f"examples in the working files that the base does not hold: {len(added)}")
    for a in added:
        print(a)
    for b in bad:
        print(b)
    if control:
        want = 3
        ok = len(bad) == want
        print(f"CONTROL: {len(bad)} of {want} planted faults reported — {'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement and no definition changed" if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
