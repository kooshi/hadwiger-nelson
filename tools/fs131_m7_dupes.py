#!/usr/bin/env python3
"""FS131-M7: what one side of a merge repeats of the other — by name, by statement, by statement up to qualifiers — and, in the
joined tree, which names stand twice and which statements stand under two names.

A copy of FS131-IA1's `tools/fs131_ia_dupes.py` (itself FS131-IR1's, FS131-M6's, FS131-M5's) under this job's prefix (standing
rule 7 bars editing another job's tool). The parsing core (`strip_comments`, `decls`, `groups`, `used_vars`, `alpha`, `norm`,
`conclusion`, `read`) is copied byte for byte. Changed:

  * `--plant` chooses its target from the refs it is given — the first public theorem that is new at <main ref> since <fork ref>,
    has an implicit binder `{x : T}`, and whose statement is carried by one name only — so it fires on any merge (IA1's plants name
    `Pushforward`'s lemmas, which are not new at this job's refs). It adds four synthetic own files: the target's name re-declared
    (NAME); its statement under a new name (STATEMENT); the same with the implicit binder made explicit, under the section variables
    it uses (STATEMENT-NORM); and a docstring line "class <name>" (must NOT be reported). It exits 0 iff exactly those three pairs
    are reported beyond the unplanted run's and the docstring line is not; it raises if no target exists.
  * `--whole <dir> <fork ref>` reads every Lean file of the WORKING TREE under <dir> and reports
      NAME-TWICE       a public qualified name declared at two places (a failure: exit 1);
      STATEMENT-TWICE  a theorem statement (with the section variables it uses, binder names alpha-normalized) carried by two
                       public names, at least one of them not declared at <fork ref> (informational);
      NORM-TWICE       the same up to namespace qualifiers and binder bracket kinds, when not already STATEMENT-TWICE
                       (informational).
    `--whole --plant` appends a synthetic file re-declaring the first public theorem of <dir> under its own name and under a new
    one, and requires one NAME-TWICE and one STATEMENT-TWICE more than the unplanted run.

Usage: fs131_m7_dupes.py [--plant] <branch rev|WT> <main ref> <fork ref>     exit 1 on any NAME or STATEMENT pair
       fs131_m7_dupes.py --whole [--plant] <dir> <fork ref>

The pairwise classes (unchanged from the earlier copies): NAME — a fully qualified name <main ref> declares in a different file;
STATEMENT — a theorem whose statement <main ref> holds under another name that is new since the fork; STATEMENT-NORM — the same up
to qualifiers and binder brackets; STATEMENT-OLD, PRIVATE, CONCL — informational. A declaration of an own file whose qualified name
the fork already declares is inherited, not own, and is skipped.
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
    for m in re.finditer(r"^variable\b((?:[^\n]*)(?:\n[ \t]+[({\[⦃][^\n]*)*)", s, re.M):
        events.append((m.start(), "variable", m.group(1)))
    for m in DECL.finditer(s):
        events.append((m.start(), "decl", m))
    events.sort(key=lambda e: e[0])
    res = []
    varstack = [[]]  # the `variable` binder groups of each open scope (index 0: the file's top level)
    for pos, kind, arg in events:
        if kind == "namespace":
            stack.append(("ns", arg.split(".")))
            varstack.append([])
        elif kind == "section":
            stack.append(("sec", arg))
            varstack.append([])
        elif kind == "end":
            if stack:
                stack.pop()
            if len(varstack) > 1:
                varstack.pop()
        elif kind == "variable":
            varstack[-1].extend(groups(arg))
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
            res.append((q, kw, stmt, line, priv, used_vars([g for fr in varstack for g in fr], stmt) + stmt))
    return res


def groups(text):
    """The top-level binder groups `(…)`, `{…}`, `[…]`, `⦃…⦄` of a `variable` command's text."""
    out, depth, start = [], 0, None
    opens, closes = "({[⦃", ")}]⦄"
    for i, ch in enumerate(text):
        if ch in opens:
            if depth == 0:
                start = i
            depth += 1
        elif ch in closes:
            depth -= 1
            if depth == 0 and start is not None:
                out.append(text[start:i + 1])
                start = None
    return out


