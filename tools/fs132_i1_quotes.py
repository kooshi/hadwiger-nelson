#!/usr/bin/env python3
"""FS132-I1 — the brief's quotations, each checked against its source (standing rule 3).

A quotation is a run of lines beginning "> " that ends at a line "> — source: <path> [<section>]".
Each is checked as a whitespace-normalised substring of its source file.  A relative path is read
under --root (this job's worktree, the tree the module is built in); an absolute path as given.

  fs132_i1_quotes.py BRIEF [--root DIR]      print one line per quotation; exit 1 on any MISMATCH
  fs132_i1_quotes.py BRIEF --self-test       plant three faults (a changed word, a wrong source, an
                                             empty quotation) and require each to be refused, and the
                                             unplanted brief to pass with at least one quotation read

The parser's pattern is `tools/fs131_rp_quotes.py`'s (another job's tool, not edited); what is this
job's own: the default root, and the count printed per source so a quotation the parser dropped shows.
"""
import re
import sys
from collections import Counter
from pathlib import Path

DEFAULT_ROOT = Path(__file__).resolve().parent.parent


def norm(s: str) -> str:
    return re.sub(r"\s+", " ", s).strip()


def quotations(text: str):
    out, cur = [], []
    for ln in text.splitlines():
        if ln.startswith("> — source:"):
            out.append(("\n".join(cur), ln[len("> — source:"):].strip()))
            cur = []
        elif ln.startswith("> "):
            cur.append(ln[2:])
        elif ln.strip() == ">":
            cur.append("")
        else:
            cur = []
    return out


def check(text: str, root: Path):
    rows, bad = [], 0
    for q, src in quotations(text):
        path = src.split()[0]
        p = Path(path) if path.startswith("/") else root / path
        if not norm(q):
            rows.append(("MISMATCH", src, "empty quotation"))
            bad += 1
            continue
        if not p.is_file():
            rows.append(("MISMATCH", src, f"no such file: {p}"))
            bad += 1
            continue
        hay = norm(p.read_text(encoding="utf-8", errors="replace"))
        if norm(q) in hay:
            rows.append(("OK", src, norm(q)[:70]))
        else:
            rows.append(("MISMATCH", src, norm(q)[:70]))
            bad += 1
    return rows, bad


def main(argv):
    if len(argv) < 2:
        print(__doc__)
        return 2
    brief = Path(argv[1]).read_text(encoding="utf-8")
    root = Path(argv[argv.index("--root") + 1]) if "--root" in argv else DEFAULT_ROOT
    if "--self-test" in argv:
        rows, bad = check(brief, root)
        if bad or not rows:
            print(f"SELF-TEST FAILED: the unplanted brief has {bad} mismatches over {len(rows)} quotations")
            return 1
        qs = quotations(brief)
        first_q, first_src = qs[0]
        word = first_q.split()[3]
        plants = {
            "a changed word": brief.replace(first_q, first_q.replace(word, word + "X", 1), 1),
            "a wrong source": brief.replace("> — source: " + first_src, "> — source: plans/STANDING-RULES.md", 1),
            "an empty quotation": brief.replace("> " + first_q.splitlines()[0], "> ", 1),
        }
        ok = True
        for name, planted in plants.items():
            if planted == brief:
                print(f"SELF-TEST FAILED: plant '{name}' did not change the brief")
                ok = False
                continue
            _, b = check(planted, root)
            print(f"plant '{name}': {'FIRED' if b else 'SILENT'} ({b} mismatch)")
            ok = ok and b >= 1
        print(f"SELF-TEST {'OK' if ok else 'FAILED'}: {len(rows)} quotations read unplanted, 0 mismatches; 3 plants")
        return 0 if ok else 1
    rows, bad = check(brief, root)
    for st, src, q in rows:
        print(f"{st}\t{src[:90]}\t{q}")
    per = Counter(src.split()[0] for _, src, _ in rows)
    for path, n in sorted(per.items()):
        print(f"  source {path}: {n}")
    print(f"quotations: {len(rows)}  mismatches: {bad}  root: {root}")
    if not rows:
        print("NO QUOTATION READ — the parser found none; that is a failure, not a pass")
        return 1
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
