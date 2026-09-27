#!/usr/bin/env python3
"""FS-71 — the derivation files and LEDGER.md § B are two costumes of one census; this checks they agree.

The theorem entry (plans/<home>-derivation.md, one `**<id> — <title>. [<grade>; <prover>]**` paragraph per theorem, with
the fields *Proof:*, *Proof verdict:*, *Rests on it:*, *Prior art:*, *Kernel:*) is the home of the fact; the § B line is a
projection of it. Written independently by six batches they will drift, so this is the bridge: every entry id appears in
exactly one § B row, every § B row's id has an entry, and (with --strict) every entry carries all its fields.

    python3 tools/fs71_ledger_b_check.py            # report; exit 1 on an id mismatch
    python3 tools/fs71_ledger_b_check.py --strict   # also exit 1 on a missing field or a placeholder row
    python3 tools/fs71_ledger_b_check.py --self-test  # plant a mismatch and a missing field in memory; both must fire

Ids: `<PREFIX>-<name>` where PREFIX is the derivation file's stem before `-derivation` (FS70, FS38, M56, ASTRA-2026-09-14,
R57) and name is `T3`, `D2-A`, `W`, `L1`…; an entry written as a bare `**T3 — …**` inherits the file's prefix.

Header shapes that do not parse FAIL the run in every mode, naming the header and the shape (2026-09-27, job BK of the
consolidation run; FS-106 inventory item 83, FS-107 item 39). Before, each was a silent skip — the entry was simply not in
the census, and nothing failed unless its § B row happened to exist. A header is entry-shaped when its bold span (from the
line-opening `**` to the next `**`) holds ` — ` and ends in `]`; if the entry grammar does not match it, the reason is one of:
a parenthetical before the dash, a non-ASCII id, a space in the id, nested brackets in the grade, a title wrapped onto a
second line. And a header the grammar does match whose grade holds a `[` (a nested bracket, or an unclosed `[` in the title
that the grade swallowed, as FS110-YB4-WINDOW's half-open interval once was) fails too.
Standard library only.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FIELDS = ("*Proof:*", "*Proof verdict:*", "*Rests on it:*", "*Prior art:*", "*Kernel:*")
ENTRY_RE = re.compile(r"^\*\*(?P<id>[A-Za-z0-9][A-Za-z0-9-]*?)\s+—\s+(?P<title>.+?)\.?\s+\[(?P<grade>[^\]]*)\]\*\*", re.M)
ROW_RE = re.compile(r"^\|\s*(?P<id>[^|]+?)\s*\|\s*(?P<ms>[^|]+?)\s*\|(?P<rest>.*)\|\s*$")


def parse_entries(text: str, prefix: str) -> dict[str, dict]:
    """Return {full_id: {"grade": ..., "fields": {...}, "title": ...}} for one derivation file."""
    out: dict[str, dict] = {}
    matches = list(ENTRY_RE.finditer(text))
    for i, m in enumerate(matches):
        raw = m.group("id")
        full = raw if "-" in raw and not re.fullmatch(r"[A-Z]\d+", raw) else f"{prefix}-{raw}"
        # A bare id like `T3`, `W`, `L1`, `D2-A` inherits the prefix; a qualified one (`FS70-T3`) stands.
        if not raw.startswith(prefix) and "-" in raw and re.fullmatch(r"[A-Z]+\d*-[A-Z]", raw):
            full = f"{prefix}-{raw}"  # `D2-A`
        body = text[m.end(): matches[i + 1].start() if i + 1 < len(matches) else len(text)]
        body = body.split("\n## ")[0]  # an entry ends at the next section heading
        fields = {f: (f in body) for f in FIELDS}
        out[full] = {"grade": m.group("grade"), "title": m.group("title"), "fields": fields, "home": prefix}
    return out


def parse_ledger_b(text: str) -> tuple[dict[str, str], list[str]]:
    """Return ({id: milestone}, [placeholder rows]) from LEDGER.md § B."""
    if "## B." not in text:
        return {}, []
    section = text.split("## B.", 1)[1]
    rows: dict[str, str] = {}
    placeholders: list[str] = []
    for line in section.splitlines():
        m = ROW_RE.match(line)
        if not m:
            continue
        cid = m.group("id").strip("` ")
        if cid in ("id", "") or set(cid) <= {"-"}:
            continue
        if "," in cid or "…" in cid or " " in cid:
            placeholders.append(cid)
            continue
        if cid in rows:
            print(f"DUPLICATE § B row: {cid}")
            rows[cid] = rows[cid] + " (dup)"
        else:
            rows[cid] = m.group("ms").strip()
            cells = [c.strip() for c in m.group("rest").split("|")]
            if cells and len(cells[0]) > 300:
                print(f"warn: § B row {cid}: theorem column is {len(cells[0])} characters (aim under 250)")
    return rows, placeholders


def check(entries: dict[str, dict], rows: dict[str, str], placeholders: list[str], strict: bool) -> int:
    failures = 0
    only_files = sorted(set(entries) - set(rows))
    only_rows = sorted(set(rows) - set(entries))
    dups = [k for k, v in rows.items() if v.endswith("(dup)")]
    for k in only_files:
        print(f"FAIL: entry {k} has no LEDGER.md § B row")
    for k in only_rows:
        print(f"FAIL: LEDGER.md § B row {k} has no derivation entry")
    for k in dups:
        print(f"FAIL: LEDGER.md § B lists {k} twice")
    failures += len(only_files) + len(only_rows) + len(dups)
    missing = {k: [f for f, ok in v["fields"].items() if not ok] for k, v in entries.items()}
    missing = {k: v for k, v in missing.items() if v}
    for k, fs in sorted(missing.items()):
        tag = "FAIL" if strict else "warn"
        print(f"{tag}: entry {k} lacks {', '.join(fs)}")
    if strict:
        failures += len(missing)
    for p in placeholders:
        tag = "FAIL" if strict else "warn"
        print(f"{tag}: placeholder § B row still present: {p[:60]}")
    if strict:
        failures += len(placeholders)
    return failures


def census(entries: dict[str, dict]) -> None:
    by_prefix: dict[str, int] = {}
    for v in entries.values():
        by_prefix[v["home"]] = by_prefix.get(v["home"], 0) + 1
    print("census:", sum(by_prefix.values()), "theorems in", len(by_prefix), "derivation files:",
          ", ".join(f"{k}={v}" for k, v in sorted(by_prefix.items())))


NEAR_RE = re.compile(r"^\*\*(?P<id>[A-Za-z0-9][A-Za-z0-9-]*?)\s+—\s", re.M)
BOLD_RE = re.compile(r"^\*\*", re.M)
# A parsed grade holding a sentence end and then a bracket began inside the title (`R_y = [a, b)` … `. [hand; …]`); an
# unclosed `[` inside a true grade (FS91-J07-10's `[t, t + β)`) is legitimate and not matched.
SWALLOW_RE = re.compile(r"[.!?]\s+\[")
# The corpus marks a deliberate non-entry in its header ("NOT given a fresh id", M53; "not given a T-id", M54).
DECLINED_RE = re.compile(r"\bnot given (?:a|separate)\b", re.I)


def declared_non_entries(text: str) -> list[str]:
    """Entry-shaped headers that declare themselves non-entries; listed on every run, never skipped in silence."""
    out = []
    for b in BOLD_RE.finditer(text):
        close = text.find("**", b.end())
        span = text[b.end(): close] if close != -1 else ""
        if " — " in span and span.rstrip().endswith("]") and DECLINED_RE.search(span):
            out.append(text[b.start(): text.find("\n", b.start())])
    return out


def _grade_open(span: str) -> int:
    """Index of the `[` that balances the `]` ending `span` (the grade's opening bracket), or -1 if unbalanced."""
    depth = 0
    for i in range(len(span) - 1, -1, -1):
        if span[i] == "]":
            depth += 1
        elif span[i] == "[":
            depth -= 1
            if depth == 0:
                return i
    return -1


def header_problems(text: str) -> list[tuple[str, str]]:
    """Every entry-shaped header the entry grammar rejects or mis-reads, as (header's first line, reason).

    Entry-shaped: a line-opening bold span holding ` — ` and ending in `]`. Each shape below was a silent skip before
    2026-09-27 — the entry vanished from the census and nothing failed unless its § B row happened to exist."""
    out: list[tuple[str, str]] = []
    parsed = {m.start(): m for m in ENTRY_RE.finditer(text)}
    for b in BOLD_RE.finditer(text):
        close = text.find("**", b.end())
        if close == -1:
            continue
        span = text[b.end(): close]
        if " — " not in span or not span.rstrip().endswith("]"):
            continue
        line = text[b.start(): text.find("\n", b.start()) if "\n" in text[b.start():] else len(text)]
        if DECLINED_RE.search(span):
            continue  # a declared non-entry ("NOT given a fresh id"), counted by `declared_non_entries`
        m = parsed.get(b.start())
        if m is not None:
            if SWALLOW_RE.search(m.group("grade")):
                out.append((line, "an unclosed `[` in the title was read as the grade's opening (write the interval in words)"))
            continue
        head = span.split(" — ", 1)[0]
        g = _grade_open(span.rstrip())
        grade = span.rstrip()[g + 1: -1] if g != -1 else ""
        if "(" in head:
            why = "a parenthetical before the dash (the id must stand alone before ` — `)"
        elif not head.isascii():
            why = "a non-ASCII id (ids are `[A-Za-z0-9-]` only)"
        elif any(c.isspace() for c in head.strip()):
            why = "a space in the id"
        elif g == -1 or "[" in grade or "]" in grade:
            why = "nested brackets in the grade (use parentheses inside a grade)"
        elif "\n" in span:
            why = "the header wraps onto a second line (a header is one line)"
        else:
            why = "the entry grammar rejects it (unclassified shape)"
        out.append((line, why))
    return out


def near_misses(text: str, parsed: dict[str, dict], prefix: str, fname: str) -> int:
    """Report every header the entry grammar skipped or mis-read; return how many (each one FAILS the run).

    Two detectors: `header_problems` (entry-shaped headers, classified by shape) and NEAR_RE (an ASCII id and a dash with
    no grade bracket closing the bold span — batch 4a lost five entries to a wrapped title and a `]` in a grade)."""
    n = 0
    flagged: set[str] = set()
    for line, why in header_problems(text):
        print(f"FAIL: {fname}: header skipped or mis-read — {why}: {line[:100]}")
        flagged.add(line)
        n += 1
    for line in declared_non_entries(text):
        print(f"note: {fname}: declared non-entry (header says 'not given … id'), not counted: {line[:100]}")
    seen = {k.split("-", 1)[1] if k.startswith(prefix + "-") else k for k in parsed}
    for m in NEAR_RE.finditer(text):
        raw = m.group("id")
        if raw in seen or raw in parsed or f"{prefix}-{raw}" in parsed:
            continue
        line = text[m.start(): text.find("\n", m.start())]
        if line in flagged:
            continue
        print(f"FAIL: {fname}: header starts like an entry but did not parse (no `[grade]**` closing it?): {line[:100]}")
        n += 1
    return n


def load() -> tuple[dict[str, dict], dict[str, str], list[str], int]:
    """Entries, § B rows, placeholders, and the count of header failures (malformed headers, ids defined twice)."""
    entries: dict[str, dict] = {}
    header_fails = 0
    for f in sorted((ROOT / "plans").glob("*-derivation.md")):
        prefix = f.name[: -len("-derivation.md")]
        text = f.read_text(encoding="utf-8")
        e = parse_entries(text, prefix)
        header_fails += near_misses(text, e, prefix, f.name)
        for k in e:
            if k in entries:
                print(f"FAIL: id {k} defined in two files")
                header_fails += 1
        entries.update(e)
    rows, placeholders = parse_ledger_b((ROOT / "LEDGER.md").read_text(encoding="utf-8"))
    return entries, rows, placeholders, header_fails


def self_test() -> int:
    entries, rows, placeholders, _ = load()
    if not entries or not rows:
        print("self-test: nothing to plant on"); return 1
    # The header shapes that were silent skips, each planted beside a faithful header that must parse clean; then two
    # headers that must NOT fire (a legitimate unclosed `[` inside a grade, a declared non-entry).
    good = "**FS99-T2 — A faithful header. [hand; one mind: X]**\n*Proof:* p. *Proof verdict:* v. *Rests on it:* r. *Prior art:* a. *Kernel:* k.\n"
    shapes = {
        "nested brackets": "**FS99-T3 — Planted. [hand; over Parts [external]]**\n",
        "non-ASCII": "**FS99-TÉ4 — Planted. [hand; one mind: X]**\n",
        "parenthetical": "**FS99-T5 (the planted one) — Planted. [hand; one mind: X]**\n",
        "a `[` in the title": "**FS99-T6 — Planted on `R = [a, b)` here. [hand; one mind: X]**\n",
    }
    legit = "**FS99-T7 — Faithful. [hand; averaging `I_t = λ^{−1}[t, t + β)` over t]**\n"
    declared = "**Proposition 9.9 (planted), original — NOT given a fresh id. [hand; one mind: X]**\n"
    quiet = header_problems(good + legit + declared) == [] and len(declared_non_entries(declared)) == 1
    print(f"self-test: an unclosed `[` inside a true grade and a declared non-entry read clean: {quiet}")
    shape_ok = header_problems(good) == []
    print(f"self-test: a faithful header reads clean: {shape_ok}")
    shape_ok = shape_ok and quiet
    for name, plant in shapes.items():
        probs = header_problems(good + plant)
        fired = len(probs) == 1 and probs[0][0] == plant.rstrip("\n")
        print(f"self-test: plant '{name}' fires naming its header: {fired} ({probs[0][1] if probs else 'nothing'})")
        shape_ok = shape_ok and fired
    # Plant 1: an entry with no row.  Plant 2: a row with no entry.  Plant 3: a missing field (strict).
    e2 = dict(entries); e2["FS99-T1"] = {"grade": "hand", "title": "planted", "fields": {f: True for f in FIELDS}, "home": "FS99"}
    r2 = dict(rows); r2["FS98-T7"] = "FS-98"
    k0 = next(iter(entries))
    e2[k0] = {**entries[k0], "fields": {**entries[k0]["fields"], "*Kernel:*": False}}
    n = check(e2, r2, [], strict=True)
    expect = 3 + sum(1 for k, v in e2.items() if k != k0 and any(not ok for ok in v["fields"].values()))
    ok_fire = n >= 3
    clean = check(entries, rows, placeholders, strict=False) == 0
    print(f"self-test: planted 3 faults, {n} failures reported (expected ≥ 3); unplanted id check {'clean' if clean else 'NOT clean'}")
    return 0 if ok_fire and shape_ok else 1


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--strict", action="store_true")
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    entries, rows, placeholders, header_fails = load()
    n = check(entries, rows, placeholders, a.strict) + header_fails
    census(entries)
    print("LEDGER § B rows:", len(rows), "| placeholders:", len(placeholders))
    print("RESULT:", "PASS" if n == 0 else f"FAIL ({n})")
    return 0 if n == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
