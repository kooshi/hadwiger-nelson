#!/usr/bin/env python3
"""FS131-KM15: check every quotation of the brief against its source (standing rule 3).

Each block of '> ' lines followed by '> — source: <path>[ § ...]' is one quotation. Its text, with the leading
'> ' removed and whitespace collapsed, must occur in the source file (whitespace collapsed). Paths are read from the
roots given (first hit wins). Exit 0 only if every quotation is found; '--plant' alters one character of the first
quotation and must make the check fail (the negative control).
"""
import re, sys, pathlib

def norm(s):
    return re.sub(r"\s+", " ", s).strip()

def quotes(brief):
    lines = brief.read_text().splitlines()
    out, buf = [], []
    for ln in lines:
        if ln.startswith(">"):
            body = ln[1:].lstrip(" ") if ln != ">" else ""
            m = re.match(r"—\s*source:\s*(\S+)", body)
            if m:
                out.append(("\n".join(buf), m.group(1)))
                buf = []
            else:
                buf.append(body)
        else:
            buf = []
    return out

def main():
    args = sys.argv[1:]
    plant = "--plant" in args
    args = [a for a in args if a != "--plant"]
    brief, roots = pathlib.Path(args[0]), [pathlib.Path(r) for r in args[1:]]
    qs = quotes(brief)
    if plant and qs:
        t, s = qs[0]
        qs[0] = (t.replace("e", "E", 1), s)
    bad = 0
    for i, (text, src) in enumerate(qs, 1):
        path = next((r / src for r in roots if (r / src).exists()), None)
        if path is None:
            print(f"[{i}] MISSING SOURCE {src}"); bad += 1; continue
        ok = norm(text) in norm(path.read_text())
        print(f"[{i}] {'FOUND' if ok else 'NOT FOUND'} {len(norm(text))} chars in {path}")
        bad += 0 if ok else 1
    print(f"quotations={len(qs)} bad={bad}")
    sys.exit(1 if bad or not qs else 0)

if __name__ == "__main__":
    main()
