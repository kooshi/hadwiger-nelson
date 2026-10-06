#!/usr/bin/env python3
"""FS131-MA1: the statement check — no statement or definition of the skeleton changed.

Compares the model files of the working tree against the skeleton commit (the planner's last, `fe9d6d32`):

  * every `theorem` of the skeleton is present with the same statement, byte for byte — the text from the keyword to the
    `:=` that ends it (the first `:=` outside every bracket);
  * every `def` of the skeleton is present with the same whole text (a definition's body is part of every statement that
    names it);
  * the lines that set a statement's context (`import`, `open`, `namespace`, `end`, `variable`, `section`) are the same, in
    the same order;
  * no declaration added since the skeleton has a name that occurs as a word in a skeleton statement (a new name could
    otherwise capture an identifier of an old statement and change its meaning with its text intact);
  * with `--no-sorry FILE…`, the named files hold no `sorry`;
  * with `--names`, every added declaration whose short name is declared anywhere else under `Proofs/` is listed for a look
    (a name declared twice in one namespace is the hazard of inventory item 462; the same short name in another namespace is
    not).

Exit 0 iff all hold. `--self-test` plants five faults (in a copy of the tree's text: a hypothesis's bound changed, a
definition's body changed, an `open` line changed, a helper named after an identifier of a statement; and the library's one
known doubled name treated as an added one) and requires each to be reported, then requires the unplanted text to pass.
"""
import re, subprocess, sys, os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SKELETON = "fe9d6d32"
FILES = [
    "Proofs/HadwigerNelson/Plane/Models/Paint.lean",
    "Proofs/HadwigerNelson/Plane/Models/Moves.lean",
    "Proofs/HadwigerNelson/Plane/Models/Stuck.lean",
    "Proofs/HadwigerNelson/Plane/Models/Bends.lean",
]
DECL = re.compile(r"^(?:@\[[^\]]*\]\s*)?(?:private |protected )?(?:noncomputable )?(theorem|def|abbrev|instance|structure|inductive|lemma)\s+(\S+)")
START = re.compile(r"^(/--|/-!|theorem |def |noncomputable |end |namespace |open |variable |section |-- |@\[|private |protected |example|instance |#|abbrev |structure |inductive |lemma )")
CONTEXT = re.compile(r"^(import |open |namespace |end |variable |section )")
OPENERS, CLOSERS = "([{⟨", ")]}⟩"


def statement_end(text):
    """Index of the first `:=` outside every bracket, or -1."""
    depth = 0
    i = 0
    while i < len(text) - 1:
        ch = text[i]
        if ch in OPENERS:
            depth += 1
        elif ch in CLOSERS:
            depth -= 1
        elif ch == ":" and text[i + 1] == "=" and depth == 0:
            return i
        i += 1
    return -1


def parse(text):
    """name -> (kind, statement text). A theorem's statement ends at its `:=`; a def's is its whole chunk."""
    lines = text.split("\n")
    decls, context = {}, []
    order = []
    i = 0
    in_comment = False
    while i < len(lines):
        line = lines[i]
        if in_comment:
            if "-/" in line:
                in_comment = False
            i += 1
            continue
        if line.startswith("/-") and "-/" not in line:
            in_comment = True
            i += 1
            continue
        if CONTEXT.match(line):
            context.append(line)
        m = DECL.match(line)
        if not m:
            i += 1
            continue
        kind, name = m.group(1), m.group(2)
        j = i + 1
        while j < len(lines) and not START.match(lines[j]):
            j += 1
        chunk = "\n".join(lines[i:j]).rstrip()
        if kind in ("theorem", "lemma"):
            k = statement_end(chunk)
            stmt = chunk if k < 0 else chunk[:k].rstrip()
        else:
            stmt = chunk
        if name in decls:
            decls[name] = (kind, decls[name][1] + "\n<<DECLARED TWICE>>\n" + stmt)
        else:
            decls[name] = (kind, stmt)
            order.append(name)
        i = j
    return decls, context, order


def skeleton_text(path):
    return subprocess.run(["git", "-C", ROOT, "show", f"{SKELETON}:{path}"], check=True, capture_output=True, text=True).stdout


def compare(old_text, new_text, label):
    problems = []
    old, octx, _ = parse(old_text)
    new, nctx, _ = parse(new_text)
    if octx != nctx:
        problems.append(f"{label}: the context lines (import/open/namespace/end/variable/section) differ")
    for name, (kind, stmt) in old.items():
        if name not in new:
            problems.append(f"{label}: `{name}` ({kind}) of the skeleton is missing")
        elif "<<DECLARED TWICE>>" in new[name][1]:
            problems.append(f"{label}: `{name}` is declared twice")
        elif new[name][1] != stmt:
            problems.append(f"{label}: `{name}` ({kind}) — statement changed")
    added = [n for n in new if n not in old]
    for n in added:
        if "<<DECLARED TWICE>>" in new[n][1]:
            problems.append(f"{label}: new declaration `{n}` is declared twice")
        short = n.split(".")[-1]
        pat = re.compile(r"(?<![\w.'])" + re.escape(short) + r"(?![\w'])")
        for name, (kind, stmt) in old.items():
            body = stmt.split("\n", 1)[1] if "\n" in stmt else ""
            head = stmt.split("\n", 1)[0]
            head = head.split(name, 1)[1] if name in head else head
            if pat.search(head + "\n" + body):
                problems.append(f"{label}: new declaration `{n}` is named like an identifier of the skeleton's `{name}`")
    return problems, len(old), len(added)


