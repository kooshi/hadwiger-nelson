#!/usr/bin/env python3
"""E2's mechanical check of a CLAUDE.md extraction: every passage the edit removed from CLAUDE.md is somewhere, verbatim.

Job E2 of the 2026-09-26 documentation consolidation (brief `data/consolidation-2026-09-26/briefs/E2-intrinsics-check.md`) verifies
job E1, which moved text out of CLAUDE.md to plans/GROKKING-INSTANCES.md, LEDGER.md and plans/FRONTIER-STUBS.md. This tool derives
the removed text from the diff ITSELF -- never from E1's move list -- so a cut E1 did not list is checked too.

    python3 tools/e2_moved_check.py                          # E1's range 230ea964..aeef4e58, homes read from the working tree
    python3 tools/e2_moved_check.py --homes-rev aeef4e58     # homes read at a revision instead
    python3 tools/e2_moved_check.py --self-test              # plant faults in copies of the homes and watch each one fire

How the removed text is found. The old and new CLAUDE.md are aligned line by line (difflib, no autojunk); inside every changed
hunk the old and new text are aligned word by word (whitespace kept as tokens), and each run of deleted or replaced old tokens is
a removed SPAN. Two spans separated by at most GAP tokens of matched text are merged (a pointer that happens to contain "the" or
"in" must not split one moved passage in two); the merged span is still a contiguous piece of the old file.

What it checks, and what FAILS the run (exit status 1):
  * LANDED: each removed span is found VERBATIM (byte for byte, newlines included) in a home: plans/GROKKING-INSTANCES.md,
    LEDGER.md, plans/FRONTIER-STUBS.md, or the current CLAUDE.md itself (a passage restored). A span that is not found whole is
    split into its lines, and every line of it that is found nowhere is printed and fails the run -- the unit of the report is
    the removed LINE, as the brief asks.
  * TABLE ROWS homed by tokens: a removed paths-forward row (a line opening with "| ") that is not verbatim anywhere passes only
    if plans/FRONTIER-STUBS.md has a row for each FS-number it names AND every fact token of the removed row (numbers,
    backticked spans, bibliography keys, identifiers) is in that FRONTIER-STUBS row; the words that are not are printed as
    a reading aid (never a failure: FRONTIER-STUBS's rows are written independently).
  * POINTER: each hunk whose spans landed in GROKKING-INSTANCES, LEDGER or FRONTIER-STUBS carries a pointer, in its new
    text, to that file (and, for GROKKING-INSTANCES, to the section "§Gnn" / "§ Building" the span landed in).
  * REWRITES -- removed spans of fewer than MIN_MOVED visible characters -- are word-level rewrites, not moves (a "both"
    replaced by "the three"); they are printed, every one, for a reader's judgement, and never pass or fail on their own.

WHAT THIS CANNOT SEE: whether the removed text was incidental. That is a judgement, recorded passage by passage in
data/consolidation-2026-09-26/E2-record.md. This tool only proves nothing was lost in transit.
"""
from __future__ import annotations

