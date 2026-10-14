#!/usr/bin/env python3
"""FS131-IPD1: the port's registration (plans/FS131-KO1-port-plan.md § 4.2, lane D), written from the files as they
stand at a base revision, and checked.

* `Proofs.lean`: the 31 generated modules and `Outside/OAI158Collapse`, one `import` line each, after the line of
  `Outside/OAI158AngularBoundary`, in the generator's dependency order (`FILES`), `OAI158Collapse` last;
* `ARCHITECTURE.md` § 3: one row per new module after `Outside/OAI158AngularBoundary`'s row, its imports cell the
  module's `Proofs` imports as generated; and the text of three rows: `Outside/OAI158` (one outside theorem, the transfer
  a theorem of the port, its consumers moved), `Plane/RadiusOutside` and `Plane/LebesgueNumber` (their imports cell —
  `Outside/OAI158Collapse` for `Outside/OAI158` — and the words that called the transfer a declared outside theorem);
* `scripts/Axioms.lean`: the `declareImport` of `proper_to_borel_weak` removed; its twelve records moved, with their
  comment lines, from IMPORTED to CLEAN (just above the PURCHASED banner, where the waves append); under them the
  generated block of the 31 modules (`tools/fs131_ko1_port.py --axioms-block`); the IMPORTED banner's prose on the
  number of imports made true (two).

Usage: fs131_ipd1_register.py apply <rev> | check <rev> | --control <rev>
  check: every change is exactly the planned one (the files' text at <rev> with the edits above, and no other line
  changed); --control plants an extra line in each file in turn and a record left under IMPORTED, each to be reported.
"""
import importlib.util
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location("port", ROOT / "tools/fs131_ko1_port.py")
port = importlib.util.module_from_spec(spec)
spec.loader.exec_module(port)

PFX = "Proofs.HadwigerNelson.Outside."
MODS = [port.ours(m) for m, _ in port.FILES]
NEW = MODS + ["OAI158Collapse"]
ANCHOR_IMPORT = "import Proofs.HadwigerNelson.Outside.OAI158AngularBoundary"
ANCHOR_ROW = "| `Outside/OAI158AngularBoundary` |"
T_DECLARE = "#eval AxiomAudit.declareImport ``HadwigerNelson.Outside.OAI158.proper_to_borel_weak"
T_GROUPS = [
    ("-- FS132-I1: the records resting on `proper_to_borel_weak`", 5),
    ("-- FS124-I1: the radius clause's records resting on `proper_to_borel_weak`", 4),
    ("-- FS131-KC1: the measurable number's records resting on `proper_to_borel_weak`", 3),
]
PURCHASED = '#eval IO.println "=== PURCHASED ==="'
OLD_PROSE = ("The library\ndeclares three imports at present: wave 10's `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207, "
             "FS131-K10c), with\neight records below, and FS-132's `Outside.OAI158.no_proper_five_coloring` and "
             "`Outside.OAI158.proper_to_borel_weak`\n(`[OAIMath2026]` family 158, FS132-I1), with six and twelve (the fifth "
             "on the transfer is FS132-L1's; one on the first and four on\nthe transfer are of FS-124's radius clause, "
             "`Plane/RadiusOutside`, FS124-I1, landed by FS124-L1; three more on the transfer are of\nFS-131's measurable "
             "number, `Plane/LebesgueNumber`, FS131-KC1, landed by FS131-LC1); its first, wave 2's\n"
             "`falconer_lemma2_nonempty`, is a theorem since FS131-IF1 (FS131-L10B's join).")
NEW_PROSE = ("The library\ndeclares two imports at present: wave 10's `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207, "
             "FS131-K10c), with\nthe records below, and FS-132's `Outside.OAI158.no_proper_five_coloring` (`[OAIMath2026]` "
             "family 158, FS132-I1), with six\n(one of them FS-124's radius clause, `Plane/RadiusOutside`). Its first, "
             "wave 2's `falconer_lemma2_nonempty`, is a\ntheorem since FS131-IF1 (FS131-L10B's join), and FS-132's second, "
             "`Outside.OAI158.proper_to_borel_weak`, since the\nport of its proof (FS-131, FS131-IPD1): its twelve records "
             "are under CLEAN.")


