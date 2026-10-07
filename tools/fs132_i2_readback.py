#!/usr/bin/env python3
"""FS132-I2 — the port's read-back: the ported declarations against the release's, as the kernel stores them at the
two pins.

A ported theorem is kernel-checked here, so nothing about its truth rests on its being the release's term.  This tool
is an instrument for one sentence — "this is the release's lemma" — and for catching a definition that came to mean
something else at this library's pin.  For every constant of the cone (`data/fs132/i2/cone/ConeDump.out`: the constants
of the release that the four target statements' stored types and proofs name, transitively) it compares the print of
the STORED TYPE at the release's pin (Lean and Mathlib v4.34.1) with the print at this library's (v4.32.0), and for a
definition the STORED VALUE too.  Two prints are made of each term, by one dumper text run at both pins:
  * the FULL print (FS132-I1's: de Bruijn indices, full constant names with universe arguments, every implicit and
    instance argument, binder kinds and names);
  * the ERASED print: the same with every instance argument and every proof argument written `_` — an argument is
    erased when the applied function's own signature, read in `MetaM` at that pin, takes it instance-implicitly or at
    a type that is a proposition.

Normalised before comparing, and nothing else:
  * the two namespaces and the two private prefixes are written `§.`;
  * NAMED: the release's anonymous instances that this library's copies name by hand (FS132-I1, FS132-K1);
  * RENAMED: Mathlib constants renamed between the pins, release's name -> name here.  Each is checked one level down
    (`level1`): one type, one value at the two pins;
  * UNFOLDED: one Mathlib definition the release's pin interposes (`Filter.EventuallySubset l s t`, which is
    `Filter.EventuallyLE l s t` at `Prop` by definition), written in its unfolded form; a kernel `rfl` at the release's
    pin checks it (in `ReleaseLevel1.lean`).

Three verdicts per constant:
  IDENTICAL                the full prints agree: the same term;
  UP-TO-INSTANCES          the erased prints agree and the full prints do not: the two terms differ only inside
                           instance arguments and proof arguments.  The constants that differ are listed; each must be
                           Mathlib's or core's, or a generated proof (`X._proof_n`), and the whole set must be the one
                           recorded in `data/fs132/i2/readback/instance-constants.txt` — a constant that is not in the
                           record fails the run until it is read and recorded.  What this verdict leaves to trust:
                           that Mathlib's instances for one class on one type agree at each pin, which no cross-pin
                           print can check;
  DIFFERENT                anything else.  The run fails.
A generated auxiliary (`X._proof_n`, `X._simp_n`, …, and the one private anonymous instance, whose generated name
carries the namespace) that is absent here under the release's name (AUX-ABSENT), or is another statement under it
(AUX-DIFFERS), is counted and listed, not failed: the elaborator numbers and shares those per module, and no
statement or definition names one outside an instance or proof argument (that would be a DIFFERENT).

  fs132_i2_readback.py emit                      write ReleaseDump.lean and HereDump.lean (pass 1: the cone)
  fs132_i2_readback.py compare REL.out HERE.out  the verdicts; writes `targets-and-definitions.tsv` (the four targets
                                                 and every definition by name, with verdict and differing constants)
                                                 and `lemmas.tsv`; exit 0 only with no DIFFERENT, no source declaration
                                                 absent, and the instance constants as recorded.
                                                 --renamed A=B,C=D replaces the RENAMED map (a control);
                                                 --record writes instance-constants.txt from this run (read it).
  fs132_i2_readback.py emit-level1 REL.out       write ReleaseLevel1.lean and HereLevel1.lean: the RENAMED pairs, the
                                                 `rfl` for UNFOLDED, and every Mathlib/core constant that the four
                                                 target statements and the definitions under them name outside
                                                 instance and proof arguments
  fs132_i2_readback.py level1 REL1.out HERE1.out IDENTICAL / DIFFERENT / MOVED per constant; exit 1 if a RENAMED pair
                                                 is not IDENTICAL or a constant is absent at a pin; any other
                                                 DIFFERENT is printed for reading, not failed
  fs132_i2_readback.py --self-test REL.out HERE.out
                                                 plant faults in copies of HERE.out, in the map and in the record, and
                                                 require each refused and the unplanted pair to pass
Prints may be `.xz` files.
"""
import lzma
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
CONE = ROOT / "data/fs132/i2/cone/ConeDump.out"
OUT = ROOT / "data/fs132/i2/readback"
REL_NS, OUR_NS = "OAI.EuclideanFiveColor.", "HadwigerNelson.Outside.OAI158."
TARGETS = ["palette_transfer_pair", "palette_sixty_disjoint", "two_state_impossible", "mem_spatialSupport_ae"]

