#!/usr/bin/env python3
"""The digest a gate prints from its own saved output, so reading a result never means running the gate again.

`scripts/vacuity.sh` and `scripts/axioms.sh` save their Lean tool's complete output (`scripts/gate-log.sh`)
and call this to print, from that file and the previous complete run's file:

* every count the tool computed, including the ones the gate does not decide on;
* whether those counts still match the ones the repository records (the vacuity baseline's header,
  `CLAUDE.md` § Trust ledger) — a drifted record is flagged here, never failed;
* every row that changed since the previous complete run, which answers "which declarations are the new
  ones?" without a second scan.

It decides nothing: pass and fail stay in the shell scripts. It does refuse, loudly and with exit status 2,
output that is not the shape it reads — a per-site listing that disagrees with the scan's own totals, a
missing accounting line — because a digest that silently printed less than the run computed would be the
failure this file exists to remove.

    gate_report.py vacuity <this run's log> <previous run's log, or ''> <baseline file>
    gate_report.py axioms  <this run's log> <previous run's log, or ''> <CLAUDE.md>
"""
from __future__ import annotations

import re
import sys
from collections import Counter
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
VERDICTS = ("vacuous", "stale", "declared", "witnessed", "generic", "unknown")
WARNING = re.compile(r"^\S+:\d+:\d+: (warning|error): ")


class Malformed(Exception):
    """The tool's output does not have the shape this digest reads."""


def say(line: str = "") -> None:
    print(f"    {line}" if line else "")


def rel(path) -> str:
    try:
        return str(Path(path).resolve().relative_to(REPO))
    except ValueError:
        return str(path)


def lines_of(path) -> list[str]:
    return Path(path).read_text(encoding="utf-8", errors="replace").splitlines()


# ---- vacuity: scripts/Vacuity.lean's report -----------------------------------------------------------

def read_vacuity(path) -> dict:
    run = {"scanned": None, "totals": None, "evidence_line": None, "sites": [], "evidence": [], "warnings": []}
    for line in lines_of(path):
        if line.startswith("=== SCANNED === "):
            run["scanned"] = {k: int(v) for k, v in re.findall(r"([\w-]+)=(\d+)", line)}
        elif line.startswith("=== TOTALS === "):
            run["totals"] = {k: int(v) for k, v in re.findall(r"([\w-]+)=(\d+)", line)}
        elif line.startswith("SITE "):
            run["sites"].append(line)
        elif line.startswith("EVIDENCE "):
            run["evidence"].append(line)
        elif line.startswith("evidence: "):
            run["evidence_line"] = line
        elif WARNING.match(line):
            run["warnings"].append(line)
    return run


def counts_of(run: dict) -> dict:
    return {**(run["scanned"] or {}), **(run["totals"] or {})}


def recorded_vacuity(baseline):
    if not Path(baseline).is_file():
        return None
    header = "\n".join(line for line in lines_of(baseline) if line.startswith("#"))
    keys = "declarations|refutations-skipped|sites|" + "|".join(VERDICTS)
    return {k: int(v) for k, v in re.findall(rf"(?<![\w-])({keys})=(\d+)", header)}


