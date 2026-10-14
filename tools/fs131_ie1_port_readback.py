#!/usr/bin/env python3
"""FS131-IE1 — the port's read-back: the declarations of `Outside/OAI015Shannon` and `Outside/OAI015Mixtures` against
the release's, as the kernel stores them at the two pins.

A ported theorem is kernel-checked here, so nothing about its truth rests on its being the release's term.  This tool
is an instrument for one sentence — "this is the release's lemma" — and for catching a definition that came to mean
something else at this library's pin.  It is FS132-I2's read-back (`tools/fs132_i2_readback.py`, another job's tool,
imported as a module and not edited: its dumper text, its two prints — FULL and ERASED —, its verdicts IDENTICAL /
UP-TO-INSTANCES / DIFFERENT and its record of the constants that differ inside instance and proof arguments are used as
they are; read its docstring for what each means), with this job's table (FS133-IA1's wrapper is the pattern):

  * the constants compared are every declaration the generator copies from the two files (`tools/fs131_ie1_port.py
    --names`; 56), each a target;
  * the release's `OAI.PrimeDegreePackets.` and this library's `HadwigerNelson.Outside.OAI015.` are written `§.`;
  * RENAMED: Mathlib constants renamed between the pins;
  * the release's side is printed from a SCRATCH file (the release's two files' text, their import lines replaced by
    `import Mathlib`, then the dumper) elaborated at the release's pin in the audit's working copy
    (`/home/kooshi/.cache/ext-oai1/lean`) by `lake env lean`, which writes no compiled file; the file lives under this
    tree's ignored `build/` and is in no commit.  The maximal inequality's file is not read back (its release-side
    print would need 89 files of the release compiled; the brief: the generator's refusal to patch a statement is
    enough there).

  fs131_ie1_port_readback.py emit                      write build/fs131-ie1/readback/ReleaseDump.lean (scratch) and
                                                       data/fs131/ie1/readback/HereDump.lean
  fs131_ie1_port_readback.py compare REL.out HERE.out  the verdicts; writes `targets-and-definitions.tsv`; exit 0 only
                                                       with no DIFFERENT, no declaration absent, and the instance
                                                       constants as recorded (--record writes instance-constants.txt)
  fs131_ie1_port_readback.py --self-test REL.out HERE.out
                                                       plant faults and require each refused
Prints may be `.xz` files.
"""
import importlib.util
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def _load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


rb = _load("fs132_i2_readback", ROOT / "tools/fs132_i2_readback.py")
port = _load("fs131_ie1_port", ROOT / "tools/fs131_ie1_port.py")

OUT = ROOT / "data/fs131/ie1/readback"
SCRATCH = ROOT / "build/fs131-ie1/readback"
REL_NS, OUR_NS = "OAI.PrimeDegreePackets.", "HadwigerNelson.Outside.OAI015."
FILES = [port.SHANNON, port.MIXTURES]
OUR_IMPORT = "import Proofs.HadwigerNelson.Outside.OAI015Mixtures\n"
# Mathlib constants renamed between the pins: name at the release's pin (v4.34.1) -> name at this pin (v4.32.0).
RENAMED = {
    # never in the text: the set-builder notation `{x | p x}` elaborates to the name of the pin (Mathlib, 2026-07-09)
    "Set.ofPred": "setOf",
}


def declarations():
    """[(short name, kind)] of the declarations the generator copies from FILES, in source order."""
    _, plans = port.generate()
    rows = []
    for module, _, files, _ in port.MODULES:
        for (rel, a, b, kind, name) in plans[module][1]:
            if rel in FILES:
                rows.append((name, kind))
    return rows


TARGETS = [n for n, _ in declarations()]


def cone_constants():
    """[(release name, release file stem, is a source declaration, kind)] — the comparator's row form."""
    return [(REL_NS + n, "", True, k) for n, k in declarations()]


def label_of(name: str) -> str:
    assert name.startswith(REL_NS), name
    return "§." + name[len(REL_NS):]


def normalise(s: str, renamed=None, here=False, erased=False) -> str:
    s = s.replace(REL_NS, "§.").replace(OUR_NS, "§.")
    if not here:
        for a, b in (RENAMED if renamed is None else renamed).items():
            s = s.replace(f"(c {a} [", f"(c {b} [")
        s = rb.unfold(s, erased)
    return s


# this job's table, in the imported comparator's own globals (its functions read them when called)
rb.OUT, rb.TARGETS, rb.RENAMED = OUT, TARGETS, RENAMED
rb.RECORD = OUT / "instance-constants.txt"
rb.cone_constants, rb.label_of, rb.normalise = cone_constants, label_of, normalise
rb.NAMED = {}


def release_text():
    """The release's two files, their import lines removed, under one `import Mathlib` (the release's own pin)."""
    out = ["import Mathlib", ""]
    for rel in FILES:
        lines = (port.CLONE / port.SRC / rel).read_text().split("\n")
        out.append(f"-- ==== FS131-IE1 scratch copy of {rel} (the release's text at commit {port.COMMIT}) ====")
        out.extend(l for l in lines if not port.IMPORT.match(l))
    return "\n".join(out) + "\n"