# The release's anonymous instances that this library's hand-made copies name (release name -> name here).
NAMED = {
    "instIsProbabilityMeasureAnglesAngularMeasure": "angularMeasure.instIsProbabilityMeasure",
    "instIsAddHaarMeasureAnglesAngularMeasure": "angularMeasure.instIsAddHaarMeasure",
}

# Mathlib constants renamed between the pins: name at the release's pin (v4.34.1) -> name at this pin (v4.32.0).
RENAMED = {
    # written `restrict` in the ported text by the generator's RENAMES table (Mathlib, 2026-07-19)
    "Set.domRestrict": "Set.restrict",
    # never in the text: the set-builder notation `{x | p x}` elaborates to the name of the pin (Mathlib, 2026-07-09)
    "Set.ofPred": "setOf",
}

# A Mathlib definition the release's pin interposes: (constant, universe arity there, the head it unfolds to here as
# a function of its first argument).  `Filter.EventuallySubset.{u} α l s t` is by definition
# `Filter.EventuallyLE.{u,0} α Prop Prop.le l s t` (Mathlib, 2026-08-14: `s ≤ᵐ[μ] t` on sets became a definition of its
# own); at this pin the notation elaborates to the right-hand side directly.
UNFOLDED = [
    ("Filter.EventuallySubset", "Filter.EventuallyLE", "(Sort 0)", "(c Prop.le [])"),
]
RECORD = OUT / "instance-constants.txt"
AUXNAME = re.compile(r"\._(proof|simp|abel|ring|aux|match|sunfold|unsafe_rec)_?[\d_]*$|\.(match|eq|congr_simp)_?[\d_]*$")

# Which module of this library holds which release file's declarations (for the private prefix).
HERE_MODULE = {
    "WeakColoring": "OAI158Palette", "Compactness": "OAI158Palette", "Palettes": "OAI158Palette",
    "Coloring": "OAI158", "CircleMaps": "OAI158CircleMaps", "Expansion": "OAI158Expansion",
    "CircleTransport": "OAI158CircleTransport", "PaletteDensity": "OAI158PaletteDensity",
    "PaletteTransport": "OAI158PaletteTransport", "BinaryPalettes": "OAI158BinaryPalettes",
    "States": "OAI158States", "AngularBoundary": "OAI158AngularBoundary",
}

