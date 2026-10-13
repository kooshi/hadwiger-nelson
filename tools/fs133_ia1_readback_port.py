#!/usr/bin/env python3
"""FS133-IA1 — the port's read-back: the declarations of `Outside/OAI158Transfer` against the release's, as the kernel
stores them at the two pins.

A ported theorem is kernel-checked here, so nothing about its truth rests on its being the release's term.  This tool
is an instrument for one sentence — "this is the release's lemma" — and for catching a definition that came to mean
something else at this library's pin.  It is FS132-I2's read-back (`tools/fs132_i2_readback.py`, another job's tool,
imported as a module and not edited: its dumper text, its two prints — FULL and ERASED —, its three verdicts
IDENTICAL / UP-TO-INSTANCES / DIFFERENT and its record of the constants that differ inside instance and proof
arguments are used as they are; read its docstring for what each means), with this job's table:

  * the cone is `data/fs133/ia1/cone/ConeDump.out` (twenty-five targets, three release files, one module here);
  * BOTH of the release's root namespaces, `OAI.EuclideanFiveColor.` and `OAI.PlaneFiveColor.`, and this library's
    `HadwigerNelson.Outside.OAI158.` are written `§.`;
  * NOT COMPARED HERE, and listed on every run: the six definitions that `Outside/OAI158Rigidity` holds (FS133-K1
    copied them; their read-back is `plans/FS133-kernel-plan.md` § 2.4) with their generated constants, and the one
    generated auxiliary of a declaration that is not ported (`tools/fs133_ia1_port.py`, AUX_UNPORTED);
  * RENAMED: Mathlib constants renamed between the pins.

  fs133_ia1_readback_port.py emit                      write ReleaseDump.lean and HereDump.lean
  fs133_ia1_readback_port.py compare REL.out HERE.out  the verdicts; writes `targets-and-definitions.tsv` and
                                                       `lemmas.tsv`; exit 0 only with no DIFFERENT, no source
                                                       declaration absent, and the instance constants as recorded
                                                       (--record writes instance-constants.txt from this run)
  fs133_ia1_readback_port.py emit-level1 REL.out       write ReleaseLevel1.lean and HereLevel1.lean: the RENAMED pairs
                                                       and every Mathlib/core constant that the targets' statements
                                                       and the definitions under them name outside instance and proof
                                                       arguments
  fs133_ia1_readback_port.py level1 REL1.out HERE1.out IDENTICAL / DIFFERENT / MOVED per constant; exit 1 if a RENAMED
                                                       pair is not IDENTICAL or a constant is absent at a pin
  fs133_ia1_readback_port.py --self-test REL.out HERE.out
                                                       plant faults and require each refused
Prints may be `.xz` files.
"""
import importlib.util
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def _load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


rb = _load("fs132_i2_readback", ROOT / "tools/fs132_i2_readback.py")
port = _load("fs133_ia1_port", ROOT / "tools/fs133_ia1_port.py")

CONE = ROOT / "data/fs133/ia1/cone/ConeDump.out"
OUT = ROOT / "data/fs133/ia1/readback"
REL_ROOTS = ("OAI.EuclideanFiveColor.", "OAI.PlaneFiveColor.")
OUR_NS = "HadwigerNelson.Outside.OAI158."
REL_IMPORT = "import OAI.Geometry.PlaneColoring.BorelTransfer\n"
OUR_IMPORT = "import Proofs.HadwigerNelson.Outside.OAI158Transfer\n"
TARGETS = [
    "Koopman.unitary", "Koopman.unitary_apply", "Koopman.nonlinear_commute",
    "ContinuousVectors.isClosed_space", "ContinuousVectors.op_mem", "ContinuousVectors.orbit_continuous",
    "ContinuousVectors.nonlinear_mem", "ContinuousVectors.projection_range", "ContinuousVectors.covariance_mem",
    "ContinuousVectors.projection_covariance_fixed", "ContinuousVectors.op_orthogonal",
    "ContinuousVectors.projection_coefficient", "projection_fixed_of_contraction", "positive_orthogonal",
    "exists_measurable_field", "Spectral.dense_E", "Spectral.orbit_uniformContinuous", "Spectral.orbitExtension",
    "Spectral.orbitExtension_continuous", "Spectral.orbitExtension_eq", "Spectral.orbitExtension_inner",
    "Spectral.normalized_algebraic", "Spectral.circle_closed_induction", "Spectral.E_countable",
    "Spectral.kCoeff_ne_zero",
]
# Mathlib constants renamed between the pins: name at the release's pin (v4.34.1) -> name at this pin (v4.32.0).
RENAMED = {
    # never in the text: the set-builder notation `{x | p x}` elaborates to the name of the pin (Mathlib, 2026-07-09)
    "Set.ofPred": "setOf",
}
UPSTREAM_OWNERS = set(port.UPSTREAM) | set(port.DERIVED)
AUX_UNPORTED = set(port.AUX_UNPORTED)


