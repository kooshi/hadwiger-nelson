#!/usr/bin/env python3
"""TB1's negative controls for tools/fs71_ledger_b_check.py: each mutation is applied to the source IN MEMORY (compiled
under the real file's path, so ROOT and GATE_PATH resolve as shipped; nothing on disk changes, nothing to restore), and
the self-test must go red naming the case the mutation breaks. Then an end-to-end run of load()/main() over a scratch
tree holding one new-grammar derivation file, a planted § B, and the real gate.

    python3 data/workflow3/tb1/mutate.py      # exit 0 iff every mutation turns the self-test red and the unmutated one is green
"""
import contextlib
import io
import re
import sys
import tempfile
from pathlib import Path

REPO = Path(__file__).resolve().parents[3]
TOOL = REPO / "tools" / "fs71_ledger_b_check.py"
SRC = TOOL.read_text(encoding="utf-8")

# (name, old text, new text, a case-name fragment whose self-test line must read False)
MUTATIONS = [
    ("drop model: from the derived list", '"minds", "model", "prior art"', '"minds", "prior art"', "lacking model: (field loop)"),
    ("the new-grammar parser reads nothing", "    for b in g.blocks(lines, fname):\n", "    for b in []:\n", "faithful entry alone"),
    ("the rests-on prose never found", 'RESTS_RE = re.compile(r"\\brests\\s+on\\b", re.I)', 'RESTS_RE = re.compile(r"(?!x)x")',
     "faithful entry alone"),
    ("the rests-on check reads the block too", "prose = any(RESTS_RE.search(x) for x in lines[end: stop])",
     "prose = any(RESTS_RE.search(x) for x in lines[h + 1: stop])", "indented inside the block"),
    ("converse never required", "        if derived and g.STRICT.search(", "        if False and g.STRICT.search(",
     "two-way derived statement"),
    ("the id rule stops inheriting the prefix", "    return full\n", "    return raw\n", "inherits the prefix"),
    ("control: blocks counted as entries", '        if b["kind"] != "derivation":\n', '        if b["kind"] not in ("derivation", "control"):\n',
     "faithful entry alone"),
    ("unreadable headers not failed", "    for ln, line in g.unread_heads(lines):", "    for ln, line in []:", "cannot read"),
    ("new-grammar duplicates kept in silence", '            print(f"FAIL: {fname}:{b[\'line\']}: id {full} defined twice in the new grammar")\n            fails += 1\n',
     "            pass\n", "defined twice in the new grammar"),
    ("both-grammar clash kept in silence", '            print(f"FAIL: {fname}: id {k} defined in both grammars")\n            fails += 1\n',
     "            pass\n", "defined in both grammars"),
    ("the hint never printed", '        if f"{home}-{k}" in only_rows:', '        if False:', "hyphenated bare name"),
    ("strict ignored for new-grammar fields", "    if strict:\n        failures += len(missing)", "    if False:\n        failures += len(missing)",
     "lacking model:, --strict"),
]


def load_module(src: str):
    ns = {"__name__": "fs71_mutant", "__file__": str(TOOL)}
    exec(compile(src, str(TOOL), "exec"), ns)
    return ns


def self_test(src: str) -> tuple[int, str]:
    ns = load_module(src)
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        code = ns["self_test"]()
    return code, buf.getvalue()


def main() -> int:
    ok = True
    code, out = self_test(SRC)
    print(f"unmutated: self-test exit {code} (expected 0)")
    ok = ok and code == 0
    for name, old, new, case in MUTATIONS:
        n = SRC.count(old)
        if n != 1:
            print(f"MUTATION NOT APPLIED ({n} matches): {name}")
            ok = False
            continue
        code, out = self_test(SRC.replace(old, new, 1))
        red = [ln for ln in out.splitlines() if ln.startswith("self-test (new grammar)") and ln.rstrip().split(": ")[-1].split(";")[0] == "False"]
        red += [ln for ln in out.splitlines() if re.search(r": False(;|$)", ln) and ln not in red]
        named = any(case in ln for ln in red)
        print(f"{name}: self-test exit {code} (expected 1); the case '{case}' reads False: {named}; {len(red)} case(s) red")
        ok = ok and code == 1 and named
    # End to end: load() and main() over a scratch tree, as the coordinator runs it, with the shipped gate.
    ns = load_module(SRC)
    with tempfile.TemporaryDirectory() as d:
        root = Path(d)
        (root / "plans").mkdir()
        (root / "plans" / "FS99-derivation.md").write_text(ns["_file"](ns["_entry"]("N8")), encoding="utf-8")
        (root / "LEDGER.md").write_text(ns["_ledger"]("FS99-N0", "FS99-N8"), encoding="utf-8")
        ns["ROOT"] = root
        for strict in (True, False):
            sys.argv = ["fs71_ledger_b_check.py"] + (["--strict"] if strict else [])
            buf = io.StringIO()
            with contextlib.redirect_stdout(buf):
                code = ns["main"]()
            print(f"end to end ({'--strict' if strict else 'plain'}): exit {code} (expected 0)")
            print("  " + buf.getvalue().strip().replace("\n", "\n  "))
            ok = ok and code == 0 and "of which in the new grammar (`derivation:` blocks): 2 in 1 files: FS99=2" in buf.getvalue()
        (root / "LEDGER.md").write_text(ns["_ledger"]("FS99-N0"), encoding="utf-8")
        sys.argv = ["fs71_ledger_b_check.py", "--strict"]
        buf = io.StringIO()
        with contextlib.redirect_stdout(buf):
            code = ns["main"]()
        print(f"end to end, the § B row for FS99-N8 removed: exit {code} (expected 1)")
        print("  " + buf.getvalue().strip().replace("\n", "\n  "))
        ok = ok and code == 1 and "FAIL: entry FS99-N8 has no LEDGER.md § B row" in buf.getvalue()
    print("MUTATION HARNESS:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