def at_rev(rev, path):
    return subprocess.run(["git", "-C", str(ROOT), "show", f"{rev}:{path}"], check=True, capture_output=True,
                          text=True).stdout


def ported_imports(mod):
    text = (ROOT / f"Proofs/HadwigerNelson/Outside/{mod}.lean").read_text()
    return [ln.split()[1][len("Proofs.HadwigerNelson."):].replace(".", "/") for ln in text.split("\n")
            if ln.startswith("import Proofs.")]


def row(mod):
    rel = port.REL_OF_MOD[mod][1] if mod in port.REL_OF_MOD else None
    imps = ", ".join(f"`{x}`" for x in ported_imports(mod)) or "—"
    if mod == "OAI158Collapse":
        return ("| `Outside/OAI158Collapse` | **FS-132 (job FS132-I1; the criterion FS132-L1's), moved by FS-131 (job "
                "FS131-IPD1, the switch).** The transfer's consumers, on the standard three axioms now that "
                "`proper_to_borel_weak` is a theorem of the port (`Outside/OAI158BorelTransfer`): "
                "`nonempty_aeColouring_of_colorable`, `colorable_iff_nonempty_aeColouring`, "
                "`chiM0_le_chromaticNumber_plane`, `chromaticNumber_plane_eq_chiM0` (`χ(ℝ²) = χ_m⁰(ℝ²)`, with no measure "
                "rigidity), and `seven_le_chromaticNumber_plane_iff` (row 131's criterion for the plane's chromatic number "
                "itself, `7 ≤ χ(ℝ²) ⟺ sup_{ε > 0} µ₆(ε) < 1`) — moved from `Outside/OAI158` character for character "
                f"with their docstrings. | {imps} | 130, 131 | FS-132 |")
    q = port.generate([mod])[1][mod]
    extra = ""
    if mod == "OAI158BorelTransfer":
        extra = (" The transfer itself, `proper_to_borel_weak` — the theorem this library declared as an axiom in "
                 "`Outside/OAI158` until FS131-IPD1's switch — under its name, its stored statement the axiom's.")
    if mod == "OAI158Ergodicity":
        extra = (" With `Spectral.residual_fourier`, the theorem the density equality's branch `fs133-wb1` declares as an "
                 "axiom (its join takes it from here).")
    return (f"| `Outside/{mod}` | **FS-131 (jobs FS131-KO1 … FS131-IPD1). Ported whole from `[OAIMath2026]` family 158** "
            f"at commit `adc7f124` — generated by `tools/fs131_ko1_port.py` from its table "
            f"(`data/fs131/ko1/port/{mod}.json`): the release file `{rel}`, all its {q['total']} declarations; proofs the "
            "release's, kernel-checked at this pin; no axiom, no `sorry`; every change listed in the module's header "
            f"(patches to proofs, renames, and each ADAPTED or RULED entry). Part of the transfer's proof.{extra} | "
            f"{imps} | {'130' if mod == 'OAI158BorelTransfer' else '—'} | FS-131 |")


