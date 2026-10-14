#!/usr/bin/env python3
"""FS131-KO1: the generator for the full port of `[OAIMath2026]` family 158's transfer — the release's proof of
`OAI.EuclideanFiveColor.proper_to_borel_weak` and, inside its cone, `OAI.PlaneFiveColor.Spectral.residual_fourier` —
and its checks.

One module per release file: `Proofs/HadwigerNelson/Outside/OAI158<Stem>.lean` for each of the 31 files of MODULES
(the 32nd file of the cone, `Geometry/PlaneColoring/Coloring.lean`, is wholly upstream: its eight cone declarations are
this library's copies in `Outside/OAI158` and `Outside/OAI158Palette`, UPSTREAM).  Nothing is retyped: every
declaration is copied by line range from the clone at the audited commit, and which declarations are copied is not
chosen here — it is read from `data/fs131/ko1/cone/ConeDump.out`, the cone (mask bit 0) of the transfer as the
release's own compiled constants give it (`ConeDump.lean`, run at the release's pin: a `DECL` line per source
declaration, a `CONE` line per constant the target's stored type and proof name, transitively).

The pattern is FS133-IA1's generator (`tools/fs133_ia1_port.py`, branch `fs133-wb1`), which is another job's and is
not edited; with FS131-IE1's scan (`tools/fs131_ie1_port.py`).  What differs from FS133-IA1's: many files, one module
each; the files' scopes read as a stack (nested `noncomputable section`s, named sections, namespaces anywhere), a scope
with no copied declaration left out whole; the release's root-namespace tokens rewritten in declarations as well as in
scaffolding (each such line counted in the header); the per-module tables are data, one JSON file per module under
`data/fs131/ko1/port/` (so that lanes porting different modules write different files); a generated auxiliary with no
source range (`….match_n.splitter`) accepted when its owner is copied.

What this script changes in the copied text, and nothing else:
  1. the namespaces: `namespace OAI` / `end OAI` are left out, and `OAI.EuclideanFiveColor[.X]`,
     `OAI.PlaneFiveColor[.X]`, `EuclideanFiveColor[.X]`, `PlaneFiveColor[.X]` are written
     `HadwigerNelson.Outside.OAI158[.X]` wherever the token stands (scaffolding and declarations: a fully qualified
     name names the same constant, and the stored terms differ from the release's only by the name map); a name that
     two ported declarations would share is refused; a declaration outside both roots is refused;
  2. the `import` lines: each module imports the ported modules (and upstream modules) whose declarations its cone
     constants name, transitively reduced, and the Mathlib modules of the import dump
     (`data/fs131/ko1/cone/ImportsDump.out`) for its release file, less the table's `drop_imports`, plus its
     `more_imports`; never `Mathlib` whole and never a module of the release;
  3. a source address in every declaration's docstring (`File.lean:line` at the commit): a docstring is added where
     the release has none (this library's `linter.missingDocs`), and prefixed where it has one;
  4. declarations outside the cone are left out, and so is a scope (namespace or section) left with none; an
     `example` is left out and listed; an `… in` line goes with its declaration;
  5. the table's `scoped`: an instance the release declares on a type that is Mathlib's is `scoped` here (`LEAN.md`
     § Assumptions) — the keyword, nothing else; every copied global instance must be in exactly one of `scoped` and
     `global_instances` (a `local instance` needs neither), or the script refuses;
  6. the table's `patches` — each a token of a PROOF that does not elaborate at this library's pin (Lean v4.32.0,
     Mathlib v4.32.0; the release is at v4.34.1), with its reason.  The script refuses a patch that touches a
     definition, an instance whose value is a term, or a theorem's statement (anything before its top-level `:=`);
  7. the table's `renames` — a Mathlib constant renamed between the pins, applied to the token wherever it stands in
     a theorem; refused inside a definition;
  8. the table's `drop_open` — a namespace that does not exist under the module's imports, taken out of its `open`
     line (by line and token); an `open` line left with none is left out.
Before anything is generated the copied lines are SCANNED for what runs code or changes options while a file
elaborates (`#`-commands, `run_cmd`/`run_elab`/`run_meta`, `initialize`, `unsafe`, `IO.`, `macro`/`elab`/`syntax`/
`notation`/`infix`/`macro_rules`/`elab_rules`, `set_option`, `attribute`, `implemented_by`, `extern`): a hit refuses.

The release's licence text travels with the ported modules: `Outside/OAIMath2026-LICENSE.txt` (written by FS132-L2)
must be the clone's `LICENSE` byte for byte; `--check` compares, every generated header names it.

Usage:
  tools/fs131_ko1_port.py --modules A,B   write the named modules (our module names, e.g. OAI158Basic)
  tools/fs131_ko1_port.py --check --modules A,B   regenerate in memory and compare with the files; exit 1 on a
                                          difference
  tools/fs131_ko1_port.py --self-test     plant faults (on the trial's modules) and require each refused, and the
                                          unplanted check to pass
  tools/fs131_ko1_port.py --list [--modules …]    per module: copied / upstream / left out, with source lines
  tools/fs131_ko1_port.py --names [--modules …]   one line per ported declaration: module, kind, name here, release name
  tools/fs131_ko1_port.py --imports [--modules …] the computed import list of each module
  tools/fs131_ko1_port.py --axioms-block [--modules …]  the audit's records for these modules (a draft for the landing)
"""
import hashlib
import json
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
CLONE = pathlib.Path("/home/kooshi/source/math")
COMMIT = "adc7f1241b42e322a6451854ab7e4b4c146bf78a"
SRCROOT = "lean/OAI"
CONE = ROOT / "data/fs131/ko1/cone/ConeDump.out"
IMPORTS = ROOT / "data/fs131/ko1/cone/ImportsDumpWhole.out"
TABLES = ROOT / "data/fs131/ko1/port"
OUTDIR = ROOT / "Proofs/HadwigerNelson/Outside"
PFX = "Proofs.HadwigerNelson.Outside."
OUR_NS = "HadwigerNelson.Outside.OAI158"
ROOT_TOKEN = re.compile(r"(?<![A-Za-z0-9_.'])(?:OAI\.)?(?:EuclideanFiveColor|PlaneFiveColor)(?![A-Za-z0-9_'])")
OTHER_OAI = re.compile(r"(?<![A-Za-z0-9_.'])OAI\.(?!EuclideanFiveColor|PlaneFiveColor)")
MASK = 1          # the transfer's cone (the rigidity lemma's lies inside it: plans/FS131-KO1-port-plan.md § 2.1)

