#!/usr/bin/env python3
"""FS131-LN1: count the findings of one saved `lake lint -- --trace` run.

The input is the driver's stdout (`batteries/runLinter --trace Proofs`), saved whole.  It has
two parts that this script holds against each other:

  * the trace, one line per linter:   [Proofs] - <linter>: (2/2) Passed!
                                      [Proofs] - <linter>: (2/2) Failed with <n> messages, ...
  * the report, present only when some linter failed:
        -- Found <N> errors in <D> declarations (plus <A> automatically generated ones) in Proofs with <L> linters
        /- The `<linter>` linter reports:
        <what the linter looks for>
        This linter can be disabled with `@[nolint <linter>]`. -/
        -- <Module.Name>
        <path>:<line>:<col>: error: <declaration> <message, which may run over further lines>

A finding is one `<path>:<line>:<col>: error:` line with its continuation lines.  The script
fails (exit 2) unless, for every linter, the findings it parsed number exactly the trace's
<n>; the linters with a report section are exactly the trace's failed ones; their sum is the
report's <N>; the number of linters is its <L>; and every finding's path is its module's file.
A run with no report must print `-- Linting passed for Proofs.` and every linter `Passed!`.
An input with no trace line for any linter is refused: nothing was measured.

  tools/fs131_ln_count.py <lint.out> [--json out.json] [--md out.md]
  tools/fs131_ln_count.py --diff <a.out> <b.out>      findings of b that a does not have, and the reverse
  tools/fs131_ln_count.py --self-test                 planted faults, each watched to fire

Module classes are drawn by git, on the module's file (see `classify`).
"""
import json
import re
import subprocess
import sys
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BASE_FS131 = "077fa8b0"   # the last commit before FS-131 that touches Proofs/
BASE_LINT = "39513500"    # the M2 close: the last recorded passing `lake lint`

TRACE = re.compile(r"^\[Proofs\] - (?P<linter>\S+): \(2/2\) (?:(?P<ok>Passed!)|Failed with (?P<n>\d+) messages)")
FOUND = re.compile(r"^-- Found (?P<n>\d+) errors? in (?P<d>\d+) declarations \(plus (?P<a>\d+) automatically generated ones\) "
                   r"in Proofs with (?P<l>\d+) linters$")
SECTION = re.compile(r"^/- The `(?P<linter>[^`]+)` linter reports:$")
SECTION_END = re.compile(r"^This linter can be disabled with `@\[nolint (?P<linter>[^\]]+)\]`\. -/$")
MODULE = re.compile(r"^-- (?P<module>Proofs(?:\.[A-Za-z0-9_']+)*)$")
FINDING = re.compile(r"^(?P<path>\S*Proofs\S*\.lean):(?P<line>\d+):(?P<col>\d+): error: (?P<rest>.*)$")
PASSED = "-- Linting passed for Proofs."


class Refused(Exception):
    """The input cannot be counted; the message says why."""


def parse(text):
    """-> dict(trace={linter: n}, found=(N, D, A, L) | None, findings=[dict], blurb={linter: str}, passed=bool)"""
    trace, findings, blurb = {}, [], {}
    found, passed = None, False
    linter = module = cur = None
    in_header = False
    for no, line in enumerate(text.splitlines(), 1):
        m = TRACE.match(line)
        if m:
            if m["linter"] in trace:
                raise Refused(f"line {no}: a second verdict for linter {m['linter']}")
            trace[m["linter"]] = 0 if m["ok"] else int(m["n"])
            continue
        m = FOUND.match(line)
        if m:
            if found:
                raise Refused(f"line {no}: a second `-- Found` line")
            found = tuple(int(m[k]) for k in "ndal")
            continue
        if line == PASSED:
            passed = True
            continue
        m = SECTION.match(line)
        if m:
            linter, module, cur, in_header = m["linter"], None, None, True
            if linter in blurb:
                raise Refused(f"line {no}: a second report section for linter {linter}")
            blurb[linter] = ""
            continue
        if in_header:
            m = SECTION_END.match(line)
            if m:
                if m["linter"] != linter:
                    raise Refused(f"line {no}: section {linter} closed as {m['linter']}")
                in_header = False
            else:
                blurb[linter] += line + "\n"
            continue
        if linter is None:
            continue                      # trace prose before the report
        m = MODULE.match(line)
        if m:
            module, cur = m["module"], None
            continue
        m = FINDING.match(line)
        if m:
            if module is None:
                raise Refused(f"line {no}: a finding before any `-- Module` line in section {linter}")
            cur = dict(linter=linter, module=module, path=m["path"], line=int(m["line"]), col=int(m["col"]),
                       text=line, out_line=no)
            cur["decl"] = m["rest"].split(" ", 1)[0].lstrip("@")   # `@decl` when the constant prints explicit
            findings.append(cur)
            continue
        if line.strip() == "":
            cur = None                    # a blank line ends a module's group
            continue
        if cur is None:
            raise Refused(f"line {no}: text inside section {linter} that belongs to no finding: {line[:80]!r}")
        cur["text"] += "\n" + line        # a message that runs over several lines
    return dict(trace=trace, found=found, findings=findings, blurb=blurb, passed=passed)


