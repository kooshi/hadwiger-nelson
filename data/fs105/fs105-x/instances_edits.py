#!/usr/bin/env python3
"""FS105-X's application of FS105-C's §R-close 4.6 (new instances, verbatim) to plans/GROKKING-INSTANCES.md, and of 4.7 (the fence-template
fix) to plans/PROTOCOL-competitor-and-advisor.md and plans/PROTOCOL-crunch.md.

Each instance is inserted at the end of its section (before the next `## ` heading), under the file's attribution line; each anchor must
occur exactly once. The instance texts are C's drafts verbatim (the protocol edits are applied in stage 5 by hand, after reading each
target; see the record).

    python3 data/fs105/fs105-x/instances_edits.py --check | --apply | --self-test
"""
from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
GI = ROOT / "plans/GROKKING-INSTANCES.md"
ATTR = "*FS105-X, FS-105's close (§R-close 4.6):*"  # short: the instances open with their own source address (--dupes)

INSTANCES: list[tuple[str, str, str]] = [
    ("G50", "## G51 — A competitor and an advisor beat one mind",
     "FS-105 (`plans/FS105-harden-mr.md` §PA.1, §R-close 3.1): **the proof 'used by statement' was in neither paper the record named.** "
     "Row 120 said EL2021 Thm 1.2's proof was 'in EL2021 §§2–9, unread here'; EL2021 p. 2 attributes it to EL2003 ('already proven in "
     "the announcement [7]'), and EL2003, fetched by Kooshi's upload, is an announcement whose §6 is 'Outline of the proof of Theorem "
     "1.1'. The theorem stands on EL2021 Thm 1.3 plus a deduction nobody had written. In the same milestone, twice more: the plan owed a "
     "new row to `[BekkaFrancini2020]`, 'abstract only', a paper held as `[BekkaFrancini2022]` with §1 read twice; and W listed Jungić's "
     "*Still Spinning* as a new title, owed since FS-58's §PA."),
    ("G51", "## G54 — Tight or slack",
     "FS-105 (`plans/FS105-harden-mr.md` §R-close 3.1; inventory items 12, 24, 28): **two covert channels open to every blind job of "
     "FS-103 and FS-105.** (1) The session transcripts (`~/.claude/projects/-home-kooshi-source-lean-dir/*.jsonl`, `subagents/`) and "
     "`chats-bak/` — 717 files carrying X01D's and X12B's route — were fenced in no FS-103 blind brief (V1, V2, B, N) and not in FS-105's "
     "B105 as drafted; the advisor found it before B's launch (A Stage 3). (2) The harness scratchpad is one directory shared by every "
     "subagent of the session, across milestones (579 entries), so B's fence 'outside your own scratchpad' fenced nothing; the blind D "
     "found it in its stage 1 (D §1.5) and overwrote two same-named files there. None of the blind jobs reported reading either; B "
     "confirmed 'none' (item 28), and FS-103's blind grades stand (the close's ruling, 3.8). G51's own design lesson — 'isolate the "
     "scratchpad per agent' — had stood since 2026-09-09; the briefs isolated the record, not the harness's directories. Also: no "
     "divergence of truth in four pairings (R–D on the deduction; R–W on (a1)–(a8) at de Grey's field; B–X01D/X12B/X01V on EF_F⁺; A–R, a "
     "misattributed route); the free-window slips were the owner's paraphrase 'a withdrawn checking reading' (item 7), R's scope tool "
     "passing a plant silently (item 20), B's constant on the equality boundary (item 27) and W's inert split filter (item 31)."),
    ("G72", "## G79 — A wall arrives as a counterexample's invariant",
     "Fifteenth, FS-105 (`plans/FS105-harden-mr.md` §R-close 3.3): the other kind. A hardening; its §IQ structural form (what every "
     "invariant measure with zero entropy for one element carries, for a group with polynomially many elements of bounded height) was "
     "answered — `T + A` at ℚ(√635087) (FS105-B), any positive growth exponent (FS105-W-G) — but the products came from reading (R, D) "
     "and from re-deriving a known proof (B, W)."),
    ("G79", "## `CLAUDE.md` § Delegation — one level deep",
     "FS-105: B's EF_F⁺ from an example invariant of the acting group (the height count) against the measure's (zero local dimension); "
     "FS105-DED from what every Thm 1.3 decomposition carries under total irreducibility; (W) and (W′), counterexample invariants — the "
     "shapes a refutation must carry — located row 129's test and produced no theorem."),
    ("standard", "## `CLAUDE.md` § Toolchain — Two machines",
     "FS-105 (`plans/FS105-harden-mr.md` §R-close 3.1): asked of MR, 'what must someone who trusts none of this actually check?' moved "
     "the external weight from EL2021 Thm 1.2, whose proof is nowhere in print, to Thm 1.3 plus ten lines."),
]


def apply(text: str, items) -> tuple[str, list[str]]:
    misses = []
    for name, heading, body in items:
        n = text.count("\n" + heading + "\n")
        if n != 1:
            misses.append(f"{name}: heading occurs {n} times")
            continue
        head, tail = text.split("\n" + heading + "\n", 1)
        head = head.rstrip("\n") + "\n\n" + ATTR + "\n\n" + body + "\n"
        text = head + "\n" + heading + "\n" + tail
    return text, misses


def main() -> int:
    mode = sys.argv[1] if len(sys.argv) > 1 else "--check"
    src = GI.read_text(encoding="utf-8")
    if mode == "--self-test":
        _, misses = apply(src, INSTANCES + [("plant", "## no such heading", "x")])
        ok = any(m.startswith("plant") for m in misses)
        print("SELF-TEST", "PASS: the planted heading was refused" if ok else "FAIL")
        return 0 if ok else 1
    new, misses = apply(src, INSTANCES)
    print(f"plans/GROKKING-INSTANCES.md {len(src.encode())} -> {len(new.encode())} bytes; {len(misses)} misses")
    for m in misses:
        print("MISS:", m)
    if misses:
        print("FAIL")
        return 1
    if mode == "--apply":
        GI.write_text(new, encoding="utf-8")
        print("written")
    print("PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
