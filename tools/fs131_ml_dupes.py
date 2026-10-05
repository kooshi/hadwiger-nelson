#!/usr/bin/env python3
"""FS131-ML1: names this branch's own files declare that `main` also declares in another file (MERGE's landing).

`tools/fs131_qa1_dupes.py` (FS131-QA1, read-only here) compares the bodies in its fixed table, which has no entry for
`fs131-w4mm`; this tool asks the same question of the one merge it was written for, with QA1's textual namespace tracking
(`qualified_decls`, imported, never copied). A branch file is "own" when it changed since the fork; a name declared in an own
file and, at `main`, in a different file is a collision when the two files meet in one environment (Lean refuses the second)
and a repeated fact otherwise. Each pair is classed IDENTICAL (the declaration's text up to its first `:=`, whitespace
normalized, is the same on both sides) or DIFFERS. A name declared in the same file on both sides is the same declaration
inherited from the fork, not a pair.

Usage: fs131_ml_dupes.py [<branch ref> <main ref> <fork ref>]   (defaults: HEAD origin/main 73d31ad6)
       fs131_ml_dupes.py --plant [...]   add two synthetic own files repeating real `main` names, one
       statement changed, one verbatim; must report DIFFERS and IDENTICAL, exit 1
Exit 1 on any pair.
"""
import collections
import pathlib
import re
import subprocess
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from fs131_qa1_dupes import qualified_decls  # noqa: E402


def git(*a):
    return subprocess.run(["git", *a], capture_output=True, text=True, check=True).stdout


def head_text(text, line):
    """The declaration starting at 1-based `line`, up to its first `:=` (or the next blank line), normalized."""
    rest = "\n".join(text.split("\n")[line - 1:])
    m = re.match(r"(.*?)(:=|\n\s*\n)", rest, re.S)
    return " ".join((m.group(1) if m else rest).split())


def decls_at(ref, paths):
    out = collections.defaultdict(list)
    for p in paths:
        t = git("show", f"{ref}:{p}")
        for q, line in qualified_decls(t):
            out[q].append((p, line, head_text(t, line)))
    return out


def run(branch, main, fork, plant=False):
    own = [p for p in git("diff", "--name-only", fork, branch, "--", "Proofs").split() if p.endswith(".lean")]
    ours = decls_at(branch, own)
    if plant:
        # two synthetic own files: `main`'s `ArcMap.exists_shave_aux` (in `Moves`) under a different statement (must read
        # DIFFERS), and `main`'s `ArcMap.exists_rayMerge_aux` with its statement copied verbatim from `main` (must read IDENTICAL)
        mv = git("show", f"{main}:Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean")
        ray = re.search(r"^theorem exists_rayMerge_aux.*?:= by", mv, re.S | re.M).group(0)
        for name, t in [("PLANTED-DIFFERS.lean", "theorem exists_shave_aux : True := trivial"),
                        ("PLANTED-IDENTICAL.lean", ray + "\n  sorry")]:
            t = "namespace HadwigerNelson.Plane\nnamespace ArcMap\n" + t + "\nend ArcMap\nend HadwigerNelson.Plane\n"
            for q, line in qualified_decls(t):
                ours[q].append((name, line, head_text(t, line)))
    allm = [p for p in git("ls-tree", "-r", "--name-only", main, "Proofs").split() if p.endswith(".lean")]
    theirs = decls_at(main, allm)
    pairs = 0
    for q in sorted(ours):
        if q not in theirs:
            continue
        for (po, lo, ho) in ours[q]:
            for (pt, lt, ht) in theirs[q]:
                if po == pt:
                    continue
                pairs += 1
                kind = "IDENTICAL" if ho == ht else "DIFFERS"
                print(f"{kind} {q}  ours {po}:{lo}  main {pt}:{lt}")
    print(f"own files {len(own)} ({', '.join(p.split('HadwigerNelson/')[-1] for p in own)}); "
          f"{sum(len(v) for v in ours.values())} own declarations; {len(theirs)} names at {main}; {pairs} pair(s)")
    return 1 if pairs else 0


if __name__ == "__main__":
    a = [x for x in sys.argv[1:] if x != "--plant"]
    refs = a if a else ["HEAD", "origin/main", "73d31ad6"]
    sys.exit(run(*refs, plant="--plant" in sys.argv))
