#!/usr/bin/env python3
"""FS131-LT5: show that an edit under `Proofs/` changed docstrings and nothing else — by two instruments.

The landing edits docstrings (`/-- … -/`) and module docs (`/-! … -/`) in modules it may not otherwise touch:
no statement, definition or proof may move. A statement is two things (FS131-I7A), so there are two checks.

1. TEXT (`text BASE`). For every file under `Proofs/` that differs between the commit BASE and the working
   tree: both texts are cut into code, line comments, plain block comments, string literals and doc comments by
   a lexer that knows Lean's nesting block comments; every doc comment is replaced by a fixed placeholder; and
   the two results must be byte-identical. So the diff lies inside doc comments, none was added or removed, and
   none grew over code. Each changed doc comment is listed with the declaration that follows it. A file added,
   deleted or renamed under `Proofs/` fails.
2. ELABORATED (`dump OUT MODULE…`, then `compare BEFORE AFTER`). Independent of the lexer: for every constant
   of the named modules, from the built library, the kernel's stored type (its hash, and the length and hash of
   its full debug text), its kind, its universe parameters, and a definition's value hash
   (`tools/fs131_lt5_sigdump.lean.in`). Taken before the edit and after the rebuild, the two dumps must agree on
   every constant: none missing, none added, none changed.

    tools/fs131_lt5_docstring_check.py text BASE
    tools/fs131_lt5_docstring_check.py dump OUT MODULE [MODULE …]     (elaborates `import Proofs`: run under the slot)
    tools/fs131_lt5_docstring_check.py compare BEFORE AFTER
    tools/fs131_lt5_docstring_check.py --self-test

`--self-test` plants faults and watches each fire, with partners that must pass. TEXT, in memory: a docstring
reworded and a module doc reworded pass (and are counted); a character of a statement, of a `--` comment and of
a plain block comment each fail; a docstring whose terminator is deleted so that it swallows the declaration
below fails; a docstring added where there was none fails; a docstring holding a nested comment beside code
holding `"--"` in a string is lexed as one comment. ELABORATED, on a planted file elaborated five times: a
docstring reworded gives an identical dump; a binder's type changed, a definition's value changed and a theorem
removed are each reported by name; and a dump with its `COUNT` line cut is refused.
"""
from __future__ import annotations

import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TEMPLATE = ROOT / "tools" / "fs131_lt5_sigdump.lean.in"
PLACE = {"doc": "/--⟪doc⟫-/", "moddoc": "/-!⟪doc⟫-/"}


class LexError(Exception):
    pass


def segments(text: str) -> list[tuple[str, int, int]]:
    """(kind, start, end) covering the text: code (string literals inside it), line, block, doc, moddoc."""
    out: list[tuple[str, int, int]] = []
    i, n, code_start = 0, len(text), 0

    def flush(j: int) -> None:
        if j > code_start:
            out.append(("code", code_start, j))

    while i < n:
        two = text[i:i + 2]
        c = text[i]
        if two == "--":
            j = text.find("\n", i)
            j = n if j < 0 else j
            flush(i)
            out.append(("line", i, j))
            i = code_start = j
        elif two == "/-":
            depth, j = 1, i + 2
            while j < n and depth > 0:
                t = text[j:j + 2]
                if t == "/-":
                    depth, j = depth + 1, j + 2
                elif t == "-/":
                    depth, j = depth - 1, j + 2
                else:
                    j += 1
            if depth != 0:
                raise LexError(f"unterminated block comment opened at line {text.count(chr(10), 0, i) + 1}")
            head = text[i:i + 3]
            kind = "doc" if head == "/--" else "moddoc" if head == "/-!" else "block"
            flush(i)
            out.append((kind, i, j))
            i = code_start = j
        elif c == '"':
            j = i + 1
            while j < n and text[j] != '"':
                j += 2 if text[j] == "\\" else 1
            i = min(j + 1, n)
        elif c == "'" and i + 2 < n and text[i + 2] == "'" and text[i + 1] != "\\":
            i += 3
        elif c == "'" and i + 3 < n and text[i + 1] == "\\" and text[i + 3] == "'":
            i += 4
        else:
            i += 1
    flush(n)
    return out