import argparse
import difflib
import re
import subprocess
import sys
import tempfile
from collections import Counter
from dataclasses import dataclass, field
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASE, AFTER = "230ea964", "aeef4e58"
HOMES = ["plans/GROKKING-INSTANCES.md", "LEDGER.md", "plans/FRONTIER-STUBS.md"]
GAP = 6            # matched tokens (words + whitespace) allowed inside one removed span
MIN_MOVED = 24     # visible characters below which a removed span is a rewrite, not a move
TOKEN = re.compile(r"\s+|\S+")
# Reviewed allowances for the table-row check: (first FS-number of the row, token) -> why the token may be absent from its
# FRONTIER-STUBS row. Each is a decision recorded in data/consolidation-2026-09-26/E2-record.md, never a silent one.
ROW_ALLOW: dict[tuple[str, str], str] = {
    ("FS-65", "G64"): "a cross-reference; the row's consequence (alpha < ceil(q^2/6) closes a wall member) is in FRONTIER-STUBS's row, "
                      "the wall's meaning in CLAUDE.md G56/G59/G64",
    ("FS-65", "`α(Γ_q)`"): "notation: FRONTIER-STUBS writes `α(UD(𝔽_q,2))`, and Γ_q := UD(𝔽_q, 2) (CLAUDE.md § Notation)",
    ("FS-41", "row 66"): "FRONTIER-STUBS's FS-42 row says \"Row 66 leaves exactly one constructive residue route\" (capital R)",
    ("FS-20", "97"): "alpha(Γ₂₃) <= 97 by FS-66's certificate stays in CLAUDE.md (Frontier item 17, row 75); FRONTIER-STUBS's FS-17 "
                     "row still reads the older <= 105 -- stale there, owed to FRONTIER-STUBS (E2 record, held for the owner)",
    ("FS-20", "FS-66"): "the same fact as ('FS-20', '97')",
    ("FS-20", "row 71"): "five refused at 23: FRONTIER-STUBS's FS-17 row states it (FS-56's certificate) without the row number",
    ("FS-13", "FS-47"): "the FS-37 <-> FS-47 link stays in CLAUDE.md, from the other side: rank 27's FS-47 row (\"with FS-37\") and G35's gate",
    ("FS-9", "row 80"): "FRONTIER-STUBS's FS-9 row cites row 80's derivation (plans/FS79-derivation.md T26); CLAUDE.md G30 and G73 carry row 80",
}
FACT = re.compile(r"`[^`\n]+`|\[[A-Z][A-Za-z]+\d{4}[a-z]*\]|FS-\d+|\b[MG]\d+\b|row \d+|\d[\d.,/·^⁻¹⁰-⁹]*")


def git_show(rev: str, path: str) -> str:
    r = subprocess.run(["git", "show", f"{rev}:{path}"], cwd=ROOT, capture_output=True, text=True)
    if r.returncode != 0:
        sys.exit(f"FAIL: git show {rev}:{path}: {r.stderr.strip()}")
    return r.stdout


@dataclass
class Span:
    text: str                 # the removed old text, verbatim
    hunk: int                 # index of its line hunk
    new_text: str             # the hunk's new side (where the pointer must be)
    old_line: int             # 1-based line of the old file where the hunk starts
    homes: list[str] = field(default_factory=list)


def removed_spans(old: str, new: str) -> list[Span]:
    ol, nl = old.splitlines(keepends=True), new.splitlines(keepends=True)
    out: list[Span] = []
    ops = difflib.SequenceMatcher(None, ol, nl, autojunk=False).get_opcodes()
    for h, (tag, i1, i2, j1, j2) in enumerate(ops):
        if tag == "equal" or i1 == i2:
            continue
        ochunk, nchunk = "".join(ol[i1:i2]), "".join(nl[j1:j2])
        ot, nt = TOKEN.findall(ochunk), TOKEN.findall(nchunk)
        runs: list[list[int]] = []                       # [start, end) in old tokens
        for t, a1, a2, _b1, _b2 in difflib.SequenceMatcher(None, ot, nt, autojunk=False).get_opcodes():
            if t in ("delete", "replace"):
                if runs and a1 - runs[-1][1] <= GAP:
                    runs[-1][1] = a2
                else:
                    runs.append([a1, a2])
        for a, b in runs:
            out.append(Span("".join(ot[a:b]), h, nchunk, i1 + 1))
    return out


def fs_rows(frontier: str) -> dict[str, str]:
    """FRONTIER-STUBS table rows by the FIRST FS-number in their stub column (the second cell)."""
    rows = {}
    for line in frontier.splitlines():
        if line.startswith("|"):
            cells = line.split("|")
            if len(cells) > 3:
                m = re.search(r"FS-\d+", cells[2])
                if m and m.group() not in rows:
                    rows[m.group()] = line
    return rows