def short(name: str) -> str:
    for r in REL_ROOTS:
        if name.startswith(r):
            return name[len(r):]
    raise AssertionError(name)


def all_rows():
    rows = []
    for ln in CONE.read_text().splitlines():
        f = ln.split("\t")
        if f[0] == "CONE":
            rows.append((f[6], f[1].rsplit(".", 1)[-1], f[4] == f[6], f[5], f[4]))
    return rows


def cone_constants():
    """[(release name, release file stem, is a source declaration, kind)] for every CONE constant that is compared."""
    return [(n, stem, src, kind) for (n, stem, src, kind, owner) in all_rows()
            if owner not in UPSTREAM_OWNERS and n not in AUX_UNPORTED
            and not any(owner == u or n.startswith(u + ".") for u in UPSTREAM_OWNERS)]


def not_compared():
    return [(n, "upstream" if n not in AUX_UNPORTED else "auxiliary of an unported declaration")
            for (n, stem, src, kind, owner) in all_rows()
            if (n, stem, src, kind) not in set(cone_constants())]


def label_of(name: str) -> str:
    return "§." + short(name)


def name_at(pin: str, name: str) -> str:
    return name if pin == "release" else OUR_NS + short(name)


def normalise(s: str, renamed=None, here=False, erased=False) -> str:
    for r in REL_ROOTS:
        s = s.replace(r, "§.")
    s = s.replace(OUR_NS, "§.")
    if not here:
        for a, b in (RENAMED if renamed is None else renamed).items():
            s = s.replace(f"(c {a} [", f"(c {b} [")
        s = rb.unfold(s, erased)
    return s


# this job's table, in the imported comparator's own globals (its functions read them when called)
rb.CONE, rb.OUT, rb.TARGETS, rb.RENAMED = CONE, OUT, TARGETS, RENAMED
rb.RECORD = OUT / "instance-constants.txt"
rb.cone_constants, rb.label_of, rb.normalise = cone_constants, label_of, normalise
rb.NAMED = {}


def emit():
    OUT.mkdir(parents=True, exist_ok=True)
    rows = cone_constants()
    rel = [(label_of(n), name_at("release", n)) for n, _, _, _ in rows]
    our = [(label_of(n), name_at("here", n)) for n, _, _, _ in rows]
    (OUT / "ReleaseDump.lean").write_text(
        REL_IMPORT + "-- FS133-IA1 (generated by tools/fs133_ia1_readback_port.py emit): the cone as the kernel holds "
        "it at the RELEASE's pin (Lean v4.34.1).\n" + rb.BODY + "\n#eval FS132I2.runAll " + rb.lean_list(rel) + "\n")
    (OUT / "HereDump.lean").write_text(
        OUR_IMPORT + "-- FS133-IA1 (generated by tools/fs133_ia1_readback_port.py emit): the ported cone as the kernel "
        "holds it at THIS library's pin (Lean v4.32.0).\n" + rb.BODY + "\n#eval FS132I2.runAll " + rb.lean_list(our)
        + "\n")
    nc = not_compared()
    print(f"wrote ReleaseDump.lean and HereDump.lean under {OUT.relative_to(ROOT)}: {len(rows)} constants each; "
          f"not compared here: {len(nc)} ({sum(1 for _, w in nc if w == 'upstream')} upstream, "
          f"{sum(1 for _, w in nc if w != 'upstream')} auxiliary of an unported declaration)")
    return 0


