#!/usr/bin/env python3
"""FS131-CC1: lane C changes no statement, and touches only its own files.

Reads the skeleton at `2736ab8c` (the commit this branch was cut from) and the working tree of `fs131-w5k`, and checks:

1. `RadialPush.lean` and `CollarMap.lean` (lane G's) are byte-identical to `2736ab8c`;
2. in `Pushforward.lean` and `BendCollar.lean`, every declaration of the skeleton is declared exactly once, in the same file, with a
   byte-identical statement: for a theorem, the docstring and the header up to the `:=` that opens the proof; for a `def` or a
   `structure`, the whole declaration (a definition a statement uses is part of the statement); each spec `example` verbatim; and
   `bend_toward_collar`'s whole text (its assembly proof included) unchanged;
3. no file under `Proofs/` other than those two differs from `2736ab8c`, and no new file under `Proofs/` exists;
4. no `axiom` declaration and no `native_decide` in the four modules.

New declarations (supporting lemmas, the model `collarModel`) are allowed and listed. Exit 0 iff all hold. `--self-test` plants faults
in memory — a changed hypothesis, a changed docstring letter, a changed definition body, a changed spec example, an edit to RadialPush, an
edit to CollarMap, a deleted theorem, a duplicated theorem, an edit to `bend_toward_collar`'s proof, an edit to a file outside the layout,
an `axiom` line, a `native_decide` — and requires each to fail, naming its culprit, and the unplanted partner to pass.
"""
import pathlib
import re
import subprocess
import sys

TREE = pathlib.Path("/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k")
BASE = "2736ab8c"
D = "Proofs/HadwigerNelson/Plane/ValidMap/"
RP, PF, CM, BC = D + "RadialPush.lean", D + "Pushforward.lean", D + "CollarMap.lean", D + "BendCollar.lean"
LAYOUT = [RP, PF, CM, BC]
FROZEN = [RP, CM]
CHECKED = [PF, BC]
WHOLE = {"bend_toward_collar"}

DECL = re.compile(r"^(?:@\[[^\]]*\]\s*)?(?:private |protected )?(?:noncomputable )?"
                  r"(theorem|lemma|def|structure|abbrev|instance|class|inductive|example)\b\s*([^\s(:{\[]*)")
STOP = re.compile(r"^(end |section|namespace|variable|open |/-!|import )")


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
            mm = re.search(r":=(?:[ \t]*by)?[ \t]*$", rest, re.M) or re.search(r":=", rest)
            stmt = (hdr + "\n" if hdr else "") + rest[:mm.end()] if mm else full
        else:
            stmt = full
        out.append((kind, name, full, stmt))
        i = e
    return out


def check(base_all, cur_all):
    errs = []
    for f in FROZEN:
        if cur_all.get(f) != base_all.get(f):
            errs.append(f"{f}: differs from {BASE} (lane G's file)")
    for f in sorted(set(base_all) | set(cur_all)):
        if f in LAYOUT:
            continue
        if f not in base_all:
            errs.append(f"{f}: new file under Proofs/")
        elif f not in cur_all:
            errs.append(f"{f}: deleted")
        elif cur_all[f] != base_all[f]:
            errs.append(f"{f}: differs from {BASE} (outside lane C's files)")
    for f in CHECKED:
        cur_ch = chunks(cur_all.get(f, ""))
        for kind, name, full, stmt in chunks(base_all[f]):
            if kind == "example":
                if full not in cur_all.get(f, ""):
                    errs.append(f"spec example changed or missing in {f}: {full.splitlines()[-1][:60]}")
                continue
            match = [c for c in cur_ch if c[1] == name and c[0] == kind]
            if len(match) != 1:
                errs.append(f"{name}: {len(match)} {kind} chunks in {f}")
                continue
            if match[0][3] != stmt:
                errs.append(f"{name}: statement differs from {BASE} ({f})")
            if name in WHOLE and match[0][2] != full:
                errs.append(f"{name}: whole text (with its assembly) differs from {BASE}")
    for f in LAYOUT:
        t = cur_all.get(f, "")
        if re.search(r"^\s*(private\s+|protected\s+)?axiom\s", t, re.M):
            errs.append(f"axiom in {f}")
        if "native_decide" in t:
            errs.append(f"native_decide in {f}")
    return errs


