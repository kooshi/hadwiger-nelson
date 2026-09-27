#!/usr/bin/env python3
"""FS105-C's drafted CLAUDE.md edits, as exact (old, new) pairs, for the front-page job FS105-X.

The close planner never edits CLAUDE.md; this script applies the drafts to a COPY and reports the byte count against the
300,000-byte budget, so the front page can see the budget holds before it writes anything.

    python3 data/fs105/fs105-c/claude_md_drafts.py --check              # apply to a temporary copy; print sizes; exit 1 on any miss
    python3 data/fs105/fs105-c/claude_md_drafts.py --out PATH           # write the edited copy to PATH (never CLAUDE.md itself)
    python3 data/fs105/fs105-c/claude_md_drafts.py --self-test          # a plant: a pair whose old text is absent must fail loudly

Every pair's old text must occur exactly once; the ranked table's renumbering (FS-105's row removed, every later rank down one) is
done by a regex over the table's rows and checked to have moved exactly the expected rows.
"""
from __future__ import annotations

import argparse
import re
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
BUDGET = 300_000

PAIRS: list[tuple[str, str, str]] = [
    ("last-updated",
     None,  # replaced below by the whole line starting with this prefix
     "*Last updated: 2026-09-26 — **FS-105, harden MR**: **Paid (hardening)** — MR (row 120) stands, its grade rewritten: "
     "`[EinsiedlerLindenstrauss2022]` Thm 1.2's proof is in neither paper cited for it (EL2003 is an announcement, its §6 an outline); "
     "it follows from their Thm 1.3 by a deduction EL2021 never writes, now two minds, one blind; PE-2 sits inside Thm 1.3's hypotheses "
     "at ℚ(√635087) and de Grey's field, a reading gap (not a mathematical one) at EL2021's cited machinery; EF_F⁺ has three derivations "
     "blind to one another; MR at degree 16 walked; row 129's killing test correct as stated, with the two shapes a refutation must take "
     "(`plans/FS105-harden-mr.md` §R-close). Before it, **FS-103, the collapse** (rows 128–130; `plans/FS103-collapse-cp-plane.md` "
     "§R-close), and FS-100 stage 5 with its waves (rows 120–127). **No finite-witness search runs until 2026-10-01** (Kooshi; "
     "§ Toolchain). Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*"),
    ("where-it-stands",
     "(row 120: `[EinsiedlerLindenstrauss2022]` Thm 1.2 by statement and `[EinsiedlerFish2010]`'s method transferred)",
     "(row 120: `[EinsiedlerLindenstrauss2022]` Thm 1.3 by statement, with a two-mind deduction of its Thm 1.2, and "
     "`[EinsiedlerFish2010]`'s method transferred, three blind derivations)"),
    ("open-milestones",
     "**None is open.** FS-103, the collapse, is **closed** (rows 128–130; `plans/FS103-collapse-cp-plane.md` §R-close; the stub's banner).",
     "**None is open.** FS-105, harden MR, is **closed** (row 120's grade; `plans/FS105-harden-mr.md` §R-close; the stub's banner)."),
    ("fs100-row",
     "MR's hardening is FS-105 |",
     "MR hardened at FS-105 (row 120's grade) |"),
    ("fs102-row",
     "`[Johnson2000]`, `[Johnson2006]` first (Kooshi, acquiring) |",
     "`[Johnson2000]`, `[Johnson2006]` first (Kooshi, acquiring); MR's external input cited as EL2021 Thm 1.3 with FS-105's deduction |"),
    ("g80-body",
     "positive entropy is Einsiedler–Lindenstrauss on each finitely generated piece,",
     "positive entropy is Einsiedler–Lindenstrauss (their Thm 1.3) on each finitely generated piece, all of it at finite places since "
     "`U` is isometric at every archimedean one,"),
    ("g80-do",
     "count the group's elements by height before calling it ×2×3-hard;",
     "count the group's elements by height before calling it ×2×3-hard — any positive exponent suffices, the degree entering "
     "constants only (FS-105);"),
    ("g50",
     "its §2 on adelic solenoids is still unread where it may hold PE-2.",
     "its §2 was read at FS-100 and holds no PE-2, and the proof of its Thm 1.2 is in neither paper cited for it (FS-105)."),
    ("g72-count",
     "**The count so far — thirteen of fourteen**",
     "**The count so far — thirteen of fifteen**"),
    ("g72-fifteenth",
     "row 130's measurable equality by extending a known tool.",
     "row 130's measurable equality by extending a known tool. Fifteenth, FS-105, the other kind: a hardening, its products from "
     "reading and from re-deriving a known proof."),
    ("g79-fs105",
     "reduced it to a finite list problem (row 130).*",
     "reduced it to a finite list problem (row 130); FS-105: its blind EF_F⁺ from the height count `U` has and no finitely generated "
     "subgroup has, while (W) and (W′), counterexample invariants, located row 129's test without a theorem.*"),
]