def emit_level1(rel_text: str):
    rel, _ = rb.load(rel_text, renamed={})
    kinds = {lab: d["kind"] for lab, d in rel.items()}
    todo = [label_of(REL_ROOTS[0] + t) if False else "§." + t for t in TARGETS]
    missing = [t for t in todo if t not in rel]
    if missing:
        print(f"FAIL: targets not in the release's print: {missing}")
        return 1
    seen, outside = set(todo), set()
    while todo:
        lab = todo.pop()
        d = rel[lab]
        for c in rb.constants(d["etype"]) | (rb.constants(d["evalue"]) if d["kind"] == "def" else set()):
            if c.startswith("§"):
                if c not in seen and kinds.get(c) == "def":
                    seen.add(c)
                    todo.append(c)
            else:
                outside.add(c)
    names = sorted(outside | set(RENAMED) | {u[0] for u in rb.UNFOLDED})
    relp = [(n, n) for n in names]
    ourp = [(n, RENAMED.get(n, n)) for n in names if n not in {u[0] for u in rb.UNFOLDED}]
    (OUT / "level1-names.txt").write_text("\n".join(names) + "\n")
    (OUT / "ReleaseLevel1.lean").write_text(
        REL_IMPORT + "-- FS133-IA1 (generated): level one at the RELEASE's pin.\nuniverse u\n" + rb.BODY
        + "\n#eval FS132I2.runLevel1 " + rb.lean_list(relp) + "\n")
    (OUT / "HereLevel1.lean").write_text(
        OUR_IMPORT + "import Mathlib.Order.Filter.Basic\n-- FS133-IA1 (generated): level one at THIS library's pin.\n"
        "universe u\n" + rb.BODY + "\n#eval FS132I2.runLevel1 " + rb.lean_list(ourp) + "\n")
    print(f"wrote ReleaseLevel1.lean and HereLevel1.lean: {len(names)} constants "
          f"(the {len(TARGETS)} targets and {len(seen) - len(TARGETS)} definitions under them)")
    return 0


