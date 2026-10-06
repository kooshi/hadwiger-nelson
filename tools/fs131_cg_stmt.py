#!/usr/bin/env python3
"""FS131-CG1: lane G's statements are KP2's, and the move of G's block into `CollarMap` is verbatim.

Reads the skeleton at `b2ccfb7b` (`RadialPush.lean`, `BendCollar.lean`) and the working tree, splits each file into declaration chunks
(a docstring and the declaration it documents), and checks:

1. every declaration of the skeleton's two files is declared in exactly one of the layout's files, the one it belongs in (G's block —
   `CollarFit` and `CollarFit.kin_subset` … `CollarFit.map_valid` — in `CollarMap`, the rest where they were), and in no other file under
   `Proofs/` that did not already declare that name at `b2ccfb7b`;
2. its statement is byte-identical: for a theorem, the docstring and the header up to the `:=` that opens the proof (a `by` after it
   is proof style, so a tactic proof may become a term proof); for a `def` or a
   `structure`, the whole declaration (a definition the statements use is part of the statement); each spec `example` verbatim;
3. the section note `## The collar's fit to the map` moved byte-identical into `CollarMap`;
4. `BendCollar.lean` is exactly the skeleton's with the moved lines deleted and one import line added (this branch never edits lane C's
   proofs), so `bend_toward_collar`'s block is unchanged with it;
5. no `axiom` declaration and no `native_decide` in the four modules of the layout;
6. no new declaration of `RadialPush` or `CollarMap` has a name declared in another file under `Proofs/` (such a clash builds alone
   and fails where both modules are imported — `Proofs.lean`).

`--move` also requires the moved declarations' full text (proofs included) to be the skeleton's: the check of the move commit itself.
New declarations (supporting lemmas) are allowed and listed. Exit 0 iff all hold. `--self-test` plants ten faults in memory — a changed
hypothesis in a moved theorem, a changed docstring letter, a changed definition body, a moved declaration duplicated in `BendCollar`, a
moved declaration deleted, a changed section note, an edit to `BendCollar`, an `axiom` line, a `native_decide`, a new name clashing with the library — requires each to fail
(naming the culprit) and the unplanted partner to pass.
"""
import pathlib
import re
import subprocess
import sys

TREE = pathlib.Path("/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5")
BASE = "b2ccfb7b"
D = "Proofs/HadwigerNelson/Plane/ValidMap/"
RP, PF, CM, BC = D + "RadialPush.lean", D + "Pushforward.lean", D + "CollarMap.lean", D + "BendCollar.lean"
LAYOUT = [RP, PF, CM, BC]
MOVED_FIRST, MOVED_LAST = "CollarFit.kin_subset", "CollarFit.map_valid"
SECTION_NOTE = "/-! ## The collar's fit to the map"
NEW_IMPORT = "import Proofs.HadwigerNelson.Plane.ValidMap.CollarMap"

DECL = re.compile(r"^(?:@\[[^\]]*\]\s*)?(?:private |protected )?(?:noncomputable )?"
                  r"(theorem|lemma|def|structure|abbrev|instance|class|inductive|example)\b\s*([^\s(:{\[]*)")
STOP = re.compile(r"^(end |section|namespace|variable|open |/-!|import )")


def chunks(text):
    """Split into declaration chunks: (kind, name, full text, statement text). A chunk is a docstring (if any) and its declaration,
    up to the next docstring, declaration or structural line at column 0; trailing blank lines dropped."""
    lines = text.split("\n")
    out = []
    i = 0
    n = len(lines)
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
            # the statement ends at the `:=` that opens the proof (a `by` after it is proof style, not statement)
            mm = re.search(r":=(?=(?:[ \t]*by)?[ \t]*$)", rest, re.M)
            if mm is None:
                mm = re.search(r":=", rest)
            stmt = (hdr + "\n" if hdr else "") + rest[:mm.end()] if mm else full
        else:
            stmt = full
        out.append((kind, name, full, stmt))
        i = e
    return out


def section_note(text):
    i = text.find(SECTION_NOTE)
    if i < 0:
        return None
    return text[i:text.index("-/", i) + 2]


