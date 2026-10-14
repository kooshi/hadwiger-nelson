#!/usr/bin/env python3
"""FS131-LP1: the evidence receipts the read-back's two new rules read (the coordinator's item 807 rulings 1 and 2).

INSTANCE-EVIDENCE (ruling 1) — `§.CommutingSpectral.generator_unitary` differs from the release's statement inside an
instance argument by a constant of the release's own (`algebra_commRing`, the ported instance this pin's elaborator
finds), which the read-back refuses unless the kernel shows the two instance terms agree.  The receipt line is written
only when every one of these holds:
  1. `data/fs131/lp1/rfl/GeneratorUnitary.lean` elaborated with exit 0 and no error (its theorems `monoid_paths_agree`
     — the release's `Monoid` path `SubmonoidClass.toMonoid (algebra U)` equals this pin's by `rfl` — and
     `statement_paths_agree` — the two statements equal by `rfl` — are then kernel-checked), and printed DONE 3;
  2. its `here_form` (the lemma's text elaborated there) has exactly the stored type, full and erased, of
     `generator_unitary` in lane D's print at this pin;
  3. its `release_form` (the lemma written with the release's instance path) has the release print's erased type, and its
     full type differs from the release print's only by constants that are not the release's own (no `§.`);
  4. the planted control `GeneratorUnitaryPlant.lean` exited 1 with an error at `planted_paths_agree` (the release's
     instance with another `npow`: the kernel refuses `rfl`) and none at `monoid_paths_agree` (its partner, accepted).
IN-LIBRARY (ruling 2) — `§.Spectral.residual_fourier`, a target, reads UP-TO-INSTANCES against the release (Mathlib's
instance constants only); the ruling accepts it given the ported theorem's type is IDENTICAL to the axiom it replaces in
the library, the density branch's.  The receipt line is written only when the density branch's dump
(`data/fs131/ipd1/join/density.out.xz`, made from that branch's build by FS131-IPD1, read only) holds the axiom with
exactly the universe parameters, full type and erased type of the theorem in lane D's print at this pin (both printed by
FS132-I1's one print function).

  fs131_lp1_instance_evidence.py              check, print every check, write data/fs131/lp1/readback/evidence.out
  fs131_lp1_instance_evidence.py --control    plant a fault in each input in turn (in memory); each must be refused
Exit 0 iff every check passes (or, with --control, every plant is refused and the unplanted inputs pass).
"""
import importlib.util
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location("rp", ROOT / "tools/fs131_ipa1_readback_port.py")
rp = importlib.util.module_from_spec(spec)
spec.loader.exec_module(rp)
RFL = ROOT / "data/fs131/lp1/rfl"
LANED = ROOT / "data/fs131/lp1/readback/laneD"
DENSITY = ROOT / "data/fs131/ipd1/join/density.out.xz"
RECEIPT = ROOT / "data/fs131/lp1/readback/evidence.out"
GU, RF = "§.CommutingSpectral.generator_unitary", "§.Spectral.residual_fourier"
RF_FULL = "HadwigerNelson.Outside.OAI158.Spectral.residual_fourier"


def fields(lines):
    d = {"head": None}
    for ln in lines:
        if ln.startswith("DUMP   "):
            d.setdefault(ln[7:13].strip(), ln[15:])
        elif ln.startswith("DUMP "):
            d["head"] = ln
    return d


def find_blocks(path, labels):
    out = {}
    for kind, *rest in rp.blocks(rp.raw_lines(path)):
        if kind == "B" and rest[0] in labels and rest[0] not in out:
            out[rest[0]] = fields(rest[1])
    return out


def rel_roots(s):
    for r in rp.REL_ROOTS:
        s = s.replace(r, "HadwigerNelson.Outside.OAI158.")
    return s


def consts(s):
    return set(re.findall(r"\(c (\S+) \[", s or ""))


