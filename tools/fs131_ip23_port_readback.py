#!/usr/bin/env python3
"""FS131-IP23 — the port's read-back: the declarations of `Outside/OAI015Generating` and
`Outside/OAI015ErgodicDecomposition` against the release's, as the kernel stores them at the two pins.

A ported theorem is kernel-checked here, so nothing about its truth rests on its being the release's term.  This tool
is an instrument for one sentence — "this is the release's lemma" — and for catching a definition that came to mean
something else at this library's pin.  It is FS132-I2's read-back (`tools/fs132_i2_readback.py`, another job's tool,
imported as a module and not edited: its dumper text, its two prints — FULL and ERASED —, its verdicts IDENTICAL /
UP-TO-INSTANCES / DIFFERENT and its record of the constants that differ inside instance and proof arguments are used as
they are; read its docstring for what each means), with this job's table (FS131-IE1's wrapper,
`tools/fs131_ie1_port_readback.py`, is the pattern and is not edited):

  * the constants compared are every declaration the generator copies for this job's two modules
    (`tools/fs131_ie1_port.py --names`; 44 + 20), each a target;
  * the release's `OAI.PrimeDegreePackets.` and this library's `HadwigerNelson.Outside.OAI015.` are written `§.`;
  * RENAMED: Mathlib constants renamed between the pins;
  * EVENTUALLYEQSET, a named rule (inventory item 772's standing word: a definition whose stored form moved and whose
    meaning did not): at the release's pin `s =ᵐ[μ] t` on sets elaborates to `Filter.EventuallyEqSet l s t`, a
    definition of its own (Mathlib: `EventuallyEq l (fun x => x ∈ s) (fun x => x ∈ t)`); here it elaborates to
    `Filter.EventuallyEq l s t`, the sets read as predicates.  The rule writes the release's
    `((c Filter.EventuallyEqSet [L]) A)` as `(((c Filter.EventuallyEq [L,0]) A) (Sort 0))`; the kernel checks at the
    release's pin that the two are one term up to unfolding (`data/fs131/ip23/lean/ReleaseEqSetRfl.lean`, with a control
    that must be refused; its log `data/fs131/ip23/logs/release-eqset-rfl.log`).  The declarations it applies to are
    listed by the compare (`EVENTUALLYEQSET applied in`), and the self-test withdraws it and requires them DIFFERENT;
  * the release's side is printed from a SCRATCH file elaborated at the release's pin in the audit's working copy
    (`/home/kooshi/.cache/ext-oai1/lean`) by `lake env lean`, which writes no compiled file: the release's text under
    one `import Mathlib` — the eleven files of the generating sequence's cone, whole (lane P's two are needed for the
    nine to elaborate; only the nine's declarations are compared), then the line ranges the generator copies of
    `KernelEntropy.lean` and `ErgodicDecomposition.lean` (its RANGES, read from the generator) — then the dumper.  The
    file lives under this tree's ignored `build/` and is in no commit.

What it cannot see: a Mathlib definition named in a statement whose body changed between the pins (the print names
the constant, never its body).  One is known and is recorded beside this tool's output: `ErgodicSMul`'s field is
`EventuallyConst s (ae μ)` here and `EventuallyEmptyOrUniv s (ae μ)` at the release's pin, where
`EventuallyEmptyOrUniv s l := EventuallyConst (· ∈ s) l` (`data/fs131/ip23/logs/pin-ErgodicSMul-*.log`).

  fs131_ip23_port_readback.py emit                      write build/fs131-ip23/readback/ReleaseDump.lean (scratch)
                                                        and data/fs131/ip23/readback/HereDump.lean
  fs131_ip23_port_readback.py compare REL.out HERE.out  the verdicts; writes `targets-and-definitions.tsv`; exit 0
                                                        only with no DIFFERENT, no declaration absent, and the
                                                        instance constants as recorded (--record writes
                                                        instance-constants.txt)
  fs131_ip23_port_readback.py --self-test REL.out HERE.out
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

OUT = ROOT / "data/fs131/ip23/readback"
SCRATCH = ROOT / "build/fs131-ip23/readback"
REL_NS, OUR_NS = "OAI.PrimeDegreePackets.", "HadwigerNelson.Outside.OAI015."
MODULES = ["OAI015Generating", "OAI015ErgodicDecomposition"]
# the release's text of the scratch file, in order: (file, None = whole | the generator's RANGES)
RELEASE_FILES = [(port.SHANNON, None), (port.MIXTURES, None)] + [(f, None) for f in port.GENERATING] + \
    [(port.KERNEL, port.RANGES[port.KERNEL]), (port.ERGDEC, port.RANGES[port.ERGDEC])]
OUR_IMPORT = ("import Proofs.HadwigerNelson.Outside.OAI015Generating\n"
              "import Proofs.HadwigerNelson.Outside.OAI015ErgodicDecomposition\n")
# Mathlib constants renamed between the pins: name at the release's pin (v4.34.1) -> name at this pin (v4.32.0).
RENAMED = {
    # never in the text: the set-builder notation `{x | p x}` elaborates to the name of the pin (Mathlib, 2026-07-09)
    "Set.ofPred": "setOf",
}


def declarations():
    """[(short name, kind)] of the declarations the generator copies into this job's modules, in source order."""
    _, plans = port.generate()
    rows = []
    for module, _, files, _ in port.MODULES:
        if module in MODULES:
            for (rel, a, b, kind, name) in plans[module][1]:
                rows.append((name, kind))
    return rows