OAI_ROW_EDITS = [
    ("**FS-132 (job FS132-I1). Two imported outside theorems** of", "**FS-132 (job FS132-I1). One imported outside theorem** of"),
    ("audited, `plans/EXT-OAI1-audit.md`), each an `axiom` in the release's own form",
     "audited, `plans/EXT-OAI1-audit.md`), an `axiom` in the release's own form"),
    ("`no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair — and `proper_to_borel_weak` — a proper "
     "`k`-colouring of `ℂ` gives a Borel `k`-colouring proper at almost every unit pair (§ Trust).",
     "`no_proper_five_coloring` — no map `ℂ → Fin 5` separates every unit pair (§ Trust). The second, the transfer "
     "`proper_to_borel_weak` — a proper `k`-colouring of `ℂ` gives a Borel `k`-colouring proper at almost every unit "
     "pair — was an `axiom` here until FS-131 ported its proof (`Outside/OAI158BorelTransfer`, FS131-IPD1); its "
     "consumers are in `Outside/OAI158Collapse`."),
    ("On the first axiom: `not_colorable_five`", "On the axiom: `not_colorable_five`"),
    (" On the second: `nonempty_aeColouring_of_colorable`, `colorable_iff_nonempty_aeColouring`, "
     "`chiM0_le_chromaticNumber_plane`, `chromaticNumber_plane_eq_chiM0` (`χ(ℝ²) = χ_m⁰(ℝ²)`, with no measure "
     "rigidity), and `seven_le_chromaticNumber_plane_iff` (job FS132-L1: row 131's criterion for the plane's chromatic "
     "number itself, `7 ≤ χ(ℝ²) ⟺ sup_{ε > 0} µ₆(ε) < 1`).", ""),
]
RADIUS_EDITS = [
    ("on the two imported outside theorems of `Outside/OAI158`.**",
     "on the imported outside theorem of `Outside/OAI158` and the transfer, a theorem of the port "
     "(`Outside/OAI158Collapse`).**"),
    ("| `Plane/Radius`, `Outside/OAI158` |", "| `Plane/Radius`, `Outside/OAI158Collapse` |"),
]
LEBESGUE_EDITS = [
    ("and, on the declared outside theorem `Outside.OAI158.proper_to_borel_weak`, `chromaticNumber_plane_eq_chiLebesgue`",
     "and, on the transfer `Outside.OAI158.proper_to_borel_weak` (a theorem of the port since FS131-IPD1), "
     "`chromaticNumber_plane_eq_chiLebesgue`"),
    ("| `Outside/OAI158`, `Plane/FalconerReduction`,", "| `Outside/OAI158Collapse`, `Plane/FalconerReduction`,"),
]


def edit_once(text, old, new, where):
    if text.count(old) != 1:
        raise SystemExit(f"{where}: {old[:60]!r} is not there exactly once ({text.count(old)})")
    return text.replace(old, new, 1)


def make(rev):
    out = {}
    p = at_rev(rev, "Proofs.lean")
    out["Proofs.lean"] = edit_once(p, ANCHOR_IMPORT + "\n", ANCHOR_IMPORT + "\n" + "".join(f"import {PFX}{m}\n" for m in NEW),
                                   "Proofs.lean")
    a = at_rev(rev, "ARCHITECTURE.md").split("\n")
    i = [k for k, ln in enumerate(a) if ln.startswith(ANCHOR_ROW)]
    if len(i) != 1:
        raise SystemExit("ARCHITECTURE.md: the anchor row is not there exactly once")
    a = a[:i[0] + 1] + [row(m) for m in NEW] + a[i[0] + 1:]
    for k, ln in enumerate(a):
        if ln.startswith("| `Outside/OAI158` |"):
            for o, n in OAI_ROW_EDITS:
                ln = edit_once(ln, o, n, "the Outside/OAI158 row")
            a[k] = ln
        elif ln.startswith("| `Plane/RadiusOutside` |"):
            for o, n in RADIUS_EDITS:
                ln = edit_once(ln, o, n, "the Plane/RadiusOutside row")
            a[k] = ln
        elif ln.startswith("| `Plane/LebesgueNumber` |"):
            for o, n in LEBESGUE_EDITS:
                ln = edit_once(ln, o, n, "the Plane/LebesgueNumber row")
            a[k] = ln
    out["ARCHITECTURE.md"] = "\n".join(a)
    x = at_rev(rev, "scripts/Axioms.lean")
    x = edit_once(x, T_DECLARE + "\n", "", "scripts/Axioms.lean")
    x = edit_once(x, OLD_PROSE, NEW_PROSE, "scripts/Axioms.lean (IMPORTED prose)")
    ls = x.split("\n")
    moved = []
    for head, n in T_GROUPS:
        k = [j for j, ln in enumerate(ls) if ln.startswith(head)]
        if len(k) != 1:
            raise SystemExit(f"Axioms.lean: {head!r} is not there exactly once")
        grp = ls[k[0]:k[0] + 1 + n]
        if not all(g.startswith("#print axioms ") for g in grp[1:]) or \
                (k[0] + 1 + n < len(ls) and ls[k[0] + 1 + n].startswith("#print axioms ")):
            raise SystemExit(f"Axioms.lean: the group {head!r} is not {n} records")
        moved.extend(grp)
        del ls[k[0]:k[0] + 1 + n]
    blk = port.axioms_block(MODS, port.generate(MODS)[1])
    nrec = sum(1 for b in blk if b.startswith("#print axioms "))
    new = ["/-! ## FS131-IPD1 — the port of `[OAIMath2026]`'s transfer proof: the transfer is a theorem, and the 31 ported "
           "modules",
           "",
           "`Outside.OAI158.proper_to_borel_weak` is the release's theorem, its proof ported (`Outside/OAI158BorelTransfer`, "
           "FS-131, the port",
           "of `plans/FS131-KO1-port-plan.md`): its `declareImport` is gone, and the twelve records that rested on it are "
           "here, under CLEAN,",
           "with their comment lines (five of them now in `Outside/OAI158Collapse`, moved there by the switch). Under them, "
           f"the {nrec} records of",
           "the 31 ported modules, generated by `tools/fs131_ko1_port.py --axioms-block` (every copied declaration, "
           "instances and the instances",
           "a `deriving` clause declares included; the one private declaration in a `section` that opens it). No axiom, "
           "no outside theorem. -/"]
    new += moved
    new += ["-- FS131-IPD1 block: the 31 ported modules (generated)"] + blk + ["-- FS131-IPD1 block end", ""]
    k = [j for j, ln in enumerate(ls) if ln == PURCHASED]
    if len(k) != 1:
        raise SystemExit("Axioms.lean: the PURCHASED banner is not there exactly once")
    ls = ls[:k[0]] + new + ls[k[0]:]
    out["scripts/Axioms.lean"] = "\n".join(ls)
    return out, nrec