def load_inputs():
    gu_out = (RFL / "GeneratorUnitary.out").read_text().splitlines()
    return {
        "gu_rc": (RFL / "GeneratorUnitary.rc").read_text().strip(),
        "gu_out": gu_out,
        "gu_err": (RFL / "GeneratorUnitary.err").read_text(),
        "plant_rc": (RFL / "GeneratorUnitaryPlant.rc").read_text().strip(),
        "plant_out": (RFL / "GeneratorUnitaryPlant.out").read_text(),
        "plant_src": (RFL / "GeneratorUnitaryPlant.lean").read_text().splitlines(),
        "rel": find_blocks(LANED / "ReleaseDump.out", {GU}),
        "here": find_blocks(LANED / "HereDump.out", {GU, RF}),
        "density": find_blocks(DENSITY, {RF_FULL}),
    }


def check(x, quiet=False):
    """-> (receipt lines, failures)"""
    fails, receipt = [], []

    def need(ok, what):
        if not quiet:
            print(f"  {'ok  ' if ok else 'FAIL'}  {what}")
        if not ok:
            fails.append(what)
        return ok

    # ruling 1
    errs = [ln for ln in x["gu_out"] + x["gu_err"].splitlines() if ": error" in ln]
    a = need(x["gu_rc"] == "0" and not errs and "DONE 3" in x["gu_out"],
             "GeneratorUnitary.lean: exit 0, no error, DONE 3 (monoid_paths_agree and statement_paths_agree kernel-checked)")
    blocks = {}
    cur = None
    for ln in x["gu_out"]:
        if ln.startswith("DUMP ") and not ln.startswith("DUMP   "):
            cur = ln.split()[1]
            blocks[cur] = []
        if cur:
            blocks[cur].append(ln)
    hf, rf = fields(blocks.get("§.here_form", [])), fields(blocks.get("§.release_form", []))
    g_here, g_rel = x["here"].get(GU, {}), x["rel"].get(GU, {})
    b = need(bool(hf.get("type")) and hf.get("type") == g_here.get("type") and hf.get("etype") == g_here.get("etype"),
             "here_form's stored type (full and erased) is generator_unitary's in lane D's print here")
    rtype, retype = rel_roots(g_rel.get("type") or ""), rel_roots(g_rel.get("etype") or "")
    diff = sorted((consts(rf.get("type")) ^ consts(rtype)))
    own = [c for c in diff if c.startswith("HadwigerNelson.") or c.startswith("OAI.")]
    c = need(bool(rf.get("etype")) and rf.get("etype") == retype and not own,
             f"release_form's erased type is the release print's; its full type differs by {len(diff)} constants, "
             f"none the release's own ({', '.join(diff)})")
    lines = x["plant_src"]
    ln_plant = next((k + 1 for k, s in enumerate(lines) if s.startswith("theorem planted_paths_agree")), None)
    ln_partner = next((k + 1 for k, s in enumerate(lines) if s.startswith("theorem monoid_paths_agree")), None)
    err_lines = {int(m.group(1)) for m in re.finditer(r"GeneratorUnitaryPlant\.lean:(\d+):\d+: error", x["plant_out"])}
    plant_span = set(range(ln_plant, ln_plant + 5)) if ln_plant else set()
    partner_span = set(range(ln_partner, ln_partner + 2)) if ln_partner else set()
    d = need(x["plant_rc"] == "1" and bool(err_lines & plant_span) and not (err_lines & partner_span),
             f"the planted control: exit 1, an error at planted_paths_agree (lines {sorted(err_lines)}), none at its "
             "partner monoid_paths_agree")
    if a and b and c and d:
        receipt.append(f"INSTANCE-EVIDENCE OK {GU}: the release's Monoid path and this pin's agree by rfl in the kernel "
                       "(data/fs131/lp1/rfl/GeneratorUnitary.lean); its planted control refused")
    # ruling 2
    dn, rh = x["density"].get(RF_FULL, {}), x["here"].get(RF, {})
    dk = (dn.get("head") or "").split(" : ")[-1]
    hk = (rh.get("head") or "").split(" : ")[-1]
    e = need(dk.startswith("axiom ") and hk.startswith("theorem ") and dk.split(" ", 1)[1] == hk.split(" ", 1)[1]
             and bool(dn.get("type")) and dn.get("type") == rh.get("type") and dn.get("etype") == rh.get("etype"),
             f"residual_fourier: the density branch's {dk or 'nothing'} and this pin's {hk or 'nothing'} — universe "
             "parameters, full type and erased type identical")
    if e:
        receipt.append(f"IN-LIBRARY OK {RF}: the ported theorem's stored type is IDENTICAL to the density branch's axiom "
                       "(data/fs131/ipd1/join/density.out.xz)")
    return receipt, fails


