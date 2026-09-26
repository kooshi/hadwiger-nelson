#!/usr/bin/env python3
"""E1 (design (b) on CLAUDE.md): the move specification, its inventory, and its application.

Every move cuts ONE exact span of CLAUDE.md -- from `start` through `end`, both included, each unique in the file -- replaces it
with `repl` (a pointer, or nothing), and copies the cut text VERBATIM to its destination: a section of plans/GROKKING-INSTANCES.md
('I'), LEDGER.md beside § The claim list ('L'), or nowhere because plans/FRONTIER-STUBS.md already holds it ('F', checked by the
fact audit's external homes). GLUE edits are pointer or address insertions with no text removed.

    python3 data/consolidation-2026-09-26/e1/moves.py inventory      # the stage-1 table (no edits)
    python3 data/consolidation-2026-09-26/e1/moves.py apply G|F|B    # apply one group; refuses unless every anchor is unique
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
INST = ROOT / "plans/GROKKING-INSTANCES.md"
PTR = "`plans/GROKKING-INSTANCES.md`"

# (id, group, entry, start, end, repl, dest, why)
MOVES = [
    ("M1", "G", "G21", "**And a periodic search measures its period cap**", "`N ≤ 120`. ", "", "I:G21",
     "a second instance of G21's own rule (a verdict measures its enumeration; here the enumeration is the period cap)"),
    ("M2", "G", "G21", "**And a one-period census measures its period**", "measures that point. ", "", "I:G21",
     "a further instance of G21's rule; its lesson is G73's Do ('compute its Θ_k cells before calling it rigid') and G68's last sentence"),
    ("M3", "G", "G21", "; and **a finite configuration measures its depth**", "emptied the claim (row 126).",
     f"; the third, and the rest: {PTR} §G21.", "I:G21",
     "instances of rules stated elsewhere: G21's own (finite configuration, rank-1 scan, proof checked by points, a verdict names its route); "
     "'Make the gate fail' (plants that could not fire; a wrong-reason red; a positive control proves only its generator's shapes); "
     "quote verbatim (G51's standing rules; standing rule 5). G74's Do carries FS81-T8"),
    ("M5", "G", "G49", "**FS-79's instance, the question itself:**", "the day it was needed. ", f"More instances: {PTR} §G49. ", "I:G49",
     "instances of G49's head rule (question as well as method; discipline's words) and of its Do (a held paper is prior art for "
     "questions it was not read for), whose one example stays (FS-71's six re-attributions)"),
    ("M6", "G", "G50", "**FS-79's instances:**", "went unsearched. ", "", "I:G50",
     "instances of G50's rule (held-but-unread blocks; an abstract is not a reading); the one example kept is FS-100's, which is also "
     "the Do's (grep BIBLIOGRAPHY.md before fetching or calling unheld)"),
    ("M7", "G", "G50", "**FS-100 stage 5's:**", "(\"multiplicative semigroup of polynomial growth\"). ", "", "I:G50",
     "an instance of G49's discipline's-words rule and G21's (a zero read as support); its mathematics is G76's Do "
     "(Einsiedler–Fish's pigeonhole before calling a measure question ×2×3-hard)"),
    ("M8", "G", "G72", "FS-73 (the instance); FS-79", "layer 2's invariant not found. ",
     f"the twelve, milestone by milestone, are in {PTR} §G72. ", "I:G72",
     "the killing test's per-milestone history; its state (twelve of thirteen) and the one exception (the thirteenth) stay; "
     "'no-gos count' is item 23's"),
    ("M9", "F", "Frontier § The prior-art position", "**Not ours:** band rigidity", "(`[Croft1967]`).",
     "**Not ours:** every attribution, verbatim, in `LEDGER.md` § The claim list — read it before calling anything ours.", "L",
     "the brief's named incidental: an attribution enumeration whose home in kind is LEDGER.md § The claim list"),
    ("M10", "F", "Frontier § Paths forward, ranks 30–59", "| 30 | **FS-39", "reading rooms and loose ends | low |",
     "| 30–59 | FS-39, FS-43, FS-99, FS-49, FS-65, FS-69, FS-57, FS-62, FS-41, FS-42, FS-44, FS-51, FS-52, FS-20, FS-17, FS-2, "
     "FS-13, FS-12, FS-19, FS-37, FS-27, FS-23, FS-30, FS-35, FS-22, FS-8, FS-29, FS-9, FS-10, FS-5 — in rank order; their rows "
     "are `plans/FRONTIER-STUBS.md`'s alone | … | … |", "F",
     "the brief's named incidental: rows ranked ≥ 30, each present and current in plans/FRONTIER-STUBS.md (checked token by token)"),
    ("M11", "B", "§ Building, Kill by PID", "(b) The\nrepair attempt", "an\nunrelated failure. ",
     f"(b), the eighth: {PTR} § Building. ", "I:Building",
     "a second instance of the paragraph's own first sentence (`pkill -f`/`pgrep -f` matches the shell that runs it)"),
]
GLUE = [
    ("g1", "G", "G21", "P3b typed", "P3b (FS-79) typed", "P3b's milestone, which M2's cut removed from the sentence before"),
    ("g2", "G", "G50", "may hold PE-2. *Do:", f"may hold PE-2. More instances: {PTR} §G50. *Do:", "the pointer"),
]
SECTION_TITLES = {
    "G21": "G21 — A negative measures its enumeration",
    "G49": "G49 — The prior-art gate",
    "G50": "G50 — Read what the search found",
    "G72": "G72 — The invariant question",
    "Building": "`CLAUDE.md` § Building — Kill by PID or process group",
}


def span(text, start, end):
    assert text.count(start) == 1, f"start anchor not unique: {start!r}"
    i = text.index(start)
    j = text.index(end, i)
    assert text.count(end) == 1 or text.find(end, i) == j, f"end anchor ambiguous: {end!r}"
    return i, j + len(end)


def inventory():
    text = (ROOT / "CLAUDE.md").read_text(encoding="utf-8")
    print("| move | address | bytes cut | pointer bytes | net | destination | incidental because |")
    print("|---|---|---:|---:|---:|---|---|")
    tot = 0
    for mid, grp, entry, s, e, repl, dest, why in MOVES:
        i, j = span(text, s, e)
        cut = len(text[i:j].encode())
        net = cut - len(repl.encode())
        tot += net
        d = {"L": "`LEDGER.md` beside § The claim list", "F": "`plans/FRONTIER-STUBS.md` (already there)"}.get(dest, f"{PTR} §{dest[2:]}")
        print(f"| {mid} | {entry}: from {s[:40]!r} to {e[-30:]!r} | {cut:,} | {len(repl.encode()):,} | {net:,} | {d} | {why} |")
    for gid, grp, entry, old, new, why in GLUE:
        assert text.count(old) == 1, old
        tot -= len(new.encode()) - len(old.encode())
        print(f"| {gid} (glue) | {entry}: {old!r} → {new!r} | 0 | {len(new.encode()) - len(old.encode())} | − | — | {why} |")
    print(f"\nnet bytes out of CLAUDE.md: {tot:,}; CLAUDE.md {len(text.encode()):,} -> {len(text.encode()) - tot:,}")


INST_HEAD = f"""# GROKKING-INSTANCES.md — the second and later instances behind `CLAUDE.md`'s rules

