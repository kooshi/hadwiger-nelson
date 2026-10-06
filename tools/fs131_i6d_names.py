#!/usr/bin/env python3
"""FS131-I6D: do this job's new declaration names collide with a declaration on another branch of the wave?

    python3 tools/fs131_i6d_names.py [ref ...]     (default refs: the wave's branches on origin)

Text level and conservative: the short names declared in this job's modules (`theorem`, `lemma`, `def`, `structure`,
`abbrev`; a leading `_root_.…` path is cut to its last component) are searched as declarations in `Proofs/` on each
ref with `git grep -P` (git's own engine), excluding this job's modules. A hit is a name to look at, never a verdict:
the same short name in another namespace is reported too. The gate's check is `scripts/dupnames.sh` on the joined
tree. `--self-test` asks the same question of a name every ref declares (`polarGraph`, `Plane/Saturated/Fan`) and of
this job's modules against themselves, and each must be reported.
"""
import re
import subprocess
import sys

OWN = [
    "Proofs/HadwigerNelson/Plane/Saturated/CurveArc.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/ArcContinuation.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/FanArcs.lean",
    "Proofs/HadwigerNelson/Plane/Saturated/FanBuild.lean",
]
EXTRA = ["isClosed_sq9Sq", "sq9_essSupport_subset_sq", "sq9_not_isCuspAt", "sq9_pred_ne", "abs_re_im_sub_lt_of_mem_ball",
         "sq9_twoColourNhd_of_re_grid", "sq9_twoColourNhd_of_im_grid", "sq9_singularSet_subset_grid",
         "sq9_singLocallyFinite", "sq9_regJFan"]  # in `FanExamples` and `FanBridge`
DEFAULT_REFS = ["origin/fs131-w6", "origin/fs131-w6c", "origin/fs131-w6g", "origin/fs131-w6p", "origin/fs131-w6m"]
DECL = r"^(?:noncomputable )?(?:@\[[^\]]*\] )?(?:theorem|lemma|def|structure|abbrev) (\S+)"


def own_names():
    names = set()
    for path in OWN:
        try:
            text = open(path).read()
        except FileNotFoundError:
            continue
        for m in re.finditer(DECL, text, flags=re.M):
            names.add(m.group(1).split(".")[-1])
    return sorted(names | set(EXTRA))


def hits(ref, names, exclude_own=True):
    found = []
    for i in range(0, len(names), 40):
        chunk = names[i:i + 40]
        pat = r"^(noncomputable )?(@\[[^\]]*\] )?(theorem|lemma|def|structure|abbrev) (\S+\.)?(" + "|".join(map(re.escape, chunk)) + r")( |$|\{|\()"
        cmd = ["git", "grep", "-n", "-P", pat, ref, "--", "Proofs/"] if ref else \
            ["git", "grep", "--untracked", "-n", "-P", pat, "--", "Proofs/"]
        out = subprocess.run(cmd, capture_output=True, text=True)
        if out.returncode not in (0, 1):
            print(f"ERROR git grep on {ref}: {out.stderr.strip()[:200]}")
            sys.exit(2)
        for line in out.stdout.splitlines():
            if exclude_own and any(f"{p}:" in line for p in OWN):
                continue
            found.append(line)
    return found


def main():
    names = own_names()
    if "--self-test" in sys.argv:
        a = hits("HEAD", ["polarGraph"])
        b = hits(None, names, exclude_own=False)  # the working tree, untracked files included
        c = hits(None, EXTRA, exclude_own=False)
        ok = len(a) >= 1 and len(b) >= len(names) // 2 and len(c) == len(EXTRA)
        print(f"self-test: a name every ref declares is found ({len(a)} hit(s)); own modules against themselves "
              f"({len(b)} hit(s) for {len(names)} names): {'OK' if ok else 'FAILED'}")
        sys.exit(0 if ok else 1)
    refs = [a for a in sys.argv[1:] if not a.startswith("--")] or DEFAULT_REFS
    total = 0
    for ref in refs:
        ok = subprocess.run(["git", "rev-parse", "--verify", "-q", ref], capture_output=True, text=True)
        if ok.returncode != 0:
            print(f"{ref}: no such ref here (not fetched) — NOT CHECKED")
            continue
        h = hits(ref, names)
        total += len(h)
        print(f"{ref} @ {ok.stdout.strip()[:8]}: {len(h)} hit(s) for {len(names)} names")
        for line in h:
            print("   " + line[:200])
    print(f"total hits: {total}")


if __name__ == "__main__":
    main()