def note_ptr(need_ptr: dict, hunk: int, where: list[str], homes: dict[str, str], body: str) -> None:
    for p in where:
        if p == "plans/GROKKING-INSTANCES.md":
            need_ptr.setdefault(hunk, set()).add(f"§{section_of(homes[p], homes[p].find(body))}")
        elif p != "CLAUDE.md (restored)":
            need_ptr.setdefault(hunk, set()).add(p)


def trim_to_fit(body: str, new_text: str, homes: dict[str, str], current: str) -> tuple[str, str]:
    """A word-level diff may take a word the edit KEPT (e.g. "P3b", re-spelled "P3b (FS-79)") into a removed span. If the span is
    not found whole, drop up to GAP tokens from either end -- only tokens that still stand in the hunk's new text -- and return
    the longest trimmed span found verbatim in a home, with the dropped text (for the report). Otherwise return it unchanged."""
    def found(t):
        return any(t in h for h in homes.values()) or t in current
    if found(body):
        return body, ""
    tk = TOKEN.findall(body)
    for total in range(1, 2 * GAP + 1):
        for lo in range(0, total + 1):
            hi = total - lo
            if lo + hi >= len(tk):
                continue
            head, mid, tail = tk[:lo], tk[lo:len(tk) - hi], tk[len(tk) - hi:]
            dropped = [t for t in head + tail if t.strip()]
            if not all(t in new_text for t in dropped):
                continue
            cand = "".join(mid).strip()
            if len(cand) >= MIN_MOVED and found(cand):
                return cand, repr(" ".join(dropped))
    return body, ""


def section_of(inst: str, pos: int) -> str:
    head = inst.rfind("\n## ", 0, pos)
    if head < 0:
        return ""
    title = inst[head + 4: inst.find("\n", head + 4)]
    m = re.match(r"(G\d+)\b", title)
    return m.group(1) if m else ("Building" if "§ Building" in title else title)