BODY = r'''
namespace FS132I2
open Lean
/-- A canonical print of a universe level. -/
partial def dumpLevel : Level → String
  | .zero => "0"
  | .succ l => s!"(S {dumpLevel l})"
  | .max a b => s!"(max {dumpLevel a} {dumpLevel b})"
  | .imax a b => s!"(imax {dumpLevel a} {dumpLevel b})"
  | .param n => s!"(p {n})"
  | .mvar _ => "(lmvar)"
def bi : BinderInfo → String
  | .default => "d" | .implicit => "i" | .strictImplicit => "s" | .instImplicit => "c"
/-- A canonical print of a term as the kernel holds it: de Bruijn indices, full constant names with their universe
arguments, every implicit and instance argument, binder kinds and binder names (macro scopes erased). Two terms print
alike exactly when they are the same term up to metadata. (FS132-I1's print, `data/fs132/i1/readback/DumpBody.lean.inc`.) -/
partial def dump : Expr → String
  | .bvar i => s!"#{i}"
  | .fvar _ => "(fvar)"
  | .mvar _ => "(mvar)"
  | .sort l => s!"(Sort {dumpLevel l})"
  | .const n ls => s!"(c {n} [{String.intercalate "," (ls.map dumpLevel)}])"
  | .app f a => s!"({dump f} {dump a})"
  | .lam n t b i => s!"(lam.{bi i} {n.eraseMacroScopes} {dump t} {dump b})"
  | .forallE n t b i => s!"(pi.{bi i} {n.eraseMacroScopes} {dump t} {dump b})"
  | .letE n t v b _ => s!"(let {n.eraseMacroScopes} {dump t} {dump v} {dump b})"
  | .lit (.natVal n) => s!"(nat {n})"
  | .lit (.strVal s) => s!"(str {s.quote})"
  | .mdata _ e => dump e
  | .proj s i e => s!"(proj {s} {i} {dump e})"
open Meta in
/-- The same print with every INSTANCE argument and every PROOF argument written `_`: an argument is erased when the
applied function's own signature, at this pin, takes it instance-implicitly (`[inst : C α]`) or at a type that is a
proposition. What is left is what the term says with the choice of instances and the proofs of side conditions set
aside. Free variables print as their position in the local context (`@n`). -/
partial def dumpE (e : Expr) : MetaM String := do
  match e with
  | .mdata _ e => dumpE e
  | .app .. =>
    let f := e.getAppFn
    let args := e.getAppArgs
    let info ← getFunInfoNArgs f args.size
    let mut s ← dumpE f
    for i in [0:args.size] do
      let erase := match info.paramInfo[i]? with
        | some pi => pi.binderInfo.isInstImplicit || pi.isProp
        | none => false
      if erase then s := s!"({s} _)" else s := s!"({s} {← dumpE args[i]!})"
    return s
  | .lam n t b i => do
    let ts ← dumpE t
    withLocalDecl n i t fun x => do
      return s!"(lam.{bi i} {n.eraseMacroScopes} {ts} {← dumpE (b.instantiate1 x)})"
  | .forallE n t b i => do
    let ts ← dumpE t
    withLocalDecl n i t fun x => do
      return s!"(pi.{bi i} {n.eraseMacroScopes} {ts} {← dumpE (b.instantiate1 x)})"
  | .letE n t v b _ => do
    let ts ← dumpE t
    let vs ← dumpE v
    withLetDecl n t v fun x => do
      return s!"(let {n.eraseMacroScopes} {ts} {vs} {← dumpE (b.instantiate1 x)})"
  | .fvar id => do return s!"@{(← id.getDecl).index}"
  | .proj s i e => do return s!"(proj {s} {i} {← dumpE e})"
  | e => return dump e
/-- A name from its print; `PRIVATE|module|name` is the private name `name` of `module`. -/
def toName (s : String) : Name :=
  match s.splitOn "|" with
  | ["PRIVATE", m, n] => mkPrivateNameCore m.toName n.toName
  | _ => s.toName
def kindOf : ConstantInfo → String
  | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .axiomInfo _ => "axiom" | .opaqueInfo _ => "opaque"
  | .inductInfo _ => "inductive" | .ctorInfo _ => "ctor" | .recInfo _ => "rec" | .quotInfo _ => "quot"
/-- One declaration: its kind, universe parameters, stored type, and (for a definition) stored value; then every
constant the type and the value name, each with the module that declares it. `label` is what the line is filed under. -/
def report (label : String) (s : String) : CoreM Unit := do
  let env ← getEnv
  let n := toName s
  match env.find? n with
  | none => IO.println s!"DUMP {label} : ABSENT"
  | some ci =>
    IO.println s!"DUMP {label} : {kindOf ci} levels={ci.levelParams}"
    IO.println s!"DUMP   type  = {dump ci.type}"
    IO.println s!"DUMP   etype = {← (dumpE ci.type).run'}"
    let mut used := ci.type.getUsedConstants
    if let .defnInfo d := ci then
      IO.println s!"DUMP   value = {dump d.value}"
      IO.println s!"DUMP   evalue= {← (dumpE d.value).run'}"
      used := used ++ d.value.getUsedConstants
    for c in (used.qsort Name.lt).toList.eraseDups do
      let m := match env.getModuleIdxFor? c with
        | some i => toString env.header.moduleNames[i.toNat]!
        | none => "(this file)"
      IO.println s!"USES {label} : {c} @ {m}"
/-- Level one: one constant as the kernel holds it at this pin — kind, universe parameters, type, and what fixes its
meaning one step down (a definition's value; an inductive type's constructors with their types). -/
def level1 (label : String) (s : String) : CoreM Unit := do
  let env ← getEnv
  let n := toName s
  match env.find? n with
  | none => IO.println s!"L1 {label} | ABSENT"
  | some ci =>
    let m := match env.getModuleIdxFor? n with
      | some i => toString env.header.moduleNames[i.toNat]!
      | none => "(this file)"
    let body ← match ci with
      | .defnInfo d => pure s!"def | value = {dump d.value}"
      | .inductInfo v => do
          let mut s := s!"inductive params={v.numParams} indices={v.numIndices} |"
          for c in v.ctors do
            let some cc := env.find? c | pure ()
            s := s ++ s!" ctor {c} : {dump cc.type} ;"
          pure s
      | ci => pure s!"{kindOf ci} |"
    IO.println s!"L1 {label} | levels={ci.levelParams} | type = {dump ci.type} | {body}"
    IO.println s!"L1MOD {label} @ {m}"
def runAll (xs : List (String × String)) : CoreM Unit := do
  for (l, s) in xs do report l s
  IO.println s!"DONE {xs.length}"
def runLevel1 (xs : List (String × String)) : CoreM Unit := do
  for (l, s) in xs do level1 l s
  IO.println s!"DONE {xs.length}"
end FS132I2
'''


def cone_constants():
    """[(short name, release file stem, is a source declaration, is private)] for every CONE constant."""
    rows = []
    for ln in CONE.read_text().splitlines():
        f = ln.split("\t")
        if f[0] != "CONE":
            continue
        stem = f[1].rsplit(".", 1)[-1]
        owner, name = f[4], f[6]
        rows.append((name, stem, owner == name, f[5]))
    return rows


def lean_list(pairs):
    return "[" + ",\n  ".join('("%s", "%s")' % (a, b) for a, b in pairs) + "]"


