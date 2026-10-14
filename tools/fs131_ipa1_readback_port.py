#!/usr/bin/env python3
"""FS131-IPA1 — the read-back across pins of the ported modules of lanes A and B: every declaration of each module, as
the kernel stores it at the release's pin (Lean and Mathlib v4.34.1) and at this library's (v4.32.0).

A ported theorem is kernel-checked here, so nothing about its truth rests on its being the release's term.  This is an
instrument for one sentence — "this is the release's declaration" — and for catching a definition that came to mean
something else at this pin.  It is FS132-I2's read-back (`tools/fs132_i2_readback.py`, another job's tool, imported as
a module and not edited, as FS133-IA1 did): its dumper text, its FULL and ERASED prints, its verdicts IDENTICAL /
UP-TO-INSTANCES / DIFFERENT, its AUX-ABSENT / AUX-DIFFERS for generated auxiliaries, and its record of the constants
that differ inside instance and proof arguments.  This job's table:

  * the constants compared, per module: EVERY source declaration of the release file (its `DECL` lines in
    `data/fs131/ko1/cone/ConeDump.out` — whole files, plan § 3.2), and every generated auxiliary the cone lists for it
    (its `CONE` lines whose name is not a declaration, and its `NORANGE` lines);
  * both release roots `OAI.EuclideanFiveColor.`, `OAI.PlaneFiveColor.` and this library's
    `HadwigerNelson.Outside.OAI158.` are written `§.`; the private prefixes `§private.`;
  * RENAMED: `Set.ofPred` -> `setOf` (never in the text: the set-builder notation elaborates to the pin's name);
  * ANON: an anonymous instance's generated name ends in a suffix made from the root of the module that declares it —
    `_oAI` at the release (modules `OAI.…`), `_proofs` here (`Proofs.…`): `instMeasurableSpaceCircle_oAI_1` there is
    `instMeasurableSpaceCircle_proofs_1` here.  The release's name is written with `_proofs`, in the name looked up
    here and inside every release print;
  * no targets: the two target statements are in lane D's modules;
  * ANTIDIAG (the coordinator's ruling (2), Amendment 1): `Finset.HasAntidiagonal`'s class parameter is `[AddMonoid A]`
    here and `[Add A]` at the release (`Mathlib/Algebra/Order/Antidiag/Prod.lean:64`); a projection takes it as an
    implicit argument, so the erased print keeps it.  In both ERASED prints that one argument of
    `Finset.HasAntidiagonal.antidiagonal` is written `_`; the full prints still differ, so the verdict is at best
    UP-TO-INSTANCES, with the differing constants recorded;
  * PIN-DIFFERENCE (ruling (3)): the three `deriving` instances whose stored VALUES differ because Mathlib's `Monoid`
    changed its parents between the pins (`Algebra/Group/Defs.lean:673` here, `Algebra/Group/Monoid.lean:390` there).
    Each must have the same kind, universe parameters and FULL type print at both pins; its value and its generated
    auxiliaries (`<owner>._aux_n`, `._proof_n`) are then counted PIN-DIFFERENCE, not failed;
  * RULED (ruling (1)): a statement that gains exactly the binders listed for it — the release's own section variables
    — at this pin.  The STRIP CHECK: this pin's erased type with exactly one binder of each listed class removed (its
    `@k` references renumbered; a removed binder still referenced fails) must equal the release's erased type;
  * ADAPTED (plan § 4.3): a declaration whose text an adaptation rewrote.  The STRIP CHECK: at each application of a
    listed head with the listed number of arguments, the inserted argument (by position) is removed from this pin's
    erased print, which must then equal the release's; the full prints are not compared.
Level one (risk 2 of the plan, § 4.7): every Mathlib or core constant that the modules' stored types and definitions'
values name OUTSIDE instance and proof arguments, printed one level down at both pins (`level1`).

  fs131_ipa1_readback_port.py emit LABEL MOD,MOD,…        write data/fs131/ipa1/readback/LABEL/{Release,Here}Dump.lean
  fs131_ipa1_readback_port.py compare LABEL [--record]    the verdicts (prints LABEL/ReleaseDump.out[.xz], HereDump.out[.xz])
  fs131_ipa1_readback_port.py emit-level1 LABEL           write LABEL/{Release,Here}Level1.lean
  fs131_ipa1_readback_port.py level1 LABEL                IDENTICAL / MOVED / DIFFERENT per constant
  fs131_ipa1_readback_port.py --self-test LABEL           plant faults and require each refused
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
port = _load("fs131_ko1_port", ROOT / "tools/fs131_ko1_port.py")

CONE = ROOT / "data/fs131/ko1/cone/ConeDump.out"
BASE = ROOT / "data/fs131/ipa1/readback"
REL_ROOTS = ("OAI.EuclideanFiveColor.", "OAI.PlaneFiveColor.")
OUR_NS = "HadwigerNelson.Outside.OAI158."
RENAMED = {"Set.ofPred": "setOf"}
STATE = {"mods": None, "label": None}


def label_dir(label):
    return BASE / label


def mods_file(label):
    return label_dir(label) / "modules.txt"


def rel_module(mod):
    return port.REL_OF_MOD[mod][0]


def short(name):
    for r in REL_ROOTS:
        if name.startswith(r):
            return name[len(r):]
    raise AssertionError(name)


def split_private(name):
    m = re.match(r"_private\.(OAI\.[\w.]+?)\.0\.(OAI\..*)$", name)
    return (m.group(1), m.group(2)) if m else (None, name)


def rows_for(mods):
    """[(release name, our module, is a source declaration, kind)] for every compared constant."""
    rels = {rel_module(m): m for m in mods}
    out, seen = [], set()
    text = CONE.read_text().splitlines()
    for ln in text:
        f = ln.split("\t")
        if f[0] == "DECL" and f[1] in rels and f[4] not in seen:
            seen.add(f[4])
            out.append((f[4], rels[f[1]], True, "?"))
    for ln in text:
        f = ln.split("\t")
        if f[0] == "CONE" and f[1] in rels and f[6] not in seen:
            seen.add(f[6])
            out.append((f[6], rels[f[1]], False, f[5]))
        elif f[0] == "NORANGE":
            pm, _ = split_private(f[1])
            if pm in rels and f[1] not in seen:
                seen.add(f[1])
                out.append((f[1], rels[pm], False, "?"))
    return out


def cone_constants():
    return rows_for(STATE["mods"])


def label_of(name):
    pm, base = split_private(name)
    return ("§private." if pm else "§.") + short(base)


ANON = re.compile(r"_oAI(?![A-Za-z])")


def name_at(pin, name, mod):
    pm, base = split_private(name)
    if pin == "release":
        return f"PRIVATE|{pm}|{base}" if pm else name
    full = OUR_NS + ANON.sub("_proofs", short(base))
    return f"PRIVATE|Proofs.HadwigerNelson.Outside.{mod}|{full}" if pm else full


def normalise(s, renamed=None, here=False, erased=False):
    s = re.sub(r"_private\.OAI\.[\w.]+?\.0\.OAI\.(?:EuclideanFiveColor|PlaneFiveColor)\.", "§private.", s)
    s = re.sub(r"_private\.Proofs\.HadwigerNelson\.Outside\.\w+\.0\.HadwigerNelson\.Outside\.OAI158\.", "§private.", s)
    for r in REL_ROOTS:
        s = s.replace(r, "§.")
    s = s.replace(OUR_NS, "§.")
    if erased:
        s = antidiag_erase(s)
    if not here:
        s = ANON.sub("_proofs", s)
        for a, b in (RENAMED if renamed is None else renamed).items():
            s = s.replace(f"(c {a} [", f"(c {b} [")
        s = rb.unfold(s, erased)
    return s


ANTIDIAG = "Finset.HasAntidiagonal.antidiagonal"
PIN_DIFFERENCE = {"§.Spectral.instCommGroupDiscreteE", "§.Spectral.instCommGroupDiscreteF",
                  "§.InvariantMean.instAddCommGroupPeriodGroup"}
RULED = {"§.DifferenceFourier.differenceLaw_probability": ["MeasurableMul₂", "MeasurableInv"]}
# label -> [(head constant, number of arguments here, position of the inserted argument)]
ADAPTED = {}
KEYWORDS = ("c", "nat", "str", "proj", "Sort", "let", "(fvar)", "(mvar)")


def parse(s):
    """A print as a tree: a list per parenthesis, an atom per token; `[…]` (universe levels) and string literals are
    one atom each.  `unparse(parse(s)) == s` is asserted by every caller."""
    pos, n = 0, len(s)

    def atom():
        nonlocal pos
        a = pos
        if s[pos] == '"':
            pos += 1
            while s[pos] != '"':
                pos += 2 if s[pos] == "\\" else 1
            pos += 1
            return s[a:pos]
        depth = 0
        while pos < n and (depth > 0 or s[pos] not in " )"):
            if s[pos] == "[":
                depth += 1
            elif s[pos] == "]":
                depth -= 1
            pos += 1
        return s[a:pos]

    def node():
        nonlocal pos
        if s[pos] != "(":
            return atom()
        pos += 1
        out = []
        while s[pos] != ")":
            if s[pos] == " ":
                pos += 1
                continue
            out.append(node())
        pos += 1
        return out

    t = node()
    assert pos == n, (pos, n, s[pos:pos + 40])
    return t


def unparse(t):
    return t if isinstance(t, str) else "(" + " ".join(unparse(x) for x in t) + ")"


def is_app(t):
    return isinstance(t, list) and len(t) == 2 and not (isinstance(t[0], str) and
                                                        (t[0] in KEYWORDS or t[0].startswith(("lam.", "pi."))))


def spine(t):
    args = []
    while is_app(t):
        args.insert(0, t[1])
        t = t[0]
    return t, args


def build(h, args):
    for a in args:
        h = [h, a]
    return h


def head_name(t):
    h, _ = spine(t)
    return h[1] if isinstance(h, list) and len(h) == 3 and h[0] == "c" else None


def rewrite(t, f):
    """Apply f(head, args) -> args at every application, bottom-up; recurse into binders."""
    if isinstance(t, str):
        return t
    if is_app(t):
        h, args = spine(t)
        h = rewrite(h, f)
        args = [rewrite(a, f) for a in args]
        return build(h, f(h, args))
    return [rewrite(x, f) for x in t]


def antidiag_erase(s):
    if ANTIDIAG not in s:
        return s
    t = parse(s)
    assert unparse(t) == s

    def f(h, args):
        if isinstance(h, list) and len(h) == 3 and h[0] == "c" and h[1] == ANTIDIAG and len(args) >= 2:
            args = args[:1] + ["_"] + args[2:]
        return args
    return unparse(rewrite(t, f))


def strip_binders(s, classes):
    """Remove one top-level binder of each class in `classes` from an erased print; renumber `@k`.  None if a listed
    class is not found exactly once or a removed binder is referenced."""
    t = parse(s)
    assert unparse(t) == s
    want, removed, depth = list(classes), [], 0
    node, path = t, []
    while isinstance(node, list) and node and isinstance(node[0], str) and node[0].startswith("pi."):
        hn = head_name(node[2])
        if hn in want:
            want.remove(hn)
            removed.append(depth)
            node = node[3]
        else:
            path.append(node[:3])
            node = node[3]
        depth += 1
    if want:
        return None
    for b in reversed(path):
        node = b + [node]
    out = unparse(node)
    bad = []

    def renum(m):
        k = int(m.group(1))
        if k in removed:
            bad.append(k)
        return "@" + str(k - sum(1 for r in removed if r < k))
    out = re.sub(r"@(\d+)", renum, out)
    return None if bad else out


def strip_inserted(s, sites):
    t = parse(s)
    assert unparse(t) == s
    hit = [0]

    def f(h, args):
        for (head, nargs, i) in sites:
            if isinstance(h, list) and len(h) == 3 and h[0] == "c" and h[1] == head and len(args) == nargs:
                hit[0] += 1
                return args[:i] + args[i + 1:]
        return args
    out = unparse(rewrite(t, f))
    return out if hit[0] else None


def ruled_compare(rel_text, our_text, renamed=None, record=None, quiet=False, write=False):
    """FS132-I2's compare, then this job's ruled classes: PIN-DIFFERENCE, RULED, ADAPTED (above)."""
    table, _, fatal, seen = rb.compare(rel_text, our_text, renamed, quiet=True, record=record)
    rel, _ = rb.load(rel_text, renamed)
    our, _ = rb.load(our_text, renamed, here=True)
    out = []
    for (cls, lab, kind, verdict, there, here, why) in table:
        r, o = rel.get(lab), our.get(lab)
        owner = next((p for p in PIN_DIFFERENCE if lab == p or lab.startswith(p + ".")), None)
        if owner is not None and verdict not in ("IDENTICAL", "UP-TO-INSTANCES"):
            ro, oo = rel.get(owner), our.get(owner)
            if ro and oo and ro["kind"] == oo["kind"] == "def" and ro["levels"] == oo["levels"] \
                    and ro["type"] == oo["type"]:
                verdict, why = "PIN-DIFFERENCE", f"`Monoid`'s parents changed between the pins; {owner}'s type is identical"
            else:
                verdict, why = "DIFFERENT", f"PIN-DIFFERENCE refused: {owner}'s kind, levels or full type differ"
        elif lab in RULED and verdict == "DIFFERENT":
            st = strip_binders(o["etype"], RULED[lab]) if o and o["etype"] else None
            if r["kind"] == o["kind"] and st is not None and st == r["etype"]:
                verdict, why = "RULED", f"the release's statement with exactly the binders {RULED[lab]} inserted"
            else:
                verdict, why = "DIFFERENT", f"RULED strip check refused (binders {RULED[lab]})"
        elif lab in ADAPTED and verdict == "DIFFERENT":
            ok = r["kind"] == o["kind"]
            for er in ("etype", "evalue"):
                if r[er] is None and o[er] is None:
                    continue
                st = strip_inserted(o[er], ADAPTED[lab]) if o[er] else None
                ok = ok and ((st is not None and st == r[er]) or r[er] == o[er])
            verdict, why = ("ADAPTED", "the release's print once the inserted argument is removed") if ok else \
                ("DIFFERENT", "ADAPTED strip check refused")
        out.append((cls, lab, kind, verdict, there, here, why))
    failing = [t for t in out if t[3] in ("DIFFERENT", "ABSENT-HERE")]
    counts = {}
    for t in out:
        counts[(t[0], t[3])] = counts.get((t[0], t[3]), 0) + 1
    if write:
        with open(rb.OUT / "verdicts.tsv", "w") as fh:
            fh.write("class\tname\tkind\tverdict\tconstants only at the release's pin\tconstants only at this pin\tnote\n")
            for t in out:
                if t[3] != "IDENTICAL":
                    fh.write("\t".join([t[0], t[1], t[2], t[3], " ".join(t[4]) or "—", " ".join(t[5]) or "—", t[6]]) + "\n")
    if not quiet:
        for t in out:
            if t[3] in ("DIFFERENT", "ABSENT-HERE", "RULED", "ADAPTED") or (t[3] == "PIN-DIFFERENCE" and t[0] != "aux"):
                print(f"{t[3]}\t{t[0]}\t{t[1]}\t{t[6][:300]}")
        for (c, v), k in sorted(counts.items()):
            print(f"  {c:12s} {v:16s} {k}")
        print(f"  constants differing inside instance and proof arguments: {len(seen)}")
        for f in fatal:
            print(f"FATAL: {f}")
        print(f"constants: {len(out)}  failing: {len(failing)}  fatal: {len(fatal)}")
    return out, failing, fatal, seen


def setup(label):
    STATE["label"] = label
    STATE["mods"] = mods_file(label).read_text().split()
    out = label_dir(label)
    rb.CONE, rb.OUT, rb.TARGETS, rb.RENAMED = CONE, out, [], RENAMED
    rb.RECORD = out / "instance-constants.txt"
    rb.cone_constants, rb.label_of, rb.normalise = cone_constants, label_of, normalise
    rb.NAMED = {}


def prints(label):
    d = label_dir(label)
    def pick(stem):
        for p in (d / f"{stem}.out.xz", d / f"{stem}.out"):
            if p.exists():
                return rb.read(p)
        raise SystemExit(f"no print {stem}.out[.xz] under {d}")
    return pick("ReleaseDump"), pick("HereDump")


def emit(label, mods):
    d = label_dir(label)
    d.mkdir(parents=True, exist_ok=True)
    mods_file(label).write_text("\n".join(mods) + "\n")
    setup(label)
    rows = cone_constants()
    rel = [(label_of(n), name_at("release", n, m)) for n, m, _, _ in rows]
    our = [(label_of(n), name_at("here", n, m)) for n, m, _, _ in rows]
    ri = "".join(f"import {rel_module(m)}\n" for m in mods)
    oi = "".join(f"import Proofs.HadwigerNelson.Outside.{m}\n" for m in mods)
    (d / "ReleaseDump.lean").write_text(ri + "-- FS131-IPA1 (generated by tools/fs131_ipa1_readback_port.py emit): the "
                                        "release's declarations as the kernel holds them at the RELEASE's pin (v4.34.1)."
                                        "\n" + rb.BODY + "\n#eval FS132I2.runAll " + rb.lean_list(rel) + "\n")
    (d / "HereDump.lean").write_text(oi + "-- FS131-IPA1 (generated by tools/fs131_ipa1_readback_port.py emit): the "
                                     "ported declarations as the kernel holds them at THIS library's pin (v4.32.0).\n"
                                     + rb.BODY + "\n#eval FS132I2.runAll " + rb.lean_list(our) + "\n")
    src = sum(1 for r in rows if r[2])
    print(f"wrote {d.relative_to(ROOT)}/ReleaseDump.lean and HereDump.lean: {len(rows)} constants each "
          f"({src} source declarations, {len(rows) - src} generated auxiliaries) in {len(mods)} modules")
    return 0


def emit_level1(label):
    setup(label)
    rel_text, _ = prints(label)
    rel, _ = rb.load(rel_text, renamed={})
    outside = set()
    for lab, dd in rel.items():
        if dd["kind"] == "ABSENT":
            continue
        for c in rb.constants(dd["etype"]) | (rb.constants(dd["evalue"]) if dd["kind"] == "def" else set()):
            if not c.startswith("§"):
                outside.add(c)
    unf = {u[0] for u in rb.UNFOLDED}
    names = sorted(outside | set(RENAMED) | unf)
    d = label_dir(label)
    (d / "level1-names.txt").write_text("\n".join(names) + "\n")
    relp = [(n, n) for n in names]
    ourp = [(n, RENAMED.get(n, n)) for n in names if n not in unf]
    mods = STATE["mods"]
    (d / "ReleaseLevel1.lean").write_text(
        "".join(f"import {rel_module(m)}\n" for m in mods) + "-- FS131-IPA1 (generated): level one at the RELEASE's "
        "pin.\nuniverse u\n" + rb.BODY + "\n#eval FS132I2.runLevel1 " + rb.lean_list(relp) + "\n")
    (d / "HereLevel1.lean").write_text(
        "".join(f"import Proofs.HadwigerNelson.Outside.{m}\n" for m in mods) + "-- FS131-IPA1 (generated): level one "
        "at THIS library's pin.\nuniverse u\n" + rb.BODY + "\n#eval FS132I2.runLevel1 " + rb.lean_list(ourp) + "\n")
    print(f"wrote ReleaseLevel1.lean and HereLevel1.lean: {len(names)} constants")
    return 0


def self_test(label):
    setup(label)
    rel_text, our_text = prints(label)
    record = rb.RECORD.read_text() if rb.RECORD.exists() else None
    _, failing, fatal, _ = ruled_compare(rel_text, our_text, quiet=True)
    if failing or fatal:
        print(f"SELF-TEST FAILED: the unplanted pair does not pass ({len(failing)} failing, {len(fatal)} fatal)")
        return 1
    print("unplanted: PASS (as it must)")
    ok, n = True, 0
    lines = our_text.splitlines()
    rel, _ = rb.load(rel_text)

    def block(lab):
        i = next(k for k, ln in enumerate(lines) if ln.startswith(f"DUMP {lab} : "))
        j = i + 1
        while j < len(lines) and lines[j].startswith("DUMP   "):
            j += 1
        return i, j

    def expect(what, text=None, renamed=None, rec=None, want_fatal=None):
        nonlocal ok, n
        n += 1
        _, f, ft, _ = ruled_compare(rel_text, our_text if text is None else text, renamed=renamed, quiet=True,
                                 record=record if rec is None else rec)
        fired = bool(f or ft)
        hit = fired and (want_fatal is None or any(want_fatal in x for x in ft))
        print(f"plant '{what}': {'REFUSED' if hit else 'SILENT' if not fired else 'REFUSED FOR ANOTHER REASON'} "
              f"({len(f)} failing, {len(ft)} fatal)")
        ok = ok and hit

    def plant(lab, old, new, fields=("type  ", "etype ", "value ", "evalue")):
        i, j = block(lab)
        out = lines[:]
        done = 0
        for k in range(i + 1, j):
            if out[k][7:13] in fields and old in out[k]:
                out[k] = out[k].replace(old, new, 1)
                done += 1
        assert done, (lab, old)
        return "\n".join(out)

    defs = [lab for lab, d in rel.items() if d["kind"] == "def" and "(nat " in (d["value"] or "")
            and not rb.AUXNAME.search(lab) and not lab.startswith("§private.")]
    thms = [lab for lab, d in rel.items() if d["kind"] == "theorem" and "(pi.d " in (d["type"] or "")
            and not rb.AUXNAME.search(lab) and not lab.startswith("§private.")]
    mathc = [(lab, c) for lab in thms for c in sorted(rb.constants(rel[lab]["etype"])) if c.startswith("Mathlib") is False
             and not c.startswith("§") and "." in c]
    lab1, c1 = mathc[0]
    expect(f"a constant changed in a statement ({c1}, in {lab1})", plant(lab1, f"(c {c1} [", f"(c {c1}' ["))
    if defs:
        m = re.search(r"\(nat (\d+)\)", next(ln for ln in lines[slice(*block(defs[0]))] if ln[7:13] == "value "))
        expect(f"a numeral changed in a definition's value ({defs[0]})",
               plant(defs[0], f"(nat {m.group(1)})", f"(nat {int(m.group(1)) + 1})"))
    expect(f"a binder kind changed ({thms[1]})", plant(thms[1], "(pi.d ", "(pi.i "))
    i, j = block(thms[2])
    expect(f"a declaration missing from this pin's print ({thms[2]})", "\n".join(lines[:i] + lines[j:]))
    out = lines[:]
    out[i] = out[i].replace(": theorem", ": axiom")
    expect(f"a theorem turned into an axiom ({thms[2]})", "\n".join(out))
    expect("a truncated print", "\n".join(lines[:len(lines) // 2]))
    expect("the record lists a constant that does not differ", rec=(record or "") + "\nNoSuch.constant\n",
           want_fatal="stale")
    # the ruled classes (Amendment 1): each must refuse what it does not cover
    for lab, classes in RULED.items():
        if lab not in rel:
            continue
        i, j = block(lab)
        k = next(x for x in range(i + 1, j) if lines[x][7:13] == "etype ")
        first = re.search(r"\(pi\.d ", lines[k])
        for what, ins in (("one other binder inserted", "(pi.c inst ((c MeasurableSpace [(p u_1)]) @0) "),
                          (f"a second {classes[-1]} binder inserted",
                           f"(pi.c inst (((({'c'} {classes[-1]} [(p u_1)]) @0) _) _) ")):
            out = lines[:]
            out[k] = out[k][:first.start()] + ins + out[k][first.start():] + ")"
            expect(f"RULED {lab}: {what}", "\n".join(out))
    anti = [lab for lab, d in rel.items() if ANTIDIAG in (d["type"] or "")]
    if anti:
        a0 = anti[0]
        expect(f"ANTIDIAG: the antidiagonal's type argument changed ({a0})",
               plant(a0, f"(c {ANTIDIAG} [0]) (c Nat []))", f"(c {ANTIDIAG} [0]) (c Int []))", fields=("etype ",)))
        saved = globals()["ANTIDIAG"]
        globals()["ANTIDIAG"] = "No.such.constant"
        try:
            expect(f"ANTIDIAG withdrawn ({a0})")
        finally:
            globals()["ANTIDIAG"] = saved
    for owner in sorted(PIN_DIFFERENCE):
        if owner in rel:
            expect(f"PIN-DIFFERENCE: the full type of {owner} changed",
                   plant(owner, "(c CommGroup [", "(c CommGroup' [", fields=("type  ",)) if "(c CommGroup [" in
                   rel[owner]["type"] else plant(owner, "(c AddCommGroup [", "(c AddCommGroup' [", fields=("type  ",)))
            break
    uses_ofpred = any("(c setOf [" in (d["type"] or "") + (d["value"] or "") for d in rel.values())
    if uses_ofpred:
        expect("RENAMED without Set.ofPred", renamed={})
    print(f"SELF-TEST OK: {n} plants refused, the unplanted pair passes" if ok else "SELF-TEST FAILED")
    return 0 if ok else 1


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    cmd, label = argv[1], argv[2]
    if cmd == "emit":
        return emit(label, argv[3].split(","))
    if cmd == "--self-test":
        return self_test(label)
    setup(label)
    if cmd == "emit-level1":
        return emit_level1(label)
    if cmd == "compare":
        rel_text, our_text = prints(label)
        if "--record" in argv:
            _, _, _, seen = rb.compare(rel_text, our_text, None, quiet=True, record="")
            rb.RECORD.write_text("# FS131-IPA1: the constants by which a ported declaration's stored term differs from "
                                 "the release's INSIDE instance\n# arguments and proof arguments only (verdict "
                                 "UP-TO-INSTANCES).  Written by `compare --record`; read before committing.\n"
                                 + "\n".join(sorted(seen)) + "\n")
            print(f"recorded {len(seen)} constants in {rb.RECORD.relative_to(ROOT)}")
        _, failing, fatal, _ = ruled_compare(rel_text, our_text, None, write=True)
        print("READBACK " + ("OK" if not failing and not fatal else "FAILED"))
        return 1 if failing or fatal else 0
    if cmd == "level1":
        d = label_dir(label)
        pick = lambda st: rb.read(next(x for x in (d / f"{st}.out.xz", d / f"{st}.out") if x.exists()))
        bad = rb.level1(pick("ReleaseLevel1"), pick("HereLevel1"))
        print("LEVEL1 " + ("OK" if not bad else "FAILED"))
        return 1 if bad else 0
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