def used_vars(gs, stmt):
    """The section-variable groups a statement uses, as Lean includes them: a group whose bound name occurs in the statement, and
    transitively a group bound in an included group's type; an instance group `[…]` when a name it mentions is included."""
    tok = lambda s: set(re.findall(r"[^\s()\[\]{}⦃⦄:,.]+", s))
    def names(g):
        if g[0] == "[" or ":" not in g:
            return set()
        return set(g[1:g.index(":")].split())
    inc, need = set(), tok(stmt)
    changed = True
    while changed:
        changed = False
        for i, g in enumerate(gs):
            if i in inc:
                continue
            ns = names(g)
            if (ns and ns & need) or (not ns and g[0] == "[" and tok(g[1:-1]) & {n for j in inc for n in names(gs[j])}):
                inc.add(i)
                need |= tok(g)
                changed = True
    return "".join(gs[i] + " " for i in sorted(inc))


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


QUAL = re.compile(r"(?<![\w'.₀-₉])(?:[A-Za-z_][\w'₀-₉]*\.)+(?=[A-Za-z_])")


def norm(stmt):
    """alpha, then delete namespace qualifiers and binder bracket kinds."""
    t = alpha(stmt)
    t = QUAL.sub("", t)
    t = re.sub(r"[{⦃]", "(", t)
    t = re.sub(r"[}⦄]", ")", t)
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



def pick_target(main, fork):
    """The first public theorem new at `main` since `fork` with an implicit binder and a statement no other name carries."""
    forkfiles = [p for p in git("ls-tree", "-r", "--name-only", fork, "Proofs").split() if p.endswith(".lean")]
    atfork = {q for p in forkfiles for q, _, _, _, _, _ in decls(git("show", f"{fork}:{p}"))}
    mainfiles = [p for p in git("ls-tree", "-r", "--name-only", main, "Proofs").split() if p.endswith(".lean")]
    cnt_a, cnt_n = collections.Counter(), collections.Counter()
    alld = []
    for p in mainfiles:
        for q, kw, st, ln, priv, stv in decls(git("show", f"{main}:{p}")):
            if priv or kw not in ("theorem", "lemma"):
                continue
            cnt_a[alpha(st)] += 1
            cnt_n[norm(stv)] += 1
            alld.append((p, q, st, stv))
    changed = set(git("diff", "--name-only", fork, main, "--", "Proofs").split())
    for p, q, st, stv in alld:
        if p in changed and q not in atfork and re.search(r"\{[^{}:]+ : [^{}]+\}", st) and len(st) >= 40 \
                and cnt_a[alpha(st)] == 1 and cnt_n[norm(stv)] == 1:
            return p, q, st, stv
    raise SystemExit(f"PLANT TARGET ABSENT: no suitable theorem new at {main} since {fork}")


def plant_files(target):
    p, q, st, stv = target
    ns, short = q.rsplit(".", 1) if "." in q else ("", q)
    op = f"namespace {ns}\n" if ns else ""
    cl = f"end {ns}\n" if ns else ""
    varline = stv[:len(stv) - len(st)].strip()
    varline = f"variable {varline}\n" if varline else ""
    m = re.search(r"\{([^{}:]+ : [^{}]+)\}", st)
    st_norm = st[:m.start()] + "(" + m.group(1) + ")" + st[m.end():]
    return [("PLANTED-NAME.lean", f"{op}theorem {short} : True := trivial\n{cl}"),
            ("PLANTED-STATEMENT.lean", f"{op}theorem planted_statement_copy{st}:= by\n  sorry\n{cl}"),
            ("PLANTED-DOC.lean", f"{op}/-- A docstring whose line begins\nclass {short}\n-/\ntheorem planted_doc_ok : True := trivial\n{cl}"),
            ("PLANTED-NORM.lean", f"{op}{varline}theorem planted_norm_copy{st_norm}:= by\n  sorry\n{cl}")]


