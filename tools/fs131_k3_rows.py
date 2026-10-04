#!/usr/bin/env python3
"""FS131-K3: quote wave 3's rows (and the rows merged into them) verbatim from plans/LEAN-BACKLOG.md.

Writes data/fs131/k3/rows.md: for each row, its backlog heading, its statement and not-claimed lines exactly as the
backlog quotes them (the backlog itself quotes the derivation files by script), and every merge note filed under it.
`--check` re-reads the output against the backlog and fails on any difference; `--plant` corrupts one quote in memory
and shows the check firing.
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
BACKLOG = ROOT / "plans" / "LEAN-BACKLOG.md"
OUT = ROOT / "data" / "fs131" / "k3" / "rows.md"

ROWS = ["FS116-V5-NE1", "FS116-V4-DICHOTOMY", "FS116-V4-MEET", "FS116-S1-CLUSTER", "FS129-OR1-WHOLE",
        "FS116-V4-TWIST", "FS116-N1-TWIST-D", "FS116-N1-GERM-R", "FS116-N1-GERM-S", "FS116-RING-Q-PRIME-S",
        "FS116-N1-QFREE4", "FS116-N2-FIVERING", "FS129-SR1-SIXQ", "FS129-SR2-TOUCHW", "FS116-N1-ECHO",
        "FS116-V5-U1", "FS116-Y4-FLANK", "FS116-S1-EXIT", "FS116-Y2-SIXFRAG", "FS129-SR1-RINGBAND"]
MERGED = {"FS116-N1-TOUCH": "FS129-SR2-TOUCHW", "FS116-RING-Q-PRIME": "FS116-RING-Q-PRIME-S",
          "FS110-N2-RING": "FS129-SR1-RINGBAND", "FS110-Y3-GP": "FS129-SR1-RINGBAND",
          "FS112-SIX": "FS116-N2-FIVERING;FS129-SR1-SIXQ",
          "FS116-RING-TRANSFER-C": "FS116-N2-FIVERING;FS116-N2-SIXRING (wave 8)"}

def sections(text):
    """Map row id -> (heading line number, body) for every '### ... <id>' heading."""
    lines = text.split("\n")
    heads = [(i, l) for i, l in enumerate(lines) if l.startswith("### ")]
    out = {}
    for n, (i, l) in enumerate(heads):
        end = heads[n + 1][0] if n + 1 < len(heads) else len(lines)
        m = re.search(r"(FS\d+-[A-Z0-9-]+|TC1-[A-Z0-9-]+)\s*$", l)
        if m:
            out[m.group(1)] = (i + 1, "\n".join(lines[i:end]))
    return out

def quotes(body, field):
    """The '> ' lines following a <!--q ID field--> marker."""
    m = re.search(r"<!--q [^ ]+ " + re.escape(field) + r"-->\n\*\*[^\n]*\n((?:>[^\n]*\n?)+)", body)
    return m.group(1).rstrip("\n") if m else None

def merges(body):
    return re.findall(r"(<!--q [^ ]+ merge@[^>]+-->\n\*\*Merge note[^\n]*\n(?:>[^\n]*\n?)+)", body)

def render(text):
    secs = sections(text)
    parts = ["# FS131-K3 — wave 3's rows, quoted verbatim from `plans/LEAN-BACKLOG.md`", "",
             "*Written by `tools/fs131_k3_rows.py`; `--check` re-reads it against the backlog. Every line under a row is the backlog's own "
             "quotation (which the backlog's script copies from the derivation file at the row's address).*", ""]
    for rid in ROWS + list(MERGED):
        if rid not in secs:
            raise SystemExit(f"row {rid} not found in the backlog")
        line, body = secs[rid]
        tag = f" — merged into {MERGED[rid]}" if rid in MERGED else ""
        parts.append(f"## {rid}{tag}")
        parts.append(f"`plans/LEAN-BACKLOG.md:{line}`; " + (re.search(r"\*\*Address\*\* `([^`]+)`", body).group(1)))
        for field in ("statement", "not_claimed", "uses_only"):
            q = quotes(body, field)
            if q is not None:
                parts += ["", f"**{field}:**", q]
        for mq in merges(body):
            parts += ["", mq.rstrip("\n")]
        parts.append("")
    return "\n".join(parts) + "\n"

def main():
    text = BACKLOG.read_text()
    out = render(text)
    if "--plant" in sys.argv:
        text = text.replace("a direction β with β − ψ in (150°, 330°)", "a direction β with β − ψ in (150°, 331°)", 1)
        planted = render(text)
        print("plant: quote altered in the backlog copy:", "FIRED" if planted != OUT.read_text() else "MISSED")
        return 0 if planted != OUT.read_text() else 1
    if "--check" in sys.argv:
        ok = OUT.read_text() == out
        print("check:", "OK" if ok else "MISMATCH")
        return 0 if ok else 1
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(out)
    print(f"wrote {OUT.relative_to(ROOT)}: {len(ROWS)} rows, {len(MERGED)} merged")
    return 0

sys.exit(main())
