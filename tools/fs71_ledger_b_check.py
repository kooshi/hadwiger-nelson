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
The new grammar (2026-09-28, job TB1). From 2026-09-28 a close writes its derivation file in the Ephodos entry grammar
(`.claude/skills/ephodos/SKILL.md` <the_entry>; `.claude/agents/ephodos.md` § The close job): a line `derivation: <name>` at column
0, then indented `field: value` lines, the block ending at a blank line. Each such block is one entry, read with the gate's own parser
(`.claude/skills/ephodos/scripts/derive_gate.py`: `HEAD`, `blocks`, `strip_fences`, imported, never re-implemented, so the census
reads exactly what the gate reads; if the gate cannot be imported the run fails, it never falls back to the older grammar alone).
`control:`, `verification:` and `invention:` blocks are not entries; a `derivation:` header inside a code fence is not one either
(noted, as the gate warns). The grammar is told per entry, not per file, so a file may hold both; an id defined twice, in either
grammar or across them, fails. The id rule is the older one, unchanged: a name containing a hyphen stands as written, a bare one
inherits the prefix — so `derivation: N7-3T` in FS114-derivation.md is `N7-3T`, and a § B row `FS114-N7-3T` fails beside it with a
hint; write the header qualified. Under --strict a new-grammar entry must carry what the gate makes mandatory — `statement:`,
`argument:`, `verdict:` always; with verdict `derived` also `uses only:`, `not claimed:`, `grade:`, `minds:`, `model:`,
`prior art:`, `handoff:`, and `converse:` when the statement is strictly two-way — present and non-empty (the gate lints the
values). The older five map as: *Proof:* → `argument:`; *Proof verdict:* → `verdict:` (with `minds:`); *Prior art:* →
`prior art:`; *Kernel:* → `handoff:`; *Rests on it:* has no field, and the lane file asks for it "in prose" under each entry, so
--strict looks for the words "rests on" in the prose between the entry's block and the next `derivation:` header or heading. An
indented `rests on it:` line inside the block is not prose: the gate folds a line with an unknown key into the field above it,
silently, so it is named as the defect it is.