def name_at(pin: str, name: str, stem: str) -> str:
    """The string the dumper resolves at a pin for the release constant `name` of file `stem`."""
    priv = re.match(r"_private\.(OAI\.Geometry\.PlaneColoring\.\w+)\.0\.(.*)$", name)
    base = priv.group(2) if priv else name
    assert base.startswith(REL_NS), name
    short = base[len(REL_NS):]
    if pin == "release":
        return f"PRIVATE|{priv.group(1)}|{base}" if priv else name
    for a, b in NAMED.items():
        if short == a or short.startswith(a + "."):
            short = b + short[len(a):]
    full = OUR_NS + short
    return f"PRIVATE|Proofs.HadwigerNelson.Outside.{HERE_MODULE[stem]}|{full}" if priv else full


def label_of(name: str) -> str:
    priv = re.match(r"_private\.OAI\.Geometry\.PlaneColoring\.\w+\.0\.(.*)$", name)
    base = priv.group(1) if priv else name
    return ("§private." if priv else "§.") + base[len(REL_NS):]


def emit():
    OUT.mkdir(parents=True, exist_ok=True)
    rows = cone_constants()
    rel = [(label_of(n), name_at("release", n, stem)) for n, stem, _, _ in rows]
    our = [(label_of(n), name_at("here", n, stem)) for n, stem, _, _ in rows]
    (OUT / "ReleaseDump.lean").write_text(
        "import OAI.Geometry.PlaneColoring.States\nimport OAI.Geometry.PlaneColoring.AngularBoundary\n"
        "-- FS132-I2 (generated by tools/fs132_i2_readback.py emit): the cone as the kernel holds it at the RELEASE's "
        "pin (Lean v4.34.1).\n" + BODY + "\n#eval FS132I2.runAll " + lean_list(rel) + "\n")
    (OUT / "HereDump.lean").write_text(
        "import Proofs.HadwigerNelson.Outside.OAI158States\nimport Proofs.HadwigerNelson.Outside.OAI158AngularBoundary\n"
        "-- FS132-I2 (generated by tools/fs132_i2_readback.py emit): the ported cone as the kernel holds it at THIS "
        "library's pin (Lean v4.32.0).\n" + BODY + "\n#eval FS132I2.runAll " + lean_list(our) + "\n")
    print(f"wrote ReleaseDump.lean and HereDump.lean under {OUT.relative_to(ROOT)}: {len(rows)} constants each")
    return 0


def unfold(s: str, erased: bool) -> str:
    """Rewrite `((c K [L]) A)` to `((((c H [L,0]) A) B) I)` for each UNFOLDED entry (I is `_` in an erased print)."""
    for (k, h, b, inst) in UNFOLDED:
        key, out, i = f"((c {k} [", [], 0
        while True:
            j = s.find(key, i)
            if j < 0:
                out.append(s[i:])
                break
            out.append(s[i:j])
            e = s.index("])", j) + 2
            lv = s[j + len(key):e - 2]
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
            out.append(f"((((c {h} [{lv},0]) {s[a0:a1]}) {b}) {'_' if erased else inst}")
            i = a1
        s = "".join(out)
    return s


def normalise(s: str, renamed=None, here=False, erased=False) -> str:
    s = re.sub(r"_private\.OAI\.Geometry\.PlaneColoring\.\w+\.0\.OAI\.EuclideanFiveColor\.", "§private.", s)
    s = re.sub(r"_private\.Proofs\.HadwigerNelson\.Outside\.\w+\.0\.HadwigerNelson\.Outside\.OAI158\.", "§private.", s)
    s = s.replace(REL_NS, "§.").replace(OUR_NS, "§.")
    if not here:
        for a, b in NAMED.items():
            s = re.sub(r"\(c §\." + re.escape(a) + r"(?=[ .])", "(c §." + b, s)
        for a, b in (RENAMED if renamed is None else renamed).items():
            s = s.replace(f"(c {a} [", f"(c {b} [")
        s = unfold(s, erased)
    return s


FIELDS = {"DUMP   type  = ": ("type", False), "DUMP   etype = ": ("etype", True),
          "DUMP   value = ": ("value", False), "DUMP   evalue= ": ("evalue", True)}


def read(path) -> str:
    path = Path(path)
    if path.suffix == ".xz":
        return lzma.open(path, "rt", encoding="utf-8").read()
    return path.read_text()


