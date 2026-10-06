#!/usr/bin/env python3
"""FS131-RP1 — exactly the ruled statements changed: every declaration of every Lean file under `Proofs/` (and `Proofs.lean`),
at BASE against the working tree, read against a manifest of what this pass is ruled to do.

A theorem's statement is its text from its name to its first `:=` (whitespace-normalised; its docstring and its proof are not
part of it).  A definition's, structure's, abbrev's, instance's, inductive's or class's is its whole block to the next blank
line, since its body is its meaning.  A declaration is keyed by (file, name as written, occurrence index in the file).

The manifest (JSON) holds four lists; each entry is checked BOTH ways — it must have happened, and nothing else may have:
  "changed": ["File.lean:name", …]        the statement differs from BASE
  "gone":    ["File.lean:name", …]        declared at BASE, not in the working tree
  "added":   ["File.lean:name", …]        declared in the working tree, not at BASE
  "moved":   ["From.lean:To.lean:name", …] gone from From, added in To, the statement text identical
File names are paths relative to `Proofs/HadwigerNelson/`.  A stale entry (a ruled change that did not happen) fails like an
unruled change does.

  fs131_rp_stmt.py BASE MANIFEST               exit 0 iff the tree's changes are exactly the manifest's
  fs131_rp_stmt.py BASE MANIFEST --self-test   the unplanted run must pass, then six plants must each fail by name:
        an unruled statement change, an unruled deletion, an unruled addition, a moved statement altered on the way,
        a manifest entry that did not happen (stale), and a statement change hidden in a file the manifest does not name
"""
import collections
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = "Proofs/HadwigerNelson/"
HEAD = re.compile(r'^(?:@\[[^\]]*\]\s+)?(?:(?:private|protected|noncomputable|nonrec|scoped)\s+)*'
                  r'(theorem|lemma|def|structure|abbrev|instance|inductive|class) ([^\s:({\[]+)', re.M)


def git(*a):
    return subprocess.run(["git", *a], capture_output=True, text=True, check=True).stdout


def strip_comments(txt):
    """Block comments (nested) and line comments out; newlines kept so blank-line structure survives."""
    out, i, depth, n = [], 0, 0, len(txt)
    while i < n:
        if txt.startswith("/-", i):
            depth += 1
            i += 2
        elif depth and txt.startswith("-/", i):
            depth -= 1
            i += 2
        elif depth:
            if txt[i] == "\n":
                out.append("\n")
            i += 1
        elif txt.startswith("--", i):
            j = txt.find("\n", i)
            i = n if j < 0 else j
        else:
            out.append(txt[i])
            i += 1
    return "".join(out)


def stmts(txt):
    txt = strip_comments(txt)
    out, seen = {}, collections.Counter()
    for m in HEAD.finditer(txt):
        rest = txt[m.end():]
        if m.group(1) in ("theorem", "lemma"):
            body = rest[:rest.index(":=")] if ":=" in rest else rest
        else:
            j = rest.find("\n\n")
            body = rest if j < 0 else rest[:j]
        name = m.group(2)
        seen[name] += 1
        out[(name, seen[name])] = " ".join(body.split())
    return out


def lean_files_at(base):
    return [p for p in git("ls-tree", "-r", "--name-only", base, "Proofs", "Proofs.lean").splitlines() if p.endswith(".lean")]


def lean_files_wt():
    return sorted(str(p) for p in list(Path("Proofs").rglob("*.lean")) + [Path("Proofs.lean")])


def snapshot_base(base):
    return {p: stmts(git("show", f"{base}:{p}")) for p in lean_files_at(base)}


def snapshot_wt(mutate=None):
    out = {}
    for p in lean_files_wt():
        t = Path(p).read_text(encoding="utf-8")
        if mutate and p in mutate:
            t = mutate[p](t)
        out[p] = stmts(t)
    return out


def rel(p):
    return p[len(ROOT):] if p.startswith(ROOT) else p


def diff(base, wt):
    changed, gone, added = set(), set(), set()
    stm = {}
    for p in set(base) | set(wt):
        b, w = base.get(p, {}), wt.get(p, {})
        for k in set(b) | set(w):
            key = f"{rel(p)}:{k[0]}" + ("" if k[1] == 1 else f"#{k[1]}")
            if k in b and k in w:
                if b[k] != w[k]:
                    changed.add(key)
            elif k in b:
                gone.add(key)
                stm[("b", key)] = b[k]
            else:
                added.add(key)
                stm[("w", key)] = w[k]
    return changed, gone, added, stm