def control():
    x = load_inputs()
    rec, fails = check(x, quiet=True)
    ok = len(rec) == 2 and not fails
    print(f"unplanted: {'PASS' if ok else 'FAILED'} ({len(rec)} receipt lines, {len(fails)} failures)")

    def plant(what, f, want):
        nonlocal ok
        y = dict(x)
        y = f(y) or y
        r, fl = check(y, quiet=True)
        refused = not any(ln.startswith(want) for ln in r)
        print(f"plant '{what}': {'REFUSED' if refused else 'SILENT'}")
        ok = ok and refused

    def sub_here(y, lab, field, old, new):
        h = {k: dict(v) for k, v in y["here"].items()}
        assert old in h[lab][field], (lab, field, old)
        h[lab][field] = h[lab][field].replace(old, new, 1)
        y["here"] = h

    plant("GeneratorUnitary.lean failed", lambda y: y.update(gu_rc="1"), "INSTANCE-EVIDENCE OK")
    plant("an error in GeneratorUnitary.lean's output", lambda y: y.update(
        gu_out=y["gu_out"] + ["data/fs131/lp1/rfl/GeneratorUnitary.lean:30:0: error: planted"]), "INSTANCE-EVIDENCE OK")
    plant("generator_unitary's stored type here changed (one instance constant)",
          lambda y: sub_here(y, GU, "type", "(c Semigroup.toMul [", "(c Planted.toMul ["), "INSTANCE-EVIDENCE OK")

    def own_const(y):
        r = {k: dict(v) for k, v in y["rel"].items()}
        r[GU]["type"] = r[GU]["type"].replace("(c MulOne.toMul [", "(c OAI.EuclideanFiveColor.Planted.toMul [", 1)
        y["rel"] = r
    plant("a constant of the release's own in the release print's instance argument", own_const, "INSTANCE-EVIDENCE OK")
    plant("the planted control accepted (exit 0)", lambda y: y.update(plant_rc="0"), "INSTANCE-EVIDENCE OK")
    plant("the planted control's error moved to its partner", lambda y: y.update(plant_out=re.sub(
        r"GeneratorUnitaryPlant\.lean:\d+:", "GeneratorUnitaryPlant.lean:14:", y["plant_out"])), "INSTANCE-EVIDENCE OK")
    plant("residual_fourier's type here changed", lambda y: sub_here(y, RF, "type", "(c Complex [", "(c Planted [ "),
          "IN-LIBRARY OK")

    def density_theorem(y):
        dd = {k: dict(v) for k, v in y["density"].items()}
        dd[RF_FULL]["head"] = dd[RF_FULL]["head"].replace(": axiom ", ": theorem ")
        y["density"] = dd
    plant("the density branch's constant not an axiom", density_theorem, "IN-LIBRARY OK")
    print("CONTROL " + ("OK: every plant refused, the unplanted inputs pass" if ok else "FAILED"))
    return 0 if ok else 1


def main():
    if "--control" in sys.argv:
        return control()
    rec, fails = check(load_inputs())
    RECEIPT.write_text("# FS131-LP1: written by tools/fs131_lp1_instance_evidence.py; read by the read-back's "
                       "INSTANCE_EVIDENCE and TARGET_IN_LIBRARY rules\n" + "".join(ln + "\n" for ln in rec))
    print(f"EVIDENCE {'OK' if not fails else 'FAILED'}: {len(rec)} receipt lines written to "
          f"{RECEIPT.relative_to(ROOT)}")
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main())
