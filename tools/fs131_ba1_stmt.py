#!/usr/bin/env python3
"""FS131-BA1: no statement or definition changed between the skeleton's commit and the working tree, but the one ruled change.
(FS131-KA1's `tools/fs131_ka_stmt.py` under this job's prefix, with `EDITABLE` extended to this job's files and the base moved to the
skeleton's commit, as the brief's "Done means" item 5 asks; standing rule 7 bars editing another job's tool.)

  python3 tools/fs131_ba1_stmt.py [--base dd8c2c33]           # exit 0 iff the checks hold
  python3 tools/fs131_ba1_stmt.py --self-test                 # plants faults in memory; each must fire

Checks, for every `.lean` file under `Proofs/` (and `Proofs.lean`) that exists at the base:
1. a file outside EDITABLE is byte-identical to the base (so `R2Cap`, `HornChart`, `BendGap`, the toward bend's modules, `Procedure`,
   `Terminal` are untouched on this branch);
2. in an EDITABLE file, every declaration of the base is declared exactly once with an identical statement — for a theorem the header
   up to its first `:=` (no theorem of these files has a `:=` inside a binder), for a `def`/`structure`/`inductive` the whole
   declaration — except:
   * the names in ALLOW, each with the rewrites a ruling made: the new statement must be EXACTLY the base's with those rewrites
     applied (so a ruled change left undone fails, and so does any other change to the same declaration) —
     `AwayBend.idle` loses `hA` and `hε`, and with `hA` its implicit `c'` (inventory ruling 446 (b));
     `dist_lt_one_of_thin` loses `hκ0` (inventory ruling 452 (a));
   * the names in DEF_UPTO, defs whose proof fields this job fills: the declaration is compared up to the marker (for `pushOutHomeo`,
     up to `left_inv`: its `toFun` and `invFun` are the definition, the four fields after them are proofs);
3. in `BendStep.lean` the only changed line is the call of `AwayBend.idle` in `bend_away_subdiv`;
4. no `axiom` declaration and no `native_decide` in any file under `Proofs/` that is new or EDITABLE.
New declarations and new files are listed, not judged. Docstrings are not statements here.
"""
import re
import subprocess
import sys
from pathlib import Path

V = "Proofs/HadwigerNelson/Plane/ValidMap/"
ALLOW = {
    "AwayBend.idle": [("{c c' : Fin k} (hA : F.IsRingArc P a b c c') ", "{c : Fin k} "), ("{ε : ℝ} (hε : 0 < ε) :", "{ε : ℝ} :")],
    "dist_lt_one_of_thin": [("(hκ0 : 0 ≤ κ) ", "")],
}
DEF_UPTO = {"pushOutHomeo": "left_inv"}
EDITABLE = {V + "LensOut.lean", V + "CollarMapOut.lean", V + "BendAway.lean", V + "BendStep.lean"}
ONE_LINE = {V + "BendStep.lean": "AwayBend.idle"}
DECL = re.compile(r"^(?:private |protected |noncomputable )*(theorem|lemma|def|structure|inductive|abbrev|instance)\s+([^\s:({\[]+)", re.M)
STOP = re.compile(r"^(?:/--|/-!|end |namespace |section|variable |open |example|#|(?:private |protected |noncomputable )*(?:theorem|lemma|def|structure|inductive|abbrev|instance)\s)", re.M)


def git(*a):
    return subprocess.run(["git", *a], check=True, capture_output=True, text=True).stdout


def decls(text):
    out = {}
    for m in DECL.finditer(text):
        kind, name = m.group(1), m.group(2)
        nxt = STOP.search(text, m.end())
        block = text[m.start(): nxt.start() if nxt else len(text)]
        if kind in ("theorem", "lemma"):
            block = re.sub(r"\s+", " ", block.split(":=", 1)[0])
            block = re.split(r" (?:where|by)\b", block, maxsplit=1)[0] if name in ALLOW else block
        elif name in DEF_UPTO:
            if DEF_UPTO[name] not in block:
                block = block + " <<MARKER MISSING>>"
            block = block.split(DEF_UPTO[name], 1)[0]
        out.setdefault(name, []).append(re.sub(r"\s+", " ", block).strip())
    return out