def check(old: str, new: str, homes: dict[str, str], current: str, quiet: bool = False, drop_span: int | None = None) -> list[str]:
    """Return the list of failures (empty = PASS). `drop_span` (self-test only) hides one span from the checks, so the
    completeness check must notice that the alignment 'lost' it."""
    fails: list[str] = []
    say = (lambda *a: None) if quiet else print
    spans = removed_spans(old, new)
    if drop_span is not None:
        spans = spans[:drop_span] + spans[drop_span + 1:]
    frow = fs_rows(homes["plans/FRONTIER-STUBS.md"])
    need_ptr: dict[int, set[str]] = {}
    n_moved = n_rewrite = n_verb = n_tok = 0
    for s in spans:
        vis = len(s.text.strip())
        if vis < MIN_MOVED:
            n_rewrite += 1
            say(f"REWRITE  old line {s.old_line}: {s.text.strip()!r}  (new side of the hunk: {s.new_text.strip()[:90]!r}…)")
            continue
        n_moved += 1
        body = s.text.strip()
        body, trimmed = trim_to_fit(body, s.new_text, homes, current)
        where = [p for p, t in homes.items() if body in t] + (["CLAUDE.md (restored)"] if body in current else [])
        if where:
            n_verb += 1
            s.homes = where
            note_ptr(need_ptr, s.hunk, where, homes, body)
            say(f"VERBATIM old line {s.old_line}: {len(body.encode()):>6} B in {', '.join(where)}: {body[:70]!r}…"
                + (f"  [ends trimmed, still in CLAUDE.md's new text: {trimmed}]" if trimmed else ""))
            continue
        # not whole: every OLD line the span touches, the line being the unit of the report
        a = old.index(s.text.strip())
        b = a + len(s.text.strip())
        ls = old.rfind("\n", 0, a) + 1
        while ls < b:
            le = old.find("\n", ls)
            le = len(old) if le < 0 else le
            full = old[ls:le]
            piece = old[max(ls, a):min(le, b)].strip()
            ls = le + 1
            if not piece:
                continue
            lw = [p for p, t in homes.items() if piece in t] + (["CLAUDE.md (restored)"] if piece in current else [])
            if lw:
                n_verb += 1
                note_ptr(need_ptr, s.hunk, lw, homes, piece)
                say(f"VERBATIM (line) old line {s.old_line}: in {', '.join(lw)}: {piece[:70]!r}…")
                continue
            if full.startswith("| "):
                cell = full.split("|")[2] if full.count("|") > 3 else ""
                ids = re.findall(r"(?:^|, )\s*\**(FS-\d+)", cell)
                rows = [frow.get(i) for i in ids]
                if not ids or any(r is None for r in rows):
                    fails.append(f"LOST row (no FRONTIER-STUBS row for {ids or 'any FS-number'}): {full[:100]!r}")
                    continue
                joined = "\n".join(rows)
                missing = sorted({t.rstrip(",.;:") for t in FACT.findall(full) if t.rstrip(",.;:") not in joined}
                                 - set(full.split("|")[1].split()) - {k[1] for k in ROW_ALLOW if k[0] == ids[0]})
                allowed = sorted(k[1] for k in ROW_ALLOW if k[0] == ids[0])
                if missing:
                    fails.append(f"LOST tokens of row {ids}: {missing}")
                    continue
                n_tok += 1
                need_ptr.setdefault(s.hunk, set()).add("plans/FRONTIER-STUBS.md")
                words = {w.strip("*`,.;:()…") for w in full.split()} - {w.strip("*`,.;:()…") for w in joined.split()}
                say(f"TOKENS   row {', '.join(ids)}: every fact token in its FRONTIER-STUBS row"
                    + (f" (allowed, reviewed: {allowed})" if allowed else "") + f"; words not there: {sorted(w for w in words if w)}")
                continue
            fails.append(f"LOST line (old line ≈{s.old_line}): {piece[:110]!r}")
    for h, wants in sorted(need_ptr.items()):
        newside = next(s.new_text for s in spans if s.hunk == h)
        for w in sorted(wants):
            key = {"plans/GROKKING-INSTANCES.md": "GROKKING-INSTANCES.md", "LEDGER.md": "`LEDGER.md`",
                   "plans/FRONTIER-STUBS.md": "FRONTIER-STUBS.md"}.get(w)
            if w.startswith("§"):
                ok = "GROKKING-INSTANCES.md" in newside and (w in newside or w.replace("§", "§ ") in newside)
            else:
                ok = key in newside
            if not ok:
                fails.append(f"NO POINTER in hunk {h} to {w}: new side {newside.strip()[:100]!r}")
            else:
                say(f"POINTER  hunk {h}: names {w}")
    # completeness: every word that left CLAUDE.md lies inside a reported span (the alignment hid no removal)
    lost = Counter(old.split()) - Counter(new.split())
    cov: Counter = Counter()
    for s in spans:
        cov += Counter(s.text.split())
    if lost - cov:
        fails.append(f"UNCOVERED words left CLAUDE.md outside every reported span: {dict(lost - cov)}")
    say(f"\nspans: {len(spans)} (moved {n_moved}, rewrites {n_rewrite}); verbatim units {n_verb}; rows homed by tokens {n_tok}; "
        f"failures {len(fails)}")
    for f in fails:
        say("FAIL: " + f)
    return fails


def load(homes_rev: str | None) -> tuple[dict[str, str], str]:
    if homes_rev:
        return {p: git_show(homes_rev, p) for p in HOMES}, git_show(homes_rev, "CLAUDE.md")
    return {p: (ROOT / p).read_text(encoding="utf-8") for p in HOMES}, (ROOT / "CLAUDE.md").read_text(encoding="utf-8")


