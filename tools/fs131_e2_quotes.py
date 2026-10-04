#!/usr/bin/env python3
"""FS131-E2: check every quotation of the claim list against its source, and the brief's three quotations against the
claim list. Exact substring checks (whitespace normalised only where a quoted block was re-wrapped is NOT allowed: the
check is verbatim, line by line, after stripping the fence's own indentation-free copy).

--plant: perturb one quoted character and confirm the check goes red."""
import re
import subprocess
import sys

ROOT = "/home/kooshi/source/lean-dir"


def read(path):
    with open(f"{ROOT}/{path}", encoding="utf-8") as f:
        return f.read()


def git_show(rev, path):
    return subprocess.run(["git", "-C", ROOT, "show", f"{rev}:{path}"], capture_output=True, text=True,
                          check=True).stdout


def fenced_blocks(text):
    return re.findall(r"```[a-z]*\n(.*?)```", text, flags=re.S)


def main(plant):
    claims = read("data/fs131/claims-E2.md")
    brief = read("data/fs131/briefs/FS131-E2-cusp-case.md")
    blocks = fenced_blocks(claims)
    results = []

    # 1. the hand statement: fenced block 0 is two field lines of FS116-V5-U1's entry
    src = read("plans/FS116-derivation.md")
    b0 = blocks[0]
    if plant:
        b0 = b0.replace("facing A", "facing  A", 1)
    # the block holds two of the entry's fields (statement; not claimed) — `uses only:` sits between them in the source
    stmt, nc = b0.split("  not claimed:", 1)
    nc = "  not claimed:" + nc
    results.append(("V5-U1 statement field (claims block 1) in plans/FS116-derivation.md", stmt in src))
    results.append(("V5-U1 not-claimed field (claims block 1) in plans/FS116-derivation.md", nc in src))
    # and both fields belong to the entry 'derivation: FS116-V5-U1' (the first occurrence of the statement follows that header)
    hdr = src.find("derivation: FS116-V5-U1\n")
    results.append(("those fields are FS116-V5-U1's entry", hdr >= 0 and src.find(stmt, hdr) == hdr + len("derivation: FS116-V5-U1\n")))

    # 2. the formal statements at 05cb0a3e (block 1) and 4f7b949d (block 2), each a sequence of chunks separated by blank lines
    for i, rev in ((1, "05cb0a3e"), (2, "4f7b949d")):
        lean = git_show(rev, "Proofs/HadwigerNelson/Plane/RingGerm.lean")
        for j, chunk in enumerate(blocks[i].strip("\n").split("\n\n")):
            results.append((f"Lean block {i + 1} chunk {j + 1} in RingGerm.lean @ {rev}", chunk in lean))

    # 3. inventory item 112, verbatim: the claim list's quoted paragraph (from '112. ' to the end of 'Wave 4 note' sentence)
    inv = read("plans/FS131-close-inventory.md")
    m = re.search(r"^112\. .*?for wave 4's implementer brief\.", claims, flags=re.S | re.M)
    q112 = m.group(0) if m else None
    results.append(("inventory item 112 in plans/FS131-close-inventory.md", q112 is not None and q112 in inv))

    # 4. FS112-N3-NOBOTH's entry (two paragraphs)
    fs112 = read("plans/FS112-derivation.md")
    m = re.search(r"^\*\*FS112-N3-NOBOTH — .*?\*Kernel:\* stub — with FS-114\.", claims, flags=re.S | re.M)
    qnb = m.group(0) if m else None
    results.append(("FS112-N3-NOBOTH entry in plans/FS112-derivation.md", qnb is not None and qnb in fs112))

    # 5. the brief's three quotations, each the '> ...' lines before its '— source:' line
    for qm in re.finditer(r"((?:^> (?!— source).*\n)+)> — source: data/fs131/claims-E2.md § The questions", brief, flags=re.M):
        lines = [ln[2:] for ln in qm.group(1).splitlines()]
        text = "\n".join(lines)
        results.append((f"brief quotation '{text[:40]}…' in the claim list", text in claims))

    ok = all(r for _, r in results)
    for name, r in results:
        print(("ok    " if r else "FAIL  ") + name)
    print(f"checks: {len(results)}  " + ("QUOTES ALL OK" if ok else "QUOTES FAIL"))
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main("--plant" in sys.argv))