def strip_docs(text: str) -> tuple[str, list[tuple[str, int, str, str]]]:
    """The text with every doc comment replaced by a placeholder, and the doc comments: (kind, line, body,
    the first line of what follows)."""
    parts, docs = [], []
    for kind, a, b in segments(text):
        if kind in PLACE:
            parts.append(PLACE[kind])
            follows = text[b:].lstrip("\n").split("\n", 1)[0].strip()
            docs.append((kind, text.count("\n", 0, a) + 1, text[a:b], follows))
        else:
            parts.append(text[a:b])
    return "".join(parts), docs


def text_pair(old: str, new: str) -> tuple[bool, list[str]]:
    """(ok, report lines) for one file's base text and tree text."""
    try:
        so, do = strip_docs(old)
        sn, dn = strip_docs(new)
    except LexError as e:
        return False, [f"LEX ERROR: {e}"]
    if so != sn:
        k = next((i for i, (x, y) in enumerate(zip(so, sn)) if x != y), min(len(so), len(sn)))
        line = so.count("\n", 0, k) + 1
        return False, [f"TEXT OUTSIDE A DOC COMMENT DIFFERS near line {line} of the base's stripped text "
                       f"({len(do)} doc comments in the base, {len(dn)} in the tree):",
                       f"    base: …{so[max(0, k - 60):k + 80]!r}",
                       f"    tree: …{sn[max(0, k - 60):k + 80]!r}"]
    lines = []
    for (kind, lo, bo, _), (_, ln, bn, follows) in zip(do, dn):
        if bo != bn:
            what = "module doc" if kind == "moddoc" else f"docstring of: {follows[:110]}"
            lines.append(f"    doc comment changed, l.{ln} (base l.{lo}) — {what}")
    return True, lines


def git(*args: str) -> str:
    return subprocess.run(["git", *args], capture_output=True, text=True, check=True, cwd=ROOT).stdout


def text_check(base: str) -> int:
    status = git("diff", "--name-status", "--no-renames", base, "--", "Proofs")
    rows = [r.split("\t") for r in status.splitlines() if r.strip()]
    bad = changed_docs = 0
    for st, path in rows:
        if st != "M":
            print(f"FAIL  {path}: status {st} — a file added or deleted under Proofs/ is not a docstring edit")
            bad += 1
            continue
        ok, lines = text_pair(git("show", f"{base}:{path}"), (ROOT / path).read_text(encoding="utf-8"))
        if ok and not lines:
            print(f"FAIL  {path}: git reports a change and no doc comment differs — the lexer and git disagree")
            bad += 1
        elif ok:
            print(f"ok    {path}: {len(lines)} doc comment(s) changed, nothing else")
            changed_docs += len(lines)
        else:
            print(f"FAIL  {path}")
            bad += 1
        for ln in lines:
            print(ln)
    print(f"text: files={len(rows)} doc-comments-changed={changed_docs} failed={bad} (base {base})")
    if not rows:
        print("text: no file under Proofs/ differs from the base — nothing was checked")
        return 1
    return 1 if bad else 0


# ---------------------------------------------------------------------------------------------- the dump

def run_dump(header: str, call: str, cwd: Path) -> tuple[int, str, str]:
    with tempfile.TemporaryDirectory() as d:
        f = Path(d) / "Fs131Lt5Dump.lean"
        f.write_text(header + "\n" + TEMPLATE.read_text(encoding="utf-8") + "\n" + call + "\n", encoding="utf-8")
        p = subprocess.run(["lake", "env", "lean", str(f)], capture_output=True, text=True, cwd=cwd)
    return p.returncode, p.stdout, p.stderr


def parse_dump(text: str) -> dict[str, tuple[str, ...]]:
    """name -> fields. Raises if the dump is not whole."""
    sigs: dict[str, tuple[str, ...]] = {}
    count = None
    for line in text.splitlines():
        if line.startswith("SIG\t"):
            f = line.split("\t")
            if len(f) != 8:
                raise ValueError(f"a SIG row with {len(f)} fields, not 8: {line[:120]}")
            if f[2] in sigs:
                raise ValueError(f"the constant {f[2]} is dumped twice")
            sigs[f[2]] = tuple(f[1:2] + f[3:])
        elif line.startswith("COUNT "):
            count = int(line.split()[1])
    if count is None:
        raise ValueError("no COUNT line: the dump did not reach its end")
    if count != len(sigs) or count == 0:
        raise ValueError(f"COUNT says {count} and {len(sigs)} SIG rows were read")
    return sigs