def load(text: str, renamed=None, here=False):
    out, cur, done = {}, None, None
    for ln in text.splitlines():
        m = re.match(r"DUMP (\S+) : (\w+)(?: levels=(.*))?$", ln)
        if m:
            cur = m.group(1)
            out[cur] = {"kind": m.group(2), "levels": m.group(3), "type": None, "etype": None, "value": None,
                        "evalue": None, "uses": {}}
        elif ln.startswith("DUMP   ") and cur:
            key = ln[:15]
            if key in FIELDS:
                f, er = FIELDS[key]
                out[cur][f] = normalise(ln[15:], renamed, here, er)
        elif ln.startswith("USES "):
            m = re.match(r"USES (\S+) : (\S+) @ (.*)$", ln)
            if m and m.group(1) in out:
                out[m.group(1)]["uses"][m.group(2)] = m.group(3)
        elif ln.startswith("DONE "):
            done = int(ln.split()[1])
    return out, done


def first_difference(a: str, b: str, width: int = 100) -> str:
    i = 0
    while i < min(len(a), len(b)) and a[i] == b[i]:
        i += 1
    lo = max(0, i - 40)
    return f"at char {i}: release …{a[lo:i + width]}… | here …{b[lo:i + width]}…"


def constants(s: str):
    return set(re.findall(r"\(c (\S+) \[", s or ""))


def judge(r, o):
    """-> (verdict, why, constants only there, constants only here)"""
    if r["kind"] != o["kind"]:
        return "DIFFERENT", f"kind {r['kind']} there, {o['kind']} here", [], []
    parts = [("type", "etype")] + ([("value", "evalue")] if r["kind"] == "def" else [])
    for full, er in parts:
        if r[er] is None or o[er] is None:
            return "DIFFERENT", f"no erased print of the {full}", [], []
        if r[er] != o[er]:
            ca, cb = constants(r[er]), constants(o[er])
            return "DIFFERENT", f"{full}, erased print, " + first_difference(r[er], o[er]), sorted(ca - cb), sorted(cb - ca)
    if r["levels"] != o["levels"]:
        return "DIFFERENT", f"universe parameters {r['levels']} there, {o['levels']} here", [], []
    there, here = set(), set()
    for full, _ in parts:
        if r[full] != o[full]:
            ca, cb = constants(r[full]), constants(o[full])
            there |= ca - cb
            here |= cb - ca
    if all(r[full] == o[full] for full, _ in parts):
        return "IDENTICAL", "", [], []
    return "UP-TO-INSTANCES", "", sorted(there), sorted(here)


def allowed_instance_constant(c: str) -> bool:
    """Mathlib's or core's, or a generated proof / a Prop-valued private instance of the port."""
    if not c.startswith("§"):
        return True
    return bool(re.search(r"\._proof_\d+(_\d+)?$", c)) or c.startswith("§private.inst")


def compare(rel_text: str, our_text: str, renamed=None, quiet=False, record=None, write=False):
    rel, rdone = load(rel_text, renamed)
    our, odone = load(our_text, renamed, here=True)
    rows = cone_constants()
    fatal, counts, table = [], {}, []
    if rdone != len(rows) or odone != len(rows):
        fatal.append(f"a print is incomplete: DONE {rdone} at the release, {odone} here, {len(rows)} cone constants")
    seen_inst = set()
    for name, stem, source, kind in rows:
        lab = label_of(name)
        r, o = rel.get(lab), our.get(lab)
        if r is None or o is None or r["kind"] == "ABSENT":
            fatal.append(f"{lab}: not in a print")
            continue
        aux = (not source) or bool(AUXNAME.search(lab)) or lab.startswith("§private.")
        if o["kind"] == "ABSENT":
            verdict, why, there, here = ("AUX-ABSENT" if aux else "ABSENT-HERE"), "", [], []
        else:
            verdict, why, there, here = judge(r, o)
            if verdict == "DIFFERENT" and aux:
                # a generated auxiliary of the same name that is another statement: the elaborator numbers and
                # shares `X._proof_n`, `X._simp_n` per module, and three release files are one module here
                verdict = "AUX-DIFFERS"
        if verdict == "UP-TO-INSTANCES":
            badc = [c for c in there + here if not allowed_instance_constant(c)]
            if badc:
                verdict, why = "DIFFERENT", f"differs inside instance arguments by the release's own constants {badc}"
            else:
                seen_inst |= set(there) | set(here)
        cls = ("target" if lab[2:] in TARGETS else "aux" if aux else "definition" if r["kind"] == "def" else "lemma")
        counts[(cls, verdict)] = counts.get((cls, verdict), 0) + 1
        table.append((cls, lab, r["kind"], verdict, there, here, why))
    failing = [t for t in table if t[3] in ("DIFFERENT", "ABSENT-HERE")]
    rec = None
    if record is None and RECORD.exists():
        record = RECORD.read_text()
    if record is not None:
        rec = {ln.strip() for ln in record.splitlines() if ln.strip() and not ln.startswith("#")}
        new, gone = sorted(seen_inst - rec), sorted(rec - seen_inst)
        if new:
            fatal.append(f"constants differing inside instance/proof arguments that the record does not hold: {new}")
        if gone:
            fatal.append(f"recorded instance constants that no longer differ (the record is stale): {gone}")
    else:
        fatal.append("no record of the instance constants (run with --record, read the file, commit it)")
    if write:
        with open(OUT / "targets-and-definitions.tsv", "w") as f:
            f.write("class\tname\tkind\tverdict\tconstants only at the release's pin\tconstants only at this pin\tnote\n")
            for t in table:
                if t[0] in ("target", "definition"):
                    f.write("\t".join([t[0], t[1][2:], t[2], t[3], " ".join(t[4]) or "—", " ".join(t[5]) or "—", t[6]]) + "\n")
        with open(OUT / "lemmas.tsv", "w") as f:
            f.write("class\tname\tkind\tverdict\tconstants only at the release's pin\tconstants only at this pin\tnote\n")
            for t in table:
                if t[0] in ("lemma", "aux") and t[3] != "IDENTICAL":
                    f.write("\t".join([t[0], t[1], t[2], t[3], " ".join(t[4]) or "—", " ".join(t[5]) or "—", t[6]]) + "\n")
    if not quiet:
        for t in table:
            if t[3] in ("DIFFERENT", "ABSENT-HERE"):
                print(f"{t[3]}\t{t[0]}\t{t[1]}\t{t[6][:400]}\tonly there {t[4]} only here {t[5]}")
        for (cls, verdict), n in sorted(counts.items()):
            print(f"  {cls:12s} {verdict:16s} {n}")
        for t in table:
            if t[0] == "target":
                print(f"  target {t[1][2:]}: {t[3]}" + (f" (only there {t[4]}, only here {t[5]})" if t[4] or t[5] else ""))
        print(f"  constants differing inside instance and proof arguments: {len(seen_inst)}"
              + ("" if rec is None else f" (recorded: {len(rec)})"))
        for f in fatal:
            print(f"FATAL: {f}")
        print(f"cone constants: {len(rows)}  failing: {len(failing)}  fatal: {len(fatal)}  "
              f"renamed map: {RENAMED if renamed is None else renamed}")
    return table, failing, fatal, seen_inst