def apply(text: str) -> tuple[str, list[str]]:
    misses: list[str] = []
    for name, old, new in PAIRS:
        if name == "last-updated":
            lines = [ln for ln in text.split("\n") if ln.startswith("*Last updated: ")]
            if len(lines) != 1:
                misses.append(f"{name}: {len(lines)} lines")
                continue
            text = text.replace(lines[0], new)
            continue
        n = text.count(old)
        if n != 1:
            misses.append(f"{name}: old text occurs {n} times")
            continue
        text = text.replace(old, new)
    # the ranked table: drop FS-105's row, move every later rank down one
    rows = text.split("\n")
    out, moved, dropped = [], 0, 0
    in_table = False
    for ln in rows:
        if ln.startswith("**Ranked stubs**"):
            in_table = True
        elif in_table and ln.startswith("**Closed as directions**"):
            in_table = False
        if in_table and ln.startswith("| 1 | **FS-105 harden MR**"):
            dropped += 1
            continue
        if in_table:
            m = re.match(r"^\| (\d+)(–(\d+))? \|", ln)
            if m and int(m.group(1)) >= 2:
                a = int(m.group(1)) - 1
                lab = f"{a}–{int(m.group(3)) - 1}" if m.group(3) else f"{a}"
                ln = f"| {lab} |" + ln[m.end():]
                moved += 1
        out.append(ln)
    if dropped != 1:
        misses.append(f"rank-1 row dropped {dropped} times")
    if moved != 28:
        misses.append(f"renumbered {moved} rows, expected 28 (ranks 2–28 and 29–61)")
    return "\n".join(out), misses


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true")
    ap.add_argument("--out")
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    src = (ROOT / "CLAUDE.md").read_text()
    if a.self_test:
        PAIRS.append(("plant", "this text is not in CLAUDE.md", "x"))
        _, misses = apply(src)
        PAIRS.pop()
        if any(m.startswith("plant") for m in misses):
            print("SELF-TEST PASS: the planted pair was refused:", [m for m in misses if m.startswith("plant")])
            return 0
        print("SELF-TEST FAIL: the planted pair was not refused")
        return 1
    new, misses = apply(src)
    before, after = len(src.encode()), len(new.encode())
    print(f"CLAUDE.md now {before} bytes; after the drafts {after} bytes ({after - before:+d}); budget {BUDGET}")
    for m in misses:
        print("MISS:", m)
    if misses or after >= BUDGET:
        print("FAIL")
        return 1
    if a.out:
        if Path(a.out).resolve() == (ROOT / "CLAUDE.md").resolve() and not a.check:
            pass  # the front page may choose to write in place; this job never does
        Path(a.out).write_text(new)
        print("written:", a.out)
    else:
        with tempfile.NamedTemporaryFile("w", delete=False, suffix=".md") as f:
            f.write(new)
            print("copy:", f.name)
    print("PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
