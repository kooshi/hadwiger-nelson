#!/usr/bin/env python3
"""Replace the `sorry` body of named leaves in a Lean file (FS124-I3).

usage: patch.py <file.lean> <patch-file>

The patch file is a sequence of blocks:

    @@ <anchor text, one line, must occur exactly once in the file>
    <proof text, replacing the first `  sorry` line (or `by sorry`) after the anchor>
    @@ ...

Fails loudly if an anchor is missing or occurs twice, or if no sorry follows it
before the next blank line.
"""
import sys, re

def main():
    path, patch = sys.argv[1], sys.argv[2]
    src = open(path).read()
    blocks = re.split(r'^@@ ', open(patch).read(), flags=re.M)[1:]
    n = 0
    for b in blocks:
        anchor, _, body = b.partition('\n')
        anchor = anchor.rstrip()
        body = body.rstrip('\n')
        cnt = src.count(anchor)
        if cnt != 1:
            sys.exit(f"anchor occurs {cnt} times: {anchor!r}")
        i = src.index(anchor)
        # the first sorry after the anchor
        m = re.compile(r'(?m)^  sorry$|by sorry$').search(src, i)
        if not m:
            sys.exit(f"no sorry after anchor: {anchor!r}")
        between = src[i:m.start()]
        if '\n\n' in between:
            sys.exit(f"a blank line stands between the anchor and its sorry: {anchor!r}")
        if m.group(0) == 'by sorry':
            src = src[:m.start()] + body + src[m.end():]
        else:
            src = src[:m.start()] + body + src[m.end():]
        n += 1
    open(path, 'w').write(src)
    print(f"patched {n} leaves in {path}")

main()
