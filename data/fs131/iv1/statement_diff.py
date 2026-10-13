#!/usr/bin/env python3
"""FS131-IV1 — no statement and no definition of the module's three files changed while its last leaves were proved.

`before` and `after` are two prints in the format of data/fs131/iv1/lean/StatementDump.lean (kind, full name, stored type,
and for a definition its stored value), made either from the compiled modules (`StatementDump.lean`, all three files) or
from a copy of one file with `lean/StatementFooter.lean` appended (the same format; used between builds) — both raw, or
both passed through data/fs131/iv1/compact_dump.py.  Every constant of `before` that is not INTERNAL (a name Lean generates
inside a declaration, or a private declaration's stored name) must be in `after` with the same kind, the same stored type
and, for a definition, the same stored value, character for character.  Constants only in `after` are listed: the helpers.
INTERNAL constants are counted, not compared: they move with a proof.

The files' side: an `example` is elaborated and discarded, so the `example`s of each file in scope are compared as text
between the base commit and the working tree (block comments and docstrings blanked first; an `example` runs from its
head to the next blank line).  And the reader's own check: every `theorem`, `def`, `abbrev` or named `instance` written
in the base commit's files in scope is a named constant of `before`.

Usage:  statement_diff.py <before.txt> <after.txt> [--scope instances|module] [--control]
  --scope instances   the dumps hold `Instances/UpperHalfValues` only (the footer's print)
  --scope module      the dumps hold all three files (the compiled modules' print; the default)
`--control` plants its faults in `after` — one character of one stored statement changed, one declaration removed, one
theorem's kind changed, one `example`'s text changed, and (scope module) one definition's value changed — and must
report exactly that many; exit 0 only then.
What this does not see: a change to a docstring or a comment (not a statement).
"""
import re, subprocess, sys, pathlib

BASE = "223241b0a"   # the skeleton's commit: the base of both branches the merge joined
FILES = {
    "instances": ["Proofs/HadwigerNelson/Instances/UpperHalfValues.lean"],
    "module": ["Proofs/HadwigerNelson/Arith/UpperHalf.lean", "Proofs/HadwigerNelson/Arith/QuadraticPrime.lean",
               "Proofs/HadwigerNelson/Instances/UpperHalfValues.lean"],
}
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


def blank(text):
    return re.sub(r"/-.*?-/", "", text, flags=re.S)  # block comments and docstrings blanked first


def examples(text):
    return [m.group(0).strip() for m in re.finditer(r"^example\b.*?(?=\n[ \t]*\n|\Z)", blank(text), flags=re.M | re.S)]


