#!/usr/bin/env python3
"""FS131-CC1 / FS131-CC2: lane C changes no statement, and touches only its own files.

Reads the skeleton at `2736ab8c` (the commit `fs131-w5k` was cut from; it holds every statement of both lanes), lane G's finished
files at `5059983d` (`fs131-w5`'s head, merged into this branch by FS131-CC2), and the working tree of `fs131-w5k`, and checks:

1. `RadialPush.lean` and `CollarMap.lean` (lane G's) are byte-identical to `5059983d`;
2. in all four modules of the layout (`RadialPush`, `Pushforward`, `CollarMap`, `BendCollar`), every declaration of the skeleton is
   declared exactly once, in the same file, with a byte-identical statement: for a theorem, the docstring and the header up to the
   statement's top-level `:=` (the first `:=` outside every bracket, comment and string — so what follows it, `by …` or a term, is proof
   and may change; a `:=` inside a binder's default value does not end the statement); for a `def` or a `structure`, the whole
   declaration (a definition a statement uses is part of the statement); each spec `example` verbatim; and `bend_toward_collar`'s whole
   text (its assembly proof included) unchanged;
3. no file under `Proofs/` other than those four differs from `2736ab8c`, and no new file under `Proofs/` exists;
4. no `axiom` declaration and no `native_decide` in the four modules;
5. no new declaration of `Pushforward` or `BendCollar` has a name declared in another file under `Proofs/` (such a clash builds alone
   and fails where both modules are imported).

New declarations (supporting lemmas, the model `collarModel`) are allowed and listed. Exit 0 iff all hold.

`--self-test` plants faults in memory and requires each to fail, naming its culprit, and each partner to pass:
a changed hypothesis, a changed docstring letter, a changed definition body, a changed spec example, an edit to `CollarMap`, a changed
hypothesis in a lane-G theorem (its file otherwise as `5059983d`), a deleted theorem, a duplicated theorem, an edit to the assembly, an
edit outside the layout, an `axiom` line, a `native_decide`, a new name clashing with the library, **a term-mode proof under a changed
statement** (fires), and, on the splitter alone, a changed default value inside a binder (fires). Partners that must pass: the unplanted
tree; **a tactic proof turned term proof under an unchanged statement** (`:= by exact X` to `:= X`, and a whole `:= by` block replaced by
a one-line term); a statement whose binder holds a `:=` with only its proof changed.
"""
import pathlib
import re
import subprocess
import sys

TREE = pathlib.Path("/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k")
BASE = "2736ab8c"
G_REV = "5059983d"
D = "Proofs/HadwigerNelson/Plane/ValidMap/"
RP, PF, CM, BC = D + "RadialPush.lean", D + "Pushforward.lean", D + "CollarMap.lean", D + "BendCollar.lean"
LAYOUT = [RP, PF, CM, BC]
FROZEN = [RP, CM]
MINE = [PF, BC]
WHOLE = {"bend_toward_collar"}

DECL = re.compile(r"^(?:@\[[^\]]*\]\s*)?(?:private |protected )?(?:noncomputable )?"
                  r"(theorem|lemma|def|structure|abbrev|instance|class|inductive|example)\b\s*([^\s(:{\[]*)")
STOP = re.compile(r"^(end |section|namespace|variable|open |/-!|import )")
OPENERS, CLOSERS = "([{⟨⦃", ")]}⟩⦄"
BINDING_WORD = re.compile(r"(?<![\w.'])(let|have|letI|haveI|show|from)(?![\w'])")


def top_level_assign(text):
    """Index of the first `:=` of `text` outside every bracket, `--` or `/- -/` comment and string literal; None if there is none.
    Fails closed (None, so the caller compares the whole declaration) when a binding keyword (`let`, `have`, …) stands before it
    outside comments: a `let x := v` in a statement would otherwise be taken for the proof's `:=`."""
    i, n, depth = 0, len(text), 0
    code = []
    while i < n:
        two = text[i:i + 2]
        ch = text[i]
        if two == "--":
            j = text.find("\n", i)
            i = n if j < 0 else j
            continue
        if two == "/-":
            lvl, i = 1, i + 2
            while i < n and lvl:
                if text[i:i + 2] == "/-":
                    lvl, i = lvl + 1, i + 2
                elif text[i:i + 2] == "-/":
                    lvl, i = lvl - 1, i + 2
                else:
                    i += 1
            continue
        if ch == '"':
            i += 1
            while i < n and text[i] != '"':
                i += 2 if text[i] == "\\" else 1
            i += 1
            continue
        if ch in OPENERS:
            depth += 1
        elif ch in CLOSERS:
            depth -= 1
        elif two == ":=" and depth == 0:
            return None if BINDING_WORD.search("".join(code)) else i
        code.append(ch)
        i += 1
    return None