def check(base_snap, manifest, mutate=None, quiet=False):
    changed, gone, added, stm = diff(base_snap, snapshot_wt(mutate))
    want_changed, want_gone, want_added = set(manifest["changed"]), set(manifest["gone"]), set(manifest["added"])
    msgs = []
    for mv in manifest["moved"]:
        src, dst, name = mv.split(":")
        a, b = f"{src}:{name}", f"{dst}:{name}"
        want_gone.add(a)
        want_added.add(b)
        if ("b", a) in stm and ("w", b) in stm and stm[("b", a)] != stm[("w", b)]:
            msgs.append(f"MOVED-ALTERED {mv}")
    for label, got, want in (("CHANGED", changed, want_changed), ("GONE", gone, want_gone), ("ADDED", added, want_added)):
        for x in sorted(got - want):
            msgs.append(f"UNRULED-{label} {x}")
        for x in sorted(want - got):
            msgs.append(f"STALE-{label} {x} (in the manifest, did not happen)")
    if not quiet:
        for m in msgs:
            print(m)
        nb = sum(len(v) for v in base_snap.values())
        print(f"declarations at BASE: {nb} in {len(base_snap)} files; changed {len(changed)}, gone {len(gone)}, added {len(added)}; "
              f"manifest: changed {len(want_changed)}, gone {len(want_gone)}, added {len(want_added)} "
              f"(moved {len(manifest['moved'])}); deviations: {len(msgs)}")
        if nb == 0:
            print("NO DECLARATION READ — a failure, not a pass")
            return ["empty"]
    return msgs


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    base, manifest = argv[1], json.loads(Path(argv[2]).read_text())
    base_snap = snapshot_base(base)
    if "--self-test" not in argv:
        return 1 if check(base_snap, manifest) else 0
    if check(base_snap, manifest, quiet=True):
        print("SELF-TEST FAILED: the unplanted tree deviates from the manifest; run without --self-test")
        return 1
    V = ROOT + "Plane/ValidMap/"
    def sub(old, new):
        def f(t):
            if old not in t:
                raise SystemExit(f"SELF-TEST: plant text not found: {old[:60]!r}")
            return t.replace(old, new, 1)
        return f
    plants = {
        "an unruled statement change": ({V + "Chain.lean": sub("theorem IsModification.refl", "theorem IsModification.refl (h0 : True)")}, "UNRULED-CHANGED"),
        "an unruled deletion": ({V + "Chain.lean": sub("theorem IsModification.refl", "theorem IsModification.refl_renamed")}, "UNRULED-GONE"),
        "an unruled addition": ({V + "Chain.lean": lambda t: t + "\ntheorem rp_planted : True := trivial\n"}, "UNRULED-ADDED"),
        "a moved statement altered": ({ROOT + "Plane/Basic.lean": sub("theorem conj_e (θ : ℝ)", "theorem conj_e (θ : ℝ) (h0 : True)")}, "MOVED-ALTERED"),
        "a change in a file outside the manifest": ({ROOT + "Kempe.lean": lambda t: t + "\ntheorem rp_planted_far : True := trivial\n"}, "UNRULED-ADDED"),
    }
    ok = True
    for name, (mut, want) in plants.items():
        msgs = check(base_snap, manifest, mutate=mut, quiet=True)
        fired = any(m.startswith(want) for m in msgs)
        print(f"plant '{name}': {'FIRED' if fired else 'SILENT'} — {msgs[0] if msgs else 'no message'}")
        ok = ok and fired
    stale = json.loads(json.dumps(manifest))
    stale["changed"].append("Plane/ValidMap/Chain.lean:IsModification.refl")
    msgs = check(base_snap, stale, quiet=True)
    fired = any(m.startswith("STALE-CHANGED") for m in msgs)
    print(f"plant 'a manifest entry that did not happen': {'FIRED' if fired else 'SILENT'} — {msgs[0] if msgs else 'no message'}")
    ok = ok and fired
    print("SELF-TEST", "OK: the unplanted run passes; 6 plants" if ok else "FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv))
