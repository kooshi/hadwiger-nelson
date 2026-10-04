#!/usr/bin/env python3
"""FS131-QA1: parse Lean declarations from a git ref, read-only, and measure them.

Reads files with `git show <ref>:<path>` (never a worktree), splits each into declarations
(theorem/lemma/def/abbrev/structure/class/inductive/instance/axiom/example/opaque), and records
for each: kind, name, line, signature (text up to the first top-level `:=` / `where` / `|`),
whether it has a docstring, body length in lines, and counts of tactics worth auditing.

Usage:
  fs131_qa1_decls.py dump <ref> <path>...        JSON lines on stdout
  fs131_qa1_decls.py --self-test                 planted controls; exit 1 on any miss

The parser is heuristic (no Lean elaboration): a declaration starts at a line whose first token,
after attributes and modifiers, is a declaration keyword at column 0; it ends where the next
column-0 command starts. Counts of tactics are textual, outside `--` comments and doc comments.
"""
import json
import re
import subprocess
import sys

KW = r"(theorem|lemma|def|abbrev|structure|class|inductive|instance|axiom|example|opaque)"
MODS = r"(?:(?:private|protected|noncomputable|nonrec|partial|unsafe|scoped)\s+)*"
ATTR = r"(?:@\[[^\]]*\]\s*)*"
DECL_RE = re.compile(r"^" + ATTR + MODS + KW + r"\b\s*([^\s:({\[⦃]*)")
# column-0 commands that end a declaration
END_RE = re.compile(r"^(end\b|namespace\b|section\b|open\b|variable\b|/-!|/--|@\[|set_option\b|"
                    r"attribute\b|#|noncomputable section|universe\b|" + MODS.replace("(?:", "(?:", 1) + KW + r"\b)")

TACTICS = {
    "sorry": r"\bsorry\b",
    "simp_bare": r"\bsimp\b(?!\s*only)(?!_)(?!\?)",
    "simp_all": r"\bsimp_all\b",
    "nlinarith": r"\bnlinarith\b",
    "polyrith": r"\bpolyrith\b",
    "decide": r"(?<![_\w])decide\b",
    "native_decide": r"\bnative_decide\b",
    "aesop": r"\baesop\b",
    "grind": r"\bgrind\b",
    "omega": r"\bomega\b",
    "maxHeartbeats": r"maxHeartbeats",
    "unused_have": r"\bhave\s+_\s*:?=",
    "exact_question": r"\b(exact\?|apply\?|simp\?|rw\?)",
    "classical_choice": r"Classical\.choice|Classical\.choose",
    "axiom_kw": r"^axiom\b",
}


def strip_comments(text):
    """Remove `--` line comments and `/- ... -/` block comments (doc comments included)."""
    out, i, n, depth = [], 0, len(text), 0
    while i < n:
        if depth == 0 and text.startswith("--", i):
            j = text.find("\n", i)
            i = n if j < 0 else j
            continue
        if text.startswith("/-", i):
            depth += 1
            i += 2
            continue
        if depth > 0 and text.startswith("-/", i):
            depth -= 1
            i += 2
            continue
        if depth > 0:
            if text[i] == "\n":
                out.append("\n")
            i += 1
            continue
        out.append(text[i])
        i += 1
    return "".join(out)


def git_show(ref, path):
    r = subprocess.run(["git", "show", f"{ref}:{path}"], capture_output=True, text=True)
    if r.returncode != 0:
        return None
    return r.stdout


def parse(text):
    lines = text.split("\n")
    # lines that begin inside a block comment (docstrings included) are never declaration starts
    in_comment, depth = [], 0
    for ln in lines:
        in_comment.append(depth > 0)
        j = 0
        while j < len(ln):
            if depth == 0 and ln.startswith("--", j):
                break
            if ln.startswith("/-", j):
                depth += 1; j += 2; continue
            if depth > 0 and ln.startswith("-/", j):
                depth -= 1; j += 2; continue
            j += 1
    starts = []
    for i, ln in enumerate(lines):
        if in_comment[i]:
            continue
        m = DECL_RE.match(ln)
        if m:
            starts.append((i, m.group(1), m.group(2)))
    decls = []
    for idx, (i, kind, name) in enumerate(starts):
        # docstring: walk back over attribute lines to a `-/` line, then to its `/--`
        j = i - 1
        while j >= 0 and lines[j].startswith("@["):
            j -= 1
        has_doc = False
        doc = ""
        if j >= 0 and lines[j].rstrip().endswith("-/"):
            k = j
            while k >= 0 and "/--" not in lines[k] and "/-!" not in lines[k] and "/-" not in lines[k]:
                k -= 1
            if k >= 0 and "/--" in lines[k]:
                has_doc = True
                doc = "\n".join(lines[k:j + 1])
        # end: next column-0 command after i
        end = len(lines)
        for t in range(i + 1, len(lines)):
            ln = lines[t]
            if ln and not ln[0].isspace() and not in_comment[t] and END_RE.match(ln):
                end = t
                break
        # trailing blank lines / doc of next decl excluded
        while end - 1 > i and lines[end - 1].strip() == "":
            end -= 1
        body = "\n".join(lines[i:end])
        code = strip_comments(body)
        # signature: up to first ':=' or ' where' or '\n  |' at depth 0
        sig = code
        m = re.search(r":=|\bwhere\b", code)
        if m:
            sig = code[:m.start()]
        counts = {k: len(re.findall(p, code, re.M)) for k, p in TACTICS.items()}
        decls.append({
            "kind": kind, "name": name, "line": i + 1, "lines": end - i,
            "has_doc": has_doc, "doc": doc[:400], "sig": " ".join(sig.split()), "counts": counts,
            "private": bool(re.match(ATTR + r"(?:\w+\s+)*private\b", lines[i])),
        })
    return decls