def chunks(text):
    """(kind, name, full text, statement text) per declaration: a docstring (if any) and its declaration, up to the next docstring,
    declaration or structural line at column 0; trailing blank lines dropped."""
    lines = text.split("\n")
    out = []
    i, n = 0, len(lines)
    while i < n:
        line = lines[i]
        start = None
        if line.startswith("/--"):
            j = i
            while "-/" not in lines[j]:
                j += 1
            k = j + 1
            if k < n and DECL.match(lines[k]):
                start, head = i, k
            else:
                i = j + 1
                continue
        elif DECL.match(line):
            start, head = i, i
        if start is None:
            i += 1
            continue
        m = DECL.match(lines[head])
        kind, name = m.group(1), m.group(2)
        e = head + 1
        while e < n and not (lines[e].startswith("/--") or DECL.match(lines[e]) or STOP.match(lines[e])):
            e += 1
        body = lines[start:e]
        while body and body[-1].strip() == "":
            body.pop()
        full = "\n".join(body)
        if kind in ("theorem", "lemma", "instance"):
            hdr = "\n".join(lines[start:head])
            rest = "\n".join(lines[head:e])
            at = top_level_assign(rest)
            stmt = (hdr + "\n" if hdr else "") + rest[:at + 2] if at is not None else full
        else:
            stmt = full
        out.append((kind, name, full, stmt))
        i = e
    return out


NS_LINE = re.compile(r"^(namespace|section|end)\b[ \t]*([^\s]*)")


def declared_names(text):
    """{name as written: full name} of the file's declarations, read with the `namespace … end` lines at column 0 (a `section` opens
    a scope that an `end` closes without leaving a namespace). Private declarations are skipped: their names are mangled per module
    and cannot clash across files."""
    out = {}
    stack = []
    for line in text.split("\n"):
        ns = NS_LINE.match(line)
        if ns:
            word, arg = ns.group(1), ns.group(2)
            if word == "namespace":
                stack.append(arg)
            elif word == "section":
                stack.append(None)
            elif stack:
                stack.pop()
            continue
        m = DECL.match(line)
        if m and m.group(1) != "example" and m.group(2) and "private " not in line[:line.find(m.group(1))]:
            name = m.group(2)
            if name.startswith("_root_."):
                out[name] = name[len("_root_."):]
            else:
                out[name] = ".".join([x for x in stack if x] + [name])
    return out


def check(base_all, g_all, cur_all):
    errs = []
    for f in FROZEN:
        if cur_all.get(f) != g_all.get(f):
            errs.append(f"{f}: differs from {G_REV} (lane G's file)")
    for f in sorted(set(base_all) | set(cur_all)):
        if f in LAYOUT:
            continue
        if f not in base_all:
            errs.append(f"{f}: new file under Proofs/")
        elif f not in cur_all:
            errs.append(f"{f}: deleted")
        elif cur_all[f] != base_all[f]:
            errs.append(f"{f}: differs from {BASE} (outside the collar's four modules)")
    cur_chunks = {f: chunks(cur_all.get(f, "")) for f in LAYOUT}
    for f in LAYOUT:
        for kind, name, full, stmt in chunks(base_all[f]):
            if kind == "example":
                if full not in cur_all.get(f, ""):
                    errs.append(f"spec example changed or missing in {f}: {full.splitlines()[-1][:60]}")
                continue
            match = [c for c in cur_chunks[f] if c[1] == name and c[0] == kind]
            if len(match) != 1:
                errs.append(f"{name}: {len(match)} {kind} chunks in {f}")
                continue
            if match[0][3] != stmt:
                errs.append(f"{name}: statement differs from {BASE} ({f})")
            if name in WHOLE and match[0][2] != full:
                errs.append(f"{name}: whole text (with its assembly) differs from {BASE}")
    # a new declaration of lane C's files has a name no other file under `Proofs/` declares
    elsewhere = {}
    for f, t in cur_all.items():
        for full in declared_names(t).values():
            elsewhere.setdefault(full, set()).add(f)
    for f in MINE:
        base_names = {c[1] for c in chunks(base_all[f])}
        mine = declared_names(cur_all.get(f, ""))
        for kind, name, _, _ in cur_chunks[f]:
            if kind != "example" and name not in base_names and name in mine:
                others = sorted(h for h in elsewhere.get(mine[name], set()) if h != f)
                if others:
                    errs.append(f"new declaration {mine[name]} ({f}) also declared in {others}")
    for f in LAYOUT:
        t = cur_all.get(f, "")
        if re.search(r"^\s*(private\s+|protected\s+)?axiom\s", t, re.M):
            errs.append(f"axiom in {f}")
        if "native_decide" in t:
            errs.append(f"native_decide in {f}")
    return errs