# (release module, path under lean/OAI) in dependency order (plans/FS131-KO1-port-plan.md § 2.2); our module is
# "OAI158" + the file's stem.
FILES = [
    ("OAI.Analysis.PlaneSpectrum.Basic", "Analysis/PlaneSpectrum/Basic.lean"),
    ("OAI.Analysis.PlaneSpectrum.InvariantMean", "Analysis/PlaneSpectrum/InvariantMean.lean"),
    ("OAI.Analysis.PlaneSpectrum.NumberFields", "Analysis/PlaneSpectrum/NumberFields.lean"),
    ("OAI.Analysis.PlaneSpectrum.PhaseEncoding", "Analysis/PlaneSpectrum/PhaseEncoding.lean"),
    ("OAI.Analysis.PlaneSpectrum.SmallArcs", "Analysis/PlaneSpectrum/SmallArcs.lean"),
    ("OAI.MeasureTheory.CompactFactors.Amenability", "MeasureTheory/CompactFactors/Amenability.lean"),
    ("OAI.MeasureTheory.CompactFactors.Centers", "MeasureTheory/CompactFactors/Centers.lean"),
    ("OAI.Analysis.PlaneSpectrum.Characters", "Analysis/PlaneSpectrum/Characters.lean"),
    ("OAI.Analysis.PlaneSpectrum.PhaseCollision", "Analysis/PlaneSpectrum/PhaseCollision.lean"),
    ("OAI.Analysis.PlaneSpectrum.Selections", "Analysis/PlaneSpectrum/Selections.lean"),
    ("OAI.MeasureTheory.CompactFactors.RelativeCenters", "MeasureTheory/CompactFactors/RelativeCenters.lean"),
    ("OAI.Analysis.PlaneSpectrum.Multipliers", "Analysis/PlaneSpectrum/Multipliers.lean"),
    ("OAI.MeasureTheory.CompactFactors.ConditionalSelection", "MeasureTheory/CompactFactors/ConditionalSelection.lean"),
    ("OAI.Analysis.PlaneSpectrum.FourierTests", "Analysis/PlaneSpectrum/FourierTests.lean"),
    ("OAI.Analysis.PlaneSpectrum.ConditionalSpectrum", "Analysis/PlaneSpectrum/ConditionalSpectrum.lean"),
    ("OAI.MeasureTheory.CompactFactors.Approximation", "MeasureTheory/CompactFactors/Approximation.lean"),
    ("OAI.MeasureTheory.CompactFactors.ConditionalLimits", "MeasureTheory/CompactFactors/ConditionalLimits.lean"),
    ("OAI.MeasureTheory.CompactFactors.Kernels", "MeasureTheory/CompactFactors/Kernels.lean"),
    ("OAI.MeasureTheory.CompactFactors.BoundedFunctions", "MeasureTheory/CompactFactors/BoundedFunctions.lean"),
    ("OAI.MeasureTheory.CompactFactors.Functions", "MeasureTheory/CompactFactors/Functions.lean"),
    ("OAI.MeasureTheory.CompactFactors.Factors", "MeasureTheory/CompactFactors/Factors.lean"),
    ("OAI.MeasureTheory.CompactFactors.RelativeProducts", "MeasureTheory/CompactFactors/RelativeProducts.lean"),
    ("OAI.MeasureTheory.CompactFactors.Separability", "MeasureTheory/CompactFactors/Separability.lean"),
    ("OAI.MeasureTheory.CompactFactors.Stationary", "MeasureTheory/CompactFactors/Stationary.lean"),
    ("OAI.MeasureTheory.CompactFactors.AlgebraModels", "MeasureTheory/CompactFactors/AlgebraModels.lean"),
    ("OAI.Analysis.PlaneSpectrum.Representations", "Analysis/PlaneSpectrum/Representations.lean"),
    ("OAI.Analysis.PlaneSpectrum.Energy", "Analysis/PlaneSpectrum/Energy.lean"),
    ("OAI.Analysis.PlaneSpectrum.SpectralMeasure", "Analysis/PlaneSpectrum/SpectralMeasure.lean"),
    ("OAI.Analysis.PlaneSpectrum.RadialEnergy", "Analysis/PlaneSpectrum/RadialEnergy.lean"),
    ("OAI.Analysis.PlaneSpectrum.Ergodicity", "Analysis/PlaneSpectrum/Ergodicity.lean"),
    ("OAI.Geometry.PlaneColoring.BorelTransfer", "Geometry/PlaneColoring/BorelTransfer.lean"),
]
COLORING = "OAI.Geometry.PlaneColoring.Coloring"

# release constant -> (the library module that declares it, its name here).  `Coloring.lean`'s eight cone
# declarations, copied by FS132-I1 (`Outside/OAI158`) and FS132-K1 (`Outside/OAI158Palette`); the two instances of
# `Coloring.lean` 19–20 are anonymous there and named here.
UPSTREAM = {
    "OAI.EuclideanFiveColor.ProperColoring": ("OAI158", "ProperColoring"),
    "OAI.EuclideanFiveColor.anglePeriodPositive": ("OAI158", "anglePeriodPositive"),
    "OAI.EuclideanFiveColor.Angles": ("OAI158", "Angles"),
    "OAI.EuclideanFiveColor.angularMeasure": ("OAI158", "angularMeasure"),
    "OAI.EuclideanFiveColor.direction": ("OAI158", "direction"),
    "OAI.EuclideanFiveColor.WeakColoring": ("OAI158", "WeakColoring"),
    "OAI.EuclideanFiveColor.instIsAddHaarMeasureAnglesAngularMeasure":
        ("OAI158Palette", "angularMeasure.instIsAddHaarMeasure"),
    "OAI.EuclideanFiveColor.direction_continuous": ("OAI158Palette", "direction_continuous"),
    # outside the transfer's cone, there with the rest of the file (whole files: § 3.2 of the plan)
    "OAI.EuclideanFiveColor.instIsProbabilityMeasureAnglesAngularMeasure":
        ("OAI158", "angularMeasure.instIsProbabilityMeasure"),
    "OAI.EuclideanFiveColor.direction_norm": ("OAI158Palette", "direction_norm"),
    "OAI.EuclideanFiveColor.direction_real": ("OAI158Palette", "direction_real"),
}
UPSTREAM_IMPORTS = {"OAI158": set(), "OAI158Palette": {"OAI158"}}   # what each upstream module imports, of these

KEYWORD = re.compile(r"^\s*(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|scoped|local|nonrec|partial)\s+)*"
                     r"(lemma|theorem|def|abbrev|instance|structure|inductive|class)\b")
PROOFKINDS = ("lemma", "theorem")
GENERATED = re.compile(r"\.(?:_proof_\d+|match_\d+(?:\.(?:splitter|_arg_pusher|eq_\d+))?|eq_\d+|_simp_\d+_\d+|"
                       r"_abel_\d+_\d+|_aux_\d+|proof_\d+|_unary|_mutual|_sunfold|eq_def)$")
SCAN = [
    (re.compile(r"^\s*#"), "a #-command"),
    (re.compile(r"\b(run_cmd|run_elab|run_meta|initialize|builtin_initialize)\b"), "a command that runs code"),
    (re.compile(r"\bunsafe\b"), "`unsafe`"),
    (re.compile(r"(?<![A-Za-z0-9_.])IO\."), "`IO.`"),
    (re.compile(r"^\s*(?:local\s+|scoped\s+)?(macro|elab|syntax|notation|infix|infixl|infixr|prefix|postfix|"
                r"macro_rules|elab_rules|declare_syntax_cat)\b"), "syntax or a macro"),
    (re.compile(r"\bset_option\b"), "`set_option`"),
    (re.compile(r"^\s*(?:local\s+|scoped\s+)?attribute\s*\["), "an `attribute` command"),
    (re.compile(r"\b(implemented_by|extern|csimp)\b"), "a compiler attribute"),
]
LICENCE_NAME = "OAIMath2026-LICENSE.txt"
LICENCE_SRC = "LICENSE"
TABLE_KEYS = {"patches", "renames", "scoped", "global_instances", "drop_open", "drop_imports", "more_imports",
              "aux_unported", "notes", "adaptations", "drop_omit"}
# ADAPTATIONS (a table of their own, pending the coordinator's ruling: plans/FS131-KO1-port-plan.md § 4.3): a token of a
# release-internal STATEMENT or DEFINITION that does not elaborate at this pin because a Mathlib API changed between the
# pins (Mathlib's `Measure.map` / `ProbabilityMeasure.map`: § 3.3), rewritten to the same object at this pin.  Refused
# on PROTECTED declarations: the two targets, and every declaration the density branch holds a copy of (its stored
# term must be that copy's: § 3.4), read from that branch's names (`data/fs131/ko1/lean/names-fs133wb1.out.xz`).
PROTECTED_TARGETS = {"OAI.EuclideanFiveColor.proper_to_borel_weak", "OAI.PlaneFiveColor.Spectral.residual_fourier"}
SHARED_MODULES = ("Proofs.HadwigerNelson.Outside.OAI158Rigidity", "Proofs.HadwigerNelson.Outside.OAI158Transfer")


def shared_names():
    import lzma
    p = ROOT / "data/fs131/ko1/lean/names-fs133wb1.out.xz"
    out = set()
    for ln in lzma.open(p, "rt"):
        f = ln.rstrip("\n").split("\t")
        if f[0] == "NAME" and f[1] in SHARED_MODULES:
            out.add(f[3])
    if not out:
        raise Refused("the density branch's names are absent: no adaptation can be checked")
    return out


class Refused(Exception):
    """A condition under which nothing may be generated."""


