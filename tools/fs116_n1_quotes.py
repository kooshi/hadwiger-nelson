#!/usr/bin/env python3
"""FS116-N1 readback: every blockquote in the brief, searched verbatim (whitespace-normalised) in the source it names.

A quote block in the brief is a run of lines starting with '> ' followed by a line '> — source: <path> § <section>'.
Normalisation: collapse whitespace only. Exit 1 if any quote is NOT FOUND or if the plant does not fire.
--plant: search a copy of the first quote with one word changed ('contained' -> 'included'); it must be NOT FOUND.
"""
import os, re, sys

os.chdir(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))  # the repository root, whatever the caller's cwd

BRIEF = "data/fs116/briefs/FS116-N1-ring.md"


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


def blocks(text):
    out, cur = [], []
    for line in text.splitlines():
        if line.startswith(">"):
            cur.append(line[1:].lstrip())
        else:
            if cur:
                out.append(cur)
            cur = []
    if cur:
        out.append(cur)
    res = []
    for b in out:
        src = [l for l in b if l.startswith("— source:")]
        body = [l for l in b if not l.startswith("— source:")]
        path = src[0].split("source:")[1].split("§")[0].strip() if src else None
        # the claim list's bullets begin '- '; the quote carries them
        res.append((path, "\n".join(body)))
    return res


def main():
    plant = "--plant" in sys.argv
    qs = blocks(open(BRIEF).read())
    if "--count" in sys.argv:          # one line for a control: FOUND n of m; with --alter the first quote is altered by one word
        n = 0
        for i, (path, body) in enumerate(qs):
            b = body[2:] if body.startswith("- ") else body
            if i == 0 and "--alter" in sys.argv:
                b = b.replace("is contained", "is included", 1)
            n += norm(b) in norm(open(path).read())
        print(f"FOUND {n} of {len(qs)}")
        return
    bad = 0
    for path, body in qs:
        src = norm(open(path).read())
        # the bullet marker '- ' at the start of the quote is list syntax; search the body after it
        b = body[2:] if body.startswith("- ") else body
        ok = norm(b) in src
        print(("FOUND    " if ok else "NOTFOUND ") + f"{path} :: {norm(b)[:90]}")
        bad += not ok
    print(f"quotes: {len(qs)}  not found: {bad}")
    if plant:
        path, body = qs[0]
        b = (body[2:] if body.startswith("- ") else body).replace("is contained", "is included", 1)
        fired = norm(b) not in norm(open(path).read())
        print("PLANT " + ("FIRES (the altered quote is NOT FOUND)" if fired else "DEAD (the altered quote was found)"))
        sys.exit(0 if (fired and bad == 0) else 1)
    sys.exit(1 if bad or not qs else 0)


if __name__ == "__main__":
    main()
