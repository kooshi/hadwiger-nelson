#!/usr/bin/env python3
"""FS131-M5: what wave 5's own files repeat of `main` — by name, and by statement under another name.

`tools/fs131_ml_dupes.py` (FS131-ML1, read-only here) finds names only, through QA1's textual `qualified_decls`, which reads a
docstring line beginning "class near …" as a `class` declaration. This tool strips comments and docstrings first (nested `/- -/`,
`--`), tracks `namespace`/`section`/`end`, and reports, for every declaration in a file the branch changed since the fork:

  NAME       a fully qualified name `main` declares in a different file (a collision when both reach one environment);
  STATEMENT  a theorem whose statement (the text after its name up to the first `:=`, binder names alpha-normalized, whitespace
             normalized) `main` holds under another name, for a name of `main`'s that is new since the fork (a copy wave 5 made of a
             lemma it could not see);
  STATEMENT-OLD (informational) the same against a `main` name already declared at the fork (a repeat the merge does not create);
  PRIVATE    (informational) a `private` own theorem repeating a `main` statement: module-local, its name mangled, so no collision;
  CONCL      (informational, never a failure) a theorem whose conclusion (the text after the last depth-0 ` : ` before `:=`, of at
             least 30 characters) `main` holds for some theorem of another name — candidates for an identical-in-effect copy that
             differs only in binders, to be read by hand.

Usage: fs131_m5_dupes.py [<branch rev|WT> <main ref> <fork ref>]   (defaults: WT origin/main 111830c8; WT = the working tree)
       fs131_m5_dupes.py --plant [...]   adds three synthetic own files: `main`'s `ArcMap.exists_shave_aux` re-declared (NAME), `main`'s
       `isPreconnected_hornSet` statement under a new name (STATEMENT), and a docstring line "class foo" (must NOT be reported);
       must report exactly the first two, exit 1
A declaration of an own file whose qualified name the fork already declares is inherited, not own, and is skipped.
Exit 1 on any NAME or STATEMENT pair.
"""
import collections
import pathlib
import re
import subprocess
import sys

KW = r"(?:theorem|lemma|def|abbrev|structure|inductive|class|instance|opaque|axiom)"
DECL = re.compile(r"^(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|partial|unsafe|nonrec)\s+)*" + KW +
                  r"\s+([^\s:({\[⦃]+)", re.M)


def git(*a):
    return subprocess.run(["git", *a], capture_output=True, text=True, check=True).stdout


def strip_comments(t):
    """Replace comments and docstrings by spaces (newlines kept, so line numbers survive)."""
    out, i, n, depth = [], 0, len(t), 0
    while i < n:
        if t.startswith("/-", i):
            depth += 1
            out.append("  ")
            i += 2
            continue
        if depth and t.startswith("-/", i):
            depth -= 1
            out.append("  ")
            i += 2
            continue
        if depth:
            out.append("\n" if t[i] == "\n" else " ")
            i += 1
            continue
        if t.startswith("--", i):
            j = t.find("\n", i)
            j = n if j < 0 else j
            out.append(" " * (j - i))
            i = j
            continue
        if t[i] == '"':  # string literal: copy through
            j = i + 1
            while j < n and t[j] != '"':
                j += 2 if t[j] == "\\" else 1
            out.append(t[i:j + 1])
            i = j + 1
            continue
        out.append(t[i])
        i += 1
    return "".join(out)


def decls(text):
    """(qualified name, kind, statement text up to the first `:=`, 1-based line) for every declaration."""
    s = strip_comments(text)
    lines = s.split("\n")
    offs, o = [], 0
    for ln in lines:
        offs.append(o)
        o += len(ln) + 1
    stack = []  # entries: ("ns", [parts]) or ("sec", name)
    events = []
    for m in re.finditer(r"^(namespace|section|end)\b[ \t]*([^\s]*)", s, re.M):
        events.append((m.start(), m.group(1), m.group(2)))
    for m in DECL.finditer(s):
        events.append((m.start(), "decl", m))
    events.sort(key=lambda e: e[0])
    res = []
    for pos, kind, arg in events:
        if kind == "namespace":
            stack.append(("ns", arg.split(".")))
        elif kind == "section":
            stack.append(("sec", arg))
        elif kind == "end":
            if stack:
                stack.pop()
        else:
            m = arg
            name = m.group(1)
            kw = re.search(KW, m.group(0)).group(0)
            if name.startswith("_root_."):
                q = name[len("_root_."):]
            else:
                pre = [p for k, ps in stack if k == "ns" for p in ps]
                q = ".".join(pre + [name])
            rest = s[m.end():]
            j = rest.find(":=")
            k2 = re.search(r"\n\s*\n", rest)
            cut = j if j >= 0 else len(rest)
            if k2 and k2.start() < cut and kw not in ("structure", "inductive", "class"):
                cut = k2.start()
            stmt = rest[:cut]
            line = s.count("\n", 0, pos) + 1
            priv = bool(re.search(r"\bprivate\s", m.group(0)))
            res.append((q, kw, stmt, line, priv))
    return res


BINDER = re.compile(r"[({\[⦃]\s*([^:(){}\[\]⦃⦄]+?)\s*:")