def stem(path):
    return path.rsplit("/", 1)[-1][:-len(".lean")]


def ours(relmod):
    return "OAI158" + relmod.rsplit(".", 1)[-1]


def base(path):
    return path.rsplit("/", 1)[-1]


MOD_OF_REL = {m: ours(m) for m, _ in FILES}
REL_OF_MOD = {ours(m): (m, p) for m, p in FILES}


def here_name(rel):
    if rel.startswith("_private."):
        rel = rel.split(".0.", 1)[1]
    for r in ("OAI.EuclideanFiveColor.", "OAI.PlaneFiveColor."):
        if rel.startswith(r):
            return OUR_NS + "." + rel[len(r):]
    raise Refused(f"{rel} is in neither of the release's root namespaces")


def short(rel):
    return here_name(rel)[len(OUR_NS) + 1:]


def clone_commit(clone):
    return subprocess.run(["git", "-C", str(clone), "rev-parse", "HEAD"], check=True, capture_output=True,
                          text=True).stdout.strip()


def load_tables(mod, tables=None):
    if tables is not None and mod in tables:
        t = tables[mod]
    else:
        p = TABLES / f"{mod}.json"
        t = json.loads(p.read_text()) if p.exists() else {}
    bad = set(t) - TABLE_KEYS
    if bad:
        raise Refused(f"{mod}: unknown table keys {sorted(bad)}")
    return {k: t.get(k, [] if k != "aux_unported" else {}) for k in TABLE_KEYS}


def read_cone(text):
    """-> decl rows per release module {(first, last, owner)}, cone owners per module, upstream owners seen,
    and the module edges."""
    mods = {m for m, _ in FILES} | {COLORING}
    rows, cone_rows, edges, norange, consts = {}, [], [], [], {}
    owner_decl = {}
    for ln in text.splitlines():
        f = ln.split("\t")
        if f[0] == "DECL":
            owner_decl.setdefault((f[4], int(f[2]), int(f[3])), set()).add(f[1])
    for ln in text.splitlines():
        f = ln.split("\t")
        if f[0] == "DECL" and f[1] in mods:
            rows.setdefault(f[1], set()).add((int(f[2]), int(f[3]), f[4]))
        elif f[0] == "CONE" and int(f[7]) & MASK:
            # a reserved name made on demand (`f.eq_1`, `f.congr_simp`) lives in the module that asked for it; it is
            # placed with its owner's declaration, and this pin makes its own
            at = owner_decl.get((f[4], int(f[2]), int(f[3])), set())
            if len(at) == 1 and f[1] not in at:
                if not re.search(r"\.(?:eq_\d+|eq_def|congr_simp)$", f[6]):
                    raise Refused(f"{f[6]} lives in {f[1]} and its owner {f[4]} is declared in {sorted(at)}")
                f[1] = next(iter(at))
            if f[1] not in mods:
                raise Refused(f"the cone leaves the planned files: {f[6]} is in {f[1]}")
            cone_rows.append((f[1], int(f[2]), int(f[3]), f[4], f[6], f[5]))
            consts[f[6]] = f[1]
        elif f[0] == "EDGE":
            edges.append((f[1], f[2]))
        elif f[0] == "NORANGE":
            norange.append(f[1])
    if not cone_rows:
        raise Refused("the cone file holds no CONE line")
    return rows, cone_rows, edges, norange, consts


def outermost(rs, lines, mod):
    """Outermost declaration ranges, and the map from every range to its outermost one."""
    top, decls, cur = {}, [], None
    for (a, b, o) in sorted(rs, key=lambda r: (r[0], -r[1], len(r[2]))):
        if cur is not None and a <= cur[1]:
            inside = b <= cur[1]
            extends = (o + ".").startswith(cur[2] + ".")
            derived = "deriving" in lines[a - 1] and o.rsplit(".", 1)[-1].startswith("inst")
            same = (a, b) == (cur[0], cur[1])     # a companion an attribute generates (`@[ext]`'s `ext_iff`)
            attr = a == cur[0] and "@[" in lines[a - 1]   # made by an attribute of the outer one (`@[simps]`)
            if not inside or not (extends or derived or same or attr):
                raise Refused(f"{mod}: declarations {cur[2]} ({cur[0]}–{cur[1]}) and {o} ({a}–{b}) overlap")
        else:
            cur = (a, b, o)
            decls.append(cur)
        top[(a, b, o)] = cur
    return decls, top


def statement_end(lines, first, last):
    """(line, column) of the declaration's top-level `:=` (or `where`/`|` for a definition by fields or cases)."""
    depth, started = 0, False
    for no in range(first, last + 1):
        s = lines[no - 1]
        i = 0
        if not started:
            m = KEYWORD.match(s)
            if not m:
                continue
            started, i = True, m.end()
        while i < len(s):
            ch = s[i]
            if ch in "([{⟨":
                depth += 1
            elif ch in ")]}⟩":
                depth -= 1
            elif depth == 0 and s.startswith(":=", i):
                return no, i
            elif depth == 0 and s.startswith("--", i):
                break
            i += 1
    return None


SCOPE_OPEN = re.compile(r"^(namespace (\S+)|(?:noncomputable )?section(?: (\S+))?)$")
SCOPE_END = re.compile(r"^end(?: (\S+))?$")
SCAFFOLD = re.compile(r"^(?:open\s.*|variable\b.*|include\b.*|omit\b.*|universe\b.*|--.*|)$")


def parse(lines, decls, mod):
    """The file as a tree of scopes.  Node: dict(kind, line, close, items) with items in source order:
    ('decl', (a, b, o)), ('scaffold', no), ('in', no) — an `… in` line before a declaration —, ('example', a, b),
    ('scope', node).  Refuses a line it cannot classify."""
    owner_at = {}
    for d in decls:
        for no in range(d[0], d[1] + 1):
            owner_at[no] = d
    root = dict(kind="file", line=0, close=None, name=None, items=[])
    stack = [root]
    no, n = 1, len(lines)
    while no <= n:
        s = lines[no - 1]
        if no in owner_at:
            d = owner_at[no]
            if no != d[0]:
                raise Refused(f"{mod}:{no}: inside {d[2]} but not at its first line")
            stack[-1]["items"].append(("decl", d))
            no = d[1] + 1
            continue
        m = SCOPE_OPEN.match(s)
        if m:
            node = dict(kind="ns" if s.startswith("namespace") else "sec", line=no, close=None,
                        name=m.group(2) or m.group(3), items=[])
            stack[-1]["items"].append(("scope", node))
            stack.append(node)
            no += 1
            continue
        m = SCOPE_END.match(s)
        if m:
            if len(stack) == 1:
                raise Refused(f"{mod}:{no}: an `end` with no scope open")
            top = stack.pop()
            if (m.group(1) or None) != top["name"]:
                raise Refused(f"{mod}:{no}: `{s}` closes `{top['name']}` opened at line {top['line']}")
            top["close"] = no
            no += 1
            continue
        if re.match(r"^import \S+$", s):
            if len(stack) != 1:
                raise Refused(f"{mod}:{no}: an import inside a scope")
            no += 1
            continue
        if re.match(r"^example\b", s):
            b = no
            while b < n and (lines[b].startswith((" ", "\t")) or lines[b] == "") and (b + 1) not in owner_at \
                    and not (lines[b] == "" and (b + 2 > n or not lines[b + 1].startswith((" ", "\t")))):
                b += 1
            stack[-1]["items"].append(("example", no, b))
            no = b + 1
            continue
        if re.match(r"^(open|omit|include|variable)\b", s):
            # a command with its continuation lines; one whose last line ends in ` in` belongs to the next declaration
            b = no
            while b < n and lines[b].startswith((" ", "\t")) and (b + 1) not in owner_at:
                b += 1
            kind = "in" if re.search(r"\sin$", lines[b - 1]) else "scaffold"
            if kind == "in":
                while b < n and lines[b] == "":
                    b += 1
            if kind == "in" and (b + 1) not in owner_at and not re.match(r"^(open|omit|include|variable)\b",
                                                                         lines[b] if b < n else ""):
                raise Refused(f"{mod}:{no}: an `… in` command not followed by a declaration")
            for k in range(no, b + 1):
                stack[-1]["items"].append((kind, k))
            no = b + 1
            continue
        if SCAFFOLD.match(s):
            stack[-1]["items"].append(("scaffold", no))
            no += 1
            continue
        if s.startswith("/-") and not s.startswith("/--"):
            b = no
            while "-/" not in lines[b - 1]:
                b += 1
            for k in range(no, b + 1):
                stack[-1]["items"].append(("scaffold", k))
            no = b + 1
            continue
        raise Refused(f"{mod}:{no}: a line this script does not classify: {s!r}")
    if len(stack) != 1:
        raise Refused(f"{mod}: a scope is not closed: {stack[-1]['name']} (line {stack[-1]['line']})")
    return root


