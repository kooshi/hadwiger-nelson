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


def load() -> tuple[dict[str, dict], dict[str, str], list[str]]:
    entries: dict[str, dict] = {}
    for f in sorted((ROOT / "plans").glob("*-derivation.md")):
        prefix = f.name[: -len("-derivation.md")]
        e = parse_entries(f.read_text(encoding="utf-8"), prefix)
        for k in e:
            if k in entries:
                print(f"FAIL: id {k} defined in two files")
        entries.update(e)
    rows, placeholders = parse_ledger_b((ROOT / "LEDGER.md").read_text(encoding="utf-8"))
    return entries, rows, placeholders


def self_test() -> int:
    entries, rows, placeholders = load()
    if not entries or not rows:
        print("self-test: nothing to plant on"); return 1
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
    return 0 if ok_fire else 1


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--strict", action="store_true")
    ap.add_argument("--self-test", action="store_true")
    a = ap.parse_args()
    if a.self_test:
        return self_test()
    entries, rows, placeholders = load()
    n = check(entries, rows, placeholders, a.strict)
    census(entries)
    print("LEDGER § B rows:", len(rows), "| placeholders:", len(placeholders))
    print("RESULT:", "PASS" if n == 0 else f"FAIL ({n})")
    return 0 if n == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