def self_test(rel_text: str, our_text: str) -> int:
    record = rb.RECORD.read_text() if rb.RECORD.exists() else None
    table, failing, fatal, seen = rb.compare(rel_text, our_text, quiet=True)
    if failing or fatal:
        print(f"SELF-TEST FAILED: the unplanted pair does not pass ({len(failing)} failing, {len(fatal)} fatal)")
        return 1
    print("unplanted: PASS (as it must)")
    ok, n = True, 0
    lines = our_text.splitlines()

    def block(label):
        i = next(k for k, ln in enumerate(lines) if ln.startswith(f"DUMP {label} : "))
        j = i + 1
        while j < len(lines) and lines[j].startswith("DUMP   "):
            j += 1
        return i, j

    def expect(label, text=None, renamed=None, rec=None, want_fatal=None):
        nonlocal ok, n
        n += 1
        t, f, ft, _ = rb.compare(rel_text, our_text if text is None else text, renamed=renamed, quiet=True,
                                 record=record if rec is None else rec)
        fired = bool(f or ft)
        names = sorted({x[1] for x in f})
        hit = fired and (want_fatal is None or any(want_fatal in x for x in ft))
        print(f"plant '{label}': {'REFUSED' if hit else 'SILENT' if not fired else 'REFUSED FOR ANOTHER REASON'}"
              f" ({len(f)} failing, {len(ft)} fatal" + (f"; e.g. {names[0]}" if names else "")
              + (f"; {ft[0][:110]}" if ft else "") + ")")
        ok = ok and hit

    def plant(label, old, new, fields=("type  ", "etype ", "value ", "evalue")):
        i, j = block(label)
        out = lines[:]
        k_done = 0
        for k in range(i + 1, j):
            if out[k][7:13] in fields and old in out[k]:
                out[k] = out[k].replace(old, new, 1)
                k_done += 1
        assert k_done, (label, old)
        return "\n".join(out)

    def instance_constant(label):
        """a constant that the full print of the type holds and the erased print does not: it sits in an instance"""
        i, j = block(label)
        full = next(ln for ln in lines[i:j] if ln[7:13] == "type  ")
        er = next(ln for ln in lines[i:j] if ln[7:13] == "etype ")
        return sorted(c for c in rb.constants(full) - rb.constants(er) if "." in c and not c.startswith("Hadwiger"))[0]

    # 1. a constant renamed in a target's statement, outside every instance argument
    expect("a constant changed in a target (MeasureTheory.Lp, in positive_orthogonal)",
           plant("§.positive_orthogonal", "(c MeasureTheory.Lp [", "(c MeasureTheory.Lp' ["))
    # 2. its twin: an undeclared difference INSIDE an instance argument only (full print only)
    c2 = instance_constant("§.positive_orthogonal")
    expect(f"an undeclared constant inside an instance argument ({c2}, in positive_orthogonal, full print only)",
           plant("§.positive_orthogonal", f"(c {c2} [", f"(c {c2}' [", fields=("type  ",)),
           want_fatal="the record does not hold")
    # 3. one of the release's own constants differing inside an instance argument: never allowed there
    c3 = instance_constant("§.ContinuousVectors.projection_range")
    expect(f"a constant of the release's own inside an instance argument (for {c3}, in projection_range)",
           plant("§.ContinuousVectors.projection_range", f"(c {c3} [", "(c HadwigerNelson.Outside.OAI158.Spectral.kCoeff [",
                 fields=("type  ",)))
    # 4. the declared rename withdrawn
    expect("RENAMED without Set.ofPred", renamed={})
    # 5. a rename pointing at another constant
    expect("RENAMED pointing Set.ofPred at Set.image", renamed={"Set.ofPred": "Set.image"})
    # 6. a numeral changed in a definition's value
    expect("a numeral changed in a definition's value (clamp)", plant("§.ContinuousVectors.clamp", "(nat 1)", "(nat 2)"))
    # 7. a binder kind changed in a target
    expect("a binder kind changed (circle_closed_induction)",
           plant("§.Spectral.circle_closed_induction", "(pi.d ", "(pi.i "))
    # 8. a target missing from this pin's print
    i, j = block("§.ContinuousVectors.projection_coefficient")
    expect("a target missing from this pin's print", "\n".join(lines[:i] + lines[j:]))
    # 9. a target turned into an axiom
    out = lines[:]
    out[i] = out[i].replace(": theorem", ": axiom")
    assert out[i] != lines[i]
    expect("a target turned into an axiom", "\n".join(out))
    # 10. a truncated print
    expect("a truncated print", "\n".join(lines[:len(lines) // 2]))
    # 11. the record stale: it lists a constant that no longer differs
    expect("the record lists a constant that does not differ", rec=(record or "") + "\nNoSuch.constant\n",
           want_fatal="stale")
    print(f"SELF-TEST OK: {n} plants refused, the unplanted pair passes" if ok else "SELF-TEST FAILED")
    return 0 if ok else 1


def main(argv) -> int:
    if len(argv) < 2:
        print(__doc__)
        return 2
    if argv[1] == "emit":
        return emit()
    if argv[1] == "emit-level1":
        return emit_level1(rb.read(argv[2]))
    if argv[1] == "compare":
        rel_text, our_text = rb.read(argv[2]), rb.read(argv[3])
        if "--record" in argv:
            _, _, _, seen = rb.compare(rel_text, our_text, None, quiet=True, record="")
            rb.RECORD.write_text("# FS133-IA1: the constants by which a ported declaration's stored term differs from "
                                 "the release's INSIDE instance\n# arguments and proof arguments only (verdict "
                                 "UP-TO-INSTANCES).  Written by `compare --record`; read before committing.\n"
                                 + "\n".join(sorted(seen)) + "\n")
            print(f"recorded {len(seen)} constants in {rb.RECORD.relative_to(ROOT)}")
        table, failing, fatal, _ = rb.compare(rel_text, our_text, None, write=True)
        nc = not_compared()
        print(f"not compared here: {len(nc)} cone constants — "
              + ", ".join(sorted({short(n) for n, w in nc if w == 'upstream' and not rb.AUXNAME.search(n)}))
              + " (in `Outside/OAI158Rigidity`; read back by FS133-K1) with their generated constants; and "
              + ", ".join(sorted(n for n, w in nc if w != 'upstream')) + " (a generated auxiliary of a declaration "
              "that is not ported)")
        print("READBACK " + ("OK" if not failing and not fatal else "FAILED"))
        return 1 if failing or fatal else 0
    if argv[1] == "level1":
        bad = rb.level1(rb.read(argv[2]), rb.read(argv[3]))
        print("LEVEL1 " + ("OK" if not bad else "FAILED"))
        return 1 if bad else 0
    if argv[1] == "--self-test":
        return self_test(rb.read(argv[2]), rb.read(argv[3]))
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