def scan(text_lines, where):
    for i, s in where:
        for pat, what in SCAN:
            if pat.search(s):
                raise Refused(f"{i}: the scan: {what} in a copied line: {s.strip()!r}")


def plan(cone_text=None, clone=CLONE, tables=None, sources=None, only=None, parse_all=False):
    cone_text = CONE.read_text() if cone_text is None else cone_text
    rows, cone_rows, edges, norange, consts = read_cone(cone_text)
    srcs = {}
    for m, p in FILES + [(COLORING, "Geometry/PlaneColoring/Coloring.lean")]:
        srcs[m] = (sources or {}).get(m) or (pathlib.Path(clone) / SRCROOT / p).read_text().split("\n")
    decls, tops = {}, {}
    for m in srcs:
        decls[m], tops[m] = outermost(rows.get(m, set()), srcs[m], m)
    # cone owners per module (outermost)
    want, aux_seen = {}, set()
    for (m, a, b, o, name, kind) in cone_rows:
        t = tops[m].get((a, b, o))
        if t is None:
            raise Refused(f"{name}: its range {m}:{a}–{b} is no declaration of the DECL lines")
        if m == COLORING:
            if t[2] not in UPSTREAM:
                raise Refused(f"{name} (Coloring.lean) is not one of the upstream copies")
            continue
        tab = load_tables(MOD_OF_REL[m], tables)
        if name in tab["aux_unported"]:
            if kind != "theorem" or not GENERATED.search(name):
                raise Refused(f"{name} is listed as a generated auxiliary and is a {kind}")
            aux_seen.add(name)
            continue
        want.setdefault(m, set()).add(t)
    for name in norange:
        if not GENERATED.search(name):
            raise Refused(f"a cone constant with no source range that is not a generated auxiliary: {name}")
        stripped = re.sub(r"(?:\.(?:match_\d+|splitter|_arg_pusher|eq_\d+|_proof_\d+))+$", "", name)
        tail = stripped.split(".0.", 1)[1] if stripped.startswith("_private.") else stripped
        if not any(t[2] == tail for ts in want.values() for t in ts):
            raise Refused(f"{name}: a generated auxiliary whose owner {tail} is not copied")
    for m, _ in FILES:
        tab = load_tables(MOD_OF_REL[m], tables)
        missing = set(tab["aux_unported"]) - aux_seen
        if missing:
            raise Refused(f"{MOD_OF_REL[m]}: aux_unported entries the cone does not hold: {sorted(missing)}")
    for (_, _, o) in decls[COLORING]:
        if o not in UPSTREAM:
            raise Refused(f"Coloring.lean declares {o}, which is not one of the upstream copies")
    # module dependencies: from constant edges
    dep = {}
    owner_mod = {}
    for (m, a, b, o, name, kind) in cone_rows:
        owner_mod[name] = m if m != COLORING else UPSTREAM.get(tops[m][(a, b, o)][2], (None,))[0]
    for (x, y) in edges:
        if x in owner_mod and y in owner_mod and owner_mod[x] != owner_mod[y]:
            dep.setdefault(owner_mod[x], set()).add(owner_mod[y])
    # whole files: a module imports what its release file imports (`Coloring` is upstream: `Outside/OAI158Palette`,
    # which imports `Outside/OAI158`, holds the last of its copies); the cone's edges must lie inside that
    dep_cone = dep
    dep = {}
    for m, _ in FILES:
        for ln in srcs[m]:
            mm = re.match(r"^import (OAI\.\S+)$", ln)
            if mm:
                tgt = mm.group(1)
                if tgt == COLORING:
                    dep.setdefault(m, set()).add("OAI158Palette")
                elif tgt in MOD_OF_REL:
                    dep.setdefault(m, set()).add(tgt)
                else:
                    raise Refused(f"{MOD_OF_REL[m]}: the release file imports {tgt}, which is not in the plan")
    plan_deps_cache.clear()
    for m, _ in FILES:
        plan_deps_cache[MOD_OF_REL[m]] = sorted(dep.get(m, set()))
    for m, _ in FILES:
        for d in dep_cone.get(m, set()):
            dd = MOD_OF_REL.get(d, d)
            if dd not in plan_closure(MOD_OF_REL[m]):
                raise Refused(f"{MOD_OF_REL[m]}: its cone names {dd}, which its imports do not reach")
    out, names_here = {}, {}
    for m, path in FILES:
        mod = MOD_OF_REL[m]
        if only is not None and mod not in only:
            continue
        # WHOLE FILES: every declaration of the file is copied (§ 3.2 of the plan: the cone misses what proofs use
        # only definitionally — `rfl` lemmas a `simp` rewrites with — and the 31 files import nothing else); the cone
        # is the check that nothing it holds is missed
        allf = set(decls[m])
        if not want.get(m, set()) <= allf:
            raise Refused(f"{mod}: cone declarations outside the file's declarations")
        out[mod] = emit_module(m, path, srcs[m], decls[m], allf, load_tables(mod, tables), names_here)
        out[mod]["deps"] = sorted(dep.get(m, set()))
        out[mod]["cone"] = len(want.get(m, set()))
    if parse_all:
        for m, path in FILES:
            parse(srcs[m], decls[m], MOD_OF_REL[m])
    return out