def check(p):
    """Hold the report against the trace; raise Refused on any disagreement."""
    if not p["trace"]:
        raise Refused("no `(2/2)` trace line for any linter: nothing was measured (was the run made with `-- --trace`?)")
    per = Counter(f["linter"] for f in p["findings"])
    failed = {k: n for k, n in p["trace"].items() if n}
    if p["found"] is None:
        if p["findings"] or p["blurb"]:
            raise Refused("report sections with no `-- Found` line")
        if failed:
            raise Refused(f"the trace has failed linters {sorted(failed)} and there is no report")
        if not p["passed"]:
            raise Refused("no report and no `-- Linting passed for Proofs.` line: the run did not finish")
        return
    if p["passed"]:
        raise Refused("both a report and `-- Linting passed`")
    n, d, a, l = p["found"]
    if l != len(p["trace"]):
        raise Refused(f"`-- Found` says {l} linters, the trace has {len(p['trace'])}")
    if set(p["blurb"]) != set(failed):
        raise Refused(f"report sections {sorted(p['blurb'])} are not the trace's failed linters {sorted(failed)}")
    for k in sorted(failed):
        if per[k] != failed[k]:
            raise Refused(f"linter {k}: parsed {per[k]} findings, the trace says {failed[k]}")
    if sum(per.values()) != n:
        raise Refused(f"parsed {sum(per.values())} findings, `-- Found` says {n}")
    for f in p["findings"]:
        want = f["module"].replace(".", "/") + ".lean"
        if not f["path"].endswith(want):
            raise Refused(f"output line {f['out_line']}: path {f['path']} is not module {f['module']}'s file")
    seen = Counter((f["linter"], f["decl"]) for f in p["findings"])
    dup = [k for k, c in seen.items() if c > 1]
    if dup:
        raise Refused(f"a declaration reported twice by one linter: {dup[:3]}")


def git_files(commit):
    out = subprocess.run(["git", "ls-tree", "-r", "--name-only", commit, "--", "Proofs/"], cwd=ROOT, check=True,
                         capture_output=True, text=True).stdout
    return {x for x in out.splitlines() if x.endswith(".lean")}


def git_changed(a, b):
    out = subprocess.run(["git", "diff", "--name-only", "--diff-filter=M", a, b, "--", "Proofs/"], cwd=ROOT, check=True,
                         capture_output=True, text=True).stdout
    return set(out.splitlines())


def classify():
    """module -> class, by git on the module's file:
       fs131     the file does not exist at BASE_FS131 (FS-131 added it)
       post-m2   it exists at BASE_FS131 and not at BASE_LINT, or was changed between them
                 (older than FS-131, and added or changed since the last recorded passing lint)
       older     it exists at BASE_LINT and is unchanged since
    """
    head, at_fs, at_lint = git_files("HEAD"), git_files(BASE_FS131), git_files(BASE_LINT)
    touched = git_changed(BASE_LINT, "HEAD")
    cls = {}
    for f in head:
        mod = f[:-5].replace("/", ".")
        if f not in at_fs:
            cls[mod] = "fs131"
        elif f not in at_lint or f in touched:
            cls[mod] = "post-m2"
        else:
            cls[mod] = "older"
    return cls


