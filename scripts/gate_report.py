#!/usr/bin/env python3
"""The digest a gate prints from its own saved output, so reading a result never means running the gate again.

`scripts/vacuity.sh` and `scripts/axioms.sh` save their Lean tool's complete output (`scripts/gate-log.sh`)
and call this to print, from that file and the previous complete run's file:

* every count the tool computed, including the ones the gate does not decide on;
* whether those counts still match the ones the repository records, **one line per recorded source, and
  a source is named on a "match" line only if it was read and every count it records was compared**:
  the vacuity scan's nine counts against the baseline's header AND against `CLAUDE.md` § The gate; the
  axiom audit's two against `CLAUDE.md` § Trust ledger. A drifted record is flagged here, never failed;
* every row that changed since the previous complete run, which answers "which declarations are the new
  ones?" without a second scan.

It decides nothing about the scan: pass and fail stay in the shell scripts. It refuses, loudly, in two
cases, because each is a check that could not run:

* exit 2 — the tool's output is not the shape it reads (a per-site listing that disagrees with the scan's
  own totals, a missing accounting line): a digest that silently printed less than the run computed would
  be the failure this file exists to remove;
* exit 3 — a recorded source it compares against could not be read (its section is missing or doubled, a
  count is missing or recorded twice). Until 2026-09-25 the vacuity digest printed "match" naming
  `CLAUDE.md` § The gate, a file it never opened, while that section was four counts stale (J23bd, J32): a
  comparison that could not run must never read as one that passed. The digest is printed in full first.

A baseline that does not exist is reported and not failed here: `scripts/vacuity.sh` fails on a missing
baseline itself, except when creating one with `--baseline`.

    gate_report.py vacuity <this run's log> <previous run's log, or ''> <baseline file> <CLAUDE.md>
    gate_report.py axioms  <this run's log> <previous run's log, or ''> <CLAUDE.md>
"""
from __future__ import annotations

import re
import sys
from collections import Counter
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
VERDICTS = ("vacuous", "stale", "declared", "witnessed", "generic", "unknown")
COUNTS = ("declarations", "refutations-skipped", "sites", *VERDICTS)  # every count a vacuity record holds
WARNING = re.compile(r"^\S+:\d+:\d+: (warning|error): ")


class Malformed(Exception):
    """The tool's output does not have the shape this digest reads."""


class Unreadable(Exception):
    """A recorded source this digest compares against could not be read, so the comparison did not run."""


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


def claude_label(claude, section: str) -> str:
    """`CLAUDE.md § <section>`, naming the file actually read whenever it is not the repository's own."""
    label = f"CLAUDE.md § {section}"
    return label if Path(claude).resolve() == REPO / "CLAUDE.md" else f"{label} (read from {rel(claude)})"


def section_text(path, heading: str, label: str) -> str:
    """The body of the one `## <heading>` section: up to the next heading of level 1–3 outside a code fence."""
    if not Path(path).is_file():
        raise Unreadable(f"could not read the counts in {label}: {rel(path)} does not exist")
    lines, fenced, starts = lines_of(path), False, []
    for i, line in enumerate(lines):
        if line.lstrip().startswith("```"):
            fenced = not fenced
        elif not fenced and line.rstrip() == f"## {heading}":
            starts.append(i)
    if len(starts) != 1:
        raise Unreadable(f"could not read the counts in {label}: {len(starts)} '## {heading}' headings, not one")
    body, fenced = [], False
    for line in lines[starts[0] + 1:]:
        if line.lstrip().startswith("```"):
            fenced = not fenced
        elif not fenced and re.match(r"#{1,3} ", line):
            break
        body.append(line)
    return "\n".join(body)


def vacuity_counts(text: str, label: str) -> dict:
    """All nine vacuity counts in `text`, each recorded exactly once — or `Unreadable`, never a partial dict.

    A partial record would compare only the counts it holds and report "match" on the rest unread."""
    found = re.findall(rf"(?<![\w-])({'|'.join(COUNTS)})=(\d+)", text)
    seen = Counter(k for k, _ in found)
    missing = [k for k in COUNTS if k not in seen]
    doubled = sorted(k for k, n in seen.items() if n > 1)
    if missing or doubled:
        raise Unreadable(f"could not read the counts in {label}: "
                         + "; ".join(([f"no {', '.join(missing)}"] if missing else [])
                                     + ([f"{', '.join(doubled)} recorded more than once"] if doubled else [])))
    return {k: int(v) for k, v in found}