TARGETS = [n for n, _ in declarations()]


def cone_constants():
    """[(release name, release file stem, is a source declaration, kind)] — the comparator's row form."""
    return [(REL_NS + n, "", True, k) for n, k in declarations()]


def label_of(name: str) -> str:
    assert name.startswith(REL_NS), name
    return "§." + name[len(REL_NS):]


UNFOLD_EQSET = True       # the rule EVENTUALLYEQSET (withdrawn by the self-test only)
EQSET_KEY = "((c Filter.EventuallyEqSet ["


def unfold_eqset(s: str) -> str:
    """Rewrite `((c Filter.EventuallyEqSet [L]) A)` to `(((c Filter.EventuallyEq [L,0]) A) (Sort 0))`."""
    out, i = [], 0
    while True:
        j = s.find(EQSET_KEY, i)
        if j < 0:
            out.append(s[i:])
            return "".join(out)
        out.append(s[i:j])
        e = s.index("])", j) + 2
        lv = s[j + len(EQSET_KEY):e - 2]
        assert s[e] == " ", s[j:e + 20]
        a0 = e + 1
        if s[a0] == "(":
            d, q = 0, a0
            while True:
                if s[q] == "(":
                    d += 1
                elif s[q] == ")":
                    d -= 1
                    if d == 0:
                        break
                q += 1
            a1 = q + 1
        else:
            a1 = a0
            while s[a1] not in " )":
                a1 += 1
        assert s[a1] == ")", s[j:a1 + 5]
        out.append(f"(((c Filter.EventuallyEq [{lv},0]) {s[a0:a1]}) (Sort 0))")
        i = a1 + 1


def normalise(s: str, renamed=None, here=False, erased=False) -> str:
    s = s.replace(REL_NS, "§.").replace(OUR_NS, "§.")
    if not here:
        for a, b in (RENAMED if renamed is None else renamed).items():
            s = s.replace(f"(c {a} [", f"(c {b} [")
        s = rb.unfold(s, erased)
        if UNFOLD_EQSET:
            s = unfold_eqset(s)
    return s


def eqset_users(rel_text: str):
    """the declarations whose release print names `Filter.EventuallyEqSet` (where the rule applies)"""
    users, cur = [], None
    for ln in rel_text.splitlines():
        if ln.startswith("DUMP ") and not ln.startswith("DUMP   "):
            cur = ln.split()[1]
        elif ln.startswith("DUMP   ") and cur and EQSET_KEY in ln and cur not in users:
            users.append(cur)
    return users


# this job's table, in the imported comparator's own globals (its functions read them when called)
rb.OUT, rb.TARGETS, rb.RENAMED = OUT, TARGETS, RENAMED
rb.RECORD = OUT / "instance-constants.txt"
rb.cone_constants, rb.label_of, rb.normalise = cone_constants, label_of, normalise
rb.NAMED = {}


