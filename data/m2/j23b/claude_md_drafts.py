#!/usr/bin/env python3
"""J23b: parse the CLAUDE.md drafts in plans/M2-kernel-lane.md §R-close stage 4 (blocks after `<!-- draft D-n op=X -->`), check each
anchor occurs exactly once in CLAUDE.md, apply them in order to a scratch copy, and print the net byte change. Never writes CLAUDE.md.

ops: replace (old → new); after (insert new right after the anchor); span (replace from start through end, inclusive); line (replace
the one whole line that begins with the given prefix).  --self-test plants an anchor that is absent and one that occurs twice."""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]

def parse(plan: str):
    sec = plan.split("### Stage 4 — SAVED", 1)[1]
    drafts = []
    parts = re.split(r"<!-- draft (D-[0-9a-z]+) op=(\w+) -->", sec)
    for i in range(1, len(parts), 3):
        did, op, body = parts[i], parts[i + 1], parts[i + 2]
        blocks = dict(re.findall(r"```(old|new|after|start|end|line)\n(.*?)\n```", body, re.S))
        drafts.append((did, op, blocks))
    return drafts

def apply(text: str, drafts, strict=True):
    errors = []
    for did, op, b in drafts:
        new = b.get("new", "")
        if op == "replace":
            n = text.count(b["old"])
            if n != 1: errors.append(f"{did}: old occurs {n} times"); continue
            text = text.replace(b["old"], new)
        elif op == "after":
            n = text.count(b["after"])
            if n != 1: errors.append(f"{did}: anchor occurs {n} times"); continue
            text = text.replace(b["after"], b["after"] + new)
        elif op == "span":
            s, e = text.count(b["start"]), text.count(b["end"])
            if s != 1 or e != 1: errors.append(f"{did}: start {s}, end {e} occurrences"); continue
            i, j = text.index(b["start"]), text.index(b["end"]) + len(b["end"])
            if j <= i: errors.append(f"{did}: end before start"); continue
            text = text[:i] + new + text[j:]
        elif op == "line":
            lines = text.split("\n"); hits = [k for k, l in enumerate(lines) if l.startswith(b["line"])]
            if len(hits) != 1: errors.append(f"{did}: line prefix matches {len(hits)} lines"); continue
            lines[hits[0]] = new; text = "\n".join(lines)
        else:
            errors.append(f"{did}: unknown op {op}")
    return text, errors

def main():
    plan = (ROOT / "plans/M2-kernel-lane.md").read_text()
    drafts = parse(plan)
    base = (ROOT / "CLAUDE.md").read_text()
    if "--self-test" in sys.argv:
        bad = drafts + [("PLANT-absent", "replace", {"old": "no such text anywhere §§§", "new": "x"}),
                        ("PLANT-twice", "after", {"after": "G63", "new": "x"})]
        _, errs = apply(base, bad)
        fired = [e for e in errs if e.startswith("PLANT")]
        print("self-test:", "OK" if len(fired) == 2 else "FAILED", fired); sys.exit(0 if len(fired) == 2 else 1)
    out, errs = apply(base, drafts)
    b0, b1 = len(base.encode()), len(out.encode())
    print(f"drafts: {len(drafts)} ({', '.join(d for d, _, _ in drafts)})")
    for e in errs: print("ERROR", e)
    print(f"CLAUDE.md {b0} bytes -> {b1} bytes: net {b1 - b0:+d} (budget +4000; file ceiling 300000)")
    sys.exit(1 if errs else 0)

main()
