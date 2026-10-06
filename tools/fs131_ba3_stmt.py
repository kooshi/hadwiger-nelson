#!/usr/bin/env python3
"""FS131-BA3: no statement or definition changed between the tree as given (`dae3d93e`) and the working tree, but the three ruled
removals of unread hypotheses (inventory ruling 457 (b)).
(FS131-BA1's `tools/fs131_ba1_stmt.py` under this job's prefix — its pinned-rewrite form — with EDITABLE set to this job's two files
and the base moved to the commit FS131-BA2 handed back; standing rule 7 bars editing another job's tool.)

  python3 tools/fs131_ba3_stmt.py                    # exit 0 iff the checks hold (the three ruled changes made, exactly)
  python3 tools/fs131_ba3_stmt.py --before-ruled     # Stage 1's form: no statement at all may differ from the base
  python3 tools/fs131_ba3_stmt.py --self-test        # plants faults in memory; each must fire; the unplanted run must pass

Checks, for every `.lean` file under `Proofs/` (and `Proofs.lean`) that exists at the base:
1. a file outside EDITABLE (`HornChart`, `BendGap`) is byte-identical to the base — so `BendStep`, `BendCollar`, `CollarMap`, the other
   half's three modules, `Procedure`, `Terminal` and `Proofs.lean` are untouched;
2. in an EDITABLE file, every declaration of the base is declared exactly once with an identical statement — for a theorem the header
   up to its first `:=` (no theorem of these files has a `:=` inside a binder), for a `def`/`structure`/`inductive` the whole
   declaration — except the names in ALLOW, each with the rewrite its ruling made: the new statement must be EXACTLY the base's with
   that rewrite applied (so a ruled change left undone fails, and so does any other change to the same declaration);
3. every name in ALLOW was met in an EDITABLE file (a checker that read no ruled statement says so);
4. no `axiom` declaration and no `native_decide` in any file under `Proofs/` that is new or EDITABLE.
New declarations and new files are listed, not judged. Docstrings and proofs are not statements here.
"""
import re
import subprocess
import sys
from pathlib import Path

V = "Proofs/HadwigerNelson/Plane/ValidMap/"
RULED = {
    "hasHornCount_zero_of_two_spheres": [("(hρ : 0 < ρ) (hρ' : 0 < ρ') ", "")],
    "hasHornCount_iff_of_germ_swap": [("(hκ : |κ₀| * r < 2) ", "")],
    "CollarFitOut.map_hornCount_le": [("(hF : F.Valid) ", "")],
}
ALLOW = dict(RULED)
EDITABLE = {V + "HornChart.lean", V + "BendGap.lean"}
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
            block = block.split(":=", 1)[0]
        out.setdefault(name, []).append(re.sub(r"\s+", " ", block).strip())
    return out


