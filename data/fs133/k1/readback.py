#!/usr/bin/env python3
"""FS133-K1 stage 1: two readbacks.

(1) brief: every quotation in the brief (a run of '> ' lines closed by '> — source: <path>[ § section]')
    must occur verbatim, as a substring, in its source file.
(2) claims: every line 'K133-<ID>: (entry at line N of the derivation file) <text>' of the claim list must
    equal the `statement:` field of the derivation entry `C133-<ID>` that starts at line N, its wrapped
    lines joined by single spaces; every 'K133-NC-<ID>: <text>' must equal that entry's `not claimed:`
    field the same way (K133-NC-ALL has no entry and is reported as such).

Usage: readback.py brief|claims [--fault]
--fault changes the last character of every quoted/copied text; every item must then mismatch (exit 1).
Exit 0 iff no mismatch.
"""
import os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
BRIEF = "data/fs133/briefs/FS133-K1-kernel-plan.md"
CLAIMS = "data/fs133/claims-K1.md"
DERIV = "plans/FS133-E1-derivation.md"
fault = "--fault" in sys.argv
mode = [a for a in sys.argv[1:] if a != "--fault"][0]


def rd(p):
    return open(os.path.join(ROOT, p), encoding="utf-8").read()


def spoil(s):
    return s[:-1] + ("#" if s[-1] != "#" else "@") if fault else s


ok = bad = 0
if mode == "brief":
    cur = []
    for ln in rd(BRIEF).split("\n"):
        if ln.startswith("> — source: "):
            src = ln[len("> — source: "):].split(" § ")[0].strip()
            text = rd(src)
            for ql in cur:
                if spoil(ql) in text:
                    ok += 1; print("match   ", src, "|", ql[:70])
                else:
                    bad += 1; print("MISMATCH", src, "|", ql[:70])
            cur = []
        elif ln.startswith("> "):
            cur.append(ln[2:])
        else:
            cur = []
elif mode == "claims":
    dl = rd(DERIV).split("\n")

    def field(start, name):
        """the field `name:` of the entry whose `derivation:` line is dl[start-1], wrapped lines joined."""
        i = start
        while i < len(dl) and dl[i].startswith("  ") and not dl[i].startswith("  " + name + ":"):
            i += 1
        if i >= len(dl) or not dl[i].startswith("  " + name + ":"):
            return None
        parts = [dl[i][len("  " + name + ":"):].strip()]
        i += 1
        while i < len(dl) and dl[i].startswith("    "):
            parts.append(dl[i].strip()); i += 1
        return " ".join(parts)

    starts = {}
    for n, ln in enumerate(dl, 1):
        m = re.match(r"derivation: (C133-\S+)$", ln)
        if m:
            starts[m.group(1)] = n
    for ln in rd(CLAIMS).split("\n"):
        m = re.match(r"K133-NC-(\S+): (.*)$", ln)
        if m:
            ident, text = "C133-" + m.group(1), m.group(2)
            if ident not in starts:
                print("NO ENTRY", ident, "(a line of the claim list's own)"); continue
            want = field(starts[ident], "not claimed")
            good = want is not None and spoil(text) == want
        else:
            m = re.match(r"K133-(\S+): \(entry at line (\d+) of the derivation file\) (.*)$", ln)
            if not m:
                continue
            ident, n, text = "C133-" + m.group(1), int(m.group(2)), m.group(3)
            want = field(n, "statement") if dl[n - 1] == "derivation: " + ident else None
            good = want is not None and spoil(text) == want
        if good:
            ok += 1; print("match   ", ln.split(":")[0], "=", ident)
        else:
            bad += 1; print("MISMATCH", ln.split(":")[0], "vs", ident)
print(f"matched: {ok}  mismatched: {bad}")
sys.exit(1 if bad else 0)