def emit_level1(rel_text: str):
    """The constants one level down: the RENAMED pairs, and every Mathlib/core constant that the four target statements
    and the definitions under them name OUTSIDE instance and proof arguments (read off the erased prints)."""
    rel, _ = load(rel_text, renamed={})
    kinds = {lab: d["kind"] for lab, d in rel.items()}
    todo = [label_of(REL_NS + t) for t in TARGETS]
    seen, outside = set(todo), set()
    while todo:
        lab = todo.pop()
        d = rel[lab]
        for c in constants(d["etype"]) | (constants(d["evalue"]) if d["kind"] == "def" else set()):
            if c.startswith("§"):
                if c not in seen and kinds.get(c) == "def":
                    seen.add(c)
                    todo.append(c)
            else:
                outside.add(c)
    names = sorted(outside | set(RENAMED) | {u[0] for u in UNFOLDED})
    relp = [(n, n) for n in names]
    ourp = [(n, RENAMED.get(n, n)) for n in names if n not in {u[0] for u in UNFOLDED}]
    (OUT / "level1-names.txt").write_text("\n".join(names) + "\n")
    rfl = ("\n-- UNFOLDED, checked by the kernel at the release's pin: `Filter.EventuallySubset l s t` is "
           "`Filter.EventuallyLE l s t` at `Prop`, by definition.\n"
           "example {α : Type u} (l : Filter α) (s t : Set α) :\n"
           "    Filter.EventuallySubset l s t = @Filter.EventuallyLE α Prop Prop.le l s t := rfl\n"
           "example {α : Type u} [MeasurableSpace α] (μ : MeasureTheory.Measure α) (s t : Set α) :\n"
           "    (s ≤ᵐ[μ] t) = @Filter.EventuallyLE α Prop Prop.le (MeasureTheory.ae μ) s t := rfl\n")
    (OUT / "ReleaseLevel1.lean").write_text(
        "import OAI.Geometry.PlaneColoring.States\nimport OAI.Geometry.PlaneColoring.AngularBoundary\n"
        "-- FS132-I2 (generated): level one at the RELEASE's pin.\nuniverse u\n" + BODY + "\n#eval FS132I2.runLevel1 "
        + lean_list(relp) + "\n" + rfl)
    here_rfl = ("\n-- The same sentence at THIS pin, where the notation gives the right-hand side directly.\n"
                "example {α : Type u} [MeasurableSpace α] (μ : MeasureTheory.Measure α) (s t : Set α) :\n"
                "    (s ≤ᵐ[μ] t) = @Filter.EventuallyLE α Prop Prop.le (MeasureTheory.ae μ) s t := rfl\n")
    (OUT / "HereLevel1.lean").write_text(
        "import Proofs.HadwigerNelson.Outside.OAI158States\nimport Proofs.HadwigerNelson.Outside.OAI158AngularBoundary\n"
        "-- FS132-I2 (generated): level one at THIS library's pin.\nuniverse u\n" + BODY + "\n#eval FS132I2.runLevel1 "
        + lean_list(ourp) + "\n" + here_rfl)
    print(f"wrote ReleaseLevel1.lean and HereLevel1.lean: {len(names)} constants "
          f"(the four targets and {len(seen) - len(TARGETS)} definitions under them)")
    return 0


