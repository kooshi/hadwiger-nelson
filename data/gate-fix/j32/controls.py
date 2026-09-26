#!/usr/bin/env python3
"""J32's controls for `scripts/gate_report.py`'s comparison against the counts the repository records.

The defect these guard (J23bd, 2026-09-25): the vacuity digest printed "recorded counts (<baseline>'s header,
CLAUDE.md § The gate): match" while it never opened `CLAUDE.md`, whose § The gate was four counts stale. So
every plant below is aimed at one recorded source, and each run is checked on BOTH sides:

* the plant fired — the planted source gets the verdict the plant should cause (STALE, with exactly the
  planted count; or NOT COMPARED, with the planted reason; exit 3 for an unreadable source);
* nothing else fired — every other source reads "match (9 of 9 compared)", no source is reported twice or
  omitted, and the exit status is exactly the expected one.

Every plant is paired with the faithful copy (V1, A1), which must pass. And the two plants that the defective
version cannot see (V2, A5) are also run against the version before J32 (`git show 7d8ac03c:…`), where the
checks must go RED — so a pass here is not a control that could never fail.

Fixtures are built here by plain string edits, never by `gate_report.py`'s own reader (a control built with
the parser under test tests nothing if the parser is wrong); each edit must apply exactly once, or the control
refuses to run. The copies live in a temporary directory; `CLAUDE.md` itself is only read.

    python3 data/gate-fix/j32/controls.py     # exit 0: every control behaved; exit 1: at least one did not
"""
from __future__ import annotations

import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
REPORT = REPO / "scripts/gate_report.py"
SCAN = HERE / "fixture-vacuity-scan.log"
AUDIT = HERE / "fixture-axioms-audit.log"
BEFORE = "7d8ac03c"  # the last commit with the defective gate_report.py
KEYS = ("declarations", "refutations-skipped", "sites", "vacuous", "stale", "declared", "witnessed", "generic",
        "unknown")
TRUST = r"current audit reads \d+ clean and \d+ declared purchases"


class PlantRefused(Exception):
    """A fixture edit did not apply exactly once: the control would test something other than its plant."""


# ---- what the fixtures' runs actually counted, read independently of gate_report.py -------------------

def scan_counts() -> dict:
    found = {}
    for line in SCAN.read_text().splitlines():
        if line.startswith(("=== SCANNED === ", "=== TOTALS === ")):
            found.update({k: int(v) for k, v in re.findall(r"([\w-]+)=(\d+)", line)})
    return {k: found[k] for k in KEYS}


def audit_counts() -> tuple[int, int]:
    """(clean records that carry axioms, declared purchases): record lines between the two banners."""
    section, clean, purchased = None, 0, 0
    for line in AUDIT.read_text().splitlines():
        if line in ("=== CLEAN ===", "=== PURCHASED ==="):
            section = line
        elif line.startswith("'") and " depends on axioms: [" in line:
            clean += section == "=== CLEAN ==="
            purchased += section == "=== PURCHASED ==="
        elif line.startswith("'") and line.endswith(" does not depend on any axioms"):
            purchased += section == "=== PURCHASED ==="
    return clean, purchased


# ---- fixture edits -------------------------------------------------------------------------------------

def span(text: str, start: str, end: str) -> tuple[int, int]:
    if text.count(start) != 1:
        raise PlantRefused(f"{start!r} occurs {text.count(start)} times, not once")
    i = text.index(start)
    j = text.find(end, i + len(start))
    if j < 0:
        raise PlantRefused(f"no {end!r} after {start!r}")
    return i, j


def sub_once(text: str, pattern: str, repl: str, start: str, end: str) -> str:
    i, j = span(text, start, end)
    body, n = re.subn(pattern, repl, text[i:j])
    if n != 1:
        raise PlantRefused(f"{pattern!r} matched {n} times between {start!r} and {end!r}, not once")
    return text[:i] + body + text[j:]


def set_counts(text: str, values: dict, start: str, end: str) -> str:
    for k, v in values.items():
        text = sub_once(text, rf"(?<![\w-]){re.escape(k)}=\d+", f"{k}={v}", start, end)
    return text