*Extracted from `CLAUDE.md` on 2026-09-26 (job E1 of the documentation consolidation; design (b) of
`plans/PROPOSAL-claude-md-knowledge-cache.md`, Kooshi: "Implement b on the file. Remove incidentals, keep intrinsics."). Like
`LEDGER.md`, this file is **read by address, never loaded**: `CLAUDE.md` keeps every rule's statement, its reasoning and one example,
and points here for the rest. One section per source — a grokking by its identifier, or a `CLAUDE.md` section by name — each moved
passage **verbatim**, under the words that precede it in the source. `tools/claude_md_fact_audit.py` audits `CLAUDE.md`, `LEDGER.md`
and this file as one corpus. Later instances of these rules belong here, under their source.*
"""


def apply(group):
    cpath, lpath = ROOT / "CLAUDE.md", ROOT / "LEDGER.md"
    text = cpath.read_text(encoding="utf-8")
    inst = INST.read_text(encoding="utf-8") if INST.exists() else INST_HEAD
    sections: dict[str, list[str]] = {}
    ledger_add = []
    for mid, grp, entry, s, e, repl, dest, why in MOVES:
        if grp != group:
            continue
        i, j = span(text, s, e)
        cut = text[i:j]
        before = " ".join(text[max(0, i - 200):i].split()[-6:])   # six words: a quote long enough to find, too short for --dupes
        text = text[:i] + repl + text[j:]
        if dest.startswith("I:"):
            sections.setdefault(dest[2:], []).append(f"*{mid}, from {entry}, after “…{before}”:*\n\n{cut.strip()}\n")
        elif dest == "L":
            ledger_add.append(cut)
    for gid, grp, entry, old, new, why in GLUE:
        if grp == group:
            assert text.count(old) == 1, old
            text = text.replace(old, new, 1)
    for sec, parts in sections.items():
        inst = inst.rstrip("\n") + f"\n\n## {SECTION_TITLES[sec]}\n\n" + "\n".join(parts)
    cpath.write_text(text, encoding="utf-8")
    if sections:
        INST.write_text(inst.rstrip("\n") + "\n", encoding="utf-8")
    if ledger_add:
        led = lpath.read_text(encoding="utf-8")
        anchor = "\n## A. The novel-results ledger"
        assert led.count(anchor) == 1
        led = led.replace(anchor, "\n" + "\n".join(c.strip() for c in ledger_add) + "\n" + anchor, 1)
        lpath.write_text(led, encoding="utf-8")


if __name__ == "__main__":
    if sys.argv[1] == "inventory":
        inventory()
    elif sys.argv[1] == "apply":
        apply(sys.argv[2])