def expected_bendcollar(base_bc):
    """The skeleton's BendCollar with the moved lines (the section note, `CollarFit`, and the block) deleted and the import added."""
    L = base_bc.split("\n")
    a = next(i for i, l in enumerate(L) if l.startswith(SECTION_NOTE))
    b = next(i for i in range(a, len(L)) if "-/" in L[i])
    fit = next(i for i, l in enumerate(L) if l.startswith("/-- **The collar fits the map**"))
    fit_end = next(i for i in range(fit, len(L)) if L[i] == "")
    first = next(i for i, l in enumerate(L) if l.startswith(f"theorem {MOVED_FIRST} ")) - 0
    while not L[first].startswith("/--"):
        first -= 1
    last = next(i for i, l in enumerate(L) if l.startswith(f"theorem {MOVED_LAST} "))
    last_end = next(i for i in range(last, len(L)) if L[i] == "")
    drop = set(range(a, b + 2)) | set(range(fit, fit_end + 1)) | set(range(first, last_end + 1))
    keep = [l for i, l in enumerate(L) if i not in drop]
    imp = max(i for i, l in enumerate(keep) if l.startswith("import "))
    keep.insert(imp + 1, NEW_IMPORT)
    return "\n".join(keep)


def moved_names(base_bc_chunks):
    names = [c[1] for c in base_bc_chunks if c[0] != "example"]
    i, j = names.index(MOVED_FIRST), names.index(MOVED_LAST)
    return {"CollarFit"} | set(names[i:j + 1])


def declaring_files(files):
    """name -> set of files (relative) under Proofs/ declaring it (by the unqualified-as-written name)."""
    out = {}
    for f, t in files.items():
        for line in t.split("\n"):
            m = DECL.match(line)
            if m and m.group(1) != "example" and m.group(2):
                out.setdefault(m.group(2), set()).add(f)
    return out


def check(base, cur, all_cur, base_decl, move_mode):
    errs = []
    base_ch = {f: chunks(base[f]) for f in (RP, BC)}
    moved = moved_names(base_ch[BC])
    cur_ch = {f: chunks(cur[f]) for f in LAYOUT if f in cur}
    cur_decl = declaring_files(all_cur)
    for f, chs in base_ch.items():
        for kind, name, full, stmt in chs:
            if kind == "example":
                home = f
                if full not in cur.get(home, ""):
                    errs.append(f"spec example changed or missing in {home}: {full.splitlines()[-1][:60]}")
                continue
            home = CM if (f == BC and name in moved) else f
            layout_files = {g for g in cur_decl.get(name, set()) if g in LAYOUT}
            if layout_files != {home}:
                errs.append(f"{name}: declared in {sorted(layout_files)} among the layout, expected [{home}]")
            others = {g for g in cur_decl.get(name, set()) if g not in LAYOUT}
            base_others = {g for g in base_decl.get(name, set()) if g not in LAYOUT}
            if others - base_others:
                errs.append(f"{name}: newly declared outside the layout in {sorted(others - base_others)}")
            match = [c for c in cur_ch.get(home, []) if c[1] == name and c[0] == kind]
            if len(match) != 1:
                errs.append(f"{name}: {len(match)} {kind} chunks in {home}")
                continue
            if match[0][3] != stmt:
                errs.append(f"{name}: statement differs from {BASE} ({home})")
            if move_mode and name in moved and match[0][2] != full:
                errs.append(f"{name}: moved text (with proof) differs from {BASE}")
    note = section_note(base[BC])
    if section_note(cur.get(CM, "")) != note:
        errs.append("section note `## The collar's fit to the map` not byte-identical in CollarMap")
    if cur.get(BC) != expected_bendcollar(base[BC]):
        errs.append("BendCollar.lean is not the skeleton's minus the moved lines plus the import")
    # a new declaration's name is declared in no other file under `Proofs/` (a clash fails only when both modules are imported)
    base_names = {c[1] for g in (RP, BC) for c in base_ch[g]}
    for g in (RP, CM):
        for kind, name, _, _ in cur_ch.get(g, []):
            if kind != "example" and name not in base_names:
                elsewhere = {h for h in cur_decl.get(name, set()) if h != g}
                if elsewhere:
                    errs.append(f"new declaration {name} ({g}) also declared in {sorted(elsewhere)}")
    for f in LAYOUT:
        t = cur.get(f, "")
        if re.search(r"^\s*(private\s+|protected\s+)?axiom\s", t, re.M):
            errs.append(f"axiom in {f}")
        if "native_decide" in t:
            errs.append(f"native_decide in {f}")
    return errs


def new_decls(base, cur):
    base_names = {c[1] for f in (RP, BC) for c in chunks(base[f])}
    return [(f, c[1]) for f in (RP, CM) for c in chunks(cur.get(f, "")) if c[0] != "example" and c[1] not in base_names]