GATE = ("\n## The gate\n", "\n### Make the gate fail")
LEDGER = ("\n## Trust ledger\n", "\n## Toolchain\n")
PACKAGE = ("\n## The package\n", "\n## The gate\n")
BASE_HEADER = ("# Counts to hold", "\n# The declaration count")


def set_trust(text: str, clean: int, purchased: int) -> str:
    return sub_once(text, TRUST, f"current audit reads {clean} clean and {purchased} declared purchases", *LEDGER)


# ---- running the digest and reading its verdicts -------------------------------------------------------

def run(script: Path, *args) -> tuple[int, list[str]]:
    done = subprocess.run([sys.executable, str(script), *map(str, args)], capture_output=True, text=True)
    return done.returncode, (done.stdout + done.stderr).splitlines()


def verdicts(lines: list[str], prefix_ok: str, prefix_stale: str, prefix_not: str) -> list[tuple[str, str, str]]:
    """(kind, label, rest) for every recorded-count verdict line."""
    out = []
    for line in lines:
        s = line.strip()
        for kind, pre in (("match", prefix_ok), ("stale", prefix_stale), ("not", prefix_not)):
            if s.startswith(pre):
                rest = s[len(pre):]
                if kind == "match":
                    label, _, tail = rest.partition(": match")
                    out.append((kind, label, "match" + tail))
                elif kind == "stale":
                    label, _, tail = rest.partition(" — update it: ")
                    out.append((kind, label, tail))
                else:
                    out.append((kind, "", rest))
    return out


def check(name: str, got_exit: int, lines: list[str], want_exit: int, want: dict, match_tail: str,
          prefixes: tuple[str, str, str]) -> list[str]:
    """Problems with one run: `want` maps each source label to ("match",), ("stale", {item, …}) or
    ("not", reason-substring). Empty means the control behaved."""
    problems = []
    if got_exit != want_exit:
        problems.append(f"exit {got_exit}, expected {want_exit}")
    seen = verdicts(lines, *prefixes)
    for label, expect in want.items():
        if expect[0] == "not":
            hits = [v for v in seen if v[0] == "not" and label in v[2]]
        else:
            hits = [v for v in seen if v[0] != "not" and v[1] == label]
        if len(hits) != 1:
            problems.append(f"{len(hits)} verdict lines for {label!r}, expected exactly one")
            continue
        kind, _, rest = hits[0]
        if kind != expect[0]:
            problems.append(f"{label!r}: {kind} ({rest}), expected {expect[0]}")
        elif kind == "match" and rest != match_tail:
            problems.append(f"{label!r}: {rest!r}, expected {match_tail!r}")
        elif kind == "stale" and set(rest.split(", ")) != expect[1]:
            problems.append(f"{label!r}: stale items {rest!r}, expected exactly {sorted(expect[1])}")
        elif kind == "not" and expect[1] not in rest:
            problems.append(f"{label!r}: {rest!r} lacks {expect[1]!r}")
    if len(seen) != len(want):
        problems.append(f"{len(seen)} verdict lines in all, expected {len(want)}: {seen}")
    if want_exit == 3 and not any(l.startswith("==> gate report: FAIL") for l in lines):
        problems.append("exit 3 without the '==> gate report: FAIL' line")
    return problems


VAC = ("recorded counts in ", "RECORDED COUNTS ARE STALE in ", "RECORDED COUNTS NOT COMPARED — ")
AX = ("recorded count in ", "RECORDED COUNT IS STALE in ", "RECORDED COUNT NOT COMPARED — ")


def main() -> int:
    now, (clean, purchased) = scan_counts(), audit_counts()
    claude_real = (REPO / "CLAUDE.md").read_text(encoding="utf-8")
    base_real = (REPO / "scripts/vacuity-baseline.txt").read_text(encoding="utf-8")
    c0 = set_trust(set_counts(claude_real, now, *GATE), clean, purchased)  # the faithful CLAUDE.md
    b0 = set_counts(base_real, now, *BASE_HEADER)  # the faithful baseline
    print(f"fixtures: scan {SCAN.name} counts {now}; audit {AUDIT.name} clean={clean} purchases={purchased}")

    tmp = Path(tempfile.mkdtemp(prefix="j32-controls-"))
    try:
        return controls(now, clean, purchased, c0, b0, tmp)
    finally:
        shutil.rmtree(tmp)  # /tmp is RAM on this machine