def level1(rel_text: str, our_text: str, quiet=False):
    def rd(text, here):
        rows, mods, done = {}, {}, None
        for ln in text.splitlines():
            if ln.startswith("L1MOD "):
                m = re.match(r"L1MOD (\S+) @ (.*)$", ln)
                mods[m.group(1)] = m.group(2)
            elif ln.startswith("L1 "):
                lab, rest = ln[3:].split(" | ", 1)
                rest = normalise(rest, None, here)
                # universe parameters are bound by the declaration: name them by position (Mathlib's files number
                # their auto-bound universes by what else the file declares, and that moved between the pins)
                m = re.match(r"levels=\[([^\]]*)\]", rest)
                if m and m.group(1):
                    for k, u in enumerate(x.strip() for x in m.group(1).split(",")):
                        rest = re.sub(r"(?<![\w.])" + re.escape(u) + r"(?![\w.])", f"𝓊{k}", rest)
                rows[lab] = rest
            elif ln.startswith("DONE "):
                done = int(ln.split()[1])
        return rows, mods, done
    rel, rmods, rdone = rd(rel_text, False)
    our, omods, odone = rd(our_text, True)
    names = (OUT / "level1-names.txt").read_text().split()
    skip = {u[0] for u in UNFOLDED}
    bad, counts = [], {}
    if rdone != len(names) or odone != len(names) - len(skip):
        bad.append(f"a print is incomplete: DONE {rdone} at the release, {odone} here, {len(names)} names")
    for n in names:
        if n in skip:
            continue
        r, o = rel.get(n), our.get(n)
        if r is None or o is None or r == "ABSENT" or o == "ABSENT":
            v = "ABSENT"
            bad.append(f"{n}: absent at a pin")
        elif r == o:
            v = "IDENTICAL" if rmods.get(n) == omods.get(n) else "MOVED"
        else:
            v = "DIFFERENT"
            if n in RENAMED:
                bad.append(f"the renamed pair {n} -> {RENAMED[n]} is not one definition: {first_difference(r, o)}")
        counts[v] = counts.get(v, 0) + 1
        tag = f" (RENAMED -> {RENAMED[n]})" if n in RENAMED else ""
        if not quiet and (v != "IDENTICAL" or tag):
            extra = ""
            if v == "DIFFERENT":
                part = "type" if r.split(" | ")[1] != o.split(" | ")[1] else "value or constructors"
                extra = f"\t{part}: {first_difference(r, o, 70)}"
            elif v == "MOVED":
                extra = f"\t{rmods.get(n)} there, {omods.get(n)} here"
            print(f"{v}{tag}\t{n}{extra}")
    if not quiet:
        print("  " + "  ".join(f"{k} {v}" for k, v in sorted(counts.items())) + f"  of {len(names) - len(skip)}")
        for b in bad:
            print(f"FAIL: {b}")
    return bad