def recorded_in_baseline(baseline) -> dict | None:
    """The baseline header's nine counts; `None` if there is no baseline (the shell gate fails on that itself)."""
    if not Path(baseline).is_file():
        return None
    header = "\n".join(line for line in lines_of(baseline) if line.startswith("#"))
    return vacuity_counts(header, f"{rel(baseline)}'s header")


def recorded_in_claude_gate(claude) -> dict:
    """The nine counts `CLAUDE.md` § The gate records ("`declarations=… refutations-skipped=… sites=…`, …")."""
    label = claude_label(claude, "The gate")
    return vacuity_counts(section_text(claude, "The gate", label), label)


TRUST = re.compile(r"current audit reads (\d+) clean and (\d+) declared purchases")


def recorded_in_trust_ledger(claude) -> tuple[int, int]:
    """(clean, purchases) from the one sentence of `CLAUDE.md` § Trust ledger that records the axiom audit."""
    label = claude_label(claude, "Trust ledger")
    found = TRUST.findall(re.sub(r"\s+", " ", section_text(claude, "Trust ledger", label)))
    if len(found) != 1:
        raise Unreadable(f"could not read the counts in {label}: {len(found)} sentences reading "
                         "'current audit reads N clean and M declared purchases', not one")
    return int(found[0][0]), int(found[0][1])


def compare(label: str, recorded: dict, now: dict) -> None:
    """One line for one recorded source: every count it records against this run's."""
    drift = [f"{k} {recorded[k]} → {now.get(k)}" for k in recorded if now.get(k) != recorded[k]]
    if drift:
        say(f"RECORDED COUNTS ARE STALE in {label} — update it: " + ", ".join(drift))
    else:
        say(f"recorded counts in {label}: match ({len(recorded)} of {len(recorded)} compared)")


def vacuity(cur_path: str, prev_path: str, baseline: str, claude: str) -> list[str]:
    run = read_vacuity(cur_path)
    if run["scanned"] is None or run["totals"] is None:
        raise Malformed("no '=== SCANNED ===' or '=== TOTALS ===' line: the scan did not report its accounting")
    now = counts_of(run)
    if any(k not in now for k in ("declarations", "refutations-skipped")):
        raise Malformed(f"the '=== SCANNED ===' line {run['scanned']} lacks declarations or refutations-skipped")
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

    unreadable = []
    for label, read in ((f"{rel(baseline)}'s header", lambda: recorded_in_baseline(baseline)),
                        (claude_label(claude, "The gate"), lambda: recorded_in_claude_gate(claude))):
        try:
            recorded = read()
        except Unreadable as e:
            say(f"RECORDED COUNTS NOT COMPARED — {e}")
            unreadable.append(str(e))
            continue
        if recorded is None:
            say(f"RECORDED COUNTS NOT COMPARED — {rel(baseline)} does not exist (scripts/vacuity.sh fails on that)")
        else:
            compare(label, recorded, now)

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
    return unreadable


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


def axioms(cur_path: str, prev_path: str, claude: str) -> list[str]:
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

    unreadable, label = [], claude_label(claude, "Trust ledger")
    try:
        was_clean, was_purchased = recorded_in_trust_ledger(claude)
    except Unreadable as e:
        say(f"RECORDED COUNT NOT COMPARED — {e}")
        unreadable.append(str(e))
    else:
        pairs = ((was_clean, len(with_axioms), "clean"), (was_purchased, len(purchased), "purchases"))
        drift = [f"{was} {what} → {now}" for was, now, what in pairs if was != now]
        if drift:
            say(f"RECORDED COUNT IS STALE in {label} — update it: " + ", ".join(drift))
        else:
            say(f"recorded count in {label}: match (clean and purchases compared)")

    say("--- changes since the previous complete run ---")
    if not prev_path:
        say("no previous complete run on record; the next run is compared with this one")
        return unreadable
    say(f"previous: {rel(prev_path)}")
    try:
        before_records, _ = read_axioms(prev_path)
    except Malformed as e:
        say(f"the previous run's output could not be read ({e}); nothing to compare")
        return unreadable
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
    return unreadable


def main(argv: list[str]) -> int:
    arity = {"vacuity": 6, "axioms": 5}
    if len(argv) < 2 or argv[1] not in arity or len(argv) != arity[argv[1]]:
        print(__doc__)
        return 2
    try:
        unreadable = (vacuity if argv[1] == "vacuity" else axioms)(*argv[2:])
    except Malformed as e:
        print(f"==> gate report: the output is not the shape this digest reads — {e}")
        return 2
    if unreadable:
        print("==> gate report: FAIL — a recorded source could not be read, so its comparison did not run "
              "(the scan's own output is fine; the digest above is complete):")
        for e in unreadable:
            print(f"    {e}")
        return 3
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