def check(base, tree_text=None, extra=None):
    """tree_text: {path: text} overrides of the working tree (for plants); extra: {path: text} new files."""
    tree_text = tree_text or {}
    bad = []
    base_files = [f for f in git("ls-tree", "-r", "--name-only", base, "--", "Proofs", "Proofs.lean").split("\n") if f.endswith(".lean")]
    seen_editable = 0
    for f in base_files:
        old = git("show", f"{base}:{f}")
        p = Path(f)
        new = tree_text.get(f, p.read_text() if p.exists() else None)
        if new is None:
            bad.append(f"DELETED {f}"); continue
        if f in EDITABLE:
            seen_editable += 1
        if new == old:
            continue
        if f not in EDITABLE:
            bad.append(f"CHANGED (not editable) {f}"); continue
        do, dn = decls(old), decls(new)
        for name, stmts in do.items():
            if name not in dn:
                bad.append(f"MISSING {f}: {name}")
            elif len(dn[name]) != len(stmts):
                bad.append(f"COUNT {f}: {name} declared {len(dn[name])} time(s), base {len(stmts)}")
            elif name in ALLOW:
                want = stmts[0]
                for a, b in ALLOW[name]:
                    if a not in want:
                        bad.append(f"ALLOW {f}: {name}: the base statement does not hold {a!r}")
                    want = want.replace(a, b, 1)
                if dn[name][0] != want:
                    bad.append(f"STATEMENT {f}: {name} is not the base's with the ruled rewrites\n    want: {want}\n    have: {dn[name][0]}")
                else:
                    print(f"ruled statement change, exactly as ruled: {f}: {name}\n    now: {dn[name][0]}")
            elif dn[name] != stmts:
                bad.append(f"STATEMENT {f}: {name}")
        for name in dn:
            if name not in do:
                print(f"new declaration: {f}: {name}")
        if f in ONE_LINE:
            o, n = old.split("\n"), new.split("\n")
            if len(o) != len(n):
                bad.append(f"LINES {f}: {len(o)} lines at the base, {len(n)} now (only one line may change)")
            else:
                diff = [i + 1 for i, (x, y) in enumerate(zip(o, n)) if x != y]
                if len(diff) > 1 or any(ONE_LINE[f] not in o[i - 1] for i in diff):
                    bad.append(f"LINES {f}: changed lines {diff}; only the one holding `{ONE_LINE[f]}` may change")
                else:
                    print(f"changed line(s) of {f}: {diff}")
    if seen_editable != len(EDITABLE):
        bad.append(f"EDITABLE: {seen_editable} of {len(EDITABLE)} editable files found at the base — the checker read the wrong tree")
    tracked = set(base_files)
    news = [str(p) for p in list(Path("Proofs").rglob("*.lean")) if str(p) not in tracked]
    for f in sorted(news):
        print(f"new file: {f}")
    scan = {f: Path(f).read_text() for f in news}
    scan.update({f: tree_text.get(f, Path(f).read_text()) for f in EDITABLE})
    scan.update(extra or {})
    for f, t in scan.items():
        if re.search(r"^\s*(?:private |protected )?axiom\s", t, re.M):
            bad.append(f"AXIOM in {f}")
        if "native_decide" in re.sub(r"/-.*?-/", "", t, flags=re.S):
            bad.append(f"native_decide in {f}")
    for b in bad:
        print("FAIL", b)
    print(f"{len(base_files)} base files, {len(news)} new files, {len(bad)} failures")
    return 1 if bad else 0


