#!/usr/bin/env python3
"""Shared text rules for the Proof Atlas (job VIZ-ATLAS): normalisation, the grade fold, and source addressing.

Used by `tools/viz_proof_atlas_facts.py` (which writes the fact table) and `tools/viz_proof_atlas_check.py` (which re-reads every fact
from its source). A source address is a dict:

  {"file": "LEDGER.md", "row": "131"}                          a markdown table line beginning "| 131 |"
  {"file": "CLAUDE.md", "section": "### The aim"}              a heading line, to the next heading of the same or a higher level
  {"file": "CLAUDE.md", "section": "### Paths forward, ranked", "row": "3"}   a table line inside that section
  {"file": "CLAUDE.md", "grok": "G64"}                         a grokking bullet "* **G64 — …", to the next "* **G"
  {"file": "Proofs/…/Interval.lean", "decl": "chromaticNumber_plane_interval"}   a `theorem` / `lemma` declaration and its docstring
  {"file": "plans/STUB-reg-scale.md"}                          the whole file

The fence: the files other jobs are writing tonight are never opened (the brief's list). A source address pointing into them is a failure
before any read.
"""
import pathlib, re

ROOT = pathlib.Path(__file__).resolve().parents[1]

FENCED = (  # the brief: FS112-YB3 (a blind verifier) and FS112-C (the close planner) are working in these tonight; never read
    "plans/FS112-YB3-verification.md",
    "data/fs112/fs112-yb3/",
    "plans/FS112-derivation.md",
    "data/fs112/fs112-c/",
    "plans/STUB-global-step",          # the two successor stubs FS112-C is drafting (their names are not known here; any stub
    "plans/STUB-stuck-ray",            # file matching these stems, or naming FS-114 / FS-115 in its path, is refused)
    "FS-114", "FS-115", "FS114", "FS115",
)


def fenced(path: str) -> bool:
    return any(path.startswith(f) or f in path for f in FENCED)


def norm(s: str) -> str:
    """Markdown bold, italics and code marks removed, escaped pipes unescaped, whitespace collapsed."""
    s = re.sub(r"(?m)^\s*>\s?", "", s)            # blockquote markers on wrapped lines
    s = s.replace("\\|", "|").replace("`", "").replace("*", "")
    return re.sub(r"\s+", " ", s).strip()


# ---- the grade fold: the source's own grade words → one of the page's statuses
STATUSES = ("kernel", "cert", "hand-2b", "hand-2", "hand-1", "reading", "external", "gap")
STATUS_WORDS = {
    "kernel": "kernel — checked by Lean's kernel",
    "cert": "certificate — an exact object accepted by exact checkers",
    "hand-2b": "hand, two minds, one blind",
    "hand-2": "hand, two minds",
    "hand-1": "hand, one mind",
    "reading": "reading — believed, with a killing test",
    "external": "external — claimed in print, not re-checked here",
    "gap": "GAP / open — a missing step",
}


def fold(g: str) -> str:
    """Fold a grade phrase, verbatim from its source, to a page status. Order matters: the first rule that fires decides."""
    if g.startswith("@lean"):
        return "kernel"
    low = g.lower()
    if (re.search(r"\bgaps?\b", low) or re.search(r"\bopen\b", low) or g.rstrip().endswith("?") or "not claimed" in low
            or re.search(r"\(stub\b", low)):
        return "gap"
    if "kernel" in low and "nothing kernel" not in low:
        return "kernel"
    if "exact checker" in low or ("accept" in low and "exact" in low):
        return "cert"
    if "external" in low or "in print" in low:
        return "external"
    if (low.startswith("[reading") or low.startswith("reading") or re.search(r"\ba reading\b", low)
            or "conjecture" in low):
        return "reading"
    if "blind" in low:
        return "hand-2b"
    if re.search(r"\b(two|three|four) (minds|derivations|readings|independent)", low):
        return "hand-2"
    if "hand" in low or "one mind" in low or "derived" in low:
        return "hand-1"
    return "?"