def dump(out: Path, modules: list[str]) -> int:
    rc, so, se = run_dump("import Proofs", "#fs131_lt5_dump " + " ".join(modules), ROOT)
    if rc != 0:
        print(f"dump: FAIL — lean exited {rc}\n{se[:2000]}\n{so[-2000:]}")
        return 1
    try:
        sigs = parse_dump(so)
    except ValueError as e:
        print(f"dump: FAIL — {e}")
        return 1
    out.write_text(so, encoding="utf-8")
    per: dict[str, int] = {}
    for f in sigs.values():
        per[f[0]] = per.get(f[0], 0) + 1
    for m in modules:
        print(f"    {m}: {per.get(m, 0)} constants")
        if per.get(m, 0) == 0:
            print(f"dump: FAIL — no constant read from {m}")
            return 1
    print(f"dump: {len(sigs)} constants of {len(modules)} modules written to {out}")
    return 0


def compare_texts(a: str, b: str) -> tuple[int, list[str]]:
    try:
        A, B = parse_dump(a), parse_dump(b)
    except ValueError as e:
        return 1, [f"compare: FAIL — {e}"]
    lines = []
    missing = sorted(set(A) - set(B))
    added = sorted(set(B) - set(A))
    changed = sorted(n for n in set(A) & set(B) if A[n] != B[n])
    for n in missing:
        lines.append(f"MISSING  {n} ({A[n][1]})")
    for n in added:
        lines.append(f"ADDED    {n} ({B[n][1]})")
    for n in changed:
        fields = ["module", "kind", "level params", "type hash", "type text", "value hash"]
        which = [fields[i] for i in range(6) if A[n][i] != B[n][i]]
        lines.append(f"CHANGED  {n} ({A[n][1]}): {', '.join(which)}")
    nthm = sum(1 for f in A.values() if f[1] == "theorem")
    lines.append(f"compare: before={len(A)} after={len(B)} (theorems before={nthm}) missing={len(missing)} "
                 f"added={len(added)} changed={len(changed)}")
    return (1 if missing or added or changed else 0), lines


# ----------------------------------------------------------------------------------------- the self-test

BASE_TEXT = '''/-!
# A planted module
-/
namespace planted

/-- The value. It says "see /- the nested -/ note". -/
def val : Nat := 1

-- a line comment
/- a plain block comment -/
/-- A lemma. -/
theorem thm (n : Nat) (h : n = n) : n + 0 = n := rfl

def str : String := "-- not a comment /- nor this"

theorem bare (n : Nat) : n = n := rfl

end planted
'''