def self_test(rel_text: str, our_text: str) -> int:
    record = RECORD.read_text() if RECORD.exists() else None
    table, failing, fatal, seen = compare(rel_text, our_text, quiet=True)
    if failing or fatal:
        print(f"SELF-TEST FAILED: the unplanted pair does not pass ({len(failing)} failing, {len(fatal)} fatal)")
        return 1
    print("unplanted: PASS (as it must)")
    ok = True
    lines = our_text.splitlines()

    def block(label):
        """indices of the lines of one declaration's block in this pin's print"""
        i = next(k for k, ln in enumerate(lines) if ln.startswith(f"DUMP {label} : "))
        j = i + 1
        while j < len(lines) and lines[j].startswith("DUMP   "):
            j += 1
        return i, j

    def expect(label, text=None, renamed=None, rec=None, want_fatal=None):
        nonlocal ok
        t, f, ft, _ = compare(rel_text, our_text if text is None else text, renamed=renamed, quiet=True,
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
        n = 0
        for k in range(i + 1, j):
            if out[k][7:13] in fields and old in out[k]:
                out[k] = out[k].replace(old, new, 1)
                n += 1
        assert n, (label, old)
        return "\n".join(out)

    # 1. the coordinator's control: a SECOND constant differs in a statement that also holds the declared rename
    expect("a second constant differs beside the declared rename (NNReal, in circleSum_local_antilipschitz)",
           plant("§.circleSum_local_antilipschitz", "(c NNReal [", "(c NNReal' ["))
    # 2. a constant renamed in a target's statement, outside every instance argument
    expect("a constant renamed in a target (Disjoint, in palette_sixty_disjoint)",
           plant("§.palette_sixty_disjoint", "(c Disjoint [", "(c Disjoint' ["))
    # 3. its twin: an undeclared difference INSIDE an instance argument only (full print only) — not a DIFFERENT, and
    #    refused all the same, because the constant is not in the record
    def instance_constant(label):
        """a constant that the full print of the type holds and the erased print does not: it sits in an instance"""
        i, j = block(label)
        full = next(ln for ln in lines[i:j] if ln[7:13] == "type  ")
        er = next(ln for ln in lines[i:j] if ln[7:13] == "etype ")
        return sorted(c for c in constants(full) - constants(er) if "." in c and not c.startswith("Hadwiger"))[0]

    c3 = instance_constant("§.palette_sixty_disjoint")
    expect(f"an undeclared constant inside an instance argument ({c3}, in palette_sixty_disjoint, full print only)",
           plant("§.palette_sixty_disjoint", f"(c {c3} [", f"(c {c3}' [", fields=("type  ",)),
           want_fatal="the record does not hold")
    # 4. one of the release's own constants differing inside an instance argument: never allowed there
    c4 = instance_constant("§.palette_transfer_pair")
    expect(f"a constant of the release's own inside an instance argument (for {c4}, in palette_transfer_pair)",
           plant("§.palette_transfer_pair", f"(c {c4} [", "(c HadwigerNelson.Outside.OAI158.sixty [", fields=("type  ",)))
    # 5. the declared renames withdrawn, one at a time
    expect("RENAMED without Set.domRestrict", renamed={"Set.ofPred": "setOf"})
    expect("RENAMED without Set.ofPred", renamed={"Set.domRestrict": "Set.restrict"})
    # 6. a rename pointing at another constant
    expect("RENAMED pointing Set.domRestrict at Set.codRestrict",
           renamed={"Set.domRestrict": "Set.codRestrict", "Set.ofPred": "setOf"})
    # 7. a numeral changed in a definition's value
    expect("a numeral changed in a definition's value (sixty)", plant("§.sixty", "(nat 3)", "(nat 4)"))
    # 8. a binder kind changed in a target
    expect("a binder kind changed (two_state_impossible)", plant("§.two_state_impossible", "(pi.d ", "(pi.i "))
    # 9. a target missing from this pin's print
    i, j = block("§.palette_transfer_pair")
    expect("a target missing from this pin's print", "\n".join(lines[:i] + lines[j:]))
    # 10. a target turned into an axiom
    out = lines[:]
    out[i] = out[i].replace(": theorem", ": axiom")
    expect("a target turned into an axiom", "\n".join(out))
    # 11. a truncated print
    expect("a truncated print", "\n".join(lines[:len(lines) // 2]))
    # 12. the record stale: it lists a constant that no longer differs
    expect("the record lists a constant that does not differ", rec=(record or "") + "\nNoSuch.constant\n",
           want_fatal="stale")
    print("SELF-TEST " + ("OK: 13 plants refused, the unplanted pair passes" if ok else "FAILED"))
    return 0 if ok else 1


def main(argv) -> int:
    if len(argv) < 2:
        print(__doc__)
        return 2
    if argv[1] == "emit":
        return emit()
    if argv[1] == "emit-level1":
        return emit_level1(read(argv[2]))
    if argv[1] == "compare":
        renamed = None
        if "--renamed" in argv:
            spec = argv[argv.index("--renamed") + 1]
            renamed = dict(x.split("=") for x in spec.split(",")) if spec else {}
        rel_text, our_text = read(argv[2]), read(argv[3])
        if "--record" in argv:
            _, _, _, seen = compare(rel_text, our_text, renamed, quiet=True, record="")
            RECORD.write_text("# FS132-I2: the constants by which a ported declaration's stored term differs from the "
                              "release's INSIDE instance\n# arguments and proof arguments only (verdict UP-TO-INSTANCES)."
                              "  Written by `compare --record`; read before committing.\n"
                              + "\n".join(sorted(seen)) + "\n")
            print(f"recorded {len(seen)} constants in {RECORD.relative_to(ROOT)}")
        table, failing, fatal, _ = compare(rel_text, our_text, renamed, write=renamed is None)
        print("READBACK " + ("OK" if not failing and not fatal else "FAILED"))
        return 1 if failing or fatal else 0
    if argv[1] == "level1":
        bad = level1(read(argv[2]), read(argv[3]))
        print("LEVEL1 " + ("OK" if not bad else "FAILED"))
        return 1 if bad else 0
    if argv[1] == "--self-test":
        return self_test(read(argv[2]), read(argv[3]))
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
