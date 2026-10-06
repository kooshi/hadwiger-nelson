#!/usr/bin/env python3
"""FS131-OL1: OPEN's records in the gate's saved axioms log — every theorem of `OpenMove` audited, each within the standard three.

Three lists are read and must agree:

  source   the theorems `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` declares (namespaces, sections and `end` tracked);
  audit    the names `#print axioms`'d in `scripts/Axioms.lean`'s block "FS-131, `OpenMove` (jobs FS131-IO1, IO2, IO3)" (up to the
           next blank line), which must stand between the CLEAN and PURCHASED banners;
  log      the records of `scripts/axioms.sh`'s full output (`build/gate/axioms/…`), parsed by FS131-IMM4's `records` (wrapped
           lines re-joined; imported, never copied).

Checks: source = audit as sets, no name twice; every name has exactly one record in the log, printed between the log's CLEAN and
PURCHASED banners, on a subset of `[propext, Classical.choice, Quot.sound]` (no `sorryAx`, no native auxiliary, no other axiom).
Prints how many rest on exactly the three, on fewer, and on none, and `exists_open`'s own axioms.

Usage: fs131_ol_axioms.py <axioms log>
       fs131_ol_axioms.py --plant <axioms log>   in memory: `sorryAx` added to `exists_open`'s record, `open_allowedCone`'s record
                                                  dropped, one audited name dropped (an unaudited theorem), and `open_rim`'s record
                                                  moved under PURCHASED; must exit 1 naming all four
Exit 0 when every check holds; 1 otherwise (each failure printed); 2 when a list could not be read at all.
"""
import pathlib
import re
import sys

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from fs131_imm_axioms import STANDARD, records  # noqa: E402

ROOT = pathlib.Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean"
AUDIT = ROOT / "scripts/Axioms.lean"
HEADER = "/-! ## FS-131, `OpenMove` (jobs FS131-IO1, IO2, IO3)"
P = "HadwigerNelson.Plane.ArcMap."
EXISTS_OPEN, ALLOWED, RIM = P + "exists_open", P + "Near.open_allowedCone", P + "Near.open_rim"


def source_theorems(text):
    """Full names of the file's theorems: `namespace`/`section` push, `end` pops, `_root_.` resets."""
    stack, out = [], []
    for line in text.split("\n"):
        m = re.match(r"^namespace\s+(\S+)", line)
        if m:
            stack.append(("ns", m.group(1)))
            continue
        if re.match(r"^section\b", line):
            stack.append(("sec", ""))
            continue
        if re.match(r"^end\b", line) and stack:
            stack.pop()
            continue
        m = re.match(r"^(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|nonrec)\s+)*(?:theorem|lemma)\s+([^\s:({\[⦃]+)", line)
        if m:
            n = m.group(1)
            prefix = ".".join(x for k, x in stack if k == "ns")
            out.append(n[len("_root_."):] if n.startswith("_root_.") else (prefix + "." + n if prefix else n))
    return out


def audit_block(text):
    """(names, in_clean): the block's `#print axioms` names, and whether the block stands between the CLEAN and PURCHASED banners."""
    if text.count(HEADER) != 1:
        return None, False
    i = text.index(HEADER)
    block = text[i:text.index("\n\n", i)]
    clean = text.find('#eval IO.println "=== CLEAN ==="')
    purchased = text.find('#eval IO.println "=== PURCHASED ==="')
    return re.findall(r"^#print axioms (\S+)$", block, re.M), 0 <= clean < i < purchased


def log_sections(text):
    """name -> the banner its record is printed under (wrapped lines belong to the record that opened them)."""
    sec, where = "", {}
    for raw in text.splitlines():
        m = re.match(r"^=== ([A-Z]+) ===$", raw)
        if m:
            sec = m.group(1)
            continue
        m = re.match(r"^'(.+)' (depends on axioms: \[|does not depend on any axioms)", raw)
        if m:
            where.setdefault(m.group(1), []).append(sec)
    return where


def main(argv):
    plant = "--plant" in argv
    paths = [a for a in argv if a != "--plant"]
    if len(paths) != 1:
        print(__doc__)
        return 2
    logtext = pathlib.Path(paths[0]).read_text()
    src = source_theorems(SOURCE.read_text())
    aud, in_clean = audit_block(AUDIT.read_text())
    if not src or aud is None or not aud:
        print(f"UNREADABLE: {len(src)} theorem(s) read from the source, the audit block " + ("not found exactly once" if aud is None else f"holds {len(aud)} name(s)"))
        return 2
    recs, dup = {}, []
    for name, ax in records(logtext):
        if name in recs:
            dup.append(name)
        recs[name] = ax
    where = log_sections(logtext)
    if not recs:
        print("UNREADABLE: no record in the log")
        return 2
    if plant:
        recs[EXISTS_OPEN] = recs[EXISTS_OPEN] | {"sorryAx"}
        recs.pop(ALLOWED, None)
        aud = [n for n in aud if not n.endswith(".open_valid")]
        where[RIM] = ["PURCHASED"]
    bad = []
    if not in_clean:
        bad.append("the audit block does not stand between the CLEAN and PURCHASED banners of scripts/Axioms.lean")
    for label, names in (("source", src), ("audit", aud)):
        for n in sorted({x for x in names if names.count(x) > 1}):
            bad.append(f"twice in the {label}: {n}")
    for n in sorted(set(src) - set(aud)):
        bad.append(f"a theorem of OpenMove with no line in the audit block: {n}")
    for n in sorted(set(aud) - set(src)):
        bad.append(f"audited in OPEN's block and not a theorem of OpenMove: {n}")
    exact = fewer = none = 0
    for n in sorted(set(src) | set(aud)):
        if n in dup:
            bad.append(f"recorded twice in the log: {n}")
        if n not in recs:
            bad.append(f"no record in the log: {n}")
            continue
        if where.get(n) != ["CLEAN"]:
            bad.append(f"printed under {where.get(n)} in the log, not once under CLEAN: {n}")
        ax = recs[n]
        if not ax <= STANDARD:
            bad.append(f"outside the standard three: {n} {sorted(ax)}")
        elif ax == STANDARD:
            exact += 1
        elif ax:
            fewer += 1
            print(f"  on fewer: {n} {sorted(ax)}")
        else:
            none += 1
            print(f"  on none: {n}")
    for b in bad:
        print("FAIL", b)
    print(f"OPEN records: {len(src)} theorems in the source, {len(aud)} names in the audit block, {len(recs)} records in the log — "
          f"{exact} on exactly the standard three, {fewer} on fewer, {none} on none; "
          f"exists_open {sorted(recs.get(EXISTS_OPEN, {'(missing)'}))}")
    print("open axioms:", "PASS" if not bad else f"FAIL ({len(bad)})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
