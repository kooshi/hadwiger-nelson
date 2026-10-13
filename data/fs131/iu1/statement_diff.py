#!/usr/bin/env python3
"""FS131-IU1 — no statement and no definition of `Arith/UpperHalf` changed while its proofs were written.

`before` and `after` are two prints in the format of data/fs131/iu1/lean/StatementDump.lean (kind, full name, stored
type, and for a definition its stored value), made either from the compiled module (`StatementDump.lean`) or from a
copy of the file with `lean/StatementFooter.lean` appended (the same format; used between builds).  Every constant of
`before` that is not INTERNAL (a name Lean generates inside a declaration) must be in `after` with the same kind, the
same type and, for a definition, the same value, character for character.  Constants only in `after` are listed as
NEW: the helpers.  INTERNAL constants are counted, not compared: they move with a proof.

The file's side: an `example` is elaborated and discarded, so the count of `example` heads in the base commit's file
and in the working file is printed (the skeleton holds none; a head in the working file is one this job added).

Usage:  statement_diff.py <before.txt> <after.txt> [--control]
`--control` plants three faults in `after` (one stored statement changed by one token, one definition's value changed,
one skeleton declaration removed) and must report exactly three; exit 0 only then.
What this does not see: a change to a docstring or a comment (not a statement).
"""
import re, subprocess, sys, pathlib

FILE = "Proofs/HadwigerNelson/Arith/UpperHalf.lean"
BASE = "223241b0a"
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
    text = re.sub(r"/-.*?-/", "", text, flags=re.S)  # block comments and docstrings blanked first
    return [m.start() for m in re.finditer(r"^example\b", text, flags=re.M)]


def main():
    control = "--control" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    before, after = read_dump(args[0]), read_dump(args[1])
    bad = []

    if control:
        # plant 1: one token of one stored statement changed in `after`
        victim = "HadwigerNelson.UpperHalf.exists_hom_levelTarget"
        t = after[victim]["type"]
        i = t.index("LE.le")
        after[victim]["type"] = t[:i] + "LT.lt" + t[i + 5:]
        # plant 2: one definition's value changed in `after`
        vdef = "HadwigerNelson.SpectralChain.StablePrime.residue"
        after[vdef]["value"] = after[vdef]["value"] + " x"
        # plant 3: one skeleton declaration gone from `after`
        del after["HadwigerNelson.UpperHalf.localRing_ne_top"]

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
    # private theorems this job added by their own names (generated children — `_proof_n`, `match_n`, `eq_n` — left out)
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
    n_old_ex, n_new_ex = len(example_heads(old)), len(example_heads((ROOT / FILE).read_text()))
    # the reader's own check: every `theorem <name>` / `def <name>` written in the base file is a named constant of `before`
    written = re.findall(r"^(?:noncomputable )?(?:@\[simp\] )?(?:theorem|def|abbrev) ([A-Za-z0-9_.]+)", re.sub(r"/-.*?-/", "", old, flags=re.S), flags=re.M)
    short = {n.split(".")[-1] for n, b in before.items() if not b["internal"]}
    unseen = [w for w in written if w.split(".")[-1] not in short]
    if unseen or not written:
        print(f"READER BROKEN: {len(written)} declarations written at {BASE}, not in the first dump: {unseen}"); sys.exit(2)

    print(f"compared: {n_cmp} named constants of the first dump ({n_thm} theorems, {n_def} definitions; types, and values of definitions); "
          f"{len(written)} declarations written at {BASE}, each found in the first dump")
    print(f"internal (not compared): {n_int_b} before, {n_int_a} after")
    print(f"new named constants in the second dump: {len(new)}")
    for n in new:
        print(f"  NEW {after[n]['kind']} {n}")
    print(f"new private declarations in the second dump (counted among the internal): {len(new_private)}")
    for n, k in new_private:
        print(f"  NEW PRIVATE {k} {n}")
    print(f"`example` heads: {n_old_ex} at {BASE}, {n_new_ex} in the working file")
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