def self_test() -> int:
    fails = 0

    def expect(label: str, got: bool, want: bool, detail: str = "") -> None:
        nonlocal fails
        good = got == want
        print(f"    {'ok  ' if good else 'FAIL'}  {label}" + (f" — {detail}" if detail and not good else ""))
        fails += 0 if good else 1

    # TEXT
    def t(label: str, new: str, want_ok: bool, want_docs: int | None = None) -> None:
        ok, lines = text_pair(BASE_TEXT, new)
        good = ok == want_ok and (want_docs is None or (ok and len(lines) == want_docs))
        expect(f"text: {label} — {'passes' if want_ok else 'fails'}", good, True, f"got ok={ok}, {lines}")

    t("a docstring reworded", BASE_TEXT.replace("/-- A lemma. -/", "/-- A lemma, reworded. -/"), True, 1)
    t("a module doc reworded", BASE_TEXT.replace("# A planted module", "# A planted module, renamed"), True, 1)
    t("a docstring holding a nested comment reworded", BASE_TEXT.replace("The value.", "The value, again."), True, 1)
    t("a character of a statement changed", BASE_TEXT.replace("(h : n = n) : n + 0 = n", "(h : n = n) : n + 0 = 0 + n"), False)
    t("a `--` comment changed", BASE_TEXT.replace("-- a line comment", "-- a line comment, changed"), False)
    t("a plain block comment changed", BASE_TEXT.replace("a plain block comment", "a plain block comment!"), False)
    t("a docstring's terminator deleted, so that it swallows the theorem below",
      BASE_TEXT.replace("/-- A lemma. -/\ntheorem thm", "/-- A lemma.\ntheorem thm").replace(
          'def str : String := "-- not a comment /- nor this"', "-/"), False)
    t("a docstring added where there was none", BASE_TEXT.replace("theorem bare", "/-- New. -/\ntheorem bare"), False)
    t("the text inside a string literal changed", BASE_TEXT.replace("-- not a comment", "-- not  a comment"), False)
    t("nothing changed (zero doc comments differ)", BASE_TEXT, True, 0)
    segs = [k for k, _, _ in segments(BASE_TEXT)]
    expect("text: the planted module is lexed as 1 module doc, 2 docstrings, 1 line comment, 1 block comment",
           (segs.count("moddoc"), segs.count("doc"), segs.count("line"), segs.count("block")) == (1, 2, 1, 1), True, str(segs))

    # ELABORATED
    variants = {
        "A": BASE_TEXT,
        "B": BASE_TEXT.replace("/-- A lemma. -/", "/-- A lemma, reworded. -/"),
        "C": BASE_TEXT.replace("(h : n = n) : n + 0 = n", "(h : n + 0 = n) : n + 0 = n"),
        "D": BASE_TEXT.replace("def val : Nat := 1", "def val : Nat := 2"),
        "E": BASE_TEXT.replace("theorem bare (n : Nat) : n = n := rfl\n", ""),
    }
    dumps = {}
    for k, body in variants.items():
        rc, so, se = run_dump("import Lean\n" + body, "#fs131_lt5_dump", ROOT)
        if rc != 0:
            print(f"    FAIL  dump: variant {k} did not elaborate: {se[:300]} {so[-300:]}")
            fails += 1
        dumps[k] = so
    if len(dumps) == 5 and all(dumps.values()):
        def c(label: str, k: str, want_rc: int, must: str) -> None:
            rc, lines = compare_texts(dumps["A"], dumps[k])
            good = rc == want_rc and any(must in ln for ln in lines)
            expect(f"dump: {label}", good, True, f"got rc={rc}, {lines}")
        c("a docstring reworded — identical dump", "B", 0, "missing=0 added=0 changed=0")
        c("a binder's type changed — CHANGED planted.thm, its type", "C", 1, "CHANGED  planted.thm (theorem): type hash, type text")
        c("a definition's value changed — CHANGED planted.val, its value", "D", 1, "CHANGED  planted.val (def): value hash")
        c("a theorem removed — MISSING planted.bare", "E", 1, "MISSING  planted.bare (theorem)")
        cut = "\n".join(ln for ln in dumps["B"].splitlines() if not ln.startswith("COUNT "))
        rc, lines = compare_texts(dumps["A"], cut)
        expect("dump: a dump with its COUNT line cut is refused", rc == 1 and "no COUNT line" in lines[0], True, str(lines))
        expect("dump: the planted file's constants are read (val, thm, str, bare among them)",
               all(f"\tplanted.{n}\t" in dumps["A"] for n in ("val", "thm", "str", "bare")), True)
    print("self-test: " + ("OK — every planted fault fired and every partner passed" if fails == 0
                           else f"FAIL — {fails} check(s) did not behave"))
    return 0 if fails == 0 else 1


def main(argv: list[str]) -> int:
    if len(argv) == 2 and argv[1] == "--self-test":
        return self_test()
    if len(argv) == 3 and argv[1] == "text":
        return text_check(argv[2])
    if len(argv) >= 4 and argv[1] == "dump":
        return dump(Path(argv[2]), argv[3:])
    if len(argv) == 4 and argv[1] == "compare":
        rc, lines = compare_texts(Path(argv[2]).read_text(encoding="utf-8"), Path(argv[3]).read_text(encoding="utf-8"))
        print("\n".join(lines))
        print("compare: " + ("IDENTICAL — every constant's stored type, kind, universe parameters and value hash agree"
                             if rc == 0 else "DIFFERENT"))
        return rc
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
