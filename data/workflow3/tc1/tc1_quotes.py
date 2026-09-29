"""TC1 readback: every quotation in the brief, matched verbatim (whitespace and the brief's '>' continuation marks
normalised) against its source. Runs from any directory: python3 data/workflow3/tc1/tc1_quotes.py
TC1_FAULT=1 plants a misquote (one word changed in the first quotation); the run must then report a miss.
Prints one line per quotation (none with TC1_QUIET=1) and a last line 'quotes: <found> of <n> found'."""
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
QUIET = os.environ.get("TC1_QUIET") == "1"

QUOTES = [
    (".claude/skills/grokkings/SKILL.md",
     "For a real number field F, a conjugation-fixed prime 𝔭 of F(i) gives χ(F²) ≤ N(𝔭); one above 2 exists iff −1 is "
     "not a square in some completion above 2 (norm 2 or 4)."),
    (".claude/skills/grokkings/SKILL.md",
     "Do: for any field, list its usable q first — six is possible only if one lies in {23, 27, 31, 43, 47}, or a prime "
     "above 2 is inert of norm 64, and the wall is broken; otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver, and over "
     "any F ⊇ K it is 5 or ≥ 7."),
    (".claude/skills/grokkings/SKILL.md",
     "So \"the wall is broken\" means **every prime above 2 splits in F(i)**, i.e. −1 is a square in every completion "
     "above 2"),
    ("CLAUDE.md",
     "1. **The 4/5 wall is 2-adic.** A unit-distance graph forces a fifth colour only if its coordinates break the "
     "2-adic wall (G1, G35)."),
    ("LEDGER.md",
     "(CLS: the only places of ratio `≥ 1/4` are those with residue field `𝔽₃` or `𝔽₇`, dyadic inert of norm `≤ 32`, "
     "and dyadic ramified in `F(i)/F`)"),
    ("LEDGER.md",
     "Seven, `χ_m⁰(ℝ²) ≥ 7`, is the map NO made uniform in the complexity bound: `1 − lim µ₆(ε) = inf_K δ₀(K)`, `δ₀(K)` "
     "the least hole density band-proper designs of complexity `≤ K` approach, so a hole bound uniform in `K` is seven "
     "itself (FS111-C1-UNIF);"),
    ("CLAUDE.md", "seven is the NO's hole bound made uniform in the complexity bound"),
]


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


if os.environ.get("TC1_FAULT") == "1":
    QUOTES[0] = (QUOTES[0][0], QUOTES[0][1].replace("(norm 2 or 4)", "(norm 2 or 8)"))

found = 0
for path, q in QUOTES:
    n = norm(open(os.path.join(ROOT, path), encoding="utf-8").read()).count(norm(q))
    found += n >= 1
    QUIET or print(f"{'ok  ' if n >= 1 else 'MISS'} {path}: {n} occurrence(s): {q[:60]}…")
print(f"quotes: {found} of {len(QUOTES)} found")