def emit_module(m, path, lines, decls, want, tab, names_here):
    name = base(path)
    mod = MOD_OF_REL[m]
    tree = parse(lines, decls, mod)
    used = dict(patches=set(), scoped=set(), glob=set(), drop_open=set(), adapt=set(), drop_omit=set())
    copied, left, examples, rooted, adapted = [], [], [], [], []

    def has_want(node):
        for it in node["items"]:
            if it[0] == "decl" and it[1] in want:
                return True
            if it[0] == "scope" and has_want(it[1]):
                return True
        return False

    def map_line(no, s):
        t = ROOT_TOKEN.sub(OUR_NS, s)
        if t != s:
            rooted.append(no)
        if OTHER_OAI.search(t):
            raise Refused(f"{name}:{no}: a name under `OAI.` outside both roots: {s.strip()!r}")
        return t

    def open_line(no, s):
        for i, (dl, tok, _) in enumerate(tab["drop_open"]):
            if dl == no:
                parts = s.split()
                if tok not in parts:
                    raise Refused(f"{mod}: drop_open {i} ({tok}) is not on line {no}")
                parts.remove(tok)
                used["drop_open"].add(i)
                s = " ".join(parts)
        if re.match(r"^open(?: scoped)?$", s.strip()):
            return None
        return s

    def emit(node, body):
        pending = []
        for it in node["items"]:
            if it[0] == "scope":
                sub = it[1]
                if not has_want(sub):
                    continue
                if sub["kind"] == "ns" and sub["name"] == "OAI":
                    emit(sub, body)
                    continue
                body.append(map_line(sub["line"], lines[sub["line"] - 1]))
                emit(sub, body)
                body.append(map_line(sub["close"], lines[sub["close"] - 1]))
            elif it[0] == "scaffold":
                if pending:
                    raise Refused(f"{name}:{it[1]}: a line between an `… in` command and its declaration")
                s = lines[it[1] - 1]
                if s.startswith("open"):
                    s = open_line(it[1], s)
                    if s is None:
                        continue
                body.append(map_line(it[1], s))
            elif it[0] == "in":
                pending.append(it[1])
            elif it[0] == "example":
                examples.append((it[1], it[2]))
                pending = []
            elif it[0] == "decl":
                d = it[1]
                if d not in want:
                    left.append(d)
                    pending = []
                    continue
                for p in pending:
                    s = lines[p - 1]
                    # the table's `drop_omit` (FS131-IPA1's revision, the coordinator's Amendment 4): a one-line
                    # `omit … in` attached to this copied declaration, left out
                    hit = [i for i, (ol, _) in enumerate(tab["drop_omit"]) if ol == p]
                    if hit:
                        if not re.match(r"^omit\s.*\sin$", s):
                            raise Refused(f"{mod}: drop_omit {hit[0]} (line {p}) is not a one-line `omit … in`")
                        used["drop_omit"].update(hit)
                        continue
                    if s.startswith("open"):
                        s = open_line(p, s)
                    if s is not None:
                        body.append(map_line(p, s))
                pending = []
                body.extend(copy_decl(d))
        if pending:
            raise Refused(f"{name}: an `… in` line at the end of a scope (line {pending[-1]})")

    def copy_decl(d):
        a, b, o = d
        text = lines[a - 1:b]
        kw = next((i for i, t in enumerate(text) if KEYWORD.match(t)), None)
        if kw is None:
            raise Refused(f"{name}:{a}–{b}: no declaration keyword found in {o}")
        kind = KEYWORD.match(text[kw]).group(1)
        scan(text, [(f"{name}:{a + j}", t) for j, t in enumerate(text)])
        se = statement_end(lines, a, b)
        for i, (pl, old, new, _) in enumerate(tab["patches"]):
            if a <= pl <= b:
                if kind not in PROOFKINDS and not (kind == "instance" and se is not None):
                    raise Refused(f"patch {i} ({name}:{pl}) is inside the {kind} {o}: a definition is never patched")
                if se is None:
                    raise Refused(f"patch {i} ({name}:{pl}): no top-level `:=` found in {o}")
                if kind == "instance" and "by" not in lines[se[0] - 1][se[1]:].split():
                    raise Refused(f"patch {i} ({name}:{pl}) is inside the instance {o}, whose value is a term")
                row = text[pl - a]
                pos = row.find(old)
                if pos < 0:
                    raise Refused(f"patch {i} does not apply at {name}:{pl}")
                if (pl, pos) < se:
                    raise Refused(f"patch {i} ({name}:{pl}) touches the statement of {o} (its `:=` is at "
                                  f"line {se[0]}, column {se[1]})")
                text[pl - a] = row.replace(old, new, 1)
                used["patches"].add(i)
        for i, (al, old, new, why) in enumerate(tab["adaptations"]):
            if a <= al <= b:
                if o in PROTECTED_TARGETS or (not o.startswith("_private.") and here_name(o) in shared_names()):
                    raise Refused(f"adaptation {i} ({name}:{al}) is in {o}, a target or a declaration the density "
                                  "branch shares: its stored term must not change")
                row = text[al - a]
                if old not in row:
                    raise Refused(f"adaptation {i} does not apply at {name}:{al}")
                text[al - a] = row.replace(old, new, 1)
                used["adapt"].add(i)
                adapted.append((a, b, o, al))
        for (r_old, r_new, _) in tab["renames"]:
            pat = re.compile(r"(?<![A-Za-z0-9_'])" + re.escape(r_old) + r"(?![A-Za-z0-9'])")
            for j, row in enumerate(text):
                if pat.search(row):
                    if kind not in PROOFKINDS:
                        raise Refused(f"rename `{r_old}` occurs in the {kind} {o} ({name}:{a + j}): "
                                      "a definition is never changed")
                    text[j] = pat.sub(r_new, row)
        if kind == "instance":
            is_local = re.match(r"^(?:@\[[^\]]*\]\s*)*(?:\w+\s+)*local\s+instance\b", text[kw]) is not None
            is_rel_scoped = re.match(r"^(?:@\[[^\]]*\]\s*)*(?:\w+\s+)*scoped\s+instance\b", text[kw]) is not None
            sc = [i for i, (sl, _) in enumerate(tab["scoped"]) if sl == a + kw]
            gl = [i for i, (gl_, _) in enumerate(tab["global_instances"]) if gl_ == a + kw]
            if is_local or is_rel_scoped:
                if sc or gl:
                    raise Refused(f"{name}:{a + kw}: a local or scoped instance needs no table entry")
            elif bool(sc) == bool(gl):
                raise Refused(f"{name}:{a + kw}: the instance {o} must be in exactly one of scoped and "
                              "global_instances")
            if sc:
                text[kw] = re.sub(r"\binstance\b", "scoped instance", text[kw], count=1)
                used["scoped"].update(sc)
            used["glob"].update(gl)
        out = [map_line(a + j, t) for j, t in enumerate(text)]
        if kind in ("structure", "class"):
            # a field with no docstring gets its source address as one (this library's `linter.missingDocs` reads
            # public fields); nothing else of the declaration is touched
            started, res = False, []
            for j, t in enumerate(out):
                if j > kw and not started and re.search(r"\bwhere\s*$", out[j - 1]):
                    started = True
                if started and re.match(r"^  [A-Za-z_][A-Za-z0-9_']* :", t) and not (res and res[-1].strip().endswith("-/")):
                    res.append(f"  /-- `[OAIMath2026]` `{name}:{a + j}`. -/")
                res.append(t)
            out = res
        addr = f"`[OAIMath2026]` `{name}:{a + kw}`."
        if out[0].startswith("/--"):
            out[0] = f"/-- {addr} " + out[0][3:].lstrip()
        else:
            out.insert(0, f"/-- {addr} -/")
        h = here_name(o) if not o.startswith("_private.") else None
        if h is not None:
            if h in names_here:
                raise Refused(f"two release declarations get one name here: {names_here[h]} and {o} -> {h}")
            names_here[h] = o
        copied.append((a, b, o, kind))
        return out

    body = []
    emit(tree, body)
    missing = want - {(a, b, o) for a, b, o, _ in copied}
    if missing:
        raise Refused(f"{name}: cone declarations not placed: {sorted(x[2] for x in missing)}")
    for key, u in (("patches", "patches"), ("scoped", "scoped"), ("global_instances", "glob"),
                   ("drop_open", "drop_open"), ("adaptations", "adapt"), ("drop_omit", "drop_omit")):
        if len(used[u]) != len(tab[key]):
            raise Refused(f"{mod}: {key} entries not used: {sorted(set(range(len(tab[key]))) - used[u])}")
    return dict(name=name, path=path, body=body, copied=copied, left=left, examples=examples, rooted=rooted,
                adapted=adapted,
                tab=tab, total=len(decls), nlines=len(lines) - (1 if lines[-1] == "" else 0))


def mathlib_imports(m, tab):
    got = set()
    for ln in IMPORTS.read_text().splitlines():
        f = ln.split("\t")
        if len(f) == 3 and f[0] == "IMPORT" and f[1] == m:
            if f[2].startswith("OAI."):
                raise Refused(f"the import dump lists a release module: {f[2]}")
            got.add(f[2])
    for mm, _ in tab["drop_imports"]:
        if mm not in got:
            raise Refused(f"drop_imports names {mm}, which the dump does not list for {m}")
        got.discard(mm)
    got |= {mm for mm, _ in tab["more_imports"]}
    return sorted(got)


def imports_of(mod, p):
    """Ported and upstream modules first (transitively reduced over the release's own dependency order), then Mathlib."""
    m, _ = REL_OF_MOD[mod]
    deps = set()
    for d in p[mod]["deps"]:
        deps.add(MOD_OF_REL.get(d, d))
    order = {MOD_OF_REL[x]: i for i, (x, _) in enumerate(FILES)}
    closure = {}

    def clos(x):
        if x in closure:
            return closure[x]
        if x in UPSTREAM_IMPORTS:
            c = set(UPSTREAM_IMPORTS[x])
            for y in UPSTREAM_IMPORTS[x]:
                c |= clos(y)
        else:
            c = set()
            full = plan_deps_cache.get(x)
            for y in (full or []):
                yy = MOD_OF_REL.get(y, y)
                c.add(yy)
                c |= clos(yy)
        closure[x] = c
        return c
    keep = [x for x in deps if not any(x in clos(y) for y in deps if y != x)]
    keep.sort(key=lambda x: (order.get(x, -1), x))
    return keep, mathlib_imports(m, p[mod]["tab"])