# ---- sources
class SourceError(Exception):
    pass


_cache: dict = {}


def raw(path: str) -> list:
    if fenced(path):
        raise SourceError(f"{path} is fenced tonight (another job's working file); never opened")
    if path not in _cache:
        p = ROOT / path
        if not p.is_file():
            raise SourceError(f"{path} does not exist")
        _cache[path] = p.read_text(encoding="utf-8").splitlines()
    return _cache[path]


def _heading_level(line: str) -> int:
    m = re.match(r"^(#+) ", line)
    return len(m.group(1)) if m else 0


def span(src: dict):
    """(first line index, last line index exclusive, lines) of the text a source address names; raises SourceError."""
    lines = raw(src["file"])
    lo, hi = 0, len(lines)
    if "section" in src:
        want = src["section"]
        idx = [i for i, l in enumerate(lines) if l.strip() == want or l.startswith(want)]
        if not idx:
            raise SourceError(f"{src['file']} has no heading {want!r}")
        lo = idx[0]
        lev = _heading_level(lines[lo]) or 9
        hi = next((j for j in range(lo + 1, len(lines)) if 0 < _heading_level(lines[j]) <= lev), len(lines))
    if "grok" in src:
        g = src["grok"]
        idx = [i for i, l in enumerate(lines) if l.startswith(f"* **{g} —") or l.startswith(f"* **{g} ")]
        if not idx:
            raise SourceError(f"{src['file']} has no grokking {g}")
        lo = idx[0]
        hi = next((j for j in range(lo + 1, len(lines)) if lines[j].startswith("* **G") or lines[j].startswith("## ")), len(lines))
    if "row" in src:
        key = str(src["row"])
        pat = re.compile(r"^\|\s*" + re.escape(key) + r"\s*\|")
        idx = [i for i in range(lo, hi) if pat.match(lines[i])]
        if not idx:
            raise SourceError(f"{src['file']}{' § ' + src['section'] if 'section' in src else ''} has no table row {key!r}")
        lo, hi = idx[0], idx[0] + 1
    if "decl" in src:
        d = src["decl"]
        pat = re.compile(r"^\s*(theorem|lemma|def)\s+" + re.escape(d) + r"\b")
        idx = [i for i, l in enumerate(lines) if pat.match(l)]
        if not idx:
            raise SourceError(f"{src['file']} declares no {d!r}")
        i = idx[0]
        j = i  # take the docstring above it too
        while j > 0 and not lines[j - 1].strip() == "" and not lines[j - 1].startswith("theorem"):
            j -= 1
        lo, hi = j, min(len(lines), i + 4)
    return lo, hi, lines


def text(src: dict) -> str:
    lo, hi, lines = span(src)
    if "decl" in src and src.get("whole_file_for_quote"):
        return norm("\n".join(lines))
    return norm("\n".join(lines[lo:hi]))


def locate(src: dict, quote: str) -> int:
    """1-based line number where the quote begins (its first eight words found on a line of the span), else the span's first line."""
    lo, hi, lines = span(src)
    head = " ".join(norm(quote).split()[:8])
    for k in (8, 5, 3):
        head = " ".join(norm(quote).split()[:k])
        for i in range(lo, hi):
            if head and head in norm(lines[i]):
                return i + 1
        # a quote that begins mid-line after a wrapped line: try a two-line window
        for i in range(lo, hi - 1):
            if head and head in norm(lines[i] + " " + lines[i + 1]):
                return i + 1
    return lo + 1


def address_str(src: dict, line: int | None = None) -> str:
    s = src["file"]
    if "section" in src:
        s += " § " + src["section"].lstrip("# ")
    if "grok" in src:
        s += " " + src["grok"]
    if "row" in src:
        s += (" row " if src["file"] == "LEDGER.md" else " item ") + str(src["row"])
    if "decl" in src:
        s += " (" + src["decl"] + ")"
    if line:
        s += f", line {line}"
    return s