def vacuity(cur_path: str, prev_path: str, baseline: str) -> None:
    run = read_vacuity(cur_path)
    if run["scanned"] is None or run["totals"] is None:
        raise Malformed("no '=== SCANNED ===' or '=== TOTALS ===' line: the scan did not report its accounting")
    now = counts_of(run)
    per = Counter(line.split(" ", 2)[1].lower() for line in run["sites"])
    if len(run["sites"]) != now.get("sites") or any(per[v] != now.get(v) for v in VERDICTS):
        raise Malformed(f"{len(run['sites'])} SITE rows, by verdict {dict(per)}, disagree with the scan's "
                        f"totals {run['totals']}")
    kinds = Counter(line.split(" ", 2)[1] for line in run["evidence"])
    m = re.match(r"evidence: (\d+) emptiness proof\(s\), (\d+) colourability witness\(es\)", run["evidence_line"] or "")
    if not m or (int(m.group(1)), int(m.group(2))) != (kinds["EMPTY"], kinds["WITNESS"]):
        raise Malformed(f"EVIDENCE rows {dict(kinds)} disagree with the scan's line {run['evidence_line']!r}")

    say("scanned: " + "  ".join(f"{k}={now[k]}" for k in ("declarations", "refutations-skipped")))
    say("sites:   " + "  ".join(f"{k}={now[k]}" for k in ("sites", *VERDICTS)))
    say(f"evidence: {kinds['EMPTY']} emptiness proof(s), {kinds['WITNESS']} witness(es)")
    if run["warnings"]:
        say(f"the scan printed {len(run['warnings'])} warning(s) of its own (full text in the log):")
        for w in run["warnings"]:
            say(f"  {w}")

    recorded = recorded_vacuity(baseline)
    if recorded is None:
        say(f"recorded counts: {rel(baseline)} does not exist")
    elif not recorded:
        say(f"recorded counts: none found in {rel(baseline)}'s header")
    else:
        drift = [f"{k} {recorded[k]} → {now[k]}" for k in recorded if now.get(k) != recorded[k]]
        if drift:
            say(f"RECORDED COUNTS ARE STALE — update {rel(baseline)}'s header and CLAUDE.md § The gate: "
                + ", ".join(drift))
        else:
            say(f"recorded counts ({rel(baseline)}'s header, CLAUDE.md § The gate): match")

    witnessed = sorted(line[len("SITE "):] for line in run["sites"] if line.startswith("SITE WITNESSED "))
    say(f"--- witnessed ({len(witnessed)}), with the evidence behind each ---")
    for line in witnessed:
        say(line)

    say("--- changes since the previous complete run ---")
    if not prev_path:
        say("no previous complete run on record; the next run is compared with this one")
    else:
        prev = read_vacuity(prev_path)
        say(f"previous: {rel(prev_path)}")
        before = counts_of(prev)
        moved = [f"{k} {before[k]} → {now[k]}" for k in now if k in before and before[k] != now[k]]
        say("counts: " + (", ".join(moved) if moved else "unchanged"))
        if not prev["sites"]:
            say("rows: the previous run predates per-site rows, so only its counts compare")
        else:
            a, b = Counter(prev["sites"] + prev["evidence"]), Counter(run["sites"] + run["evidence"])
            added, removed = sorted((b - a).elements()), sorted((a - b).elements())
            for line in added:
                say(f"+ {line}")
            for line in removed:
                say(f"- {line}")
            if not added and not removed:
                say("rows: none changed")
    say(f"every site and piece of evidence: rg '^(SITE|EVIDENCE) ' {rel(cur_path)}")


# ---- axioms: scripts/Axioms.lean's `#print axioms` receipt --------------------------------------------

RECORD = re.compile(r"^'(.+?)' (?:depends on axioms: \[(.*)\]|(does not depend on any axioms))$")


def read_axioms(path) -> tuple[list, list]:
    """`(section, declaration, axioms)` per record — `#print axioms` wraps a long list across lines."""
    records, warnings, section, buf = [], [], None, None

    def finish(raw: str) -> None:
        m = RECORD.match(re.sub(r"\s+", " ", raw).strip())
        if not m:
            raise Malformed(f"unreadable record: {raw[:160]!r}")
        axioms = () if m.group(3) else tuple(a.strip() for a in m.group(2).split(","))
        records.append((section, m.group(1), axioms))

    for line in lines_of(path):
        if buf is not None:
            buf += " " + line
            if "]" in line:
                finish(buf)
                buf = None
        elif re.fullmatch(r"=== [A-Z]+ ===", line):
            section = line.strip("= ")
        elif line.startswith("'") and " depends on axioms: [" in line:
            if "]" in line:
                finish(line)
            else:
                buf = line
        elif line.startswith("'") and line.endswith(" does not depend on any axioms"):
            finish(line)
        elif WARNING.match(line):
            warnings.append(line)
    if buf is not None:
        raise Malformed("the output ends inside a record")
    return records, warnings