def run(branch, main, fork, extra=()):
    """Returns the list of failure lines (NAME, STATEMENT, STATEMENT-NORM) and prints the report."""
    if branch == "WT":
        own = [p for p in git("diff", "--name-only", fork, "--", "Proofs").split() if p.endswith(".lean")]
        own = [p for p in own if pathlib.Path(p).exists()]
    else:
        own = [p for p in git("diff", "--name-only", fork, branch, "--", "Proofs").split() if p.endswith(".lean")]
        have = set(git("ls-tree", "-r", "--name-only", branch, "Proofs").split())
        own = [p for p in own if p in have]
    mainfiles = [p for p in git("ls-tree", "-r", "--name-only", main, "Proofs").split() if p.endswith(".lean")]
    # a file both sides changed (or that git took from main) counts as main's when its text equals main's
    ours = []
    for p in own:
        t = read(branch, p)
        if p in mainfiles and t == git("show", f"{main}:{p}"):
            continue
        ours.append((p, t))
    ours += list(extra)
    forkfiles = [p for p in git("ls-tree", "-r", "--name-only", fork, "Proofs").split() if p.endswith(".lean")]
    atfork = {q for p in forkfiles for q, _, _, _, _, _ in decls(git("show", f"{fork}:{p}"))}
    byname, bystmt, byconcl = collections.defaultdict(list), collections.defaultdict(list), collections.defaultdict(list)
    bynorm = collections.defaultdict(list)
    for p in mainfiles:
        for q, kw, st, ln, priv, stv in decls(git("show", f"{main}:{p}")):
            if priv:
                continue
            byname[q].append((p, ln, kw))
            if kw in ("theorem", "lemma"):
                bystmt[alpha(st)].append((q, p, ln))
                bynorm[norm(stv)].append((q, p, ln))
                c = conclusion(st)
                if c and len(c) >= 30:
                    byconcl[c].append((q, p, ln))
    fails, ndecl, concl, old = [], 0, [], []
    for p, t in ours:
        for q, kw, st, ln, priv, stv in decls(t):
            if q in atfork:
                continue
            ndecl += 1
            if priv:
                for (qm, pm, lm) in bystmt.get(alpha(st), []) if kw in ("theorem", "lemma") else []:
                    old.append(f"PRIVATE {q} ({p}:{ln}) repeats main's {qm} ({pm}:{lm}), module-local (no collision)")
                continue
            for (pm, lm, km) in byname.get(q, []):
                if pm != p:
                    fails.append(f"NAME {q}  ours {p}:{ln}  main {pm}:{lm}")
            if kw in ("theorem", "lemma"):
                for (qm, pm, lm) in bystmt.get(alpha(st), []):
                    if qm != q and qm not in atfork:
                        fails.append(f"STATEMENT {q} ({p}:{ln}) = main's {qm} ({pm}:{lm})")
                    elif qm != q:
                        old.append(f"STATEMENT-OLD {q} ({p}:{ln}) = main's {qm} ({pm}:{lm}), declared at the fork")
                exact = {qm for (qm, _, _) in bystmt.get(alpha(st), [])}
                for (qm, pm, lm) in bynorm.get(norm(stv), []):
                    if qm == q or qm in exact or qm.split(".")[-1] == q.split(".")[-1] and pm == p:
                        continue
                    if qm not in atfork:
                        fails.append(f"STATEMENT-NORM {q} ({p}:{ln}) = main's {qm} ({pm}:{lm}) up to qualifiers and binder brackets")
                    else:
                        old.append(f"STATEMENT-NORM-OLD {q} ({p}:{ln}) = main's {qm} ({pm}:{lm}) up to qualifiers, declared at the fork")
                c = conclusion(st)
                if c and len(c) >= 30:
                    for (qm, pm, lm) in byconcl.get(c, []):
                        if qm != q:
                            concl.append(f"CONCL {q} ({p}:{ln}) ~ main's {qm} ({pm}:{lm}): {c[:120]}")
    for line in fails + old + concl:
        print(line)
    if not ours or not byname:
        print("READ NOTHING: no own file or no name at the other ref")
        fails.append("READ NOTHING")
    print(f"own files {len(ours)}; {ndecl} own declarations; {len(byname)} names at {main}; "
          f"{len(fails)} NAME/STATEMENT pair(s); {len(old)} STATEMENT-OLD/PRIVATE; {len(concl)} CONCL candidate(s)")
    return fails