def dump(ref, paths):
    for p in paths:
        t = git_show(ref, p)
        if t is None:
            continue
        for d in parse(t):
            d["path"] = p
            d["ref"] = ref
            print(json.dumps(d, ensure_ascii=False))


SELF_TEST = '''import Mathlib

/-- documented -/
theorem foo (x : Nat) : x = x := by
  simp
  sorry

theorem bar : True := by
  have _ := 1
  nlinarith [sq_nonneg 1]
  -- simp in a comment does not count
  simp only [x]

/-- an instance -/
instance : Inhabited Nat := ⟨0⟩

axiom baz : False

@[simp] private lemma qux : 1 = 1 := by decide +kernel

/-- a docstring whose second line starts with a keyword
class of objects, not a declaration -/
theorem quux : True := trivial
'''


def self_test():
    ds = {d["name"] or d["kind"]: d for d in parse(SELF_TEST)}
    fails = []
    def want(cond, msg):
        if not cond:
            fails.append(msg)
    want(set(ds) >= {"foo", "bar", "instance", "baz", "qux"}, f"declarations found: {sorted(ds)}")
    want(ds.get("foo", {}).get("has_doc") is True, "foo's docstring missed")
    want(ds.get("bar", {}).get("has_doc") is False, "bar given a docstring it lacks")
    want(ds.get("foo", {}).get("counts", {}).get("sorry") == 1, "foo's sorry missed")
    want(ds.get("foo", {}).get("counts", {}).get("simp_bare") == 1, "foo's bare simp missed")
    want(ds.get("bar", {}).get("counts", {}).get("simp_bare") == 0, "simp only / comment counted as bare simp")
    want(ds.get("bar", {}).get("counts", {}).get("unused_have") == 1, "have _ := missed")
    want(ds.get("bar", {}).get("counts", {}).get("nlinarith") == 1, "nlinarith missed")
    want(ds.get("baz", {}).get("kind") == "axiom", "axiom missed")
    want("of" not in ds, "a docstring line read as a declaration")
    want(ds.get("quux", {}).get("has_doc") is True, "quux's two-line docstring missed")
    want(ds.get("qux", {}).get("counts", {}).get("decide") == 1, "decide missed")
    want(ds.get("qux", {}).get("private") is True, "private missed")
    want(ds.get("foo", {}).get("sig", "").endswith("x = x"), f"foo's signature: {ds.get('foo', {}).get('sig')}")
    for f in fails:
        print("FAIL", f)
    print("self-test:", "FAIL" if fails else "OK", f"({len(fails)} misses)")
    return 1 if fails else 0


def summary(jsonl_paths):
    """Per body: kinds, docstring coverage of public non-example declarations, sorry, outliers, tactic totals."""
    import collections
    for jp in jsonl_paths:
        ds = [json.loads(l) for l in open(jp)]
        kinds = collections.Counter(d["kind"] for d in ds)
        pub = [d for d in ds if d["kind"] not in ("example", "instance") and not d["private"]]
        undoc = [d for d in pub if not d["has_doc"]]
        tot = collections.Counter()
        for d in ds:
            tot.update(d["counts"])
        sorried = [d for d in ds if d["counts"]["sorry"] > 0]
        proofs = sorted((d for d in ds if d["kind"] in ("theorem", "lemma")), key=lambda d: -d["lines"])
        print(f"== {jp}: {len(ds)} declarations {dict(kinds)}")
        print(f"   public non-example: {len(pub)}, undocumented: {len(undoc)}")
        print(f"   declarations with sorry: {len(sorried)}; tactic totals: "
              + ", ".join(f"{k}={v}" for k, v in sorted(tot.items()) if v))
        lens = [d["lines"] for d in proofs]
        if lens:
            lens_s = sorted(lens)
            med = lens_s[len(lens_s) // 2]
            p90 = lens_s[int(len(lens_s) * 0.9)]
            print(f"   theorem lengths: n={len(lens)} median={med} p90={p90} max={lens_s[-1]}")
            for d in proofs[:6]:
                print(f"     {d['lines']:4d}  {d['path'].split('/')[-1]}:{d['line']}  {d['name']}")
        for d in undoc[:12]:
            print(f"   undoc: {d['path'].split('/')[-1]}:{d['line']} {d['kind']} {d['name']}")


if __name__ == "__main__":
    if len(sys.argv) >= 2 and sys.argv[1] == "--self-test":
        sys.exit(self_test())
    if len(sys.argv) >= 3 and sys.argv[1] == "summary":
        summary(sys.argv[2:])
        sys.exit(0)
    if len(sys.argv) >= 3 and sys.argv[1] == "dump":
        dump(sys.argv[2], sys.argv[3:])
        sys.exit(0)
    print(__doc__)
    sys.exit(2)