def controls(now: dict, clean: int, purchased: int, c0: str, b0: str, tmp: Path) -> int:
    before = tmp / "gate_report_before.py"
    shown = subprocess.run(["git", "-C", str(REPO), "show", f"{BEFORE}:scripts/gate_report.py"],
                           capture_output=True, text=True)
    if shown.returncode != 0:
        print(f"FAIL  could not extract the pre-J32 gate_report.py: {shown.stderr.strip()}")
        return 1
    before.write_text(shown.stdout)

    def files(case: str, base: str | None, claude: str) -> tuple[Path, Path]:
        d = tmp / case
        d.mkdir()
        (d / "CLAUDE.md").write_text(claude, encoding="utf-8")
        if base is not None:
            (d / "vacuity-baseline.txt").write_text(base, encoding="utf-8")
        return d / "vacuity-baseline.txt", d / "CLAUDE.md"

    def labels(b: Path, c: Path) -> tuple[str, str, str]:
        return f"{b}'s header", f"CLAUDE.md § The gate (read from {c})", f"CLAUDE.md § Trust ledger (read from {c})"

    M, results = ("match",), []

    def vac(name, base, claude, want_exit, want_fn, script=REPORT, red_because=None):
        b, c = files(name, base, claude)
        lb, lc, _ = labels(b, c)
        args = ("vacuity", SCAN, "", b) if script == before else ("vacuity", SCAN, "", b, c)
        code, lines = run(script, *args)
        problems = check(name, code, lines, want_exit, want_fn(lb, lc), "match (9 of 9 compared)", VAC)
        results.append((name, problems, red_because, code, lines))

    def ax(name, claude, want_exit, want_fn, script=REPORT, red_because=None):
        _, c = files(name, None, claude)
        _, _, lt = labels(c, c)
        code, lines = run(script, "axioms", AUDIT, "", c)
        problems = check(name, code, lines, want_exit, want_fn(lt), "match (clean and purchases compared)", AX)
        results.append((name, problems, red_because, code, lines))

    w = now["witnessed"]
    g = now["generic"]
    # V: the vacuity digest.
    vac("V1-faithful", b0, c0, 0, lambda lb, lc: {lb: M, lc: M})
    vac("V2-claude-stale", b0, set_counts(c0, {"witnessed": w + 1}, *GATE), 0,
        lambda lb, lc: {lb: M, lc: ("stale", {f"witnessed {w + 1} → {w}"})})
    vac("V3-baseline-stale", set_counts(b0, {"generic": g - 1}, *BASE_HEADER), c0, 0,
        lambda lb, lc: {lb: ("stale", {f"generic {g - 1} → {g}"}), lc: M})
    vac("V4-claude-count-missing", b0, sub_once(c0, r" unknown=\d+", "", *GATE), 3,
        lambda lb, lc: {lb: M, lc: ("not", f"could not read the counts in {lc}: no unknown")})
    vac("V5-claude-count-doubled", b0, sub_once(c0, r"(?<![\w-])sites=(\d+)", r"sites=\1 sites=\1", *GATE), 3,
        lambda lb, lc: {lb: M, lc: ("not", f"could not read the counts in {lc}: sites recorded more than once")})
    vac("V6-claude-heading-gone", b0, sub_once(c0, r"\n## The gate\n", "\n## The gates\n", *GATE), 3,
        lambda lb, lc: {lb: M, lc: ("not", f"could not read the counts in {lc}: 0 '## The gate' headings")})
    moved = c0
    for k in KEYS:  # the counts leave § The gate (key=N → key N) and reappear, faithful, in § The package
        moved = sub_once(moved, rf"(?<![\w-]){re.escape(k)}=(\d+)", rf"{k} \1", *GATE)
    moved = sub_once(moved, r"(The \*\*`proofs`\*\* package)",
                     " ".join(f"{k}={now[k]}" for k in KEYS) + r"\n\n\1", *PACKAGE)
    vac("V7-claude-counts-outside-section", b0, moved, 3,
        lambda lb, lc: {lb: M, lc: ("not", "no " + ", ".join(KEYS))})
    vac("V8-baseline-count-missing", sub_once(b0, r"declarations=\d+  ", "", *BASE_HEADER), c0, 3,
        lambda lb, lc: {lb: ("not", f"could not read the counts in {lb}: no declarations"), lc: M})
    vac("V9-baseline-absent", None, c0, 0,
        lambda lb, lc: {lc: M, lb.removesuffix("'s header"): ("not", "does not exist")})
    # The plant the defect hid, against the version before J32: the checks must go RED.
    vac("V2-against-pre-J32", b0, set_counts(c0, {"witnessed": w + 1}, *GATE), 0,
        lambda lb, lc: {lb: M, lc: ("stale", {f"witnessed {w + 1} → {w}"})}, script=before,
        red_because="CLAUDE.md § The gate): match")  # the defect itself: "match", naming a file never opened

    # A: the axiom digest.
    ax("A1-faithful", c0, 0, lambda lt: {lt: M})
    ax("A2-clean-stale", set_trust(c0, clean + 1, purchased), 0,
       lambda lt: {lt: ("stale", {f"{clean + 1} clean → {clean}"})})
    ax("A3-purchases-stale", set_trust(c0, clean, purchased + 1), 0,
       lambda lt: {lt: ("stale", {f"{purchased + 1} purchases → {purchased}"})})
    ax("A4-sentence-reworded", sub_once(c0, r"current audit reads", "current audit holds", *LEDGER), 3,
       lambda lt: {lt: ("not", f"could not read the counts in {lt}: 0 sentences")})
    outside = sub_once(c0, TRUST, "current audit is recorded elsewhere", *LEDGER)
    outside = sub_once(outside, r"(Managed by \*\*elan\*\*)",
                       f"The current audit reads {clean} clean and {purchased} declared purchases.\\n\\n\\1",
                       "\n## Toolchain\n", "\n### ")
    ax("A5-sentence-outside-section", outside, 3, lambda lt: {lt: ("not", "0 sentences")})
    doubled = sub_once(c0, r"(\| Entry \| Status \|)",
                       f"The current audit reads {clean} clean and {purchased} declared purchases.\\n\\n\\1", *LEDGER)
    ax("A6-sentence-doubled", doubled, 3, lambda lt: {lt: ("not", "2 sentences")})
    ax("A5-against-pre-J32", outside, 3, lambda lt: {lt: ("not", "0 sentences")}, script=before,
       red_because="recorded count (CLAUDE.md § Trust ledger): match")  # read from outside the section

    failed = 0
    for name, problems, red_because, code, lines in results:
        if red_because is not None:
            # RED, and for its own reason: the old version built a digest (exit 0, never usage or a crash) and
            # printed the false "match" the defect is — not merely some output these checks do not parse.
            hit = [l.strip() for l in lines if "recorded count" in l.lower()]
            if problems and code == 0 and any(red_because in l for l in hit):
                print(f"ok    {name}: RED on the defective version, for its own reason — {problems[0]}")
                print(f"        it printed: {hit}")
            else:
                failed += 1
                why = "PASSED" if not problems else f"went red for another reason (exit {code}, printed {hit})"
                print(f"FAIL  {name}: the checks {why} on the defective version — this control cannot see the defect")
        elif problems:
            failed += 1
            print(f"FAIL  {name}:")
            for p in problems:
                print(f"        {p}")
            print(f"        its output began: {[l for l in lines[:3]]}")
        else:
            hit = [l.strip() for l in lines if "recorded count" in l.lower() or l.startswith("==> gate report")]
            print(f"ok    {name}: {hit}")
    print(f"==> J32 controls: {len(results) - failed} of {len(results)} behaved" + (f"; {failed} DID NOT" if failed else ""))
    return 1 if failed else 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except PlantRefused as e:
        print(f"==> J32 controls: FAIL — a plant could not be applied, so nothing was tested: {e}")
        sys.exit(1)