plan_deps_cache = {}


def plan_closure(mod):
    """Every module `mod` imports, transitively (ported names, upstream names)."""
    out, st = set(), [mod]
    while st:
        x = st.pop()
        nxt = UPSTREAM_IMPORTS.get(x) if x in UPSTREAM_IMPORTS else \
            {MOD_OF_REL.get(y, y) for y in plan_deps_cache.get(x, [])}
        for y in nxt:
            if y not in out:
                out.add(y)
                st.append(y)
    return out


def render(mod, p):
    q = p[mod]
    ported, ml = imports_of(mod, p)
    o = [f"import {PFX}{x}" for x in ported] + [f"import {x}" for x in ml]
    n = sum(b - a + 1 for a, b, *_ in q["copied"])
    o += ["", "/-!", f"# `[OAIMath2026]` `{q['path']}`, ported: the part the transfer's proof uses (FS-131, job FS131-KO1)",
          "",
          "**GENERATED by `tools/fs131_ko1_port.py` from `[OAIMath2026]` family 158 (github.com/openai/math at commit",
          f"`{COMMIT}`), `lean/OAI/{q['path']}`: do not edit by hand; rerun the script.**",
          "",
          "**Licence and notice of change.** The source is licensed under the Apache License, Version 2.0 (`LICENSE` at the",
          "root of the release; http://www.apache.org/licenses/LICENSE-2.0); a byte-identical copy of that licence text is",
          f"beside this file, `Outside/{LICENCE_NAME}` (the script's `--check` compares the two). **This file is a changed",
          "copy of part of one file of the release.** The changes, all of them:",
          "",
          f"1. *A selection*: {len(q['copied'])} of its {q['total']} declarations ({n} of its {q['nlines']} lines) — those the",
          "   transfer `proper_to_borel_weak` uses, as the release's own compiled constants give them",
          "   (`data/fs131/ko1/cone/ConeDump.out`). Source lines copied:"]
    for chunk in wrap(", ".join(f"{a}–{b}" if b > a else f"{a}" for a, b, *_ in q["copied"]), 110):
        o.append("   " + chunk)
    if q["examples"]:
        o.append("   Left out, declaring nothing: the `example`s at lines "
                 + ", ".join(f"{a}" for a, _ in q["examples"]) + ".")
    o += ["2. *The namespaces*: `OAI.EuclideanFiveColor` and `OAI.PlaneFiveColor` there are one namespace here,",
          f"   `{OUR_NS}`; the token is rewritten on {len(set(q['rooted']))} source lines (scope lines, `open` lines and the",
          "   declarations' own text, where a fully qualified name names the same constant); no two ported declarations",
          "   share a name (the script refuses)."]
    o += ["3. *Docstrings*: every declaration's docstring opens with its source line at the commit; where the release",
          "   has a docstring it follows the address, and where it has none the address is the docstring."]
    k = 4
    t = q["tab"]
    for sl, why in t["scoped"]:
        o.extend(["   " + c if i else f"{k}. " + c for i, c in enumerate(wrap_words(
            f"*An instance scoped*: the keyword `scoped`, and nothing else, at `{q['name']}:{sl}` — {why}.", 112))])
        k += 1
    for gl, why in t["global_instances"]:
        o.extend(["   " + c if i else f"{k}. " + c for i, c in enumerate(wrap_words(
            f"*An instance left global, as in the release*: `{q['name']}:{gl}` — {why}.", 112))])
        k += 1
    if t["patches"]:
        o.append(f"{k}. *Patches* ({len(t['patches'])}), each to a proof and none to a statement or a definition — "
                 "Mathlib at this pin (v4.32.0)")
        o.append("   against the release's (v4.34.1):")
        for pl, old, new, why in t["patches"]:
            for c in wrap_words(f"- `{q['name']}:{pl}`: `{old}` → `{new}` — {why}", 112):
                o.append("   " + c)
    else:
        o.append(f"{k}. *Patches*: none. Every proof here is the release's text, unchanged.")
    k += 1
    if t["adaptations"]:
        o.append(f"{k}. *Adaptations* ({len(t['adaptations'])}) — ADAPTED: a token of a statement or a definition of the release, "
                 "rewritten to the same object at")
        o.append("   this pin because a Mathlib API changed between the pins; never in the transfer, the rigidity lemma or a")
        o.append("   declaration the density branch shares (the script refuses):")
        for al, old, new, why in t["adaptations"]:
            for c in wrap_words(f"- `{q['name']}:{al}`: `{old}` → `{new}` — {why}", 112):
                o.append("   " + c)
        k += 1
    for r_old, r_new, why in t["renames"]:
        for i, c in enumerate(wrap_words(f"*A Mathlib name at this pin*: `{r_old}` is written `{r_new}` — {why}.", 112)):
            o.append(("   " if i else f"{k}. ") + c)
        k += 1
    for ol, why in t["drop_omit"]:
        for i, c in enumerate(wrap_words(f"*An `omit … in` left out*: `{q['name']}:{ol}` — {why}.", 112)):
            o.append(("   " if i else f"{k}. ") + c)
        k += 1
    for dl, tok, why in t["drop_open"]:
        for i, c in enumerate(wrap_words(f"*An `open` token left out*: `{tok}` at `{q['name']}:{dl}` — {why}.", 112)):
            o.append(("   " if i else f"{k}. ") + c)
        k += 1
    o.append(f"{k}. *Imports*: the ported modules this selection names, and the Mathlib modules that declare what its")
    o.append("   stored terms name at the release's pin (`data/fs131/ko1/cone/ImportsDump.out`; the release imports `Mathlib`")
    o.append("   whole)" + ("" if not (t["drop_imports"] or t["more_imports"]) else ", with the table's changes:"))
    for mm, why in t["drop_imports"]:
        for c in wrap_words(f"- left out, `{mm}` — {why}.", 112):
            o.append("   " + c)
    for mm, why in t["more_imports"]:
        for c in wrap_words(f"- added, `{mm}` — {why}.", 112):
            o.append("   " + c)
    o += ["", "All of it is kernel-checked in this library: no axiom, no `sorry`; the proofs are the release's, at this",
          "pin. The statements are the release's, compared as the kernel stores them by the port's read-back.", "-/", ""]
    o.extend(q["body"])
    return "\n".join(o) + "\n"


def wrap(text, width):
    out, cur = [], ""
    for tok in text.split(", "):
        add = tok if not cur else cur + ", " + tok
        if len(add) > width and cur:
            out.append(cur + ",")
            cur = tok
        else:
            cur = add
    if cur:
        out.append(cur)
    return out


def wrap_words(text, width):
    out, cur = [], ""
    for tok in text.split(" "):
        add = tok if not cur else cur + " " + tok
        if len(add) > width and cur:
            out.append(cur)
            cur = tok
        else:
            cur = add
    if cur:
        out.append(cur)
    return out


def generate(mods, clone=CLONE, cone_text=None, tables=None, sources=None):
    head = clone_commit(clone)
    if head != COMMIT:
        raise Refused(f"the clone is at {head}, not the audited commit {COMMIT}")
    full = plan(cone_text, clone, tables, sources, only=None if mods is None else set(mods))
    return {x: render(x, full) for x in full}, full


def licence_check(outdir, clone, quiet=False):
    src = pathlib.Path(clone) / LICENCE_SRC
    dst = pathlib.Path(outdir) / LICENCE_NAME
    want = src.read_bytes() if src.exists() else None
    cur = dst.read_bytes() if dst.exists() else None
    if want is None or cur != want:
        if not quiet:
            print(f"FAIL: {dst.name} " + ("is absent" if cur is None else "differs from the release's LICENSE"))
        return 1
    if not quiet:
        print(f"OK: {dst.name} is the release's LICENSE byte for byte, sha256 {hashlib.sha256(want).hexdigest()[:16]}")
    return 0


