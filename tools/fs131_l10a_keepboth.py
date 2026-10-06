#!/usr/bin/env python3
"""FS131-L10A: resolve a keep-both conflict in scripts/Axioms.lean, and check a resolution.

  tools/fs131_l10a_keepboth.py resolve <file>
      Every conflict hunk `<<<<<<< / ======= / >>>>>>>` becomes: ours, a blank line, theirs.
      Refuses a diff3-style hunk (`|||||||`) and a file with no hunk.

  tools/fs131_l10a_keepboth.py check <file> <ours-ref> <theirs-ref> <base-ref> [<path-in-git>]
      The resolved <file> must hold no conflict marker; every line of the file at <ours-ref> and at
      <theirs-ref>, with its multiplicity, must be in it (blank lines apart); and its count of
      `#print axioms` lines must be ours + theirs - base. No `#print axioms` name may occur twice.
      Exit 0 iff all hold.

  tools/fs131_l10a_keepboth.py --self-test <file> <ours-ref> <theirs-ref> <base-ref>
      Runs `check` on the file, then on three plants written to a scratch copy: a record of theirs
      dropped (LOST), a record doubled (TWICE), a marker left in (MARKER). Exit 0 iff the faithful
      run passes and each plant fails with its own word.
"""
import collections
import subprocess
import sys
import tempfile

PATH = "scripts/Axioms.lean"


def show(ref, path):
    return subprocess.run(["git", "show", f"{ref}:{path}"], check=True, capture_output=True,
                          text=True).stdout


def resolve(path):
    out, state, n = [], None, 0
    for ln in open(path, encoding="utf-8").read().split("\n"):
        if ln.startswith("<<<<<<< "):
            assert state is None, "nested hunk"
            state, n = "ours", n + 1
        elif ln.startswith("||||||| "):
            sys.exit("refused: a diff3-style hunk")
        elif ln == "=======" and state == "ours":
            state = "theirs"
            out.append("")
        elif ln.startswith(">>>>>>> ") and state == "theirs":
            state = None
        else:
            out.append(ln)
    if state is not None:
        sys.exit("refused: an unterminated hunk")
    if n == 0:
        sys.exit("refused: no conflict hunk in the file")
    open(path, "w", encoding="utf-8").write("\n".join(out))
    print(f"resolved {n} hunk(s) in {path}")


def check_text(text, ours, theirs, base):
    faults = []
    lines = text.split("\n")
    for ln in lines:
        if ln.startswith(("<<<<<<< ", ">>>>>>> ", "||||||| ")) or ln == "=======":
            faults.append(f"MARKER {ln[:40]!r}")
    have = collections.Counter(l for l in lines if l.strip())
    for name, side in (("ours", ours), ("theirs", theirs)):
        need = collections.Counter(l for l in side.split("\n") if l.strip())
        for l, k in need.items():
            if have[l] < k:
                faults.append(f"LOST from {name}: {l[:90]!r} (need {k}, have {have[l]})")
    cnt = lambda t: sum(1 for l in t.split("\n") if l.startswith("#print axioms "))
    exp = cnt(ours) + cnt(theirs) - cnt(base)
    if cnt(text) != exp:
        faults.append(f"COUNT #print axioms: have {cnt(text)}, expected ours {cnt(ours)} + theirs "
                      f"{cnt(theirs)} - base {cnt(base)} = {exp}")
    names = collections.Counter(l.split()[2] for l in lines if l.startswith("#print axioms "))
    for nm, k in names.items():
        if k > 1:
            faults.append(f"TWICE {nm} ({k})")
    return faults, cnt(text), cnt(ours), cnt(theirs), cnt(base)


def check(path, ours_ref, theirs_ref, base_ref, gitpath=PATH, label="check"):
    text = open(path, encoding="utf-8").read()
    faults, c, co, ct, cb = check_text(text, show(ours_ref, gitpath), show(theirs_ref, gitpath),
                                       show(base_ref, gitpath))
    print(f"{label}: #print axioms lines {c} = ours {co} + theirs {ct} - base {cb}; "
          f"faults {len(faults)}")
    for f in faults[:12]:
        print("  " + f)
    return faults


def main(argv):
    if len(argv) >= 2 and argv[0] == "resolve":
        resolve(argv[1])
        return 0
    if len(argv) >= 5 and argv[0] == "check":
        faults = check(argv[1], argv[2], argv[3], argv[4], *(argv[5:6] or [PATH]))
        print("keep-both: PASS" if not faults else "keep-both: FAIL")
        return 1 if faults else 0
    if len(argv) == 5 and argv[0] == "--self-test":
        path, o, t, b = argv[1:]
        ok = not check(path, o, t, b, label="faithful")
        text = open(path, encoding="utf-8").read()
        ours_names = {l for l in show(o, PATH).split("\n") if l.startswith("#print axioms ")}
        theirs_only = [l for l in show(t, PATH).split("\n")
                       if l.startswith("#print axioms ") and l not in ours_names]
        victim = theirs_only[0]
        plants = {
            "LOST": text.replace(victim + "\n", "", 1),
            "TWICE": text.replace(victim + "\n", victim + "\n" + victim + "\n", 1),
            "MARKER": text.replace(victim + "\n", "=======\n" + victim + "\n", 1),
        }
        for word, planted in plants.items():
            with tempfile.NamedTemporaryFile("w", suffix=".lean", delete=False, encoding="utf-8") as f:
                f.write(planted)
            faults = check(f.name, o, t, b, label=f"plant {word}")
            fired = any(x.startswith(word) for x in faults)
            print(f"  plant {word}: {'fired' if fired else 'DID NOT FIRE'}")
            ok = ok and fired
        print("self-test: PASS" if ok else "self-test: FAIL")
        return 0 if ok else 1
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