Standard library only.
"""
from __future__ import annotations

import argparse
import contextlib
import importlib.util
import io
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FIELDS = ("*Proof:*", "*Proof verdict:*", "*Rests on it:*", "*Prior art:*", "*Kernel:*")
ENTRY_RE = re.compile(r"^\*\*(?P<id>[A-Za-z0-9][A-Za-z0-9-]*?)\s+—\s+(?P<title>.+?)\.?\s+\[(?P<grade>[^\]]*)\]\*\*", re.M)
ROW_RE = re.compile(r"^\|\s*(?P<id>[^|]+?)\s*\|\s*(?P<ms>[^|]+?)\s*\|(?P<rest>.*)\|\s*$")


def full_id(raw: str, prefix: str) -> str:
    """The id rule, one for both grammars: a bare id like `T3`, `W`, `L1`, `D2-A` inherits the prefix; a qualified one
    (`FS70-T3`) stands — and so does any other name containing a hyphen (M2's `J17-T1` is counted and keyed as written)."""
    full = raw if "-" in raw and not re.fullmatch(r"[A-Z]\d+", raw) else f"{prefix}-{raw}"
    if not raw.startswith(prefix) and "-" in raw and re.fullmatch(r"[A-Z]+\d*-[A-Z]", raw):
        full = f"{prefix}-{raw}"  # `D2-A`
    return full


def parse_entries(text: str, prefix: str) -> dict[str, dict]:
    """Return {full_id: {"grade": ..., "fields": {...}, "title": ...}} for one derivation file (the older grammar)."""
    out: dict[str, dict] = {}
    matches = list(ENTRY_RE.finditer(text))
    for i, m in enumerate(matches):
        raw = m.group("id")
        full = full_id(raw, prefix)
        body = text[m.end(): matches[i + 1].start() if i + 1 < len(matches) else len(text)]
        body = body.split("\n## ")[0]  # an entry ends at the next section heading
        fields = {f: (f in body) for f in FIELDS}
        if full in out:
            out[full]["dup"] = True  # reported by `read_file`; a dict would otherwise keep one of the two in silence
        out[full] = {"grade": m.group("grade"), "title": m.group("title"), "fields": fields, "home": prefix,
                     "grammar": "old", "dup": out.get(full, {}).get("dup", False)}
    return out


GATE_PATH = ROOT / ".claude" / "skills" / "ephodos" / "scripts" / "derive_gate.py"
_GATE = None


def gate():
    """The Ephodos gate as a module: the new grammar is read with its parser, never a copy of it. Fails the run if missing."""
    global _GATE
    if _GATE is None:
        spec = importlib.util.spec_from_file_location("derive_gate", GATE_PATH)
        if not GATE_PATH.exists() or spec is None or spec.loader is None:
            print(f"FAIL: cannot import the Ephodos gate at {GATE_PATH.relative_to(ROOT)} — the new grammar cannot be read")
            print("RESULT: FAIL (the census would miss every new-grammar entry)")
            sys.exit(2)
        mod = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(mod)
        _GATE = mod
    return _GATE


NEW_ALWAYS = ("statement", "argument", "verdict")
NEW_DERIVED = ("uses only", "not claimed", "grade", "minds", "model", "prior art", "handoff")
RESTS_RE = re.compile(r"\brests\s+on\b", re.I)
RESTS = "prose under the block naming what rests on it"
MD_HEADING = re.compile(r"^#{1,6}\s")


def parse_new_entries(text: str, prefix: str, fname: str) -> tuple[dict[str, dict], list[str], int]:
    """Entries in the new grammar: ({full_id: entry}, notes, failures), the failures printed here.

    Each `derivation:` block the gate reads is an entry; its `fields` map each field the gate makes mandatory for it to
    whether it is present and non-empty, plus RESTS (the lane file's prose). Failures: a header the gate cannot read
    (`unread_heads`), a name defined twice in this grammar."""
    g = gate()
    lines, fenced = g.strip_fences(text)
    out: dict[str, dict] = {}
    notes: list[str] = []
    fails = 0
    for ln, line in g.unread_heads(lines):
        print(f"FAIL: {fname}:{ln}: header opens a block the gate cannot read (write `derivation:` in lower case at column 0, "
              f"then one token): {line[:100]}")
        fails += 1
    for ln, line in fenced:
        if (fm := g.HEAD_LOOSE.match(line)) and fm.group(1) == "derivation":
            notes.append(f"note: {fname}:{ln}: a `derivation:` header inside a code fence is not an entry, not counted: {line.strip()[:80]}")
    other: dict[str, int] = {}
    stops = [i for i, x in enumerate(lines) if MD_HEADING.match(x) or ((m := g.HEAD.match(x)) and m.group(1) == "derivation")]
    for b in g.blocks(lines, fname):
        if b["kind"] != "derivation":
            if b["kind"] != "control":
                other[b["kind"]] = other.get(b["kind"], 0) + 1
            continue
        h = b["line"] - 1
        end = h + 1
        while end < len(lines) and lines[end].strip() and lines[end][0] in " \t":
            end += 1
        stop = next((i for i in stops if i > h), len(lines))
        inside = any(RESTS_RE.search(x) for x in lines[h + 1: end])
        prose = any(RESTS_RE.search(x) for x in lines[end: stop])
        f = b["fields"]
        derived = f.get("verdict", "").strip().lower() == "derived"
        need = list(NEW_ALWAYS) + (list(NEW_DERIVED) if derived else [])
        if derived and g.STRICT.search(f.get("statement", "")):
            need.append("converse")
        fields = {f"{k}:": bool(f.get(k, "").strip()) for k in need}
        rests = RESTS if not inside else RESTS + " (an indented `rests on` line sits inside the block, where the gate folds it into the field above it)"
        fields[rests] = prose
        full = full_id(b["name"], prefix)
        if full in out:
            print(f"FAIL: {fname}:{b['line']}: id {full} defined twice in the new grammar")
            fails += 1
        out[full] = {"grade": f.get("grade", ""), "title": f.get("statement", "")[:80], "fields": fields, "home": prefix,
                     "grammar": "new", "dup": False}
    if other:
        notes.append(f"note: {fname}: " + ", ".join(f"{v} `{k}:` block{'s' if v != 1 else ''}" for k, v in sorted(other.items()))
                     + " — not entries, not counted")
    return out, notes, fails


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
    for k in only_files:
        home = entries[k]["home"]
        if f"{home}-{k}" in only_rows:
            print(f"hint: entry {k} ({home}-derivation.md) and § B row {home}-{k} differ only by the file's prefix — a name "
                  f"containing a hyphen stands as written; write the header qualified, {home}-{k}")
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
    new: dict[str, int] = {}
    for v in entries.values():
        if v.get("grammar") == "new":
            new[v["home"]] = new.get(v["home"], 0) + 1
    if new:
        print("  of which in the new grammar (`derivation:` blocks):", sum(new.values()), "in", len(new), "files:",
              ", ".join(f"{k}={v}" for k, v in sorted(new.items())))


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


def read_file(text: str, prefix: str, fname: str) -> tuple[dict[str, dict], int]:
    """One derivation file, both grammars, told per entry: (entries, header failures), every failure and note printed."""
    e = parse_entries(text, prefix)
    fails = near_misses(text, e, prefix, fname)
    for k, v in e.items():
        if v.get("dup"):
            print(f"FAIL: {fname}: id {k} defined twice in the older grammar")
            fails += 1
    n, notes, nfails = parse_new_entries(text, prefix, fname)
    fails += nfails
    for line in notes:
        print(line)
    for k in n:
        if k in e:
            print(f"FAIL: {fname}: id {k} defined in both grammars")
            fails += 1
    return {**e, **n}, fails


def load() -> tuple[dict[str, dict], dict[str, str], list[str], int]:
    """Entries, § B rows, placeholders, and the count of header failures (malformed headers, ids defined twice)."""
    entries: dict[str, dict] = {}
    header_fails = 0
    for f in sorted((ROOT / "plans").glob("*-derivation.md")):
        prefix = f.name[: -len("-derivation.md")]
        text = f.read_text(encoding="utf-8")
        e, fails = read_file(text, prefix, f.name)
        header_fails += fails
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
    ok_fire = n == expect  # two-sided: exactly the plants, so a plant firing twice or a stray failure is seen (TB1)
    clean = check(entries, rows, placeholders, strict=False) == 0
    print(f"self-test: planted 3 faults, {n} failures reported (expected {expect}); unplanted id check {'clean' if clean else 'NOT clean'}")
    new_ok = self_test_new()
    return 0 if ok_fire and shape_ok and clean and new_ok else 1


# ---------------------------------------------------------------- the new grammar's plants (TB1, 2026-09-28)

_ENTRY = """derivation: {name}
  statement: {statement}
  uses only: that 0 is the additive identity of the integers
  not claimed: that n · 0 = n — false at n = 1
  argument: § Argument
  verdict: derived
  grade: hand
  minds: 1
  model: n = 3 — 3 + 0 = 3
  prior art: known — the additive identity, in any algebra text
  handoff: none — a planted entry for the census self-test
"""
_STATEMENT = "every planted integer n satisfies n + 0 = n"
_REST = "\nRests on it: nothing; it is planted.\n\n"
_CONTROL = """control: FS99-N0-check
  of: FS99-N0 — the forward direction on every n below 10
  run: python3 -c "print(sum(n + 0 != n for n in range(10)))"
  expect: 0
  fault: python3 -c "print(sum(n + 1 != n for n in range(10)))"

"""
_TOP = "# FS-99 — a planted derivation file (the census self-test's)\n\n"
_ARG = "## Argument\n\n0 is the additive identity, so n + 0 = n.\n"


def _entry(name: str, drop: str = "", statement: str = _STATEMENT, verdict: str = "derived", rest: bool = True) -> str:
    """One planted entry in the new grammar, with `drop` removed, and its prose line naming what rests on it."""
    lines = _ENTRY.format(name=name, statement=statement).splitlines()
    lines = [x.replace("verdict: derived", f"verdict: {verdict}") for x in lines if not (drop and x.startswith(f"  {drop}:"))]
    return "\n".join(lines) + "\n" + (_REST if rest else "\n")


def _file(*plants: str) -> str:
    """The faithful entry FS99-N0 with its control, then the plants, then the argument section every entry points to."""
    return _TOP + _entry("FS99-N0") + _CONTROL + "".join(plants) + _ARG


def _ledger(*ids: str) -> str:
    head = "## B. Planted\n\n| id | milestone | the theorem | grade | proof | kernel |\n|---|---|---|---|---|---|\n"
    return head + "".join(f"| {i} | FS-99 | planted | hand | `plans/FS99-derivation.md` {i} | declined |\n" for i in ids)


def _run(text: str, ids: tuple[str, ...], strict: bool = True) -> tuple[list[str], int, dict[str, dict]]:
    """Every line the checker prints for this file and these § B rows, the failure count, the entries — by the run's own path."""
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        e, hf = read_file(text, "FS99", "FS99-derivation.md")
        rows, ph = parse_ledger_b(_ledger(*ids))
        n = check(e, rows, ph, strict) + hf
    return [x for x in buf.getvalue().splitlines() if x.strip()], n, e


def _gate_run(text: str) -> tuple[int, str]:
    """The Ephodos gate's entry lint on the planted file, so each plant's shape is judged by the grammar's own checker."""
    with tempfile.TemporaryDirectory() as d:
        f = Path(d) / "FS99-derivation.md"
        f.write_text(text, encoding="utf-8")
        r = subprocess.run([sys.executable, str(GATE_PATH), "entries", str(f)], capture_output=True, text=True, timeout=60)
        return r.returncode, r.stdout


def self_test_new() -> bool:
    """Each plant beside the faithful FS99-N0, in its own run; the run must print exactly the expected lines (patterns,
    fullmatched one to one), so a plant is seen to fire, to fire once, and for its own reason. The faithful file alone must
    print nothing and pass the gate; each missing-field plant must fail the gate too, so "mandatory" is the gate's word."""
    N0 = ("FS99-N0",)
    lacks = lambda i, f: rf"FAIL: entry {i} lacks {re.escape(f)}"
    cases = [
        # (name, text, § B ids, strict, expected line patterns, expected entry ids or None, gate exit expected or None)
        ("faithful entry alone (must pass)", _file(), N0, True, [], {"FS99-N0"}, 0),
        ("an entry with no § B row", _file(_entry("FS99-N1")), N0, True,
         [r"FAIL: entry FS99-N1 has no LEDGER\.md § B row"], None, None),
        ("a § B row whose entry is missing", _file(), N0 + ("FS99-N2",), True,
         [r"FAIL: LEDGER\.md § B row FS99-N2 has no derivation entry"], None, None),
        ("an entry lacking model:, --strict", _file(_entry("FS99-N3", drop="model")), N0 + ("FS99-N3",), True,
         [lacks("FS99-N3", "model:")], None, 1),
        ("the same, without --strict (a warning, no failure)", _file(_entry("FS99-N3", drop="model")), N0 + ("FS99-N3",), False,
         [r"warn: entry FS99-N3 lacks model:"], None, None),
        ("an entry with no prose naming what rests on it", _file(_entry("FS99-N5", rest=False)), N0 + ("FS99-N5",), True,
         [lacks("FS99-N5", RESTS)], None, 0),
        ("`rests on it:` indented inside the block (the gate folds it; must fail here)",
         _file(_entry("FS99-N5", rest=False).rstrip("\n") + "\n  rests on it: nothing\n\n"), N0 + ("FS99-N5",), True,
         [lacks("FS99-N5", RESTS) + r" \(an indented .*"], None, 0),
        ("a header the gate cannot read", _file("Derivation: FS99-N6\n  statement: planted\n\n"), N0, True,
         [r"FAIL: FS99-derivation\.md:\d+: header opens a block the gate cannot read .*Derivation: FS99-N6"], {"FS99-N0"}, 1),
        ("a hyphenated bare name beside a prefixed row (fails from both sides, with a hint)",
         _file(_entry("N7-3T")), N0 + ("FS99-N7-3T",), True,
         [r"FAIL: entry N7-3T has no LEDGER\.md § B row", r"FAIL: LEDGER\.md § B row FS99-N7-3T has no derivation entry",
          r"hint: entry N7-3T \(FS99-derivation\.md\) and § B row FS99-N7-3T differ only by the file's prefix .*"], None, None),
        ("a bare name without a hyphen inherits the prefix (must pass)", _file(_entry("N8")), N0 + ("FS99-N8",), True,
         [], {"FS99-N0", "FS99-N8"}, None),
        ("control:, verification: and a fenced derivation: are not entries (notes only)",
         _file("verification: FS99-N0\n  statement: " + _STATEMENT + "\n\n```\nderivation: FS99-N9\n  statement: fenced\n```\n\n"),
         N0, True,
         [r"note: FS99-derivation\.md:\d+: a `derivation:` header inside a code fence is not an entry, not counted: derivation: FS99-N9",
          r"note: FS99-derivation\.md: 1 `verification:` block — not entries, not counted"], {"FS99-N0"}, None),
        ("an id defined twice in the new grammar", _file(_entry("FS99-N0")), N0, True,
         [r"FAIL: FS99-derivation\.md:\d+: id FS99-N0 defined twice in the new grammar"], None, None),
        ("an id defined in both grammars", _file("**FS99-N0 — Planted twice. [hand; one mind: X]**\n*Proof:* p. *Proof verdict:* v. "
                                                 "*Rests on it:* r. *Prior art:* a. *Kernel:* k.\n\n"), N0, True,
         [r"FAIL: FS99-derivation\.md: id FS99-N0 defined in both grammars"], None, None),
        ("a stalled entry needs only statement, argument, verdict (must pass)",
         _file(_entry("FS99-N10", verdict="stalls at: the planted step", drop="model")), N0 + ("FS99-N10",), True, [],
         None, 0),
        ("a two-way derived statement with no converse:",
         _file(_entry("FS99-N11", statement="an integer n is even if and only if n + 0 is even")), N0 + ("FS99-N11",), True,
         [lacks("FS99-N11", "converse:")], None, 1),
    ]
    # Every field of the gate's own list (`FIELDS["derivation"]`, converse aside: it is conditional, planted above), dropped one
    # at a time from a derived entry: the census must name exactly it, and the gate must fail. The list is the gate's, not
    # NEW_ALWAYS + NEW_DERIVED — a loop over the constant under test would lose a field's case with the field (TB1's mutant 1).
    for fld in [f for f in gate().FIELDS["derivation"] if f != "converse"]:
        cases.append((f"an entry lacking {fld}: (field loop)", _file(_entry("FS99-N12", drop=fld)), N0 + ("FS99-N12",), True,
                      [lacks("FS99-N12", f"{fld}:")], None, 1))
    ok = True
    for name, text, ids, strict, pats, want_ids, gate_exit in cases:
        lines, n, e = _run(text, ids, strict)
        unmatched = list(lines)
        missing = []
        for pat in pats:
            hit = [x for x in unmatched if re.fullmatch(pat, x)]
            if len(hit) != 1:
                missing.append(pat)
            else:
                unmatched.remove(hit[0])
        n_want = sum(1 for pat in pats if pat.startswith("FAIL"))
        good = not missing and not unmatched and n == n_want and (want_ids is None or set(e) == want_ids)
        g_note = ""
        if gate_exit is not None:
            code, out = _gate_run(text)
            g_ok = code == gate_exit
            g_note = f"; gate exit {code} (expected {gate_exit})"
            good = good and g_ok
        print(f"self-test (new grammar): {name}: {'fires as planted' if pats else 'reads clean'}: {good}{g_note}")
        for x in missing:
            print(f"    expected, not printed exactly once: {x}")
        for x in unmatched:
            print(f"    printed, not expected: {x}")
        if want_ids is not None and set(e) != want_ids:
            print(f"    entries {sorted(e)} (expected {sorted(want_ids)})")
        ok = ok and good
    return ok


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
