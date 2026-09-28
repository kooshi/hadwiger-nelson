"""X1's shared helpers: extract drafts and Poros's corrections from their sources by exact text; replace exactly once."""
import re, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]

def read(p):
    return (ROOT / p).read_text(encoding="utf-8")

def write(p, s):
    (ROOT / p).write_text(s, encoding="utf-8")

def poros_pairs():
    """Poros's § Draft re-rank item 6: {F-label: [(old, new), ...]} with wrapped lines joined."""
    t = read("plans/POROS-2026-09-28-close-reread.md")
    a = t.index("**6. Corrections owed to the closes"); b = t.index("## Draft for CLAUDE.md § Paths forward")
    blk = re.sub(r"\n  (?=\S)", " ", t[a:b])
    out = {}
    for line in blk.split("\n"):
        m = re.match(r"- \*\*(F\d+)", line)
        if not m:
            continue
        out[m.group(1)] = [(x.group(1), x.group(2)) for x in
                           re.finditer(r'"([^"]*)"(?:\s*\([^()]*\))?\s*→\s*"([^"]*)"', line)]
    return out

def once(s, old, new, what):
    n = s.count(old)
    assert n == 1, f"{what}: old text found {n} times: {old[:90]!r}"
    return s.replace(old, new)

def once_ws(s, old, new, what):
    """Replace `old` matched modulo runs of whitespace; a line break inside the match is kept at the nearest space of `new`."""
    pat = r"\s+".join(re.escape(w) for w in old.split())
    ms = list(re.finditer(pat, s))
    assert len(ms) == 1, f"{what}: old text (whitespace-free match) found {len(ms)} times: {old[:90]!r}"
    m = ms[0]; span = m.group(0)
    br = re.search(r"\n[ \t]*", span)
    rep = new
    if br:
        off = br.start()
        k = new.find(" ", off) if new.find(" ", off) != -1 else new.rfind(" ")
        rep = new[:k] + br.group(0) + new[k + 1:]
    return s[:m.start()] + rep + s[m.end():]

R111 = [("‹R111-a›–‹R111-c›", "139–141"), ("‹R111-a›", "139"), ("‹R111-b›", "140"), ("‹R111-c›", "141")]

def r111(s):
    for a, b in R111:
        s = s.replace(a, b)
    assert "‹R111" not in s
    return s
