#!/usr/bin/env python3
"""FS131-K4: quote wave 4's rows (and the two rows merged into them) verbatim from plans/LEAN-BACKLOG.md.

Writes data/fs131/k4/rows.md: each row's whole backlog section (heading, address, statement, not-claimed line, grade,
handoff, dated notes, merge notes), byte for byte. The backlog itself quotes the derivation files by script
(tools/fs129_l1_backlog.py), so nothing here is copied by hand. `--check` re-reads the output against the backlog and
fails on any difference; `--plant` corrupts one quote in a copy of the backlog and shows the check firing.
"""
import re, sys, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
BACKLOG = ROOT / "plans" / "LEAN-BACKLOG.md"
OUT = ROOT / "data" / "fs131" / "k4" / "rows.md"

ROWS = ["FS106-L", "FS106-TS-T", "FS106-WO", "FS106-TW", "FS106-AE-MAP6",
        "FS110-N3-CONF", "FS110-N3-DEG", "FS110-N4-SHADOW", "FS110-N4-SHAVE", "FS110-N4-STUCK", "FS110-N4-FIN",
        "FS110-W-MERGE",
        "FS112-A4SIX", "FS112-BOWTIE", "FS112-C-DOUBLE", "FS112-FLANK", "FS112-ISO", "FS112-LOCK", "FS112-N2-BENDS",
        "FS112-N2-FLANK-Q", "FS112-N2-RAY", "FS112-N3-ANTI", "FS112-N3-FAIL", "FS112-N3-NOBOTH", "FS112-N3-END",
        "FS112-N3-PAIRS", "FS112-NB4P", "FS112-U1", "FS114-L60-LE"]
MERGED = {"FS112-BEND": "FS112-N2-BENDS", "FS114-L60-WALK": "FS114-L60-LE"}


def sections(text):
    """Map row id -> (heading line number, body) for every '### ... <id>' heading."""
    lines = text.split("\n")
    heads = [(i, l) for i, l in enumerate(lines) if l.startswith("### ") or l.startswith("## ")]
    out = {}
    for n, (i, l) in enumerate(heads):
        end = heads[n + 1][0] if n + 1 < len(heads) else len(lines)
        m = re.search(r"(FS\d+-[A-Z0-9-]+|TC1-[A-Z0-9-]+)\s*$", l)
        if m and l.startswith("### "):
            out.setdefault(m.group(1), (i + 1, "\n".join(lines[i:end]).rstrip("\n")))
    return out


def render(text):
    secs = sections(text)
    parts = ["# FS131-K4 — wave 4's rows, quoted verbatim from `plans/LEAN-BACKLOG.md`", "",
             "*Written by `tools/fs131_k4_rows.py`; `--check` re-reads it against the backlog. Each row is its whole backlog "
             "section, byte for byte (the backlog's script copies each field from the derivation file at the row's address).*", ""]
    for rid in ROWS + list(MERGED):
        if rid not in secs:
            raise SystemExit(f"row {rid} not found in the backlog")
        line, body = secs[rid]
        tag = f" — merged into {MERGED[rid]}" if rid in MERGED else ""
        parts += [f"## {rid}{tag}", f"`plans/LEAN-BACKLOG.md:{line}`", "", body, ""]
    return "\n".join(parts) + "\n"


def main():
    text = BACKLOG.read_text()
    out = render(text)
    if "--plant" in sys.argv:
        secs = sections(text)
        body = secs["FS110-N3-CONF"][1]
        i = body.index("\n> ") + 3
        planted_text = text.replace(body, body[:i] + "X" + body[i:], 1)
        planted = render(planted_text)
        fired = planted != OUT.read_text()
        print("plant: one character inserted in a quoted line of in FS110-N3-CONF's backlog section:", "FIRED" if fired else "MISSED")
        return 0 if fired else 1
    if "--check" in sys.argv:
        ok = OUT.read_text() == out
        print("check:", "OK" if ok else "MISMATCH", f"({len(ROWS)} rows, {len(MERGED)} merged)")
        return 0 if ok else 1
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(out)
    print(f"wrote {OUT.relative_to(ROOT)}: {len(ROWS)} rows, {len(MERGED)} merged")
    return 0


if __name__ == "__main__":
    sys.exit(main())