def alpha(stmt):
    """Whitespace-normalize and rename binder names (in order of binding) to b0, b1, ..."""
    names = []
    for m in BINDER.finditer(stmt):
        for v in m.group(1).split():
            if re.fullmatch(r"[^\s]+", v) and v not in names:
                names.append(v)
    t = " ".join(stmt.split())
    for i, v in enumerate(names):
        t = re.sub(r"(?<![\w'.₀-₉])" + re.escape(v) + r"(?![\w'₀-₉])", f"b{i}", t)
    return t


def conclusion(stmt):
    depth, last = 0, -1
    for i, ch in enumerate(stmt):
        if ch in "([{⦃⟨":
            depth += 1
        elif ch in ")]}⦄⟩":
            depth -= 1
        elif ch == ":" and depth == 0 and (i + 1 >= len(stmt) or stmt[i + 1] != "="):
            last = i
    return " ".join(stmt[last + 1:].split()) if last >= 0 else None


def read(rev, path):
    if rev == "WT":
        return pathlib.Path(path).read_text()
    return git("show", f"{rev}:{path}")


def run(branch, main, fork, plant=False):
    if branch == "WT":
        own = [p for p in git("diff", "--name-only", fork, "--", "Proofs").split() if p.endswith(".lean")]
        own = [p for p in own if pathlib.Path(p).exists()]
    else:
        own = [p for p in git("diff", "--name-only", fork, branch, "--", "Proofs").split() if p.endswith(".lean")]
    mainfiles = [p for p in git("ls-tree", "-r", "--name-only", main, "Proofs").split() if p.endswith(".lean")]
    # a file both sides changed (or that git took from main) counts as main's when its text equals main's
    ours = []
    for p in own:
        t = read(branch, p)
        if p in mainfiles and t == git("show", f"{main}:{p}"):
            continue
        ours.append((p, t))
    if plant:
        sv = git("show", f"{main}:Proofs/HadwigerNelson/Plane/ValidMap/Surgery.lean")
        hs = re.search(r"^theorem isPreconnected_hornSet\b(.*?):=", sv, re.S | re.M).group(1)
        ours += [("PLANTED-NAME.lean", "namespace HadwigerNelson.Plane\nnamespace ArcMap\n"
                  "theorem exists_shave_aux : True := trivial\nend ArcMap\nend HadwigerNelson.Plane\n"),
                 ("PLANTED-STATEMENT.lean", "namespace HadwigerNelson.Plane\nnamespace ArcMap\n"
                  "theorem planted_hornSet_copy" + hs + ":= by\n  sorry\nend ArcMap\nend HadwigerNelson.Plane\n"),
                 ("PLANTED-DOC.lean", "namespace HadwigerNelson.Plane\n/-- A docstring whose line begins\nclass e_mul_e_neg\n-/\n"
                  "theorem planted_doc_ok : True := trivial\nend HadwigerNelson.Plane\n")]
    forkfiles = [p for p in git("ls-tree", "-r", "--name-only", fork, "Proofs").split() if p.endswith(".lean")]
    atfork = {q for p in forkfiles for q, _, _, _, _ in decls(git("show", f"{fork}:{p}"))}
    byname, bystmt, byconcl = collections.defaultdict(list), collections.defaultdict(list), collections.defaultdict(list)
    for p in mainfiles:
        for q, kw, st, ln, priv in decls(git("show", f"{main}:{p}")):
            if priv:
                continue
            byname[q].append((p, ln, kw))
            if kw in ("theorem", "lemma"):
                bystmt[alpha(st)].append((q, p, ln))
                c = conclusion(st)
                if c and len(c) >= 30:
                    byconcl[c].append((q, p, ln))
    bad, ndecl, concl, old = 0, 0, [], []
    for p, t in ours:
        for q, kw, st, ln, priv in decls(t):
            if q in atfork:
                continue
            ndecl += 1
            if priv:
                for (qm, pm, lm) in bystmt.get(alpha(st), []) if kw in ("theorem", "lemma") else []:
                    old.append(f"PRIVATE {q} ({p}:{ln}) repeats main's {qm} ({pm}:{lm}), module-local (no collision)")
                continue
            for (pm, lm, km) in byname.get(q, []):
                if pm != p:
                    bad += 1
                    print(f"NAME {q}  ours {p}:{ln}  main {pm}:{lm}")
            if kw in ("theorem", "lemma"):
                for (qm, pm, lm) in bystmt.get(alpha(st), []):
                    if qm != q and qm not in atfork:
                        bad += 1
                        print(f"STATEMENT {q} ({p}:{ln}) = main's {qm} ({pm}:{lm})")
                    elif qm != q:
                        old.append(f"STATEMENT-OLD {q} ({p}:{ln}) = main's {qm} ({pm}:{lm}), declared at the fork")
                c = conclusion(st)
                if c and len(c) >= 30:
                    for (qm, pm, lm) in byconcl.get(c, []):
                        if qm != q:
                            concl.append(f"CONCL {q} ({p}:{ln}) ~ main's {qm} ({pm}:{lm}): {c[:120]}")
    for line in old + concl:
        print(line)
    print(f"own files {len(ours)}; {ndecl} own declarations; {len(byname)} names at {main}; "
          f"{bad} NAME/STATEMENT pair(s); {len(old)} STATEMENT-OLD/PRIVATE; {len(concl)} CONCL candidate(s)")
    return 1 if bad else 0


if __name__ == "__main__":
    a = [x for x in sys.argv[1:] if x != "--plant"]
    refs = a if a else ["WT", "origin/main", "111830c8"]
    sys.exit(run(*refs, plant="--plant" in sys.argv))