def check(mods, outdir=OUTDIR, quiet=False, **kw):
    try:
        texts, _ = generate(mods, **kw)
    except Refused as e:
        if not quiet:
            print(f"FAIL: {e}")
        return 1
    bad = 0
    for x, t in texts.items():
        path = pathlib.Path(outdir) / f"{x}.lean"
        cur = path.read_text() if path.exists() else None
        if cur != t:
            bad += 1
            if not quiet:
                print(f"FAIL: {path.name} " + ("is absent" if cur is None else "differs from the generated text"))
        elif not quiet:
            print(f"OK: {path.name} is the generated text, {t.count(chr(10))} lines, "
                  f"sha256 {hashlib.sha256(t.encode()).hexdigest()[:16]}")
    bad += licence_check(outdir, kw.get("clone", CLONE), quiet)
    return 1 if bad else 0


def self_test(mods):
    import shutil
    import tempfile
    ok, n = True, 0
    if check(mods, quiet=True) != 0:
        print("SELF-TEST FAILED: the unplanted check does not pass")
        return 1
    print("unplanted: PASS (as it must)")
    texts, full = generate(mods)
    cone_text = CONE.read_text()
    m0 = mods[0]
    rel0, path0 = REL_OF_MOD[m0]
    src0 = (CLONE / SRCROOT / path0).read_text().split("\n")
    q0 = full[m0]

    def expect(label, rc):
        nonlocal ok, n
        n += 1
        print(f"plant '{label}': {'REFUSED' if rc else 'SILENT'}")
        ok = ok and rc != 0

    def refused(**kw):
        try:
            generate(mods, **kw)
            return 0
        except Refused:
            return 1

    with tempfile.TemporaryDirectory() as td:
        td = pathlib.Path(td)
        for x, t in texts.items():
            (td / f"{x}.lean").write_text(t)
        (td / LICENCE_NAME).write_bytes((CLONE / LICENCE_SRC).read_bytes())
        if check(mods, outdir=td, quiet=True) != 0:
            print("SELF-TEST FAILED: the scratch copy does not pass unplanted")
            return 1
        v = td / f"{m0}.lean"
        t0 = texts[m0]
        i = t0.index(":= by", len(t0) // 2)
        v.write_text(t0[:i] + ":= by  " + t0[i + 5:])
        expect("a generated file changed by two spaces", check(mods, outdir=td, quiet=True))
        v.unlink()
        expect("a generated file absent", check(mods, outdir=td, quiet=True))
        v.write_text(t0)
        # a needed declaration dropped from the cone: every CONE line of one copied theorem removed
        a, b, o, kind = next(c for c in q0["copied"] if c[3] in PROOFKINDS and c[1] > c[0] + 1)
        # whole files: the selection is every declaration, so removing a cone line changes nothing (the partner below
        # shows it); a declaration's DECL line removed must be refused (its lines become unclassified, or the cone
        # names a range no declaration has)
        kept = [ln for ln in cone_text.splitlines()
                if not (ln.startswith("DECL") and ln.split("\t")[4] == o)]
        assert len(kept) < len(cone_text.splitlines()), "the plant removed nothing"
        expect(f"the DECL line of {short(o)} removed", check(mods, outdir=td, cone_text="\n".join(kept), quiet=True))
        kept2 = [ln for ln in cone_text.splitlines() if not (ln.startswith("CONE") and ln.split("\t")[4] == o)]
        rc2 = check(mods, outdir=td, cone_text="\n".join(kept2), quiet=True)
        print(f"partner 'the CONE lines of {short(o)} removed' (whole files copy it anyway): "
              f"{'AGREES' if rc2 == 0 else 'REFUSED'}")
        ok = ok and rc2 == 0
        # a declaration added that the cone does not hold
        if q0["left"]:
            la, lb, lo = q0["left"][0]
            extra = "\t".join(["CONE", rel0, str(la), str(lb), lo, "theorem", lo, "1"])
            expect("a CONE line added for a left-out declaration",
                   check(mods, outdir=td, cone_text=cone_text + "\n" + extra + "\n", quiet=True))
        # the cone leaving the planned files
        far = "\t".join(["CONE", "OAI.Geometry.PlaneColoring.Five", "1", "2", "OAI.EuclideanFiveColor.x", "theorem",
                         "OAI.EuclideanFiveColor.x", "1"])
        expect("a CONE line in a file outside the plan", refused(cone_text=cone_text + "\n" + far + "\n"))
        # a no-range constant that is not a generated auxiliary
        expect("a NORANGE constant that is no auxiliary",
               refused(cone_text=cone_text + "\nNORANGE\tOAI.EuclideanFiveColor.someLemma\n"))
        # patches: not applying; into a statement; into a definition; the partner into a proof
        tab = json.loads(json.dumps(q0["tab"]))
        tabs = {m0: dict(tab, patches=tab["patches"] + [[b, "@@no such text@@", "x", "planted"]])}
        expect("a patch that does not apply", refused(tables=tabs))
        first_word = src0[a - 1].split()[-1] if not KEYWORD.match(src0[a - 1]) else src0[a - 1].split()[1]
        kwline = next(no for no in range(a, b + 1) if KEYWORD.match(src0[no - 1]))
        tok = src0[kwline - 1].split()[1] if src0[kwline - 1].split()[0] in PROOFKINDS else src0[kwline - 1].split()[2]
        tabs = {m0: dict(tab, patches=tab["patches"] + [[kwline, tok, tok + "'", "planted"]])}
        expect("a patch into a statement", refused(tables=tabs))
        dd = next((c for c in q0["copied"] if c[3] == "def"), None)
        if dd is not None:
            dtok = src0[dd[1] - 1].split()[-1]
            tabs = {m0: dict(tab, patches=tab["patches"] + [[dd[1], dtok, dtok + " ", "planted"]])}
            expect("a patch into a definition", refused(tables=tabs))
        last_tok = src0[b - 1].split()[-1]
        planted = {m0: dict(tab, patches=tab["patches"] + [[b, last_tok, last_tok + " ", "planted"]])}
        gen_ok = not refused(tables=planted)
        rc = check(mods, outdir=td, tables=planted, quiet=True)
        print(f"partner 'a patch into a proof': generation {'ACCEPTED' if gen_ok else 'REFUSED'}, file then "
              f"{'DIFFERS' if rc else 'AGREES'}")
        ok = ok and gen_ok and rc != 0
        # an adaptation on a declaration the density branch shares (`Spectral.kCoeff`, Basic.lean:224) is refused, and
        # one that does not apply is refused
        if "OAI158Basic" in mods:
            tb = full["OAI158Basic"]["tab"]
            expect("an adaptation in a shared declaration (`Spectral.kCoeff`)",
                   refused(tables={"OAI158Basic": dict(tb, adaptations=[[224, "u.val", "u.1", "planted"]])}))
            expect("an adaptation that does not apply",
                   refused(tables={"OAI158Basic": dict(tb, adaptations=[[17, "@@none@@", "x", "planted"]])}))
        # instances: a table entry withdrawn
        for x in mods:
            tx = full[x]["tab"]
            if tx["scoped"]:
                expect(f"{x}: a scoped entry withdrawn (an instance in neither table)",
                       refused(tables={x: dict(tx, scoped=tx["scoped"][1:])}))
                break
        for x in mods:
            tx = full[x]["tab"]
            if tx["global_instances"]:
                expect(f"{x}: a global_instances entry withdrawn",
                       refused(tables={x: dict(tx, global_instances=tx["global_instances"][1:])}))
                break
        # the scan: a `set_option` planted inside a copied proof
        s2 = list(src0)
        s2[b - 1] = s2[b - 1] + "  -- x"
        s2[b - 2] = "  set_option maxHeartbeats 0 in" if not s2[b - 2].strip() else s2[b - 2] + " -- set_option"
        expect("the scan: `set_option` in a copied proof", refused(sources={rel0: s2}))
        s3 = list(src0)
        s3[a - 1] = s3[a - 1] + " -- IO.println"
        expect("the scan: `IO.` in a copied line", refused(sources={rel0: s3}))
        # an unclassified line at column 0 between declarations
        s4 = list(src0)
        j = next(no for no in range(len(s4)) if s4[no] == "" and no > 10)
        s4[j] = "#eval 1"
        expect("an unclassified `#eval` line", refused(sources={rel0: s4}))
        # an indented declaration (one space before its keyword, as `RelativeCenters.lean:40`) is copied as such
        # (FS131-IPA1's revision, the coordinator's Amendment 2: `KEYWORD` allows leading whitespace)
        s5 = list(src0)
        s5[kwline - 1] = " " + s5[kwline - 1]
        try:
            t5, _ = generate(mods, sources={rel0: s5})
            ind_ok = (" " + src0[kwline - 1]) in t5[m0].split("\n") and t5[m0] != texts[m0]
        except Refused:
            ind_ok = False
        print(f"partner 'an indented declaration ({short(o)}) copied as such': {'COPIED' if ind_ok else 'REFUSED'}")
        ok = ok and ind_ok
        # drop_omit (Amendment 4): an entry on a line that is no `omit … in` is refused; a used entry removes exactly
        # that line (the partner, on `OAI158Centers`, whose release file has such lines)
        expect("a drop_omit entry on a line that is no `omit`",
               refused(tables={m0: dict(tab, drop_omit=[[a, "planted"]])}))
        tc = load_tables("OAI158Centers")
        base_c, _ = generate(["OAI158Centers"], tables={"OAI158Centers": dict(tc, drop_omit=[])})
        src_c = (CLONE / SRCROOT / REL_OF_MOD["OAI158Centers"][1]).read_text().split("\n")
        ol = next(i + 1 for i, x in enumerate(src_c) if re.match(r"^omit\s.*\sin$", x))
        try:
            dropped, _ = generate(["OAI158Centers"], tables={"OAI158Centers": dict(tc, drop_omit=[[ol, "planted"]])})
            bl = base_c["OAI158Centers"].split("\n")
            dl = dropped["OAI158Centers"].split("\n")
            body_b = bl[bl.index("-/") + 1:]
            body_d = dl[dl.index("-/") + 1:]
            om_ok = len(body_b) == len(body_d) + 1 and \
                any(body_b[:i] + body_b[i + 1:] == body_d and body_b[i] == src_c[ol - 1] for i in range(len(body_b)))
        except Refused:
            om_ok = False
        print(f"partner 'a drop_omit entry (Centers.lean:{ol}) removes exactly that line': {'REMOVED' if om_ok else 'FAILED'}")
        ok = ok and om_ok
        # drop_omit's other refusal (FS131-IPB1, the coordinator's item 769 ruling 3): an entry on an `… in` line that
        # is attached to a copied declaration and is no `omit` (that `omit` line made an `include e in` in a copy of
        # the source) must be refused by that branch — read from its message, so that a refusal for another reason
        # (an unused entry, an unclassified line) does not count
        src_i = list(src_c)
        src_i[ol - 1] = "include e in"
        try:
            generate(["OAI158Centers"], tables={"OAI158Centers": dict(tc, drop_omit=tc["drop_omit"] + [[ol, "planted"]])},
                     sources={REL_OF_MOD["OAI158Centers"][0]: src_i})
            why_i = None
        except Refused as e:
            why_i = str(e)
        n += 1
        hit_i = why_i is not None and "is not a one-line `omit … in`" in why_i
        print(f"plant 'a drop_omit entry on an `include … in` line (Centers.lean:{ol} in a copy)': "
              f"{'REFUSED' if hit_i else 'SILENT' if why_i is None else 'REFUSED FOR ANOTHER REASON: ' + why_i}")
        ok = ok and hit_i
        # an upstream copy that is not upstream
        expect("an upstream entry removed", refused_upstream())
        # licence
        lic = td / LICENCE_NAME
        bts = lic.read_bytes()
        lic.write_bytes(bts[:100] + bytes([bts[100] ^ 1]) + bts[101:])
        expect("the licence copy changed by one byte", check(mods, outdir=td, quiet=True))
        lic.unlink()
        expect("the licence copy absent", check(mods, outdir=td, quiet=True))
        lic.write_bytes(bts)
        clone2 = td / "clone"
        subprocess.run(["git", "init", "-q", str(clone2)], check=True)
        subprocess.run(["git", "-C", str(clone2), "-c", "user.name=x", "-c", "user.email=x@x", "commit", "-q",
                        "--allow-empty", "-m", "x"], check=True)
        expect("the clone at another commit", check(mods, outdir=td, clone=clone2, quiet=True))
        shutil.rmtree(clone2)
        if check(mods, outdir=td, quiet=True) != 0:
            print("SELF-TEST FAILED: the scratch copy does not pass after the plants were undone")
            return 1
    print(f"SELF-TEST OK: {n} plants refused and 4 partners accepted" if ok else "SELF-TEST FAILED")
    return 0 if ok else 1


def refused_upstream():
    saved = dict(UPSTREAM)
    UPSTREAM.pop("OAI.EuclideanFiveColor.direction")
    try:
        generate(None)
        return 0
    except Refused:
        return 1
    finally:
        UPSTREAM.clear()
        UPSTREAM.update(saved)


def arg_mods():
    if "--modules" in sys.argv:
        ms = sys.argv[sys.argv.index("--modules") + 1].split(",")
        for x in ms:
            if x not in REL_OF_MOD:
                raise SystemExit(f"unknown module {x}")
        return ms
    return None


def main():
    mods = arg_mods()
    if "--self-test" in sys.argv:
        return self_test(mods or ["OAI158Basic"])
    if "--parse-all" in sys.argv:
        try:
            plan(only=set(), parse_all=True)
        except Refused as e:
            print(f"FAIL: {e}")
            return 1
        print("PARSE OK: every file of the plan reads as scopes, declarations and scaffolding")
        return 0
    if "--check" in sys.argv:
        if mods is None:
            raise SystemExit("--check needs --modules")
        rc = check(mods)
        print("CHECK " + ("OK" if rc == 0 else "FAILED"))
        return rc
    try:
        texts, full = generate(mods)
    except Refused as e:
        print(f"FAIL: {e}")
        return 1
    sel = mods or [ours(m) for m, _ in FILES]
    if "--list" in sys.argv:
        for x in sel:
            q = full[x]
            nl = sum(b - a + 1 for a, b, *_ in q["copied"])
            print(f"{x} ({q['name']}): {q['total']} declarations — copied {len(q['copied'])} ({nl} lines), left out "
                  f"{len(q['left'])}, examples {len(q['examples'])}, root tokens on {len(set(q['rooted']))} lines")
            for a, b, o, kind in q["copied"]:
                print(f"    {a}–{b}\t{kind}\t{o}")
        return 0
    if "--names" in sys.argv:
        for x in sel:
            for a, b, o, kind in full[x]["copied"]:
                print(f"{x}\t{kind}\t{here_name(o) if not o.startswith('_private.') else '(private) ' + o}\t{o}")
        return 0
    if "--imports" in sys.argv:
        for x in sel:
            ported, ml = imports_of(x, full)
            print(f"{x}\t" + " ".join(ported) + " | " + " ".join(ml))
        return 0
    if "--axioms-block" in sys.argv:
        for x in sel:
            print(f"-- Outside/{x}")
            for a, b, o, kind in full[x]["copied"]:
                if kind == "instance" or o.startswith("_private."):
                    continue
                print(f"#print axioms {here_name(o)}")
        return 0
    if mods is None:
        print("writing needs --modules (a lane writes its own modules)")
        return 1
    for x in mods:
        path = OUTDIR / f"{x}.lean"
        path.write_text(texts[x])
        print(f"wrote {x}.lean ({texts[x].count(chr(10))} lines, sha256 "
              f"{hashlib.sha256(texts[x].encode()).hexdigest()[:16]})")
    return licence_check(OUTDIR, CLONE)


if __name__ == "__main__":
    sys.exit(main())