def main():
    base = "dd8c2c33"
    if "--base" in sys.argv:
        base = sys.argv[sys.argv.index("--base") + 1]
    if "--self-test" in sys.argv:
        lo, cm, ba, bs = (V + "LensOut.lean", V + "CollarMapOut.lean", V + "BendAway.lean", V + "BendStep.lean")
        g = V + "BendGap.lean"
        T = {f: Path(f).read_text() for f in (lo, cm, ba, bs, g)}

        def rep(f, a, b):
            assert a in T[f], f"the plant's anchor is gone: {a!r} in {f}"
            return {f: T[f].replace(a, b, 1)}
        plants = {
            "a changed hypothesis of a theorem (collarOutArcs_carrier)": (rep(lo, "theorem collarOutArcs_carrier {P : ℂ} {θ₁ θ₂ R : ℝ} (hR : 1 < R)", "theorem collarOutArcs_carrier {P : ℂ} {θ₁ θ₂ R : ℝ} (hR : 1 ≤ R)"), None),
            "a ruled change left undone (dist_lt_one_of_thin with hκ0 back)": (rep(lo, "(h2 : φ₂ < α₂) (hκ : κ ≤ 1 / 8)", "(h2 : φ₂ < α₂) (hκ0 : 0 ≤ κ) (hκ : κ ≤ 1 / 8)"), None),
            "a second change to a ruled statement (dist_lt_one_of_thin's bound)": (rep(lo, "(h2 : φ₂ < α₂) (hκ : κ ≤ 1 / 8)", "(h2 : φ₂ < α₂) (hκ : κ ≤ 1 / 4)"), None),
            "a second change to a ruled statement (AwayBend.idle's conclusion)": (rep(ba, "AwayBend F F (Homeomorph.refl ℂ) ∅ P a b c ε where", "AwayBend F F (Homeomorph.refl ℂ) ∅ P a a c ε where"), None),
            "a changed data field of a def with proof fields (pushOutHomeo.toFun)":
                (rep(lo, "toFun := radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) 1 (l θ) (b θ) t)",
                     "toFun := radialMap P ((θ₁ + θ₂) / 2) (fun θ t => push1 (a θ) 1 (b θ) (b θ) t)"), None),
            "a changed field of a structure (CollarFitOut.params)": (rep(cm, "R < R'' ∧ R ≤ 9 / 8", "R < R'' ∧ R ≤ 9 / 7"), None),
            "a changed field of a structure (AwayBend.rest)": (rep(ba, "P + 2 * e θ ∉ closure (F.region c)}.Finite", "P + 2 * e θ ∉ closure (F.region c)}.Countable"), None),
            "a renamed theorem (AwayBend.next)": (rep(ba, "theorem AwayBend.next", "theorem AwayBend.next'"), None),
            "a changed conclusion in BendStep (bend_away_subdiv)": (rep(bs, "∀ ε : ℝ, 0 < ε → ε ≤ 1 / 2 →", "∀ ε : ℝ, 0 < ε → ε ≤ 1 / 3 →"), None),
            "a second changed line in BendStep (a proof line)": (rep(bs, "have hab := h1.lt", "have hab := h1.lt  -- planted"), None),
            "an edit to a file that is not editable (BendGap, the other half's)": ({g: T[g] + "\n-- planted\n"}, None),
            "an axiom in a new file": (None, {"Proofs/Planted.lean": "axiom planted : False\n"}),
            "native_decide in an editable file": ({lo: T[lo] + "\nexample : 1 = 1 := by native_decide\n"}, None),
        }
        ok = True
        for label, (tt, ex) in plants.items():
            rc = check(base, tt, ex)
            print(f"PLANT [{label}]: {'FIRED' if rc else 'DID NOT FIRE'}")
            ok = ok and rc != 0
        rc0 = check(base)
        print(f"UNPLANTED: {'PASS' if rc0 == 0 else 'FAIL'}")
        sys.exit(0 if ok and rc0 == 0 else 1)
    sys.exit(check(base))


if __name__ == "__main__":
    main()