def self_test(old: str, new: str) -> int:
    """Plant faults in COPIES of the homes; each plant must fail for exactly its planted unit, each partner must pass."""
    homes, current = load(AFTER)
    ok = True

    def run(name, h, cur, nw, must_fail_with: str | None, drop_span=None):
        nonlocal ok
        fails = check(old, nw, h, cur, quiet=True, drop_span=drop_span)
        if must_fail_with is None:
            good = not fails
        else:
            good = len(fails) >= 1 and all(must_fail_with in f for f in fails)
        print(f"{'ok  ' if good else 'BAD '} {name}: {len(fails)} failure(s){': ' + fails[0][:120] if fails else ''}")
        ok &= good

    run("partner: homes and CLAUDE.md as E1 left them", homes, current, new, None)
    # plant 1: one moved line deleted from GROKKING-INSTANCES (M1's second line)
    victim = "  milestone, row 79): ℚ(√167)'s `L3e1c94c6` read as having no periodic three-colouring because the search stopped at `N = 20` —"
    inst = homes["plans/GROKKING-INSTANCES.md"]
    assert inst.count(victim + "\n") == 1, "plant 1's victim line is not unique in the instances file"
    run("plant 1: one moved line deleted from GROKKING-INSTANCES", {**homes, "plans/GROKKING-INSTANCES.md": inst.replace(victim + "\n", "")},
        current, new, "L3e1c94c6")
    # plant 2: one line of the Not ours list deleted from LEDGER
    v2 = "ω ≠ χ on finite planes (Vinh, Krebs, Schneider–Silva); the cell family's ≥ 7 floor (Sokolov–Voronov); the"
    led = homes["LEDGER.md"]
    assert led.count(v2 + "\n") == 1, "plant 2's victim line is not unique in LEDGER.md"
    run("plant 2: one Not-ours line deleted from LEDGER", {**homes, "LEDGER.md": led.replace(v2 + "\n", "")}, current, new, "Sokolov")
    # plant 3: a fact token of FS-65's row dropped from FRONTIER-STUBS
    fr = homes["plans/FRONTIER-STUBS.md"]
    row = fs_rows(fr)["FS-65"]
    assert "struction" in row
    run("plant 3: FS-65's row loses `struction` in FRONTIER-STUBS", {**homes, "plans/FRONTIER-STUBS.md": fr.replace(row, row.replace("`struction`", "a solver"))},
        current, new, "FS-65")
    # plant 4: the §G49 pointer dropped from the new CLAUDE.md
    ptr = "More instances: `plans/GROKKING-INSTANCES.md` §G49. "
    assert new.count(ptr) == 1
    new4 = new.replace(ptr, "")
    run("plant 4: the §G49 pointer dropped", homes, new4, new4, "§G49")
    # partner 5: a passage restored to CLAUDE.md and deleted from its home still passes (found in CLAUDE.md)
    m11 = ("(b) The\nrepair attempt then ran `for p in $(pgrep -u $USER -f \"fplane_sat_cube.py run\"); do kill -TERM $p; done` —\n"
           "and `pgrep -f` matched **the shell executing the loop**, whose command line contains the pattern, so the\n"
           "shell killed itself mid-loop before reaching a single real target and exited 144, which reads like an\nunrelated failure.")
    assert inst.count(m11) == 1 and old.count(m11) == 1
    run("partner 5: M11 restored to CLAUDE.md, gone from its home", {**homes, "plans/GROKKING-INSTANCES.md": inst.replace(m11, "")},
        current + "\n" + m11, new, None)
    # plant 6: the alignment "loses" the M11 span (the last one) -- the completeness check must name its words
    last = len(removed_spans(old, new)) - 1
    run("plant 6: one removed span hidden from the checks", homes, current, new, "UNCOVERED", drop_span=last)
    print("SELF-TEST " + ("PASSED" if ok else "FAILED"))
    return 0 if ok else 1


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--base", default=BASE)
    ap.add_argument("--after", default=AFTER)
    ap.add_argument("--homes-rev", help="read the homes and the current CLAUDE.md at this revision (default: the working tree)")
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    old, new = git_show(a.base, "CLAUDE.md"), git_show(a.after, "CLAUDE.md")
    if a.self_test:
        return self_test(old, new)
    homes, current = load(a.homes_rev)
    fails = check(old, new, homes, current)
    print("CHECK " + ("PASSED" if not fails else "FAILED"))
    return 0 if not fails else 1


if __name__ == "__main__":
    sys.exit(main())