def spread(items, k=3):
    """k items spread over a sorted list: first, middle, last."""
    if len(items) <= k:
        return list(items)
    return [items[0], items[len(items) // 2], items[-1]]


def tabulate(p, cls):
    f_all = sorted(p["findings"], key=lambda f: (f["linter"], f["module"], f["line"], f["decl"]))
    linters = sorted(p["trace"])
    classes = ["fs131", "post-m2", "older"]
    by_lc = Counter((f["linter"], cls[f["module"]]) for f in f_all)
    by_mod = defaultdict(Counter)
    for f in f_all:
        by_mod[f["module"]][f["linter"]] += 1
    mods = sorted(by_mod, key=lambda m: (-sum(by_mod[m].values()), m))
    out = dict(
        found=p["found"], linters=linters, passed=p["passed"], trace=p["trace"],
        total=len(f_all),
        modules_with_findings=len(mods),
        class_modules=dict(Counter(cls.values())),
        by_linter={k: p["trace"][k] for k in linters},
        by_linter_class={k: {c: by_lc[(k, c)] for c in classes} for k in linters if p["trace"][k]},
        by_class={c: sum(by_lc[(k, c)] for k in linters) for c in classes},
        by_module=[dict(module=m, cls=cls[m], total=sum(by_mod[m].values()), **{"by": dict(by_mod[m])}) for m in mods],
        samples={k: [f["text"] for f in spread([f for f in f_all if f["linter"] == k])] for k in linters if p["trace"][k]},
        blurb=p["blurb"],
    )
    return out


def markdown(t, src):
    L = []
    w = L.append
    w(f"<!-- made by tools/fs131_ln_count.py from {src}; do not edit by hand -->")
    if t["found"]:
        n, d, a, l = t["found"]
        w(f"The driver's own line: {n} findings in {d} declarations (plus {a} automatically generated ones) with {l} linters.")
    else:
        w(f"The run passed: `{PASSED}` and {len(t['linters'])} linters each `Passed!`.")
    w("")
    w("| linter | findings | in FS-131's modules | in post-M2 modules | in older modules |")
    w("|---|---:|---:|---:|---:|")
    for k in t["linters"]:
        c = t["by_linter_class"].get(k, {"fs131": 0, "post-m2": 0, "older": 0})
        w(f"| `{k}` | {t['by_linter'][k]} | {c['fs131']} | {c['post-m2']} | {c['older']} |")
    w(f"| **all** | **{t['total']}** | **{t['by_class']['fs131']}** | **{t['by_class']['post-m2']}** | **{t['by_class']['older']}** |")
    w("")
    cm = t["class_modules"]
    w(f"Modules: {cm.get('fs131', 0)} FS-131, {cm.get('post-m2', 0)} post-M2, {cm.get('older', 0)} older; "
      f"{t['modules_with_findings']} have at least one finding.")
    w("")
    w("| # | module | class | findings | by linter |")
    w("|---:|---|---|---:|---|")
    for i, r in enumerate(t["by_module"], 1):
        by = ", ".join(f"{k} {v}" for k, v in sorted(r["by"].items(), key=lambda kv: (-kv[1], kv[0])))
        w(f"| {i} | `{r['module']}` | {r['cls']} | {r['total']} | {by} |")
    w("")
    for k, ss in t["samples"].items():
        w(f"### `{k}` — {t['by_linter'][k]} findings; three quoted in full (first, middle, last by module and line)")
        w("")
        w("The linter's own description: " + " ".join(t["blurb"][k].split()))
        w("")
        for s in ss:
            w("```")
            w(s)
            w("```")
        w("")
    return "\n".join(L) + "\n"


def keyset(p):
    return {(f["linter"], f["decl"]): f for f in p["findings"]}


def run(path):
    p = parse(Path(path).read_text())
    check(p)
    return p


# ---------------------------------------------------------------- self-test

GOOD = """[Proofs] Starting lint...
[Proofs] Running linters:
  docBlame
  simpNF
  unusedArguments
[Proofs] - docBlame: (0/2) Starting...
[Proofs] - docBlame: (1/2) Getting...
[Proofs] - docBlame: (2/2) Failed with 1 messages, but these may include declarations in `nolints.json`.
[Proofs] - simpNF: (1/2) Getting...
[Proofs] - simpNF: (2/2) Passed!
[Proofs] - unusedArguments: (1/2) Getting...
[Proofs] - unusedArguments: (2/2) Failed with 3 messages, but these may include declarations in `nolints.json`.
[Proofs] Completed linting!
-- Found 4 errors in 10 declarations (plus 2 automatically generated ones) in Proofs with 3 linters

/- The `docBlame` linter reports:
DEFINITIONS ARE MISSING DOCUMENTATION STRINGS:
This linter can be disabled with `@[nolint docBlame]`. -/
-- Proofs.A.B
././Proofs/A/B.lean:3:1: error: A.foo definition missing documentation string

/- The `unusedArguments` linter reports:
UNUSED ARGUMENTS.
This linter can be disabled with `@[nolint unusedArguments]`. -/
-- Proofs.A.B
././Proofs/A/B.lean:3:1: error: A.foo argument 2 m : ℕ
././Proofs/A/B.lean:9:1: error: A.bar argument 1 h : a = b
  with a second line of message

-- Proofs.C
././Proofs/C.lean:1:1: error: C.baz argument 4 _hF : P
"""

PASS = """[Proofs] - docBlame: (2/2) Passed!
[Proofs] - unusedArguments: (2/2) Passed!
[Proofs] Completed linting!
-- Linting passed for Proofs.
"""


def expect_refused(name, text, needle):
    try:
        check(parse(text))
    except Refused as e:
        if needle not in str(e):
            return f"{name}: refused, but for another reason: {e}"
        return None
    return f"{name}: the plant was NOT caught"


def self_test():
    fails = []
    # the positive: the good input counts exactly, a multi-line message stays one finding
    p = parse(GOOD)
    check(p)
    per = Counter(f["linter"] for f in p["findings"])
    if dict(per) != {"docBlame": 1, "unusedArguments": 3}:
        fails.append(f"good: wrong counts {dict(per)}")
    if not any("with a second line" in f["text"] for f in p["findings"]):
        fails.append("good: the continuation line was not attached to its finding")
    if [f["decl"] for f in p["findings"]] != ["A.foo", "A.foo", "A.bar", "C.baz"]:
        fails.append("good: wrong declarations")
    q = parse(PASS)
    check(q)
    if q["findings"] or not q["passed"]:
        fails.append("pass: a passing run misread")
    plants = [
        ("a finding line deleted",
         GOOD.replace("././Proofs/C.lean:1:1: error: C.baz argument 4 _hF : P\n", ""), "parsed 2 findings, the trace says 3"),
        ("a finding line added",
         GOOD + "././Proofs/C.lean:5:1: error: C.qux argument 1 x : ℕ\n", "parsed 4 findings, the trace says 3"),
        ("the trace count altered",
         GOOD.replace("Failed with 1 messages", "Failed with 2 messages"), "parsed 1 findings, the trace says 2"),
        ("the Found total altered", GOOD.replace("-- Found 4 errors", "-- Found 5 errors"), "`-- Found` says 5"),
        ("a failed linter with no section",
         GOOD.replace("(2/2) Passed!", "(2/2) Failed with 2 messages"), "are not the trace's failed linters"),
        ("a linter's trace line missing",
         GOOD.replace("[Proofs] - simpNF: (2/2) Passed!\n", ""), "says 3 linters, the trace has 2"),
        ("no trace at all (a run without --trace)",
         "\n".join(l for l in GOOD.splitlines() if "(2/2)" not in l) + "\n", "nothing was measured"),
        ("an empty file", "", "nothing was measured"),
        ("a truncated passing run", PASS.replace(PASSED + "\n", ""), "the run did not finish"),
        ("a passing line over a failed trace",
         PASS.replace("- docBlame: (2/2) Passed!", "- docBlame: (2/2) Failed with 1 messages"), "there is no report"),
        ("a finding under the wrong module",
         GOOD.replace("././Proofs/C.lean:1:1", "././Proofs/A/B.lean:1:1"), "is not module Proofs.C's file"),
        ("a declaration reported twice",
         GOOD.replace("error: A.bar argument 1", "error: A.foo argument 1"), "reported twice by one linter"),
        ("stray text inside a section",
         GOOD.replace("-- Proofs.C\n", "-- Proofs.C\nsomething that is no finding\n"), "belongs to no finding"),
    ]
    for name, text, needle in plants:
        if text == GOOD or text == PASS:
            fails.append(f"{name}: the plant changed nothing")
            continue
        r = expect_refused(name, text, needle)
        if r:
            fails.append(r)
    # the diff: a plant added to a run is reported as exactly itself
    b = parse(GOOD.replace("-- Found 4", "-- Found 5").replace("Failed with 3 messages", "Failed with 4 messages")
              + "././Proofs/C.lean:5:1: error: C.qux argument 1 x : ℕ\n")
    check(b)
    added = sorted(set(keyset(b)) - set(keyset(p)))
    if added != [("unusedArguments", "C.qux")]:
        fails.append(f"diff: expected the one planted finding, got {added}")
    # the classes: each class is inhabited and the three are a partition of HEAD's modules
    cls = classify()
    c = Counter(cls.values())
    if not (c["fs131"] and c["post-m2"] and c["older"]):
        fails.append(f"classify: an empty class {dict(c)}")
    if cls.get("Proofs.HadwigerNelson.Plane.ValidMap.OpenMove") != "fs131":
        fails.append("classify: OpenMove is not fs131")
    if cls.get("Proofs.HadwigerNelson.ThetaCert") != "post-m2":
        fails.append("classify: ThetaCert is not post-m2")
    if cls.get("Proofs.HadwigerNelson.Transcendental") != "post-m2":
        fails.append("classify: Transcendental (changed after the M2 close) is not post-m2")
    if cls.get("Proofs.HadwigerNelson.Kempe") != "older":
        fails.append("classify: Kempe is not older")
    if fails:
        print("SELF-TEST FAIL")
        for f in fails:
            print("  " + f)
        return 1
    print(f"SELF-TEST OK: 2 inputs counted exactly, {len(plants)} plants each refused for its own reason, "
          f"the diff names a planted finding alone, the classes are inhabited ({dict(c)})")
    return 0


def main(argv):
    if argv == ["--self-test"]:
        return self_test()
    try:
        if argv and argv[0] == "--diff":
            a, b = run(argv[1]), run(argv[2])
            ka, kb = keyset(a), keyset(b)
            print(f"{argv[1]}: {len(ka)} findings; {argv[2]}: {len(kb)} findings")
            for sign, keys, src in (("+", sorted(set(kb) - set(ka)), kb), ("-", sorted(set(ka) - set(kb)), ka)):
                for k in keys:
                    print(f"{sign} [{k[0]}] {src[k]['text']}")
            moved = sorted(k for k in set(ka) & set(kb) if ka[k]["text"] != kb[k]["text"])
            for k in moved:
                print(f"~ [{k[0]}] {ka[k]['text']}\n    -> {kb[k]['text']}")
            print(f"added {len(set(kb) - set(ka))}, removed {len(set(ka) - set(kb))}, changed text {len(moved)}")
            return 0
        args = [a for a in argv if not a.startswith("--")]
        opts = {argv[i]: argv[i + 1] for i in range(len(argv) - 1) if argv[i] in ("--json", "--md")}
        src = [a for a in args if a not in opts.values()]
        if len(src) != 1:
            raise SystemExit(__doc__)
        p = run(src[0])
        t = tabulate(p, classify())
        md = markdown(t, src[0])
        if "--json" in opts:
            Path(opts["--json"]).write_text(json.dumps(t, indent=1, ensure_ascii=False) + "\n")
        if "--md" in opts:
            Path(opts["--md"]).write_text(md)
        else:
            print(md, end="")
        return 0
    except Refused as e:
        print(f"REFUSED: {e}")
        return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
