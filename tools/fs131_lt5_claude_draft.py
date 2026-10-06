#!/usr/bin/env python3
"""FS131-LT5: write a copy of `CLAUDE.md` with the drafted paragraph of the assumptions scan's nine counts.

`CLAUDE.md` is the coordinator's file; this job drafts. `scripts/assumptions.sh` fails while the nine counts
are absent from `CLAUDE.md` § Trust ledger (inventory item 562 (d)), so until the paragraph is filed the gate
is run against this copy (`ASSUMPTIONS_CLAUDE=<copy>`; the gate then prints a NOTE saying so). The paragraph is
inserted after the § Trust ledger paragraph that ends "Rung B holds none." — the anchor must occur exactly once —
and its counts are read from a scan's saved output, never typed.

    tools/fs131_lt5_claude_draft.py <scan log> <out.md>           writes the copy and prints the paragraph
    tools/fs131_lt5_claude_draft.py --paragraph <scan log>        prints the paragraph only
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
KEYS = ("axioms", "rests", "named", "inline", "outside", "ours", "open", "takes", "mentions")
ANCHOR = "Rung B holds none.\n"
WORDS = ["no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen",
         "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty", "twenty-one", "twenty-two",
         "twenty-three", "twenty-four", "twenty-five", "twenty-six", "twenty-seven", "twenty-eight", "twenty-nine", "thirty",
         "thirty-one", "thirty-two", "thirty-three", "thirty-four", "thirty-five", "thirty-six", "thirty-seven",
         "thirty-eight", "thirty-nine", "forty"]


def word(n: int) -> str:
    return WORDS[n] if n < len(WORDS) else str(n)


def counts(log: Path) -> dict[str, int]:
    lines = [ln for ln in log.read_text(encoding="utf-8").splitlines() if ln.startswith("=== TOTALS === ")]
    if len(lines) != 1:
        raise SystemExit(f"{log}: {len(lines)} '=== TOTALS ===' lines, not one")
    found = dict(re.findall(r"(\w+)=(\d+)", lines[0]))
    missing = [k for k in KEYS if k not in found]
    if missing:
        raise SystemExit(f"{log}: the TOTALS line lacks {missing}")
    c = {k: int(found[k]) for k in KEYS}
    takes = [ln.split() for ln in log.read_text(encoding="utf-8").splitlines() if ln.startswith("TAKES ")]
    if len(takes) != c["takes"]:
        raise SystemExit(f"{log}: TOTALS says takes={c['takes']} and {len(takes)} TAKES rows were read")
    c["statements"] = len({row[2] for row in takes})
    return c


def paragraph(c: dict[str, int]) -> str:
    hyp = c["named"] + c["inline"]
    if c["outside"] + c["ours"] + c["open"] != hyp:
        raise SystemExit(f"the kinds ({c['outside']} + {c['ours']} + {c['open']}) do not add up to the hypotheses ({hyp})")
    record = " ".join(f"{k}={c[k]}" for k in KEYS)
    return (
        "**What the library assumes, in both forms** (`scripts/assumptions.sh`, whose digest reads these counts and fails if\n"
        f"they are absent): `{record}` — {word(c['axioms'])} outside theorem declared as\n"
        f"an axiom, with {word(c['rests'])} theorems resting on it; {word(hyp)} hypotheses, {word(c['named'])} named and "
        f"{word(c['inline'])} written out in a\n"
        f"binder — {word(c['outside'])} standing for outside theorems, {word(c['ours'])} for hand results of ours and "
        f"{word(c['open'])} for open questions — taken in\n"
        f"{c['takes']} (hypothesis, statement) pairs by {c['statements']} statements (`scripts/assumptions-ledger.txt` lists each pair; FS131-LT5,\n"
        "2026-10-06). Weil's bound is counted in each form it takes — the axiom, the named hypothesis `KloostermanBound`, and that\n"
        "hypothesis written out at a family of fields: one outside theorem, three entries.\n"
    )


def main(argv: list[str]) -> int:
    if len(argv) == 3 and argv[1] == "--paragraph":
        print(paragraph(counts(Path(argv[2]))), end="")
        return 0
    if len(argv) != 3:
        print(__doc__)
        return 2
    c = counts(Path(argv[1]))
    text = (REPO / "CLAUDE.md").read_text(encoding="utf-8")
    if text.count(ANCHOR) != 1:
        raise SystemExit(f"the anchor {ANCHOR!r} occurs {text.count(ANCHOR)} times in CLAUDE.md, not once")
    for k in KEYS:
        if re.search(rf"(?<![\w-]){k}=\d+", text):
            raise SystemExit(f"CLAUDE.md already records {k}=…: the paragraph is filed, or a count is recorded elsewhere")
    p = paragraph(c)
    Path(argv[2]).write_text(text.replace(ANCHOR, ANCHOR + "\n" + p), encoding="utf-8")
    print(p, end="")
    print(f"written: {argv[2]}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