def whole(root, fork, extra=()):
    """Returns (NAME-TWICE lines, STATEMENT-TWICE lines, NORM-TWICE lines) for the working tree under `root`."""
    files = sorted(str(p) for p in pathlib.Path(root).rglob("*.lean"))
    forkfiles = [p for p in git("ls-tree", "-r", "--name-only", fork, root).split() if p.endswith(".lean")]
    atfork = {q for p in forkfiles for q, _, _, _, _, _ in decls(git("show", f"{fork}:{p}"))}
    byname, bystmt, bynorm = collections.defaultdict(list), collections.defaultdict(list), collections.defaultdict(list)
    nd = 0
    for p, t in [(p, pathlib.Path(p).read_text()) for p in files] + list(extra):
        for q, kw, st, ln, priv, stv in decls(t):
            if priv:
                continue
            nd += 1
            byname[q].append(f"{p}:{ln}")
            if kw in ("theorem", "lemma"):
                bystmt[alpha(stv)].append((q, f"{p}:{ln}"))
                bynorm[norm(stv)].append((q, f"{p}:{ln}"))
    names = [f"NAME-TWICE {q}  " + "  ".join(ws) for q, ws in sorted(byname.items()) if len(ws) > 1]
    stm, seen = [], set()
    for key, ws in bystmt.items():
        qs = sorted({q for q, _ in ws})
        if len(qs) > 1 and any(q not in atfork for q in qs):
            seen.add(frozenset(qs))
            stm.append("STATEMENT-TWICE " + "  =  ".join(f"{q} ({w})" + ("" if q in atfork else " [new]") for q, w in sorted(set(ws))))
    nrm = []
    for key, ws in bynorm.items():
        qs = sorted({q for q, _ in ws})
        if len(qs) > 1 and any(q not in atfork for q in qs) and not any(frozenset(qs) <= s or s <= frozenset(qs) for s in seen):
            nrm.append("NORM-TWICE " + "  ~  ".join(f"{q} ({w})" + ("" if q in atfork else " [new]") for q, w in sorted(set(ws))))
    for line in names + sorted(stm) + sorted(nrm):
        print(line)
    if not files or not nd:
        print("READ NOTHING")
        names.append("READ NOTHING")
    print(f"{len(files)} files under {root}; {nd} public declarations; {len(atfork)} names at {fork}; "
          f"{len(names)} NAME-TWICE; {len(stm)} STATEMENT-TWICE; {len(nrm)} NORM-TWICE")
    return names, stm, nrm


if __name__ == "__main__":
    plant = "--plant" in sys.argv
    a = [x for x in sys.argv[1:] if not x.startswith("--")]
    if "--whole" in sys.argv:
        root, fork = a
        n0, s0, r0 = whole(root, fork)
        if not plant:
            sys.exit(1 if n0 else 0)
        first = next(p for p in sorted(str(p) for p in pathlib.Path(root).rglob("*.lean"))
                     if any(kw == "theorem" and not priv for _, kw, _, _, priv, _ in decls(pathlib.Path(p).read_text())))
        t = pathlib.Path(first).read_text()
        q, _, st, _, _, stv = next(d for d in decls(t) if d[1] == "theorem" and not d[4])
        ns, short = q.rsplit(".", 1) if "." in q else ("", q)
        varline = stv[:len(stv) - len(st)].strip()
        body = (f"namespace {ns}\n" if ns else "") + (f"variable {varline}\n" if varline else "") + \
            f"theorem {short}{st}:= by\n  sorry\n\ntheorem planted_whole_copy{st}:= by\n  sorry\n" + (f"end {ns}\n" if ns else "")
        print(f"--- planted: {q} re-declared and copied as planted_whole_copy")
        n1, s1, r1 = whole(root, fork, extra=[("PLANTED-WHOLE.lean", body)])
        ok = len(n1) == len(n0) + 1 and any("PLANTED-WHOLE" in x for x in n1) and \
            (any("planted_whole_copy" in x for x in s1))
        print("PLANT:", "FIRED (the re-declared name NAME-TWICE, the copy STATEMENT-TWICE)" if ok else "DID NOT FIRE")
        sys.exit(0 if ok else 1)
    branch, main, fork = a
    f0 = run(branch, main, fork)
    if not plant:
        sys.exit(1 if f0 else 0)
    target = pick_target(main, fork)
    print(f"--- planted on {target[1]} ({target[0]})")
    f1 = run(branch, main, fork, extra=plant_files(target))
    new = [x for x in f1 if x not in f0]
    kinds = sorted(x.split()[0] for x in new)
    doc = any("planted_doc_ok" in x or "PLANTED-DOC" in x for x in new)
    ok = kinds == ["NAME", "STATEMENT", "STATEMENT-NORM"] and not doc and \
        any("PLANTED-NAME" in x for x in new) and any("planted_statement_copy" in x for x in new) and \
        any("planted_norm_copy" in x for x in new)
    print("PLANT:", "FIRED (exactly the three planted pairs beyond the unplanted run's; the docstring line not reported)"
          if ok else f"DID NOT FIRE as planted: new lines {new}")
    sys.exit(0 if ok else 1)
