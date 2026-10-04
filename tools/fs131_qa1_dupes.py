#!/usr/bin/env python3
"""FS131-QA1: declarations defined in more than one body's own files (merge collisions and duplicated facts).

Reads the dumps written by fs131_qa1_decls.py (data/fs131/qa1/decls-*.jsonl). A body's own files are those it added or
changed since its fork point (given below); a name declared in the own files of two bodies is either a merge collision
(same namespace, same name: Lean refuses the second) or a duplicated fact under one name. Namespaces are read from the
`namespace` lines of the file at the body's ref (textual; nested namespaces joined).

Usage: fs131_qa1_dupes.py            report
       fs131_qa1_dupes.py --self-test planted control
"""
import json, re, subprocess, sys, collections

BODIES = {  # body: (ref, fork ref whose versions of shared files are not "own")
    "w1": ("main", None),
    "w2": ("fs131-w2", "28a76106"),
    "w3": ("fs131-w3", "da5303b4"),
    "k4": ("f620977c", "05cb0a3e"),   # the wave-4 skeleton both w4 and ww carry
    "w4": ("fs131-w4", "f620977c"),
    "ww": ("fs131-ww", "f620977c"),
}
W1_FILES = ["Basic", "UnitPairs", "AeColouring", "ArcMap", "UnitAvoiding", "DensityPoints", "Chord", "Closure", "Diameter"]


def git(*a):
    return subprocess.run(["git", *a], capture_output=True, text=True).stdout


def own_files(body):
    ref, fork = BODIES[body]
    if body == "w1":
        return [f"Proofs/HadwigerNelson/Plane/{f}.lean" for f in W1_FILES] + \
               ["Proofs/HadwigerNelson/Arith/FalconerFan.lean", "Proofs/HadwigerNelson/Arith/NoAffine.lean"]
    return [p for p in git("diff", "--name-only", fork, ref, "--", "Proofs/HadwigerNelson").split() if p.endswith(".lean")]


def qualified_decls(text):
    """(qualified name, line) for every declaration, tracking namespace/end nesting textually."""
    stack, out = [], []
    decl = re.compile(r"^(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|nonrec)\s+)*"
                      r"(theorem|lemma|def|abbrev|structure|class|inductive|instance|axiom|opaque)\s+([^\s:({\[⦃]+)")
    for i, ln in enumerate(text.split("\n")):
        m = re.match(r"^namespace\s+(\S+)", ln)
        if m:
            stack.append(m.group(1)); continue
        m = re.match(r"^end\s+(\S+)", ln)
        if m and stack and stack[-1] == m.group(1):
            stack.pop(); continue
        m = decl.match(ln)
        if m and m.group(1) != "instance" and "private" not in ln.split(m.group(1))[0]:
            out.append((".".join(stack + [m.group(2)]), i + 1))
    return out


def collect():
    by_name = collections.defaultdict(list)
    for body in BODIES:
        ref = BODIES[body][0]
        for p in own_files(body):
            t = git("show", f"{ref}:{p}")
            for q, line in qualified_decls(t):
                by_name[q].append((body, p.split("HadwigerNelson/")[-1], line))
    return by_name


def report():
    by_name = collect()
    coll = {n: v for n, v in by_name.items() if len({b for b, _, _ in v}) > 1}
    # k4 is an ancestor of w4 and ww: a name in k4 and w4 in the same file is the same declaration, not a duplicate
    real = {}
    for n, v in coll.items():
        files = {(f) for _, f, _ in v}
        bodies = {b for b, _, _ in v}
        if len(files) == 1:
            # one file in every body: an inherited declaration (k4 under w4/ww; wave 1's Chord under w3), not a duplicate
            continue
        real[n] = v
    for n in sorted(real):
        print(n, " | ".join(f"{b}:{f}:{l}" for b, f, l in real[n]))
    print(f"total: {len(real)} names declared in the own files of two bodies")


def self_test():
    t = "namespace A\nnamespace B\ntheorem foo : True := trivial\nend B\ntheorem bar : True := trivial\nend A\n" \
        "private theorem baz : True := trivial\n"
    got = qualified_decls(t)
    ok = [n for n, _ in got] == ["A.B.foo", "A.bar"]
    print("self-test:", "OK" if ok else f"FAIL {got}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(self_test() if sys.argv[1:] == ["--self-test"] else report() or 0)