def new_decls(base_all, cur_all):
    out = []
    for f in CHECKED:
        base_names = {(c[0], c[1]) for c in chunks(base_all[f])}
        out += [(f, c[0], c[1]) for c in chunks(cur_all.get(f, "")) if c[0] != "example" and (c[0], c[1]) not in base_names]
    return out


def load():
    lst = subprocess.run(["git", "-C", str(TREE), "ls-tree", "-r", "--name-only", BASE, "Proofs/"], check=True,
                         capture_output=True, text=True).stdout.split()
    base_all = {f: subprocess.run(["git", "-C", str(TREE), "show", f"{BASE}:{f}"], check=True, capture_output=True,
                                  text=True).stdout for f in lst if f.endswith(".lean")}
    cur_all = {str(p.relative_to(TREE)): p.read_text() for p in (TREE / "Proofs").rglob("*.lean")}
    return base_all, cur_all


def main():
    base_all, cur_all = load()
    if "--self-test" in sys.argv:
        def plant(f, old, new, count=1):
            c = dict(cur_all)
            assert c[f].count(old) >= 1, f"plant anchor missing: {old!r}"
            c[f] = c[f].replace(old, new, count)
            return c
        plants = [
            ("changed hypothesis", plant(PF, "(hr₀ : 0 < r₀)\n    (hI :", "(hr₀ : 0 ≤ r₀)\n    (hI :"), "hasDegree_iff_of_agree"),
            ("changed docstring letter", plant(BC, "**R3** (clause 10)", "**R3** (clause 11)"), "map_R3"),
            ("changed definition body", plant(PF, "  col := F.col ∘ h.symm\n", "  col := F.col\n"), "pushforward"),
            ("changed spec example", plant(RP, "tent 0 1 2 1 = 1", "tent 0 1 2 1 = 2"), "RadialPush"),
            ("edit to CollarMap", plant(CM, "theorem CollarFit.map_valid", "theorem CollarFit.map_valid'"), "CollarMap"),
            ("deleted theorem", plant(BC, "theorem CollarFit.map_inert", "theorem CollarFit.map_inert_gone"),
             "CollarFit.map_inert"),
            ("duplicated theorem", plant(BC, "end Collar\n", "theorem CollarFit.map_R3 : True := trivial\n\nend Collar\n"),
             "CollarFit.map_R3"),
            ("edit to the assembly", plant(BC, "  have _ := hmax\n", "  have _ := hlen\n"), "bend_toward_collar"),
            ("edit outside the layout", plant(D + "BaseDense.lean", "namespace HadwigerNelson.Plane",
                                               "namespace HadwigerNelson.Plane\n"), "BaseDense"),
            ("axiom line", plant(PF, "end ArcMap\n", "axiom bogus : False\n\nend ArcMap\n"), "axiom"),
            ("native_decide", plant(BC, "end Collar\n", "example : 1 = 1 := by native_decide\n\nend Collar\n"), "native_decide"),
        ]
        fired = 0
        for label, c, culprit in plants:
            errs = check(base_all, c)
            if errs and any(culprit in e for e in errs):
                fired += 1
                print(f"FIRED ({label}): {errs[0]}")
            else:
                print(f"DID NOT FIRE ({label}): {errs}")
        partner = check(base_all, cur_all)
        print(f"self-test: {fired} of {len(plants)} plants fired, each naming its culprit; unplanted partner "
              f"{'PASS' if not partner else 'FAIL: ' + str(partner)}")
        return 0 if fired == len(plants) and not partner else 1
    errs = check(base_all, cur_all)
    for e in errs:
        print("FAIL:", e)
    for f, kind, name in new_decls(base_all, cur_all):
        print(f"new {kind} in {f.split('/')[-1]}: {name}")
    print("PASS" if not errs else f"FAIL: {len(errs)} error(s)")
    return 0 if not errs else 1


if __name__ == "__main__":
    sys.exit(main())