def release_text():
    """The release's text at the audited commit, its import lines removed, under one `import Mathlib`."""
    out = ["import Mathlib", ""]
    for rel, ranges in RELEASE_FILES:
        lines = (port.CLONE / port.SRC / rel).read_text().split("\n")
        if lines and lines[-1] == "":
            lines = lines[:-1]
        out.append(f"-- ==== FS131-IP23 scratch copy of {rel}" + (f" lines {ranges}" if ranges else "")
                   + f" (the release's text at commit {port.COMMIT}) ====")
        if ranges is None:
            out.extend(l for l in lines if not port.IMPORT.match(l))
        else:
            for a, b in ranges:
                out.extend(lines[a - 1:b])
                out.append("")
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
        release_text() + "\n-- FS131-IP23 (generated by tools/fs131_ip23_port_readback.py emit): the two modules' "
        "declarations as the kernel holds them at the RELEASE's pin (Lean v4.34.1).\n" + rb.BODY
        + "\n#eval FS132I2.runAll " + rb.lean_list(rel) + "\n")
    (OUT / "HereDump.lean").write_text(
        OUR_IMPORT + "-- FS131-IP23 (generated by tools/fs131_ip23_port_readback.py emit): the ported declarations as "
        "the kernel holds them at THIS library's pin (Lean v4.32.0).\n" + rb.BODY + "\n#eval FS132I2.runAll "
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
    expect("a constant changed in a statement (ErgodicSMul, in action_ergodic_decomposition)",
           plant("§.action_ergodic_decomposition", "(c ErgodicSMul [", "(c ErgodicSMul' ["))
    expect("a constant changed in a statement (MeasurePreserving, in measureEntropy_eq_iSup_generating)",
           plant("§.measureEntropy_eq_iSup_generating", "(c MeasureTheory.MeasurePreserving [",
                 "(c MeasureTheory.Measure.QuasiMeasurePreserving ["))
    # 2. a definition's value changed: `observationSigma` is `comap Q ⊤`; `actionInvariantSigma` an infimum
    expect("a constant changed in a definition's value (MeasurableSpace.comap, in observationSigma)",
           plant("§.observationSigma", "(c MeasurableSpace.comap [", "(c MeasurableSpace.map ["))
    expect("iInf become iSup in actionInvariantSigma's value",
           plant("§.actionInvariantSigma", "(c iInf [", "(c iSup ["))
    # 3. a binder kind changed in a theorem
    expect("a binder kind changed (action_ergodic_decomposition)",
           plant("§.action_ergodic_decomposition", "(pi.d ", "(pi.i "))
    # 4. a declaration missing from this pin's print
    i, j = block("§.ergodicSMul_of_orbit_indicator_limits")
    expect("a declaration missing from this pin's print", "\n".join(lines[:i] + lines[j:]))
    # 5. a theorem turned into an axiom
    out = lines[:]
    out[i] = out[i].replace(": theorem", ": axiom")
    assert out[i] != lines[i]
    expect("a theorem turned into an axiom", "\n".join(out))
    # 6. a truncated print
    expect("a truncated print", "\n".join(lines[:len(lines) // 2]))
    # 7. the declared rename withdrawn
    expect("RENAMED without Set.ofPred", renamed={})
    # 8. the record stale: it lists a constant that no longer differs
    expect("the record lists a constant that does not differ", rec=(record or "") + "\nNoSuch.constant\n",
           want_fatal="stale")
    # 9. the rule EVENTUALLYEQSET withdrawn: the declarations it applies to must then read DIFFERENT, and only they
    global UNFOLD_EQSET
    users = eqset_users(rel_text)
    UNFOLD_EQSET = False
    try:
        n += 1
        _, f, _, _ = rb.compare(rel_text, our_text, quiet=True, record=record)
        diff = sorted(t[1] for t in f if t[3] == "DIFFERENT")
        hit = bool(users) and diff == sorted(users)
        print(f"plant 'EVENTUALLYEQSET withdrawn': {'REFUSED' if hit else 'SILENT OR REFUSED FOR ANOTHER REASON'} "
              f"(DIFFERENT: {diff}; the rule's users: {users})")
        ok = ok and hit
    finally:
        UNFOLD_EQSET = True
    # 10. the rule does not hide a real change: the release's EventuallyEqSet made EventuallySubset in one statement
    #     (its full and its erased print), which must then read DIFFERENT
    rlines = rel_text.splitlines()
    k = next(k for k, ln in enumerate(rlines) if ln.startswith("DUMP   type  = ") and EQSET_KEY in ln)
    rl2 = rlines[:]
    for kk in (k, k + 1):
        assert rl2[kk][:15] in ("DUMP   type  = ", "DUMP   etype = ") and EQSET_KEY in rl2[kk], rl2[kk][:40]
        rl2[kk] = rl2[kk].replace(EQSET_KEY, "((c Filter.EventuallySubset [", 1)
    n += 1
    _, f, ft, _ = rb.compare("\n".join(rl2), our_text, quiet=True, record=record)
    hit = any(t[3] == "DIFFERENT" for t in f)
    print(f"plant 'the release's EventuallyEqSet become EventuallySubset in one statement': "
          f"{'REFUSED' if hit else 'SILENT'} ({len(f)} failing, {len(ft)} fatal)")
    ok = ok and hit
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
            rb.RECORD.write_text("# FS131-IP23: the constants by which a ported declaration's stored term differs from "
                                 "the release's INSIDE instance\n# arguments and proof arguments only (verdict "
                                 "UP-TO-INSTANCES).  Written by `compare --record`; read before committing.\n"
                                 + "\n".join(sorted(seen)) + "\n")
            print(f"recorded {len(seen)} constants in {rb.RECORD.relative_to(ROOT)}")
        table, failing, fatal, _ = rb.compare(rel_text, our_text, None, write=True)
        print(f"EVENTUALLYEQSET applied in: {eqset_users(rel_text)}")
        print("READBACK " + ("OK" if not failing and not fatal else "FAILED"))
        return 1 if failing or fatal else 0
    if argv[1] == "--self-test":
        return self_test(rb.read(argv[2]), rb.read(argv[3]))
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