def check(base, tree_text=None, extra=None):
    """tree_text: {path: text} overrides of the working tree (for plants); extra: {path: text} new files."""
    tree_text = tree_text or {}
    bad = []
    base_files = [f for f in git("ls-tree", "-r", "--name-only", base, "--", "Proofs", "Proofs.lean").split("\n") if f.endswith(".lean")]
    seen_editable, seen_allow = 0, set()
    for f in base_files:
        old = git("show", f"{base}:{f}")
        p = Path(f)
        new = tree_text.get(f, p.read_text() if p.exists() else None)
        if new is None:
            bad.append(f"DELETED {f}"); continue
        if f in EDITABLE:
            seen_editable += 1
        if f not in EDITABLE:
            if new != old:
                bad.append(f"CHANGED (not editable) {f}")
            continue
        do, dn = decls(old), decls(new)
        for name, stmts in do.items():
            if name not in dn:
                bad.append(f"MISSING {f}: {name}")
            elif len(dn[name]) != len(stmts):
                bad.append(f"COUNT {f}: {name} declared {len(dn[name])} time(s), base {len(stmts)}")
            elif name in ALLOW:
                seen_allow.add(name)
                want = stmts[0]
                for a, b in ALLOW[name]:
                    if a not in want:
                        bad.append(f"ALLOW {f}: {name}: the base statement does not hold {a!r}")
                    want = want.replace(a, b, 1)
                if dn[name][0] != want:
                    bad.append(f"STATEMENT {f}: {name} is not the base's with the ruled rewrite\n    want: {want}\n    have: {dn[name][0]}")
                else:
                    print(f"ruled statement change, exactly as ruled: {f}: {name}\n    now: {dn[name][0]}")
            elif dn[name] != stmts:
                bad.append(f"STATEMENT {f}: {name}")
        for name in dn:
            if name not in do:
                print(f"new declaration: {f}: {name}")
    if seen_editable != len(EDITABLE):
        bad.append(f"EDITABLE: {seen_editable} of {len(EDITABLE)} editable files found at the base — the checker read the wrong tree")
    if seen_allow != set(ALLOW):
        bad.append(f"ALLOW: ruled names never met in an editable file: {sorted(set(ALLOW) - seen_allow)}")
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
    global ALLOW
    base = "dae3d93e"
    if "--base" in sys.argv:
        base = sys.argv[sys.argv.index("--base") + 1]
    if "--before-ruled" in sys.argv:
        ALLOW = {}
        sys.exit(check(base))
    if "--self-test" in sys.argv:
        hc, bg = V + "HornChart.lean", V + "BendGap.lean"
        bc, bs, cm = V + "BendCollar.lean", V + "BendStep.lean", V + "CollarMapOut.lean"
        T = {f: Path(f).read_text() for f in (hc, bg, bc, bs, cm)}
        r1 = "(h : hfit.map.IsRingArc Q a b d d') : F.IsRingArc Q a b d d'"
        r2 = "(h : F.IsRingArc Q a b d d') (hd : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) :"
        s2 = "theorem hasHornCount_zero_of_two_spheres {x q q' : ℂ} {ρ ρ' r : ℝ} (hx : x ∈ F.dom) (hr : 0 < r)"
        gs = "theorem hasHornCount_iff_of_germ_swap {M : ArcMap k} {x : ℂ} {β₀ κ₀ κ₀' r : ℝ} (hx : x ∈ F.dom) (hdom : M.dom = F.dom)"
        hl = "theorem CollarFitOut.map_hornCount_le (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} {j : ℕ}"
        cf = "theorem exists_collarFitOut (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)"
        for txt, a in [(T[bg], r1), (T[bg], r2), (T[hc], s2), (T[hc], gs), (T[bg], hl), (T[bg], cf),
                       (T[hc], "(hκ' : |κ₀'| * r < 2)"), (T[bg], "theorem CollarFitOut.map_R2 ")]:
            assert a in txt, f"a plant's anchor is gone: {a}"
        plants = {
            "a ruled removal left undone (hρ, hρ' back in hasHornCount_zero_of_two_spheres)":
                ({hc: T[hc].replace(s2, s2 + " (hρ : 0 < ρ) (hρ' : 0 < ρ')", 1)}, None),
            "a ruled removal left undone (hκ back in hasHornCount_iff_of_germ_swap)":
                ({hc: T[hc].replace("(hr : 0 < r) (hκ' : |κ₀'| * r < 2)", "(hr : 0 < r) (hκ : |κ₀| * r < 2) (hκ' : |κ₀'| * r < 2)", 1)}, None),
            "a ruled removal left undone (hF back in CollarFitOut.map_hornCount_le)":
                ({bg: T[bg].replace("theorem CollarFitOut.map_hornCount_le (hfit", "theorem CollarFitOut.map_hornCount_le (hF : F.Valid) (hfit", 1)}, None),
            "a second change to a ruled statement (hκ' dropped from the swap lemma too)":
                ({hc: T[hc].replace("(hκ' : |κ₀'| * r < 2) ", "", 1)}, None),
            "a second change to a ruled statement (the horn clause's conclusion weakened)":
                ({bg: T[bg].replace(hl + "\n    (hj : F.HasHornCount x j) : ∃ j' ≤ j,", hl + "\n    (hj : F.HasHornCount x j) : ∃ j',", 1)}, None),
            "map_R1's conclusion changed": ({bg: T[bg].replace(r1, r1.replace("F.IsRingArc Q a b d d'", "F.IsRingArc Q a b d' d"), 1)}, None),
            "map_R1 gains a hypothesis": ({bg: T[bg].replace(r1, "(hQ : Q ≠ P) " + r1, 1)}, None),
            "map_R2 loses its disjointness hypothesis": ({bg: T[bg].replace(r2, "(h : F.IsRingArc Q a b d d') :", 1)}, None),
            "map_R2 renamed": ({bg: T[bg].replace("theorem CollarFitOut.map_R2 ", "theorem CollarFitOut.map_R2' ", 1)}, None),
            "a hypothesis dropped from a proved theorem (exists_collarFitOut)": ({bg: T[bg].replace(cf, cf.replace(" (hin : c ∉ F.coloursAt P)", ""), 1)}, None),
            "an edit to the toward bend's module (BendCollar)": ({bc: T[bc] + "\n-- planted\n"}, None),
            "an edit to BendStep (its horn child keeps hF)": ({bs: T[bs].replace("theorem CollarFit.map_hornCount_le (hF : F.Valid) (hfit", "theorem CollarFit.map_hornCount_le (hfit", 1)}, None),
            "an edit to the other half's module (CollarMapOut)": ({cm: T[cm] + "\n-- planted\n"}, None),
            "an axiom in a new file": (None, {"Proofs/Planted.lean": "axiom planted : False\n"}),
            "an axiom in an editable file": ({bg: T[bg] + "\naxiom planted : False\n"}, None),
            "native_decide in an editable file": ({hc: T[hc] + "\nexample : 1 = 1 := by native_decide\n"}, None),
        }
        assert "theorem CollarFit.map_hornCount_le (hF : F.Valid) (hfit" in T[bs], "the BendStep plant's anchor is gone"
        ok = True
        for label, (tt, ex) in plants.items():
            if tt:
                for f, t in tt.items():
                    assert t != T[f], f"plant [{label}] planted nothing"
            rc = check(base, tt, ex)
            print(f"PLANT [{label}]: {'FIRED' if rc else 'DID NOT FIRE'}")
            ok = ok and rc != 0
        rc0 = check(base)
        print(f"UNPLANTED: {'PASS' if rc0 == 0 else 'FAIL'}")
        print(f"{len(plants)} plants")
        sys.exit(0 if ok and rc0 == 0 else 1)
    sys.exit(check(base))


if __name__ == "__main__":
    main()