def axiom_set(axioms: tuple) -> str:
    if not axioms:
        return "(no axioms)"
    native = [a for a in axioms if "._native." in a or "ofReduceBool" in a]
    rest = [a for a in axioms if a not in native]
    return "[" + ", ".join(([f"{len(native)} native"] if native else []) + rest) + "]"


def axioms(cur_path: str, prev_path: str, claude: str) -> None:
    records, warnings = read_axioms(cur_path)
    clean = [r for r in records if r[0] == "CLEAN"]
    purchased = [r for r in records if r[0] == "PURCHASED"]
    if not clean:
        raise Malformed("no records under '=== CLEAN ==='")
    with_axioms = [r for r in clean if r[2]]
    free = sorted(r[1] for r in clean if not r[2])
    say(f"audited: {len(records)} records — {len(with_axioms)} clean on the standard axioms, "
        f"{len(free)} axiom-free, {len(purchased)} declared purchase(s)")
    say("clean records, by axiom set:")
    for axs, n in sorted(Counter(r[2] for r in with_axioms).items(), key=lambda kv: (-kv[1], kv[0])):
        say(f"  {n:5d}  {axiom_set(axs)}")
    say(f"  {len(free):5d}  (no axioms): {', '.join(free)}")
    say("declared purchases:")
    for _, name, axs in purchased:
        say(f"  {name}  {axiom_set(axs)}")
    stray = [r for r in records if r[0] not in ("CLEAN", "PURCHASED")]
    if stray:
        say(f"records outside both banners: {len(stray)}: {', '.join(r[1] for r in stray)}")
    twice = sorted(n for n, c in Counter(r[1] for r in records).items() if c > 1)
    if twice:
        say(f"audited more than once: {', '.join(twice)}")
    if warnings:
        say(f"the audit printed {len(warnings)} warning(s) (full text in the log):")
        for w in warnings:
            say(f"  {w}")

    flat = re.sub(r"\s+", " ", Path(claude).read_text(encoding="utf-8"))
    m = re.search(r"current audit reads (\d+) clean and (\d+) declared purchases", flat)
    if not m:
        say("recorded count: not found in CLAUDE.md § Trust ledger "
            "(it reads 'current audit reads N clean and M declared purchases')")
    elif (int(m.group(1)), int(m.group(2))) != (len(with_axioms), len(purchased)):
        pairs = ((int(m.group(1)), len(with_axioms), "clean"), (int(m.group(2)), len(purchased), "purchases"))
        say("RECORDED COUNT IS STALE — update CLAUDE.md § Trust ledger: "
            + ", ".join(f"{was} {label} → {now}" for was, now, label in pairs if was != now))
    else:
        say("recorded count (CLAUDE.md § Trust ledger): match")

    say("--- changes since the previous complete run ---")
    if not prev_path:
        say("no previous complete run on record; the next run is compared with this one")
        return
    say(f"previous: {rel(prev_path)}")
    try:
        before_records, _ = read_axioms(prev_path)
    except Malformed as e:
        say(f"the previous run's output could not be read ({e}); nothing to compare")
        return
    before = {r[1]: (r[0], r[2]) for r in before_records}
    after = {r[1]: (r[0], r[2]) for r in records}

    def show(v):
        return f"{v[0]} {axiom_set(v[1])}"

    rows = ([f"+ {n}  {show(after[n])}" for n in sorted(after.keys() - before.keys())]
            + [f"- {n}  {show(before[n])}" for n in sorted(before.keys() - after.keys())]
            + [f"~ {n}  {show(before[n])} → {show(after[n])}"
               for n in sorted(after.keys() & before.keys()) if after[n] != before[n]])
    for row in rows:
        say(row)
    if not rows:
        say("no record appeared, disappeared or changed its axioms")


def main(argv: list[str]) -> int:
    if len(argv) != 5 or argv[1] not in ("vacuity", "axioms"):
        print(__doc__)
        return 2
    try:
        (vacuity if argv[1] == "vacuity" else axioms)(argv[2], argv[3], argv[4])
    except Malformed as e:
        print(f"==> gate report: the output is not the shape this digest reads — {e}")
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
