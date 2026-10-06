#!/usr/bin/env python3
"""FS131-I5n: ruling 348 (a)'s swap — `exists_merge`'s statement and docstring on `fs131-w5c` replaced by `fs131-w4mm`'s (ruling 269's form).

The block is the docstring opening `/-- **FS110-W-MERGE**` through the statement's `:= by` line. The source is read from the committed
ref `origin/fs131-w4mm` (or `--ref`), never from that tree's working copy, which another job edits. The `sorry` body below `:= by` is kept.

  python3 tools/fs131_i5n_merge_swap.py --apply        # rewrite this tree's Contact.lean (fails unless exactly one block in each)
  python3 tools/fs131_i5n_merge_swap.py --check        # exit 0 iff the two blocks are byte-identical; prints the diff otherwise
  python3 tools/fs131_i5n_merge_swap.py --self-test    # plants a one-character change in a copy of this tree's block; --check must fail
"""
import difflib
import subprocess
import sys
from pathlib import Path

TREE = Path(__file__).resolve().parent.parent
PATH = "Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean"
MAIN = Path("/home/kooshi/source/lean-dir")
START = "/-- **FS110-W-MERGE**"
END = ":= by"


def ref_arg() -> str:
    if "--ref" in sys.argv:
        return sys.argv[sys.argv.index("--ref") + 1]
    return "origin/fs131-w4mm"


def source_text(ref: str) -> str:
    return subprocess.run(["git", "-C", str(MAIN), "show", f"{ref}:{PATH}"], check=True, capture_output=True,
                          text=True).stdout


def block(text: str) -> tuple[int, int]:
    """(start, end) character offsets of the unique W-MERGE docstring + statement block, end just after `:= by`."""
    starts = [i for i in range(len(text)) if text.startswith(START, i)]
    if len(starts) != 1:
        raise SystemExit(f"expected exactly one '{START}', found {len(starts)}")
    s = starts[0]
    j = text.find("theorem exists_merge ", s)
    if j < 0:
        raise SystemExit("no 'theorem exists_merge ' after the docstring")
    e = text.find(END, j)
    if e < 0:
        raise SystemExit("no ':= by' after the statement")
    e += len(END)
    if text.count("theorem exists_merge ") != 1:
        raise SystemExit("expected exactly one 'theorem exists_merge '")
    return s, e


def diff(a: str, b: str) -> list[str]:
    return list(difflib.unified_diff(a.splitlines(), b.splitlines(), "fs131-w4mm", "fs131-w5c", lineterm=""))


def check(here: str, there: str) -> int:
    s1, e1 = block(here)
    s2, e2 = block(there)
    d = diff(there[s2:e2], here[s1:e1])
    if d:
        print("\n".join(d))
        print("DIFFERENT — the two exists_merge statement blocks are not identical")
        return 1
    print(f"IDENTICAL — exists_merge's docstring and statement ({e1 - s1} characters, "
          f"{here[s1:e1].count(chr(10)) + 1} lines) equal {ref_arg()}'s; the body after ':= by' begins "
          f"{here[e1:e1 + 12]!r}")
    return 0


def main():
    there = source_text(ref_arg())
    p = TREE / PATH
    here = p.read_text()
    if "--apply" in sys.argv:
        s1, e1 = block(here)
        s2, e2 = block(there)
        old = here[s1:e1]
        new = here[:s1] + there[s2:e2] + here[e1:]
        print("\n".join(diff(old, there[s2:e2])))
        p.write_text(new)
        sys.exit(check(new, there))
    if "--self-test" in sys.argv:
        s1, e1 = block(here)
        k = here.find("F'.coloursAt v", s1, e1)
        planted = here[:k] + "F'.coloursAt w" + here[k + len("F'.coloursAt v"):] if k >= 0 else here[:s1] + "X" + here[s1:]
        rc = check(planted, there)
        print("SELF-TEST:", "FIRED (good)" if rc != 0 else "DID NOT FIRE (bad)")
        sys.exit(0 if rc != 0 else 1)
    sys.exit(check(here, there))


if __name__ == "__main__":
    main()
