#!/usr/bin/env python3
"""FS131-ML1: MERGE's two restored declarations are byte-identical to `fs131-w4mm` at `c9623d04`, and the restore is complete.

For `exists_merge_aux` (`Plane/ValidMap/Moves`) and `exists_merge` (`Plane/ValidMap/Contact`): the docstring and the statement — the
text from the `/--` that opens the declaration's docstring through the `:= by` that ends its statement — must be byte-identical in the
working tree (or at `--rev`) and at the reference revision; each must occur exactly once. Also checked: `Contact`'s body is the one-line
citation `exact exists_merge_aux hF hv hn1 hn hD`; `Moves` imports `MergeMove`; `Contact`'s header names `exists_merge`; `Proofs.lean`
imports `MergeMove`; `ARCHITECTURE.md` has `MergeMove`'s row and names `exists_merge` in `Contact`'s row and `exists_merge_aux` in
`Moves`' row; `scripts/Axioms.lean` records both.

Usage: fs131_ml_restore.py [--rev <rev>] [--ref <rev>]       (defaults: the working tree; reference c9623d04)
       fs131_ml_restore.py --plant    one character of `exists_merge`'s statement changed in memory; must exit 1 naming it
Exit 1 on any failure.
"""
import pathlib
import re
import subprocess
import sys

MOVES = "Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean"
CONTACT = "Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean"


def read(path, rev):
    if rev is None:
        return pathlib.Path(path).read_text()
    return subprocess.run(["git", "show", f"{rev}:{path}"], capture_output=True, text=True, check=True).stdout


def decl(text, name):
    """Every docstring + statement of `theorem <name>` (exact name), from its `/--` through `:= by`."""
    out = []
    for m in re.finditer(r"^theorem " + re.escape(name) + r" ", text, re.M):
        start = text.rfind("/--", 0, m.start())
        end = text.index(":= by", m.start()) + len(":= by")
        # the docstring must end directly before the theorem line
        assert text[start:m.start()].rstrip().endswith("-/"), name
        out.append((text[start:end], end))
    return out


def run(rev, ref, plant):
    bad = []
    moves, contact = read(MOVES, rev), read(CONTACT, rev)
    if plant:
        contact = contact.replace("(hn1 : 1 ≤ n)\n    (hn : F.HasSectors v c (n + 1)) (hD",
                                  "(hn1 : 2 ≤ n)\n    (hn : F.HasSectors v c (n + 1)) (hD", 1)
    for name, path, cur in [("exists_merge_aux", MOVES, moves), ("exists_merge", CONTACT, contact)]:
        want, got = decl(read(path, ref), name), decl(cur, name)
        if len(want) != 1 or len(got) != 1:
            bad.append(f"{name}: {len(got)} occurrence(s) here, {len(want)} at {ref}")
            continue
        if want[0][0] != got[0][0]:
            bad.append(f"{name}: docstring + statement differ from {ref}")
        else:
            print(f"IDENTICAL {name} ({path.split('/')[-1]}): {len(got[0][0].encode())} bytes")
    c = decl(contact, "exists_merge")
    if len(c) == 1:
        body = contact[c[0][1]:].split("\n\n")[0]
        if body.strip() != "exact exists_merge_aux hF hv hn1 hn hD":
            bad.append(f"exists_merge: body is {body.strip()!r}, not the one-line citation")
    checks = [
        ("Moves imports MergeMove", "import Proofs.HadwigerNelson.Plane.ValidMap.MergeMove\n" in moves.split("/-!")[0]),
        ("Contact's header names exists_merge", "* **FS110-W-MERGE**: `exists_merge`.\n" in contact.split("-/")[0]),
        ("Proofs.lean imports MergeMove", "import Proofs.HadwigerNelson.Plane.ValidMap.MergeMove\n" in read("Proofs.lean", rev)),
    ]
    arch = read("ARCHITECTURE.md", rev)
    rows = {m.group(1): m.group(0) for m in re.finditer(r"^\| `(Plane/ValidMap/\w+)` \|.*$", arch, re.M)}
    checks += [
        ("ARCHITECTURE has MergeMove's row", "Plane/ValidMap/MergeMove" in rows),
        ("ARCHITECTURE's Contact row names exists_merge", "`exists_merge`" in rows.get("Plane/ValidMap/Contact", "")),
        ("ARCHITECTURE's Moves row names exists_merge_aux", "`exists_merge_aux`" in rows.get("Plane/ValidMap/Moves", "")),
    ]
    ax = read("scripts/Axioms.lean", rev)
    for n in ["exists_merge", "exists_merge_aux"]:
        checks.append((f"Axioms records ArcMap.{n}",
                       len(re.findall(rf"^#print axioms HadwigerNelson\.Plane\.ArcMap\.{n}$", ax, re.M)) == 1))
    for b in bad:
        print("FAIL", b)
    for what, ok in checks:
        print(("ok   " if ok else "FAIL ") + what)
        if not ok:
            bad.append(what)
    print("restore:", "PASS" if not bad else f"FAIL ({len(bad)})")
    return 1 if bad else 0


if __name__ == "__main__":
    a = sys.argv[1:]
    rev = a[a.index("--rev") + 1] if "--rev" in a else None
    ref = a[a.index("--ref") + 1] if "--ref" in a else "c9623d04"
    sys.exit(run(rev, ref, "--plant" in a))