def emit():
    if port.clone_commit() != port.COMMIT:
        print("FAIL: the clone is not at the audited commit")
        return 1
    OUT.mkdir(parents=True, exist_ok=True)
    SCRATCH.mkdir(parents=True, exist_ok=True)
    chk = subprocess.run(["git", "-C", str(ROOT), "check-ignore", "-q", str(SCRATCH / "ReleaseDump.lean")])
    if chk.returncode != 0:
        print(f"FAIL: {SCRATCH} is not ignored by git: the release's text may not be written there")
        return 1
    rows = cone_constants()
    rel = [(label_of(n), n) for n, _, _, _ in rows]
    our = [(label_of(n), OUR_NS + n[len(REL_NS):]) for n, _, _, _ in rows]
    (SCRATCH / "ReleaseDump.lean").write_text(
        release_text() + "\n-- FS131-IE1 (generated by tools/fs131_ie1_port_readback.py emit): the two files' "
        "declarations as the kernel holds them at the RELEASE's pin (Lean v4.34.1).\n" + rb.BODY
        + "\n#eval FS132I2.runAll " + rb.lean_list(rel) + "\n")
    (OUT / "HereDump.lean").write_text(
        OUR_IMPORT + "-- FS131-IE1 (generated by tools/fs131_ie1_port_readback.py emit): the ported declarations as the "
        "kernel holds them at THIS library's pin (Lean v4.32.0).\n" + rb.BODY + "\n#eval FS132I2.runAll "
        + rb.lean_list(our) + "\n")
    print(f"wrote {SCRATCH.relative_to(ROOT)}/ReleaseDump.lean (scratch, ignored) and "
          f"{OUT.relative_to(ROOT)}/HereDump.lean: {len(rows)} constants each")
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
        hit = fired and (want_fatal is None or any(want_fatal in x for x in ft))
        print(f"plant '{label}': {'REFUSED' if hit else 'SILENT' if not fired else 'REFUSED FOR ANOTHER REASON'}"
              f" ({len(f)} failing, {len(ft)} fatal" + (f"; {ft[0][:110]}" if ft else "") + ")")
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

    # 1. a Mathlib constant changed in a statement, outside every instance argument
    expect("a constant changed in a definition's value (Real.negMulLog, in finiteShannon)",
           plant("§.finiteShannon", "(c Real.negMulLog [", "(c Real.negMulLog' ["))
    expect("a constant changed in a statement (MeasurePreserving, in measureEntropy_kernel_zero)",
           plant("§.measureEntropy_kernel_zero", "(c MeasureTheory.MeasurePreserving [",
                 "(c MeasureTheory.Measure.QuasiMeasurePreserving ["))
    # 2. a numeral changed in a definition's value (observationEntropyRate: `Set.Ici 1`)
    expect("a numeral changed in a definition's value (observationEntropyRate)",
           plant("§.observationEntropyRate", "(nat 1)", "(nat 2)"))
    # 3. sInf become sSup in the rate's value
    expect("sInf become sSup in observationEntropyRate's value",
           plant("§.observationEntropyRate", "(c InfSet.sInf [", "(c SupSet.sSup ["))
    # 4. a binder kind changed in a theorem
    expect("a binder kind changed (measureEntropy_kernel_zero)",
           plant("§.measureEntropy_kernel_zero", "(pi.d ", "(pi.i "))
    # 5. a declaration missing from this pin's print
    i, j = block("§.tendsto_observationEntropyRate")
    expect("a declaration missing from this pin's print", "\n".join(lines[:i] + lines[j:]))
    # 6. a theorem turned into an axiom
    out = lines[:]
    out[i] = out[i].replace(": theorem", ": axiom")
    assert out[i] != lines[i]
    expect("a theorem turned into an axiom", "\n".join(out))
    # 7. a truncated print
    expect("a truncated print", "\n".join(lines[:len(lines) // 2]))
    # 8. the declared rename withdrawn
    expect("RENAMED without Set.ofPred", renamed={})
    # 9. the record stale: it lists a constant that no longer differs
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
    if argv[1] == "compare":
        rel_text, our_text = rb.read(argv[2]), rb.read(argv[3])
        if "--record" in argv:
            _, _, _, seen = rb.compare(rel_text, our_text, None, quiet=True, record="")
            rb.RECORD.write_text("# FS131-IE1: the constants by which a ported declaration's stored term differs from "
                                 "the release's INSIDE instance\n# arguments and proof arguments only (verdict "
                                 "UP-TO-INSTANCES).  Written by `compare --record`; read before committing.\n"
                                 + "\n".join(sorted(seen)) + "\n")
            print(f"recorded {len(seen)} constants in {rb.RECORD.relative_to(ROOT)}")
        table, failing, fatal, _ = rb.compare(rel_text, our_text, None, write=True)
        print("READBACK " + ("OK" if not failing and not fatal else "FAILED"))
        return 1 if failing or fatal else 0
    if argv[1] == "--self-test":
        return self_test(rb.read(argv[2]), rb.read(argv[3]))
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