def main():
    base = {f: subprocess.run(["git", "-C", str(TREE), "show", f"{BASE}:{f}"], check=True, capture_output=True,
                              text=True).stdout for f in (RP, BC)}
    lst = subprocess.run(["git", "-C", str(TREE), "ls-tree", "-r", "--name-only", BASE, "Proofs/"], check=True,
                         capture_output=True, text=True).stdout.split()
    base_all = {}
    for f in lst:
        if f.endswith(".lean") and "/Cnf/" not in f and "/HalfA/" not in f and "/Critical/" not in f:
            base_all[f] = subprocess.run(["git", "-C", str(TREE), "show", f"{BASE}:{f}"], check=True, capture_output=True,
                                         text=True).stdout
    base_decl = declaring_files(base_all)
    all_cur = {str(p.relative_to(TREE)): p.read_text() for p in (TREE / "Proofs").rglob("*.lean")
               if "/Cnf/" not in str(p) and "/HalfA/" not in str(p) and "/Critical/" not in str(p)}
    cur = {f: all_cur[f] for f in LAYOUT if f in all_cur}
    move_mode = "--move" in sys.argv
    if "--self-test" in sys.argv:
        def plant(f, old, new):
            c = dict(cur)
            a = dict(all_cur)
            assert c[f].count(old) >= 1, f"plant anchor missing: {old!r}"
            c[f] = c[f].replace(old, new, 1)
            a[f] = c[f]
            return c, a
        plants = {
            "hypothesis (moved theorem)": plant(CM, "{z : ℂ} (hz : z ∈ lensSet P θ₁ θ₂ R) :", "{z : ℂ} (hz : z ∈ lensCurve P θ₁ θ₂ R) :"),
            "docstring letter (RadialPush)": plant(RP, "**The push is continuous.**", "**The push is continuous!**"),
            "definition body": plant(RP, "max 0 (min ((t - a) / (m - a))", "max 0 (min ((t - a) / (m - b))"),
            "section note": plant(CM, "## The collar's fit to the map", "## The collar's fit to a map"),
            "BendCollar edit": plant(BC, "# The collar bend (FS131-KB2)", "# The collar bend (FS131-KB3)"),
            "axiom": plant(RP, "\nend HadwigerNelson.Plane", "\naxiom bogus : False\nend HadwigerNelson.Plane"),
            "native_decide": plant(CM, "\nend Collar", "\nexample : 1 = 1 := by native_decide\nend Collar"),
        }
        plants["new name clashing with the library"] = plant(RP, "\nend HadwigerNelson.Plane",
                                                            "\ntheorem polar_inj : True := trivial\nend HadwigerNelson.Plane")
        # a moved declaration duplicated in BendCollar
        dup = [c for c in chunks(cur[CM]) if c[1] == "CollarFit.map_valid"][0][2]
        c2, a2 = dict(cur), dict(all_cur)
        c2[BC] = c2[BC].replace("\nend Collar", "\n" + dup + "\n\nend Collar", 1)
        a2[BC] = c2[BC]
        plants["duplicated in BendCollar"] = (c2, a2)
        # a moved declaration deleted
        c3, a3 = dict(cur), dict(all_cur)
        c3[CM] = c3[CM].replace(dup, "", 1)
        a3[CM] = c3[CM]
        plants["moved declaration deleted"] = (c3, a3)
        fired = 0
        for name, (c, a) in plants.items():
            e = check(base, c, a, base_decl, move_mode)
            if e:
                fired += 1
                print(f"plant {name}: FIRED — {e[0]}")
            else:
                print(f"PLANT {name}: DID NOT FIRE")
        partner = check(base, cur, all_cur, base_decl, move_mode)
        print(f"self-test: {fired} of {len(plants)} plants fired; unplanted partner {'PASS' if not partner else 'FAIL'}")
        for e in partner:
            print("  partner:", e)
        return 0 if fired == len(plants) and not partner else 1
    errs = check(base, cur, all_cur, base_decl, move_mode)
    for e in errs:
        print("FAIL:", e)
    n = sum(1 for f in (RP, BC) for c in chunks(base[f]))
    nd = new_decls(base, cur)
    print(f"declarations of the skeleton checked: {n}; new declarations: {len(nd)}")
    for f, name in nd:
        print(f"  new: {name} ({f.rsplit('/', 1)[1]})")
    if not errs:
        print("PASS" + (" (--move: moved text byte-identical)" if move_mode else ""))
    return 0 if not errs else 1


if __name__ == "__main__":
    sys.exit(main())