def check(rev, files=None, quiet=False):
    files = files or {}
    want, nrec = make(rev)
    bad = []
    for p, w in want.items():
        g = files[p] if p in files else (ROOT / p).read_text()
        if g != w:
            gl, wl = g.split("\n"), w.split("\n")
            i = next((j for j, (a, b) in enumerate(zip(gl, wl)) if a != b), min(len(gl), len(wl)))
            bad.append(f"{p}: not the planned text (first difference at line {i + 1})")
    ax = files.get("scripts/Axioms.lean", (ROOT / "scripts/Axioms.lean").read_text())
    imp = ax.split("=== IMPORTED ===", 1)[1].split("=== CLEAN ===", 1)[0]
    if "proper_to_borel_weak" in "\n".join(ln for ln in imp.split("\n") if ln.startswith(("#print", "#eval"))):
        bad.append("scripts/Axioms.lean: a record or a declaration of the transfer is still under IMPORTED")
    if not quiet:
        for b in bad:
            print("FAIL:", b)
        print(f"REGISTER-CHECK {'OK' if not bad else 'FAILED'}: {len(NEW)} modules, {len(NEW)} rows, {nrec} generated "
              f"records and 12 moved")
    return bad


def main():
    cmd, rev = sys.argv[1], sys.argv[2]
    if cmd == "apply":
        out, nrec = make(rev)
        for p, t in out.items():
            (ROOT / p).write_text(t)
        print("wrote", *out, f"({nrec} generated records)")
        return 0
    if cmd == "check":
        return 1 if check(rev) else 0
    if cmd == "--control":
        base = {p: (ROOT / p).read_text() for p in ("Proofs.lean", "ARCHITECTURE.md", "scripts/Axioms.lean")}
        ok = not check(rev, base, quiet=True)
        print(f"unplanted: {'PASS' if ok else 'FAILED'}")
        plants = []
        for p in base:
            f = dict(base)
            f[p] = base[p] + "\n-- planted\n"
            plants.append((f"an extra line in {p}", f))
        f = dict(base)
        f["scripts/Axioms.lean"] = base["scripts/Axioms.lean"].replace(
            '#eval IO.println "=== CLEAN ==="',
            "#print axioms HadwigerNelson.Outside.OAI158.proper_to_borel_weak\n" + '#eval IO.println "=== CLEAN ==="', 1)
        plants.append(("a record of the transfer left under IMPORTED", f))
        for label, fs in plants:
            r = check(rev, fs, quiet=True)
            print(f"plant '{label}': {'REPORTED' if r else 'SILENT'}")
            ok = ok and bool(r)
        print("CONTROL OK" if ok else "CONTROL FAILED")
        return 0 if ok else 1
    raise SystemExit(__doc__)


if __name__ == "__main__":
    sys.exit(main())
