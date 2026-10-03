#!/usr/bin/env python3
"""Build data/fs129/demand-judged.md from data/fs129/q1/demand-template.md (FS129-Q1, Poros).

{{A path a b}} -> the address "`path` ll. a–b" (or "l. a").
{{Q path a b}} -> lines a..b of path, each stripped of leading whitespace and of a leading "> ", joined by one space.
Every substituted quotation, and every hand-typed quotation listed in HAND below, is checked as an exact substring
of its source after whitespace normalisation; any miss exits 1. `--plant` corrupts one quotation to show the check fires.
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[3]
TPL = ROOT / "data/fs129/q1/demand-template.md"
OUT = ROOT / "data/fs129/demand-judged.md"

HAND = [  # (quoted text exactly as it appears in the template, its source)
    ("a close complementary pair of cubic trichromatic vertices sits on a unit rhombus with four-colour corners (FS-110's T2, forced)", "LEDGER.md"),
    ("every close complementary pair of cubic trichromatic vertices needs four-colour vertices at both common unit points (row 135); each positive's design supplies one", "LEDGER.md"),
    ("in such a map complementary-type vertices within distance 2 are tangent pairs or bowties", "LEDGER.md"),
    ("Does FS114-Y4-RSTOPALL, the bowtie killed at `√3`, survive as an exclusion for band-proper fragments with slack ε and small holes, at a radius and margin independent of ε and the complexity?", "plans/STUB-forced-pair.md"),
    ("row 134's base, Lemma 4 at cusps (BASE-V), before any publication", "plans/STUB-qfree-ring.md"),
    ("what is left is Townsend's (c) in full", "plans/STUB-regular-half-residuals.md"),
    ("not claimed: anything about modifications that may lower a class; anything at five or six", "plans/FS121-derivation.md"),
    ("a reformulation, carried in FS-121", "plans/STUB-cp-plane-six.md"),
    ("not only are \"hubs\" important, but deep \"roots\", where a long chain of theorems starts, even if it has only one offshoot", "plans/FS129-cross-application-audit.md"),
    ("only for the uniqueness of `R⁻`, `R⁺` and of the tip", "plans/STUB-qfree-ring.md"),
    ("a non-density (integrality) argument", "plans/STUB-cp-plane-six.md"),
]

norm = lambda s: re.sub(r"\s+", " ", s).strip()


def lines(path, a, b):
    L = (ROOT / path).read_text().split("\n")
    out = []
    for l in L[a - 1:b]:
        l = l.strip()
        if l.startswith("> "):
            l = l[2:]
        out.append(l)
    return " ".join(out)


def src(path):
    out = []
    for l in (ROOT / path).read_text().split("\n"):
        l = l.strip()
        out.append(l[2:] if l.startswith("> ") else l)
    return norm(" ".join(out))


def addr(path, a, b):
    return f"`{path}` l. {a}" if a == b else f"`{path}` ll. {a}–{b}"


def main(plant=False):
    t = TPL.read_text()
    fails, quotes = [], []

    def subQ(m):
        p, a, b = m.group(1), int(m.group(2)), int(m.group(3))
        q = lines(p, a, b)
        quotes.append((q, p))
        return q

    t = re.sub(r"\{\{A (\S+) (\d+) (\d+)\}\}", lambda m: addr(m.group(1), int(m.group(2)), int(m.group(3))), t)
    t = re.sub(r"\{\{Q (\S+) (\d+) (\d+)\}\}", subQ, t)
    if plant:
        quotes[0] = (quotes[0][0].replace("fragment", "fragmint", 1), quotes[0][1])
    for q, p in quotes:
        if norm(q) not in src(p):
            fails.append(("Q", p, q[:80]))
    for q, p in HAND:
        if norm(q) not in norm(t):
            fails.append(("HAND not in template", p, q[:80]))
        if norm(q) not in src(p):
            fails.append(("HAND not in source", p, q[:80]))
    if "{{" in t:
        fails.append(("unsubstituted placeholder", "", ""))
    for f in fails:
        print("FAIL", *f)
    print(f"quotes by line range: {len(quotes)}; hand quotes: {len(HAND)}; failures: {len(fails)}")
    if fails:
        return 1
    if not plant:
        OUT.write_text(t)
        print(f"wrote {OUT.relative_to(ROOT)} ({len(t.encode())} bytes)")
    return 0


if __name__ == "__main__":
    sys.exit(main(plant="--plant" in sys.argv))