def run(texts=None, quiet=False):
    problems, total, added = [], 0, 0
    olds, news = {}, {}
    for path in FILES:
        old = skeleton_text(path)
        new = texts[path] if texts else open(os.path.join(ROOT, path)).read()
        p, n, a = compare(old, new, os.path.basename(path))
        problems += p
        total += n
        added += a
        olds[path], news[path] = parse(old)[0], parse(new)[0]
        if not quiet:
            print(f"{os.path.basename(path)}: {n} skeleton declarations compared, {a} added, {len(p)} problem(s)")
    # a name added in one file against the statements of the other files
    for path in FILES:
        for n in news[path]:
            if n in olds[path]:
                continue
            short = n.split(".")[-1]
            pat = re.compile(r"(?<![\w.'])" + re.escape(short) + r"(?![\w'])")
            for other in FILES:
                if other == path:
                    continue
                for name, (kind, stmt) in olds[other].items():
                    rest = stmt.split(name, 1)[1] if name in stmt else stmt
                    if pat.search(rest):
                        problems.append(f"{os.path.basename(path)}: new declaration `{n}` is named like an identifier of "
                                        f"`{name}` in {os.path.basename(other)}")
    return problems, total, added


def library_index():
    """short name -> every (file, line) under Proofs/ that declares it."""
    index = {}
    for dirpath, _, files in os.walk(os.path.join(ROOT, "Proofs")):
        for f in files:
            if not f.endswith(".lean"):
                continue
            full = os.path.join(dirpath, f)
            for ln, line in enumerate(open(full), 1):
                m = DECL.match(line)
                if m:
                    index.setdefault(m.group(2).split(".")[-1], []).append((os.path.relpath(full, ROOT), ln))
    return index


def library_names(extra=()):
    """Every added name whose short name is not declared exactly once under Proofs/ (a doubled name is inventory item 462's
    hazard). `extra` names are treated as added (the self-test's planted name)."""
    added = []
    for path in FILES:
        old = parse(skeleton_text(path))[0]
        new = parse(open(os.path.join(ROOT, path)).read())[0]
        added += [n for n in new if n not in old]
    added += list(extra)
    index = library_index()
    hits = [(n, index.get(n.split(".")[-1], [])) for n in added if len(index.get(n.split(".")[-1], [])) != 1]
    return added, hits


def self_test():
    base = {p: open(os.path.join(ROOT, p)).read() for p in FILES}
    paint, moves = FILES[0], FILES[1]
    plants = []
    t = dict(base)
    a = "(h2 : |κ₂| * ρ ≤ 1) : frontier (hornSet v α κ₁ κ₂ ρ)"
    assert a in t[paint]
    t[paint] = t[paint].replace(a, a.replace("≤ 1", "≤ 2"))
    plants.append(("a hypothesis's bound changed", t, "frontier_hornSet_subset"))
    t = dict(base)
    a = "noncomputable def hornW : Set ℂ := hornSet plantPt 0 (-1 / 2) (1 / 2) (1 / 10) ∪ tangentDisc"
    assert a in t[moves]
    t[moves] = t[moves].replace(a, a.replace("(1 / 10)", "(1 / 20)"))
    plants.append(("a definition's body changed", t, "hornW"))
    t = dict(base)
    a = "open Complex Real Set Filter Topology Metric\n"
    assert a in t[moves]
    t[moves] = t[moves].replace(a, "open Complex Real Set Filter Topology\n", 1)
    plants.append(("an `open` line changed", t, "context lines"))
    t = dict(base)
    t[paint] = t[paint].replace("\nend HadwigerNelson.Plane\n", "\ntheorem hornSet : True := trivial\n\nend HadwigerNelson.Plane\n")
    plants.append(("a helper named after an identifier of a statement", t, "named like an identifier"))
    ok = True
    for what, texts, needle in plants:
        problems, _, _ = run(texts, quiet=True)
        fired = any(needle in p for p in problems)
        print(f"self-test: {what}: {'fired' if fired else 'DID NOT FIRE'} ({len(problems)} problem(s))")
        ok = ok and fired
    # the names listing: `conj_e` is the library's one known doubled name (inventory item 463); treated as added, it must be listed
    _, hits = library_names(extra=("conj_e",))
    fired = any(n == "conj_e" and len(where) == 2 for n, where in hits)
    print(f"self-test: a doubled name (`conj_e`, the library's known pair) treated as added: {'fired' if fired else 'DID NOT FIRE'}")
    ok = ok and fired
    problems, _, _ = run(base, quiet=True)
    print(f"self-test: the unplanted text: {len(problems)} problem(s)")
    ok = ok and not problems
    print("self-test:", "OK" if ok else "FAIL")
    return ok


def main():
    if "--self-test" in sys.argv:
        sys.exit(0 if self_test() else 1)
    problems, total, added = run()
    if "--no-sorry" in sys.argv:
        for f in sys.argv[sys.argv.index("--no-sorry") + 1:]:
            n = len(re.findall(r"\bsorry\b", open(os.path.join(ROOT, f)).read()))
            print(f"{os.path.basename(f)}: {n} occurrence(s) of `sorry`")
            if n:
                problems.append(f"{os.path.basename(f)}: {n} `sorry`")
    if "--names" in sys.argv:
        added_names, hits = library_names()
        print(f"names: {len(added_names)} added declarations; {len(hits)} whose short name is declared elsewhere under Proofs/")
        for n, where in hits:
            print(f"  LOOK: `{n}` declared at " + ", ".join(f"{f}:{ln}" for f, ln in where))
    for p in problems:
        print("PROBLEM:", p)
    print(f"RESULT: {total} skeleton declarations compared against {SKELETON}, {added} added, {len(problems)} problem(s) -> "
          f"{'PASS' if not problems else 'FAIL'}")
    sys.exit(1 if problems else 0)


if __name__ == "__main__":
    main()
