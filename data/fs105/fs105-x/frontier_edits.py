#!/usr/bin/env python3
"""FS105-X's application of FS105-C's §R-close 4.4 (and 4.8's row half) to plans/FRONTIER-STUBS.md.

Exact (old, new) pairs, each required to occur exactly once, then the ranked table's renumbering: FS-105's rank-1 row out, ranks 2–61
-> 1–60, checked to have dropped one row and moved exactly 60.

    python3 data/fs105/fs105-x/frontier_edits.py --check | --apply | --self-test
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
FS = ROOT / "plans/FRONTIER-STUBS.md"

PAIRS: list[tuple[str, str, str]] = [
    ("open",
     "**None is open.** FS-103, the collapse, is **closed** (2026-09-26; rows 128–130; `plans/FS103-collapse-cp-plane.md` §R-close; its "
     "banner). Next: Kooshi's choice; the default is the top row.",
     "**None is open.** FS-105, harden MR, is **closed** (2026-09-26; row 120's grade; `plans/FS105-harden-mr.md` §R-close; its banner). "
     "Next: Kooshi's choice; the default is the top row."),
    ("header-note",
     "*At FS-103's close (2026-09-26, FS103-X):",
     "*At FS-105's close (2026-09-26, FS105-X): FS-105 closed and left the table; every later rank moved up one, so FS-104 leads (the "
     "default; Kooshi's choice — FS-102, the fallback write-up, is the alternative now that MR is hardened). Re-aimed: FS-100 (MR "
     "hardened; its left items unchanged), FS-102 (MR cited as EL2021 Thm 1.3 with FS105-DED; `[11]` Prop. 6.4 first if a write-up wants "
     "the full reading).*\n\n"
     "*At FS-103's close (2026-09-26, FS103-X):"),
    ("fs100",
     "MR's hardening moves to FS-105.",
     "MR hardened at FS-105 (row 120's grade)."),
    ("fs102",
     "Owed first: `[Johnson2000]`, `[Johnson2006]` (Kooshi, acquiring); the kernel form (FS-101) |",
     "Owed first: `[Johnson2000]`, `[Johnson2006]` (Kooshi, acquiring); the kernel form (FS-101). MR's external input cited as EL2021 "
     "Thm 1.3 with FS105-DED; a write-up that wants the full reading of Thm 1.3's machinery reads EL2021's `[11]` Prop. 6.4 first |"),
    ("closed",
     "## Closed, absorbed and demoted\n",
     "## Closed, absorbed and demoted\n"
     "* **FS-105 harden MR** — `plans/STUB-harden-mr.md`. **Closed 2026-09-26** (record `plans/FS105-harden-mr.md` §R-close; "
     "`plans/FS105-derivation.md`): **Paid (hardening)** — MR stands, its grade rewritten: EL2021 Thm 1.2 = Thm 1.3 plus a deduction "
     "EL2021 never writes (two minds, one blind), EL2003's proof an outline; PE-2 within Thm 1.3's hypotheses at ℚ(√635087) and de "
     "Grey's field, a reading gap at the cited machinery; EF_F⁺ three blind derivations; MR at degree 16 walked; row 129's test "
     "correct, its shapes (W), (W′). Its successors: FS-104 (rank 1), FS-102, FS-100's left items.\n"),
]


def renumber(text: str) -> tuple[str, list[str]]:
    misses = []
    lines = text.split("\n")
    out, moved, dropped, in_table = [], 0, 0, False
    for ln in lines:
        if ln.startswith("## Ranked stubs"):
            in_table = True
        elif in_table and ln.startswith("## "):
            in_table = False
        if in_table and ln.startswith("| 1 | **FS-105 harden MR**"):
            dropped += 1
            continue
        if in_table:
            m = re.match(r"^\| (\d+) \|", ln)
            if m and int(m.group(1)) >= 2:
                ln = f"| {int(m.group(1)) - 1} |" + ln[m.end():]
                moved += 1
        out.append(ln)
    if dropped != 1:
        misses.append(f"rank-1 row dropped {dropped} times")
    if moved != 60:
        misses.append(f"renumbered {moved} rows, expected 60 (ranks 2–61)")
    return "\n".join(out), misses


def apply(text: str, pairs) -> tuple[str, list[str]]:
    misses = []
    for name, old, new in pairs:
        n = text.count(old)
        if n != 1:
            misses.append(f"{name}: old text occurs {n} times")
            continue
        text = text.replace(old, new)
    text, m2 = renumber(text)
    return text, misses + m2


def main() -> int:
    mode = sys.argv[1] if len(sys.argv) > 1 else "--check"
    src = FS.read_text(encoding="utf-8")
    if mode == "--self-test":
        _, misses = apply(src, PAIRS + [("plant", "this text is not in FRONTIER-STUBS.md", "x")])
        ok = any(m.startswith("plant") for m in misses)
        print("SELF-TEST", "PASS: the planted pair was refused" if ok else "FAIL")
        return 0 if ok else 1
    new, misses = apply(src, PAIRS)
    print(f"plans/FRONTIER-STUBS.md {len(src.encode())} -> {len(new.encode())} bytes; {len(misses)} misses")
    for m in misses:
        print("MISS:", m)
    if misses:
        print("FAIL")
        return 1
    if mode == "--apply":
        FS.write_text(new, encoding="utf-8")
        print("written")
    print("PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
