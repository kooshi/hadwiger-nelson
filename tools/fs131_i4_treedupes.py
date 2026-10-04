#!/usr/bin/env python3
"""FS131-I4l: qualified declaration names declared more than once anywhere in the working tree's `Proofs/` (a merge collision,
or one fact under one name twice). `tools/fs131_qa1_dupes.py` compares bodies (branches) and skips a name repeated inside one
body; after a merge both sides are one body, so this scans the tree itself, with QA1's textual namespace tracking
(`qualified_decls`, imported, never copied). Exit 1 on any repeat.

Usage: fs131_i4_treedupes.py              report on the working tree
       fs131_i4_treedupes.py --rev <rev>  report on a committed revision (to tell a merge's repeats from its parents')
       fs131_i4_treedupes.py --plant      add one synthetic file repeating a real name; must report it and exit 1
"""
import collections, pathlib, subprocess, sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from fs131_qa1_dupes import qualified_decls  # noqa: E402


def tree_texts(rev):
    if rev is None:
        return [(str(p), p.read_text()) for p in sorted(pathlib.Path("Proofs").rglob("*.lean"))]
    names = subprocess.run(["git", "ls-tree", "-r", "--name-only", rev, "Proofs"], capture_output=True, text=True,
                           check=True).stdout.split()
    return [(p, subprocess.run(["git", "show", f"{rev}:{p}"], capture_output=True, text=True, check=True).stdout)
            for p in names if p.endswith(".lean")]


def scan(extra=(), rev=None):
    by_name = collections.defaultdict(list)
    texts = tree_texts(rev) + list(extra)
    for path, text in texts:
        for q, line in qualified_decls(text):
            by_name[q].append(f"{path}:{line}")
    return len(texts), by_name


def main():
    extra = []
    if sys.argv[1:] == ["--plant"]:
        # a real name from a wave-4 module, repeated in a synthetic file under the same namespace
        extra = [("PLANTED.lean", "namespace HadwigerNelson.Plane\nnamespace ArcMap\ntheorem pair_i : True := trivial\nend ArcMap\n"
                  "end HadwigerNelson.Plane\n")]
    rev = sys.argv[sys.argv.index("--rev") + 1] if "--rev" in sys.argv else None
    n, by_name = scan(extra, rev)
    rep = {q: v for q, v in by_name.items() if len(v) > 1}
    for q in sorted(rep):
        print("REPEAT", q, " | ".join(rep[q]))
    print(f"{n} files, {sum(len(v) for v in by_name.values())} declarations, {len(by_name)} names, {len(rep)} repeated")
    return 1 if rep else 0


if __name__ == "__main__":
    sys.exit(main())
