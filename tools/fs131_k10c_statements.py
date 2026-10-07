#!/usr/bin/env python3
"""FS131-K10c: no statement of a fixed module may move across a merge.

For each file named, the declaration heads (keyword, name, binders and type, up to the `:=` or `where` that opens the
body) at a base commit are compared with those in the working tree.  A head present at the base must be present,
character for character after whitespace is normalized, in the tree; heads only in the tree are listed as ADDED.

    tools/fs131_k10c_statements.py <base-commit> <file> [<file> ...]     exit 0: none changed or removed
    tools/fs131_k10c_statements.py --self-test                           plants three faults, watches each fire

Docstrings and proofs are not compared (the kernel checks proofs; a docstring is not a statement).
A file with no declaration at the base is an error (exit 2), never a pass: a check that read nothing checked nothing.
"""
import re
import subprocess
import sys

KW = r"(?:theorem|lemma|def|abbrev|structure|inductive|instance|axiom|class|opaque)"
START = re.compile(r"^(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|scoped|local)\s+)*" + KW + r"\b")


def strip_comments(text: str) -> str:
    """Remove block comments (nested) and line comments."""
    out, i, depth = [], 0, 0
    while i < len(text):
        if text.startswith("/-", i):
            depth += 1
            i += 2
        elif depth and text.startswith("-/", i):
            depth -= 1
            i += 2
        elif depth:
            if text[i] == "\n":
                out.append("\n")
            i += 1
        elif text.startswith("--", i):
            while i < len(text) and text[i] != "\n":
                i += 1
        else:
            out.append(text[i])
            i += 1
    return "".join(out)


def heads(text: str) -> dict:
    """name-or-anonymous-key -> normalized head."""
    lines = strip_comments(text).split("\n")
    found, i, anon = {}, 0, 0
    while i < len(lines):
        if START.match(lines[i]):
            buf = []
            j = i
            while j < len(lines):
                ln = lines[j]
                cut = None
                m = re.search(r":=|\bwhere\s*$", ln)
                if m:
                    cut = m.start()
                # a structure/inductive with no `where`/`:=` on its head ends at the next blank line
                if cut is not None:
                    buf.append(ln[:cut])
                    break
                if j > i and ln.strip() == "":
                    break
                buf.append(ln)
                j += 1
            head = " ".join(" ".join(buf).split())
            m = re.match(r"^(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|scoped|local)\s+)*" + KW + r"\s+([^\s:({\[]+)", head)
            if m:
                key = m.group(1)
            else:
                anon += 1
                key = f"<anonymous {anon}>"
            if key in found:
                key = key + "#2"
            found[key] = head
            i = j + 1
        else:
            i += 1
    return found


def compare(base_text: str, new_text: str, label: str):
    b, n = heads(base_text), heads(new_text)
    if not b:
        print(f"ERROR   {label}: no declaration read at the base — nothing was checked")
        return None
    changed = [k for k in b if k in n and b[k] != n[k]]
    removed = [k for k in b if k not in n]
    added = [k for k in n if k not in b]
    for k in changed:
        print(f"CHANGED {label}: {k}\n   base: {b[k]}\n   tree: {n[k]}")
    for k in removed:
        print(f"REMOVED {label}: {k}")
    print(f"{label}: {len(b)} heads at the base, {len(changed)} changed, {len(removed)} removed, {len(added)} added"
          + (": " + ", ".join(added) if added else ""))
    return len(changed) + len(removed)


def self_test() -> int:
    base = (
        "/-- doc -/\ntheorem foo {F : Type*} [Field F] (h : a ≠ 0) :\n    a * b = c := by\n  simp\n\n"
        "def Bar (n : ℕ) : Prop :=\n  n = 0\n\n-- theorem ghost : False := sorry\n"
    )
    ok = True
    # control: identical text passes
    r = compare(base, base, "control-identical")
    ok &= (r == 0)
    # fault 1: a hypothesis dropped
    r = compare(base, base.replace("(h : a ≠ 0) ", ""), "fault-hypothesis-dropped")
    ok &= (r == 1)
    # fault 2: a declaration removed
    r = compare(base, base.replace("def Bar (n : ℕ) : Prop :=\n  n = 0\n", ""), "fault-removed")
    ok &= (r == 1)
    # fault 3: a conclusion changed
    r = compare(base, base.replace("a * b = c", "a * b = d"), "fault-conclusion")
    ok &= (r == 1)
    # partner: a proof changed, a docstring changed, a declaration added — must pass
    r = compare(base, base.replace("simp", "ring").replace("doc", "other") + "\ntheorem new : True := trivial\n", "partner-proof-doc-added")
    ok &= (r == 0)
    # a file with no declaration is an error, never a pass
    r = compare("-- nothing here\n", "-- nothing here\n", "empty-file")
    ok &= (r is None)
    # the commented-out theorem is not a head
    ok &= ("ghost" not in heads(base))
    print("self-test:", "all controls behaved" if ok else "A CONTROL MISBEHAVED")
    return 0 if ok else 1


def main() -> int:
    if len(sys.argv) >= 2 and sys.argv[1] == "--self-test":
        return self_test()
    if len(sys.argv) < 3:
        print(__doc__)
        return 2
    base = sys.argv[1]
    total, err = 0, False
    for f in sys.argv[2:]:
        p = subprocess.run(["git", "show", f"{base}:{f}"], capture_output=True, text=True)
        if p.returncode != 0:
            print(f"ERROR   {f}: not at {base}")
            err = True
            continue
        r = compare(p.stdout, open(f).read(), f)
        if r is None:
            err = True
        else:
            total += r
    if err:
        return 2
    print(f"TOTAL: {total} changed or removed")
    return 1 if total else 0


if __name__ == "__main__":
    sys.exit(main())