def new_decls(base_all, cur_all):
    out = []
    for f in MINE:
        base_names = {(c[0], c[1]) for c in chunks(base_all[f])}
        out += [(f, c[0], c[1]) for c in chunks(cur_all.get(f, "")) if c[0] != "example" and (c[0], c[1]) not in base_names]
    return out


def load():
    def at(rev, files=None):
        lst = subprocess.run(["git", "-C", str(TREE), "ls-tree", "-r", "--name-only", rev, "Proofs/"], check=True,
                             capture_output=True, text=True).stdout.split()
        return {f: subprocess.run(["git", "-C", str(TREE), "show", f"{rev}:{f}"], check=True, capture_output=True,
                                  text=True).stdout for f in lst if f.endswith(".lean") and (files is None or f in files)}
    base_all = at(BASE)
    g_all = at(G_REV, set(FROZEN))
    cur_all = {str(p.relative_to(TREE)): p.read_text() for p in (TREE / "Proofs").rglob("*.lean")}
    return base_all, g_all, cur_all


def self_test(base_all, g_all, cur_all):
    def plant(f, old, new, count=1, src=None):
        c = dict(src or cur_all)
        assert c[f].count(old) >= 1, f"plant anchor missing: {old!r}"
        c[f] = c[f].replace(old, new, count)
        return c

    def retype_proof(f, name, new_proof, new_stmt_edit=None):
        """Replace the proof of theorem `name` in `f` (everything after its statement's top-level `:=`) by `new_proof`; optionally
        also edit its statement."""
        ch = [c for c in chunks(cur_all[f]) if c[1] == name and c[0] == "theorem"]
        assert len(ch) == 1, f"retype anchor: {name}"
        full, stmt = ch[0][2], ch[0][3]
        assert full != stmt and full.startswith(stmt), f"{name}: statement is not a proper prefix of its text"
        new_stmt = stmt if new_stmt_edit is None else stmt.replace(*new_stmt_edit)
        assert new_stmt_edit is None or new_stmt != stmt, f"{name}: statement edit anchor missing"
        return plant(f, full, new_stmt + " " + new_proof)

    fires = [
        ("changed hypothesis", plant(PF, "(hr₀ : 0 < r₀)\n    (hI :", "(hr₀ : 0 ≤ r₀)\n    (hI :"), "hasDegree_iff_of_agree"),
        ("changed docstring letter", plant(BC, "**R3** (clause 10)", "**R3** (clause 11)"), "map_R3"),
        ("changed definition body", plant(PF, "  col := F.col ∘ h.symm\n", "  col := F.col\n"), "pushforward"),
        ("changed spec example", plant(RP, "tent 0 1 2 1 = 1", "tent 0 1 2 1 = 2"), "RadialPush"),
        ("edit to CollarMap", plant(CM, "theorem CollarFit.map_valid", "theorem CollarFit.map_valid'"), "CollarMap"),
        ("changed hypothesis in a lane-G theorem", plant(RP, "theorem tangRad_lt_one {R u : ℝ} (hR : 1 / 2 < R)",
                                                         "theorem tangRad_lt_one {R u : ℝ} (hR : 1 / 2 ≤ R)"), "tangRad_lt_one"),
        ("deleted theorem", plant(BC, "theorem CollarFit.map_inert", "theorem CollarFit.map_inert_gone"), "CollarFit.map_inert"),
        ("duplicated theorem", plant(BC, "end Collar\n", "theorem CollarFit.map_R3 : True := trivial\n\nend Collar\n"),
         "CollarFit.map_R3"),
        ("edit to the assembly", plant(BC, "  have _ := hmax\n", "  have _ := hlen\n"), "bend_toward_collar"),
        ("edit outside the layout", plant(D + "BaseDense.lean", "namespace HadwigerNelson.Plane",
                                           "namespace HadwigerNelson.Plane\n"), "BaseDense"),
        ("axiom line", plant(PF, "end ArcMap\n", "axiom bogus : False\n\nend ArcMap\n"), "axiom"),
        ("native_decide", plant(BC, "end Collar\n", "example : 1 = 1 := by native_decide\n\nend Collar\n"), "native_decide"),
        ("new name clashing with the library (same namespace)",
         plant(BC, "end Collar\n", "theorem exists_kept_of_mem_openArc : True := trivial\n\nend Collar\n"),
         "HadwigerNelson.Plane.ArcMap.exists_kept_of_mem_openArc"),
        ("term-mode proof under a changed statement",
         retype_proof(BC, "CollarFit.map_R3", "fun h => absurd h (by simp)", ("{θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂)", "{θ : ℝ} (hθ : θ ∈ Icc θ₁ θ₂)")),
         "CollarFit.map_R3"),
    ]
    passes = [
        ("the unplanted tree", cur_all),
        ("a new name another namespace declares (no clash)",
         plant(BC, "end Collar\n", "theorem polar_inj : True := trivial\n\nend Collar\n")),
        ("`:= by exact X` turned `:= X` (statement unchanged)",
         plant(BC, ":= by\n  exact (hfit.map_degree_and_repeated hF z).2", ":=\n  (hfit.map_degree_and_repeated hF z).2")),
        ("a tactic block replaced by a one-line term (statement unchanged)",
         retype_proof(BC, "CollarFit.map_R3", "fun h => absurd h (by simp)")),
    ]
    ok = True
    fired = 0
    for label, c, culprit in fires:
        errs = check(base_all, g_all, c)
        named = [e for e in errs if culprit in e]
        if named:
            fired += 1
            print(f"FIRED ({label}): {named[0]}")
        else:
            ok = False
            print(f"DID NOT FIRE ({label}): {errs}")
    passed = 0
    for label, c in passes:
        errs = check(base_all, g_all, c)
        if not errs:
            passed += 1
            print(f"PARTNER PASS ({label})")
        else:
            ok = False
            print(f"PARTNER FAILED ({label}): {errs}")
    # the splitter alone, on synthetic declarations
    def stmt_of(src):
        ch = chunks(src)
        assert len(ch) == 1, src
        return ch[0][3]
    a = "theorem t (a : Nat := 1) : a = a := rfl"
    unit = [
        ("a changed default value inside a binder", stmt_of(a) != stmt_of("theorem t (a : Nat := 2) : a = a := rfl"), True),
        ("a binder `:=` kept, the proof changed", stmt_of(a) == stmt_of("theorem t (a : Nat := 1) : a = a := by\n  rfl"), False),
        ("the statement ends at the top-level `:=`", stmt_of(a) == "theorem t (a : Nat := 1) : a = a :=", False),
        ("a `:=` in a comment or a string is skipped",
         stmt_of('theorem t (s : String) (h : s = ":=") : /- := -/ s = ":=" := h') == 'theorem t (s : String) (h : s = ":=") : /- := -/ s = ":=" :=',
         False),
        ("a `let` in the statement fails closed (whole text compared)",
         stmt_of("theorem t : let x := 1; x = 1 := rfl") == "theorem t : let x := 1; x = 1 := rfl", False),
    ]
    for label, good, is_fire in unit:
        if good:
            if is_fire:
                fired += 1
                print(f"FIRED (splitter: {label})")
            else:
                passed += 1
                print(f"PARTNER PASS (splitter: {label})")
        else:
            ok = False
            print(f"SPLITTER CONTROL WRONG ({label})")
    n_fire = len(fires) + sum(1 for u in unit if u[2])
    n_pass = len(passes) + sum(1 for u in unit if not u[2])
    print(f"self-test: {fired} of {n_fire} plants fired, each naming its culprit; {passed} of {n_pass} partners passed")
    return 0 if ok and fired == n_fire and passed == n_pass else 1


def main():
    base_all, g_all, cur_all = load()
    if "--self-test" in sys.argv:
        return self_test(base_all, g_all, cur_all)
    errs = check(base_all, g_all, cur_all)
    for e in errs:
        print("FAIL:", e)
    for f, kind, name in new_decls(base_all, cur_all):
        print(f"new {kind} in {f.split('/')[-1]}: {name}")
    n = sum(1 for f in LAYOUT for c in chunks(base_all[f]) if c[0] != "example")
    print(f"PASS ({n} skeleton declarations, each once, statements byte-identical to {BASE}; lane G's files as {G_REV})" if not errs
          else f"FAIL: {len(errs)} error(s)")
    return 0 if not errs else 1


if __name__ == "__main__":
    sys.exit(main())