def main():
    control = "--control" in sys.argv
    scope = sys.argv[sys.argv.index("--scope") + 1] if "--scope" in sys.argv else "module"
    args = [a for a in sys.argv[1:] if not a.startswith("--") and a not in FILES]
    before, after = read_dump(args[0]), read_dump(args[1])
    files = FILES[scope]
    bad = []

    old_text = {f: subprocess.run(["git", "show", f"{BASE}:{f}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout
                for f in files}
    new_text = {f: (ROOT / f).read_text() for f in files}
    old_ex = {f: examples(old_text[f]) for f in files}
    new_ex = {f: examples(new_text[f]) for f in files}

    want = 0
    if control:
        # plant 1: one character of one stored statement changed in `after` (its last: a raw dump and a compact one both carry it)
        victim = "HadwigerNelson.UpperHalf.exists_stablePrime_rat"
        t = after[victim]["type"]
        after[victim]["type"] = t[:-1] + ("!" if t[-1] != "!" else "?")
        # plant 2: one skeleton declaration gone from `after`
        del after["HadwigerNelson.UpperHalf.numberField_bot"]
        # plant 3: one theorem's kind changed (a `theorem` rewritten as a `def`)
        after["HadwigerNelson.UpperHalf.two_le_chromaticNumber_planeOver"]["kind"] = "DEF"
        # plant 4: one `example`'s text changed in the working file's list (a numeral)
        f = FILES["instances"][0]
        new_ex[f] = [new_ex[f][0]] + [new_ex[f][1] + " -- planted"] + new_ex[f][2:]
        want = 4
        # plant 5 (scope module): one definition's value changed
        if scope == "module":
            vdef = "HadwigerNelson.SpectralChain.StablePrime.residue"
            after[vdef]["value"] = after[vdef]["value"] + " x"
            want = 5

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
        if b["kind"] == "DEF" and a["kind"] == "DEF" and a["value"] != b["value"]:
            bad.append(f"VALUE    DEF {name}: the stored definition differs")
    new = sorted(n for n, a in after.items() if n not in before and not a["internal"])

    # a private declaration's stored name (`_private.<module>.0.<name>`) is flagged INTERNAL by the dumper; list the
    # private theorems by their own names (generated children — `_proof_n`, `match_n`, `eq_n` — left out)
    def private_user(n):
        m = re.match(r"_private\.(.*?)\.0\.(.*)$", n)
        if not m:
            return None
        last = m.group(2).split(".")[-1]
        return None if (last.startswith("_") or re.fullmatch(r"(match|eq|proof)_\d+(_\d+)*", last)) else m.group(2)
    new_private = sorted((private_user(n), a["kind"]) for n, a in after.items() if n not in before and private_user(n))
    n_int_b = sum(1 for b in before.values() if b["internal"])
    n_int_a = sum(1 for a in after.values() if a["internal"])

    # the `example`s, as text
    n_ex = 0
    for f in files:
        n_ex += len(old_ex[f])
        if old_ex[f] != new_ex[f]:
            for i, e in enumerate(old_ex[f]):
                if i >= len(new_ex[f]) or new_ex[f][i] != e:
                    bad.append(f"EXAMPLE  {f}: example {i + 1} of {len(old_ex[f])} at {BASE} differs in the working file"); break
            else:
                bad.append(f"EXAMPLE  {f}: {len(old_ex[f])} at {BASE}, {len(new_ex[f])} in the working file")

    # the reader's own check: every declaration written in the base files in scope is a named constant of `before`
    written = []
    for f in files:
        written += re.findall(r"^(?:noncomputable )?(?:@\[simp\] )?(?:theorem|def|abbrev|instance) ([A-Za-z0-9_.]+)",
                              blank(old_text[f]), flags=re.M)
    short = {n.split(".")[-1] for n, b in before.items() if not b["internal"]}
    unseen = [w for w in written if w.split(".")[-1] not in short]
    if unseen or not written:
        print(f"READER BROKEN: {len(written)} declarations written at {BASE}, not in the first dump: {unseen}"); sys.exit(2)

    print(f"scope: {scope} ({len(files)} file(s))")
    print(f"compared: {n_cmp} named constants of the first dump ({n_thm} theorems, {n_def} definitions; kinds, types, and values "
          f"of definitions); {len(written)} declarations written at {BASE}, each found in the first dump")
    print(f"internal (not compared): {n_int_b} before, {n_int_a} after")
    print(f"new named constants in the second dump: {len(new)}")
    for n in new:
        print(f"  NEW {after[n]['kind']} {n}")
    print(f"new private declarations in the second dump (counted among the internal): {len(new_private)}")
    for n, k in new_private:
        print(f"  NEW PRIVATE {k} {n}")
    print(f"`example`s compared as text: {n_ex} at {BASE} (" + ", ".join(f"{len(old_ex[f])} in {pathlib.Path(f).name}" for f in files) + ")")
    for b in bad:
        print(b)
    if control:
        ok = len(bad) == want
        print(f"CONTROL: {len(bad)} of {want} planted faults reported — {'the check can fail' if ok else 'THE CONTROL DID NOT FIRE AS PLANTED'}")
        sys.exit(0 if ok else 1)
    print("PASS: no statement and no definition changed" if not bad else f"FAIL: {len(bad)} difference(s)")
    sys.exit(1 if bad else 0)


if __name__ == "__main__":
    main()
