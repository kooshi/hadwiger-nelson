#!/usr/bin/env python3
"""FS133-IA1: the port of the release's generic lemmas that FS-133's field theorem stands on — the generator and its
check.

Generates ONE module, `Proofs/HadwigerNelson/Outside/OAI158Transfer.lean`, from three files of the clone of
`[OAIMath2026]` (github.com/openai/math) at the audited commit: `Analysis/PlaneSpectrum/Basic.lean`,
`Analysis/PlaneSpectrum/Representations.lean` and `Geometry/PlaneColoring/BorelTransfer.lean`, in that order (each
imports the one before it there).  Nothing is retyped: every declaration is copied by line range, and which
declarations are copied is not chosen here — it is read from `data/fs133/ia1/cone/ConeDump.out`, the cone of the
twenty-five target declarations (`plans/FS133-kernel-plan.md` § 5.1, leaf P) as the release's own compiled constants
give it (`ConeDump.lean`, run at the release's pin; a `DECL` line per source declaration of the release, a `CONE` line
per constant the targets' stored types and proofs name, transitively).

The pattern is FS132-I2's generator (`tools/fs132_i2_port.py`), which is another job's and is not edited; what differs
here is said where it differs (one module from three files; three release namespaces; declarations already upstream in
`Outside/OAI158Rigidity`; a generated auxiliary of a declaration that is not ported).

What this script changes in the copied text, and nothing else:
  1. the namespaces: `OAI.EuclideanFiveColor[.X]` and `OAI.PlaneFiveColor[.X]` -> `HadwigerNelson.Outside.OAI158[.X]`
     (on the `namespace`, `end` and `open` lines of a section; a declaration whose own text names one of the release's
     root namespaces is refused, so nothing is re-resolved in silence);
  2. a source address in every declaration's docstring (`File.lean:line` at the commit): a docstring is added where
     the release has none (this library's `linter.missingDocs`), and prefixed where it has one;
  3. declarations outside the cone are left out, and a section left with no declaration is left out whole;
  4. UPSTREAM: the six definitions FS133-K1 copied into `Outside/OAI158Rigidity` (with the derived instance) are not
     repeated: a `--` comment stands where each was, and this module imports that one;
  5. SCOPED: an instance the release declares on a type that is Mathlib's is `scoped` here (`LEAN.md` § Assumptions);
  6. the PATCHES below — each a line of a PROOF that does not elaborate at this library's pin (Lean v4.32.0, Mathlib
     v4.32.0; the release is at v4.34.1), with its reason.  The script refuses a patch that touches a definition, or a
     theorem's statement (anything before the declaration's top-level `:=`);
  7. RENAMES — a Mathlib constant renamed between the pins, applied to the token wherever it stands; refused inside a
     definition.
AUX_UNPORTED lists cone constants that are generated auxiliaries (`X._proof_n`) of a declaration that is NOT ported:
the release's elaborator shares such a proof between declarations of one file, and at this pin the elaborator makes
its own.  EXTRA lists declarations brought in although no stored term of the cone names them, each with its reason.
A command of a copied section that declares nothing (an `example`) is left out and listed.

The release's licence text travels with every ported module: `Outside/OAIMath2026-LICENSE.txt` (written by FS-132's
generator) must be the clone's `LICENSE` byte for byte; `--check` compares, and the default run writes it only if it is
absent.

Usage:
  tools/fs133_ia1_port.py                 write the module
  tools/fs133_ia1_port.py --check         regenerate in memory, compare with the file and the licence copy; exit 1 on
                                          any difference
  tools/fs133_ia1_port.py --self-test     plant faults and require each refused, and the unplanted check to pass
  tools/fs133_ia1_port.py --list          print the cone per file and per section: copied / upstream / left out
  tools/fs133_ia1_port.py --axioms-block  print the audit's records for the module (a draft for the landing)
"""
import hashlib
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
CLONE = pathlib.Path("/home/kooshi/source/math")
COMMIT = "adc7f1241b42e322a6451854ab7e4b4c146bf78a"
SRCROOT = "lean/OAI"
CONE = ROOT / "data/fs133/ia1/cone/ConeDump.out"
IMPORTS = ROOT / "data/fs133/ia1/cone/ImportsDump.out"
OUTDIR = ROOT / "Proofs/HadwigerNelson/Outside"
MODULE = "OAI158Transfer"
UPSTREAM_MODULE = "OAI158Rigidity"
PFX = "Proofs.HadwigerNelson.Outside."
OUR_NS = "HadwigerNelson.Outside.OAI158"
REL_ROOTS = ("EuclideanFiveColor", "PlaneFiveColor")          # inside the release's `namespace OAI`
ROOT_TOKEN = re.compile(r"(?<![A-Za-z0-9_.'])(?:OAI\.)?(EuclideanFiveColor|PlaneFiveColor)(?![A-Za-z0-9_'])")

# (release module, path under lean/OAI, what of it is here) in dependency order.
FILES = [
    ("OAI.Analysis.PlaneSpectrum.Basic", "Analysis/PlaneSpectrum/Basic.lean",
     "the algebraic plane is countable, the imaginary unit as a point of it, a rotation's coefficient is not zero"),
    ("OAI.Analysis.PlaneSpectrum.Representations", "Analysis/PlaneSpectrum/Representations.lean",
     "the Koopman unitary of a measure-preserving equivalence on `L²`; the continuous vectors of a unitary "
     "representation (a closed invariant subspace, with continuous orbit maps); the projection on a closed subspace "
     "commutes with a contraction that keeps it; the projection on the continuous vectors keeps `[0, 1]`-valued "
     "functions and vectors fixed by a covariant unitary, and keeps a correlation whose orthogonal part vanishes"),
    ("OAI.Geometry.PlaneColoring.BorelTransfer", "Geometry/PlaneColoring/BorelTransfer.lean",
     "the algebraic plane is dense in `ℂ`; the orbit map of a continuous vector extends continuously to `ℂ`, with "
     "its inner products; a closed property of unit complex numbers that holds at the algebraic ones holds at all; a "
     "continuous map into `L²` has a jointly measurable version; non-negative orthogonal functions have almost "
     "surely zero product"),
]

# release constant -> the keyword and the last name component under which `Outside/OAI158Rigidity` declares it
# (FS133-K1 copied these; `tools/fs132_i1_readback.py`'s comparison of them is in `plans/FS133-kernel-plan.md` § 2.4).
UPSTREAM = {
    "OAI.PlaneFiveColor.Spectral.E": ("abbrev", "E"),
    "OAI.PlaneFiveColor.Spectral.K": ("def", "K"),
    "OAI.PlaneFiveColor.Spectral.DiscreteE": ("def", "DiscreteE"),
    "OAI.PlaneFiveColor.Spectral.kCoeff": ("def", "kCoeff"),
    "OAI.EuclideanFiveColor.ContinuousVectors.op": ("def", "op"),
    "OAI.EuclideanFiveColor.ContinuousVectors.space": ("def", "space"),
}
# an instance made by a `deriving` clause: its source range lies inside its definition's (release constant -> owner)
DERIVED = {"OAI.PlaneFiveColor.Spectral.instCommGroupDiscreteE": "OAI.PlaneFiveColor.Spectral.DiscreteE"}

# cone constant -> reason.  A generated auxiliary of a declaration that is not ported.
AUX_UNPORTED = {
    "OAI.PlaneFiveColor.LabelModel.projected._proof_1":
        "Mathlib's instance `SeminormedAddCommGroup.toIsTopologicalAddGroup ℂ : IsTopologicalAddGroup ℂ` — a proof — "
        "abstracted by the release's elaborator at the first definition of `BorelTransfer.lean` that needs it "
        "(`LabelModel.projected`, line 46, of the label model: not ported) and shared with `approxIndex`, "
        "`approxField`, `measurableField` and `index_measurable` further down the file; at this pin the elaborator "
        "abstracts its own (`data/fs133/ia1/cone/AuxProbe.out` is its stored statement and value at the release's pin)",
}

# (file, line, old substring, new substring, reason) — an instance on a type that is Mathlib's, scoped.
SCOPED = [
    ("Basic.lean", 53, "instance E_countable : Countable E", "scoped instance E_countable : Countable E",
     "`E` is an abbreviation of Mathlib's `algebraicClosure ℚ ℂ`: an unscoped `Countable` instance on it would be "
     "this library's speech into every instance search on a Mathlib type. Scoped to "
     "`HadwigerNelson.Outside.OAI158.Spectral`: found inside that namespace and under `open` of it"),
]

# (file, line, reason) — an instance the release declares that stays global here, as there.  Every copied instance is
# in SCOPED or here: the script refuses one that is in neither.
GLOBAL_INSTANCES = [
    ("Representations.lean", 209,
     "`CompleteSpace (space U)`: on the subtype of the release's own `ContinuousVectors.space U`, a definition copied "
     "into this library, not on a type that is Mathlib's; instance search reaches it only at that submodule"),
]

# (file, Mathlib module, reason) — imports the stored terms do not show (a tactic, a notation, an instance found by
# search), found against the build at this pin.
MORE_IMPORTS = [
]
# (Mathlib module, reason) — a module of the dump that is not imported here.
DROP_IMPORTS = [
    ("Mathlib.Algebra.Order.Ring.Star",
     "not needed to elaborate at this pin, and no stored term of the module moves with it "
     "(`data/fs133/ia1/imports/hashes-B-dump.txt` is `hashes-B-min.txt`: the hash of every stored type and value "
     "of the module with the dump's whole list and with this one); every import here enters the closure of the "
     "modules downstream of `Plane/OneClass/Field`, so none is taken that is not needed"),
    ("Mathlib.RingTheory.Flat.FaithfullyFlat.Basic", "the same: not needed, and no stored term moves with it"),
    ("Mathlib.RingTheory.Flat.TorsionFree", "the same: not needed, and no stored term moves with it"),
    ("Mathlib.RingTheory.SimpleRing.Principal", "the same: not needed, and no stored term moves with it"),
]

# (file, line, old substring, new substring, reason) — Mathlib differences between v4.34.1 (theirs) and v4.32.0 (ours).
# A patch is a change to a PROOF; the script refuses one that touches a statement or a definition.
PATCHES = [
    ("Representations.lean", 323, "Complex.isometry_ofReal.lipschitzWith.comp", "Complex.isometry_ofReal.lipschitz.comp",
     "Mathlib renamed `Isometry.lipschitz` to `Isometry.lipschitzWith` on 2026-08-16 "
     "(`Mathlib/Topology/MetricSpace/Isometry.lean:77`; at v4.34.1 the old name is its deprecated alias); at v4.32.0 "
     "the lemma has only the old name, the same statement"),
    ("BorelTransfer.lean", 113, "isAlgebraic_ratCast", "isAlgebraic_rat",
     "Mathlib renamed `isAlgebraic_rat` to `isAlgebraic_ratCast` on 2026-07-14 "
     "(`Mathlib/RingTheory/Algebraic/Basic.lean:153`; at v4.34.1 the old name is its deprecated alias); at v4.32.0 the "
     "lemma has only the old name, the same statement"),
    ("BorelTransfer.lean", 114, "isAlgebraic_ratCast", "isAlgebraic_rat", "the same rename of Mathlib's"),
    ("BorelTransfer.lean", 186, "by simp [Circle.norm_coe]", "by simp",
     "at v4.32.0 `simp` closes `(‖(u:ℂ)‖ : ℂ) ≠ 0` without the lemma, and the build's `linter.unusedSimpArgs` warns "
     "that the argument is unused; this library's modules build with no warning"),
    ("BorelTransfer.lean", 284, "(by norm_num : (1:ℝ≥0∞) ≤ 2)",
     "(by norm_num : (1:ℝ≥0∞) ≤ 2) (fun n => Lp.aestronglyMeasurable (g n))",
     "at v4.32.0 `summable_norm_of_tsum_eLpNorm_ne_top` takes the measurability of the functions as a hypothesis "
     "(`hf : ∀ n, AEStronglyMeasurable (f n) μ`, `Mathlib/MeasureTheory/Function/LpSpace/InfiniteSum.lean:30`); at "
     "v4.34.1 it derives it from the finiteness of the sum. Each `g n` is an element of `Lp`, so the hypothesis is "
     "`Lp.aestronglyMeasurable`"),
]

# (name at the release's Mathlib, name at this library's Mathlib, the evidence) — see `tools/fs132_i2_port.py`.
RENAMES = [
]

# (file, release name, a sentence) — a sentence added to a declaration's docstring after its source address.
NOTES = [
]

# (file, release name, reason) — declarations no stored term of the cone names.
EXTRA = [
]

KEYWORD = re.compile(r"^(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|scoped|local)\s+)*"
                     r"(lemma|theorem|def|abbrev|instance|structure|inductive|class)\b")
SCAFFOLD = re.compile(r"^(?:|noncomputable section|open .*|namespace \S+|end \S+|end|"
                      r"variable .*|include .*|omit .*|--.*)$")
PROOFKINDS = ("lemma", "theorem")
LICENCE_NAME = "OAIMath2026-LICENSE.txt"
LICENCE_SRC = "LICENSE"


class Refused(Exception):
    """A condition under which nothing may be generated."""


def clone_commit(clone=CLONE) -> str:
    return subprocess.run(["git", "-C", str(clone), "rev-parse", "HEAD"], check=True, capture_output=True,
                          text=True).stdout.strip()


def base(path: str) -> str:
    return path.rsplit("/", 1)[-1]


def here_name(rel: str) -> str:
    """The name here of a release constant: the release's two root namespaces are one namespace here."""
    for r in REL_ROOTS:
        p = f"OAI.{r}."
        if rel.startswith(p):
            return OUR_NS + "." + rel[len(p):]
    raise Refused(f"{rel} is in neither of the release's namespaces this script maps")


def short(rel: str) -> str:
    return here_name(rel)[len(OUR_NS) + 1:]


def load_cone(text: str, sources):
    """-> decls[module] = [(first, last, owner)] (outermost ranges), cone[module] = {owner}, aux = [name], and
    nested[module] = {(first, last, owner): outer row}.  `sources[module]` is the file's list of lines."""
    mods = {f[0] for f in FILES}
    rows, cone_rows, seen_aux = {}, [], []
    for ln in text.splitlines():
        f = ln.split("\t")
        if f[0] == "DECL" and f[1] in mods:
            rows.setdefault(f[1], set()).add((int(f[2]), int(f[3]), f[4]))
        elif f[0] == "CONE":
            if f[6] in AUX_UNPORTED:
                if f[5] != "theorem" or not re.search(r"\._proof_\d+$", f[6]):
                    raise Refused(f"{f[6]} is listed as a generated auxiliary and is a {f[5]}")
                seen_aux.append(f[6])
                continue
            if f[1] not in mods:
                raise Refused(f"the cone leaves the three planned files: {f[6]} is in {f[1]}")
            rows.setdefault(f[1], set()).add((int(f[2]), int(f[3]), f[4]))
            cone_rows.append((f[1], int(f[2]), int(f[3]), f[4], f[6]))
        elif f[0] == "NORANGE":
            raise Refused(f"a cone constant with no source declaration: {f[1]}")
    if not cone_rows:
        raise Refused("the cone file holds no CONE line")
    missing_aux = set(AUX_UNPORTED) - set(seen_aux)
    if missing_aux:
        raise Refused(f"AUX_UNPORTED entries the cone does not hold: {sorted(missing_aux)}")
    top, decls = {}, {}
    for mod, rs in rows.items():
        cur = None
        lines = sources[mod]
        for (a, b, o) in sorted(rs, key=lambda r: (r[0], -r[1], len(r[2]))):
            if cur is not None and a <= cur[1]:
                inside = b <= cur[1]
                extends = (o + ".").startswith(cur[2] + ".")
                # an instance made by a `deriving` clause: its range is the clause's line, inside its definition's
                derived = "deriving" in lines[a - 1] and o.rsplit(".", 1)[-1].startswith("inst")
                if not inside or not (extends or derived):
                    raise Refused(f"{mod}: declarations {cur[2]} ({cur[0]}–{cur[1]}) and {o} ({a}–{b}) overlap")
            else:
                cur = (a, b, o)
                decls.setdefault(mod, []).append(cur)
            top[(mod, a, b, o)] = cur
    cone = {}
    for (mod, a, b, o, name) in cone_rows:
        t = top[(mod, a, b, o)]
        if any(t[2] == AUX_UNPORTED_OWNER for AUX_UNPORTED_OWNER in aux_owners()):
            raise Refused(f"{name} belongs to {t[2]}, which is listed as not ported")
        cone.setdefault(mod, set()).add(t)
    for mod in decls:
        decls[mod].sort()
    return decls, cone, seen_aux


def aux_owners():
    return {re.sub(r"\._proof_\d+$", "", n) for n in AUX_UNPORTED}


def statement_end(lines, first, last):
    """The (line, column) of the declaration's top-level `:=`: everything before it is the signature.  Brackets are
    counted from the declaration keyword on."""
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


def map_scaffold(s: str) -> str:
    return ROOT_TOKEN.sub(OUR_NS, s)


def read_sources(clone=CLONE):
    return {mod: (pathlib.Path(clone) / SRCROOT / path).read_text().split("\n") for mod, path, _ in FILES}


def upstream_check(text: str):
    """Each UPSTREAM declaration must be declared, by its keyword, in the upstream module's text."""
    for rel, (kw, last) in UPSTREAM.items():
        if not re.search(r"^(?:noncomputable\s+)?" + kw + r"\s+" + re.escape(last) + r"\b", text, flags=re.M):
            raise Refused(f"{short(rel)} is not declared (`{kw} {last}`) in Outside/{UPSTREAM_MODULE}.lean")
    for rel, owner in DERIVED.items():
        last = UPSTREAM[owner][1]
        if not re.search(r"^def\s+" + re.escape(last) + r"\b.*\bderiving\b", text, flags=re.M):
            raise Refused(f"the derived instance {short(rel)}: no `deriving` on `{last}` in Outside/{UPSTREAM_MODULE}.lean")


def plan(cone_text: str, patches=None, extra=None, renames=None, scoped=None, upstream_text=None, clone=CLONE,
         global_instances=None):
    """-> per release module: the blocks to emit, and the bookkeeping the header prints."""
    patches = PATCHES if patches is None else patches
    extra = EXTRA if extra is None else extra
    renames = RENAMES if renames is None else renames
    scoped = SCOPED if scoped is None else scoped
    global_instances = GLOBAL_INSTANCES if global_instances is None else global_instances
    used_global = set()
    sources = read_sources(clone)
    decls, cone, aux = load_cone(cone_text, sources)
    upstream_check((OUTDIR / f"{UPSTREAM_MODULE}.lean").read_text() if upstream_text is None else upstream_text)
    out, noted = {}, set()
    used_patches, used_extra, used_scoped = set(), set(), set()
    names_here = {}
    for mod, path, _ in FILES:
        name = base(path)
        lines = sources[mod]
        want = {o for (_, _, o) in cone.get(mod, ())}
        for i, (ef, en, _) in enumerate(extra):
            if ef == name:
                if en not in {o for (_, _, o) in decls.get(mod, [])}:
                    raise Refused(f"EXTRA {en} is not a declaration of {name}")
                if en in want:
                    raise Refused(f"EXTRA {en} is already in the cone")
                want.add(en)
                used_extra.add(i)
        owner_at = {}
        for (a, b, o) in decls.get(mod, []):
            for no in range(a, b + 1):
                owner_at[no] = (a, b, o)
        # the sections: `noncomputable section` … `end`
        blocks, cur, examples = [], None, []
        for no, s in enumerate(lines, 1):
            if no in owner_at:
                if cur is None:
                    raise Refused(f"{name}:{no}: a declaration outside every section")
                continue
            if s == "noncomputable section":
                if cur is not None:
                    raise Refused(f"{name}:{no}: a section opened inside a section")
                cur = no
            elif s == "end" and cur is not None:
                blocks.append((cur, no))
                cur = None
            elif cur is not None and not SCAFFOLD.match(s):
                if re.match(r"^example\b.*:=", s) and not lines[no].startswith((" ", "\t")):
                    examples.append(no)        # a one-line `example`: it declares nothing
                    continue
                k = no - 1
                while k >= 1 and lines[k - 1].startswith((" ", "\t")) and k not in owner_at:
                    k -= 1
                if not (s.startswith((" ", "\t")) and (no - 1) not in owner_at and lines[k - 1].startswith("variable ")):
                    raise Refused(f"{name}:{no}: a line this script does not classify: {s!r}")
            elif cur is None and not re.match(r"^(?:|import \S+|namespace OAI|end OAI)$", s):
                raise Refused(f"{name}:{no}: a line outside every section that this script does not classify: {s!r}")
        if cur is not None:
            raise Refused(f"{name}: a section is not closed")
        emitted, copied, upstream, left, renamed, dropped_examples = [], [], [], [], [], []
        for (b0, b1) in blocks:
            body, any_decl, no = [], False, b0
            pending, block_copied, block_examples = [], [], []
            while no <= b1:
                s = lines[no - 1]
                if no not in owner_at:
                    if no in examples:
                        block_examples.append(no)
                    elif re.search(r"\sin$", s) and (no + 1) in owner_at:
                        pending.append(s)
                    else:
                        if pending:
                            raise Refused(f"{name}:{no}: an `… in` line not followed by a declaration")
                        body.append(map_scaffold(s))
                    no += 1
                    continue
                a, b, o = owner_at[no]
                if no != a:
                    raise Refused(f"{name}:{no}: inside {o} but not at its first line")
                if o not in want:
                    left.append((a, b, o))
                elif o in UPSTREAM:
                    upstream.append((a, b, o))
                    body.append(f"-- `{short(o)}` ({name}:{a}" + (f"–{b}" if b > a else "") + f"): in "
                                f"`Outside/{UPSTREAM_MODULE}`, copied there by FS133-K1.")
                else:
                    text = lines[a - 1:b]
                    kw = next((i for i, t in enumerate(text) if KEYWORD.match(t)), None)
                    if kw is None:
                        raise Refused(f"{name}:{a}–{b}: no declaration keyword found in {short(o)}")
                    kind = KEYWORD.match(text[kw]).group(1)
                    for j, row in enumerate(text):
                        if ROOT_TOKEN.search(row) or re.search(r"(?<![A-Za-z0-9_.'])OAI\.", row):
                            raise Refused(f"{name}:{a + j}: {short(o)} names a root namespace of the release in its "
                                          "own text: not handled")
                    addr = f"`[OAIMath2026]` `{name}:{a + kw}`."
                    se = statement_end(lines, a, b)
                    for i, (pf, pl, old, new, _) in enumerate(patches):
                        if pf == name and a <= pl <= b:
                            if kind not in PROOFKINDS and not (kind == "instance" and se is not None):
                                raise Refused(f"patch {i} ({name}:{pl}) is inside the {kind} {short(o)}: a definition "
                                              "is never patched")
                            if kind == "instance":
                                if "by" not in lines[se[0] - 1][se[1]:].split():
                                    raise Refused(f"patch {i} ({name}:{pl}) is inside the instance {short(o)}, whose "
                                                  "value is a term: not patched")
                            if se is None:
                                raise Refused(f"patch {i} ({name}:{pl}): no top-level `:=` found in {short(o)}")
                            row = text[pl - a]
                            pos = row.find(old)
                            if pos < 0:
                                raise Refused(f"patch {i} does not apply at {name}:{pl}")
                            if (pl, pos) < se:
                                raise Refused(f"patch {i} ({name}:{pl}) touches the statement of {short(o)} (its `:=` "
                                              f"is at line {se[0]}, column {se[1]})")
                            text[pl - a] = row.replace(old, new)
                            used_patches.add(i)
                    for i, (sf, sl, old, new, _) in enumerate(scoped):
                        if sf == name and a <= sl <= b:
                            if kind != "instance" or sl != a + kw:
                                raise Refused(f"SCOPED {i} ({name}:{sl}) is not the keyword line of an instance")
                            if not text[kw].startswith(old) or new != "scoped " + old:
                                raise Refused(f"SCOPED {i} does not apply at {name}:{sl}, or is more than the keyword")
                            text[kw] = "scoped " + text[kw]
                            used_scoped.add(i)
                    if kind == "instance":
                        is_scoped = any(sf == name and sl == a + kw for (sf, sl, *_r) in scoped)
                        g = [i for i, (gf, gl, _) in enumerate(global_instances) if gf == name and gl == a + kw]
                        if is_scoped == bool(g):
                            raise Refused(f"{name}:{a + kw}: the instance {short(o)} must be in exactly one of SCOPED "
                                          "and GLOBAL_INSTANCES")
                        used_global.update(g)
                    for (r_old, r_new, _) in renames:
                        pat = re.compile(r"(?<![A-Za-z0-9_'])" + re.escape(r_old) + r"(?![A-Za-z0-9'])")
                        for j, row in enumerate(text):
                            if pat.search(row):
                                if kind not in PROOFKINDS:
                                    raise Refused(f"rename `{r_old}` occurs in the {kind} {short(o)} ({name}:{a + j}): "
                                                  "a definition is never changed")
                                text[j] = pat.sub(r_new, row)
                                renamed.append((a + j, r_old))
                    note = [t for (nf, nn, t) in NOTES if nf == name and nn == o]
                    if note:
                        noted.add((name, o))
                    if kw == 0:
                        body.extend(pending)
                        if note:
                            body.extend(wrap_words(f"/-- {addr} {note[0]} -/", 118))
                        else:
                            body.append(f"/-- {addr} -/")
                    elif note:
                        raise Refused(f"{name}: a note on {short(o)}, which has a docstring of its own: not handled")
                    elif text[0].startswith("/--"):
                        text[0] = f"/-- {addr} " + text[0][3:].lstrip()
                        body.extend(pending)
                    else:
                        raise Refused(f"{name}:{a}: {short(o)} begins with neither a keyword nor a docstring")
                    body.extend(text)
                    h = here_name(o)
                    if h in names_here:
                        raise Refused(f"two release declarations get one name here: {names_here[h]} and {o} -> {h}")
                    names_here[h] = o
                    block_copied.append((a, b, o, kind))
                    any_decl = True
                pending = []
                no = b + 1
            if pending:
                raise Refused(f"{name}:{b1}: an `… in` line at the end of a section")
            if any_decl:
                ns = next((m.group(1) for s in lines[b0 - 1:b1] for m in [re.match(r"^namespace (\S+)$", s)] if m), None)
                emitted.append((b0, b1, body, ns, block_copied))
                copied.extend(block_copied)
                dropped_examples.extend(block_examples)
        missing = want - {c[2] for c in copied} - {c[2] for c in upstream}
        if missing:
            raise Refused(f"{name}: cone declarations not placed: {sorted(missing)}")
        out[mod] = dict(name=name, emitted=emitted, copied=copied, upstream=upstream, left=left, renamed=renamed,
                        examples=dropped_examples, total=len(decls.get(mod, [])),
                        nlines=len(lines) - (1 if lines[-1] == "" else 0))
    if len(used_patches) != len(patches):
        raise Refused(f"patches not used: {sorted(set(range(len(patches))) - used_patches)}")
    if len(used_scoped) != len(scoped):
        raise Refused(f"SCOPED entries not used: {sorted(set(range(len(scoped))) - used_scoped)}")
    if len(used_global) != len(global_instances):
        raise Refused("GLOBAL_INSTANCES entries not used")
    if len(noted) != len(NOTES):
        raise Refused(f"NOTES not placed: {sorted({(a, b) for a, b, _ in NOTES} - noted)}")
    if len(used_extra) != len(extra):
        raise Refused(f"EXTRA entries not used: {sorted(set(range(len(extra))) - used_extra)}")
    up_seen = {c[2] for mod in out for c in out[mod]["upstream"]}
    if up_seen != set(UPSTREAM):
        raise Refused(f"UPSTREAM and the cone disagree: {sorted(up_seen ^ set(UPSTREAM))}")
    out["__aux__"] = aux
    return out


def full_imports():
    """The upstream module, then the Mathlib modules of the dump (less DROP_IMPORTS) and of MORE_IMPORTS, sorted."""
    got, mods = set(), {f[0] for f in FILES}
    for ln in IMPORTS.read_text().splitlines():
        f = ln.split("\t")
        if len(f) == 3 and f[0] == "IMPORT" and f[1] in mods:
            if f[2].startswith("OAI."):
                raise Refused(f"the import dump lists a release module: {f[2]}")
            got.add(f[2])
    if not got:
        raise Refused("the import dump has no line for the three files")
    for m, _ in DROP_IMPORTS:
        if m not in got:
            raise Refused(f"DROP_IMPORTS names {m}, which the dump does not list")
        got.discard(m)
    got |= {m for (_, m, _) in MORE_IMPORTS}
    return [UPSTREAM_MODULE] + sorted(got)


def ranges_text(rows):
    return ", ".join(f"{a}–{b}" if b > a else f"{a}" for a, b, *_ in rows)


def wrap_words(text: str, width: int):
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


def wrap(text: str, width: int):
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


def render(p, patches=None, extra=None, scoped=None) -> str:
    patches = PATCHES if patches is None else patches
    extra = EXTRA if extra is None else extra
    scoped = SCOPED if scoped is None else scoped
    imports = full_imports()
    o = [f"import {m if m.startswith('Mathlib') else PFX + m}" for m in imports]
    ncop = sum(len(p[mod]["copied"]) for mod, _, _ in FILES)
    o.append("")
    o.append("/-!")
    o.append("# `[OAIMath2026]`: the generic lemmas of the transfer's proof that FS-133's field theorem stands on, ported")
    o.append("(job FS133-IA1)")
    o.append("")
    o.append("**GENERATED by `tools/fs133_ia1_port.py` from `[OAIMath2026]` family 158 (github.com/openai/math at commit")
    o.append(f"`{COMMIT}`), three files under `lean/OAI/`:")
    o.append("do not edit by hand; rerun the script.**")
    o.append("")
    o.append("**Licence and notice of change.** The source is licensed under the Apache License, Version 2.0 (`LICENSE` at the")
    o.append("root of the release; http://www.apache.org/licenses/LICENSE-2.0); a byte-identical copy of that licence text is")
    o.append(f"beside this file, `Outside/{LICENCE_NAME}` (this script's `--check` compares the two). **This file is a")
    o.append("changed copy of parts of three files of the release.** The changes, all of them:")
    o.append("")
    o.append(f"1. *A selection*: {ncop} declarations — those that the twenty-five targets of `plans/FS133-kernel-plan.md` § 5.1")
    o.append("   (leaf P) use, as the release's own compiled constants give them (`data/fs133/ia1/cone/ConeDump.out`).")
    for mod, path, _ in FILES:
        q = p[mod]
        n = sum(b - a + 1 for a, b, *_ in q["copied"])
        o.append(f"   - `{path}`: {len(q['copied'])} of its {q['total']} declarations ({n} of its")
        o.append(f"     {q['nlines']} lines). Source lines copied:")
        for chunk in wrap(ranges_text(q["copied"]), 110):
            o.append("     " + chunk)
    ups = [short(c[2]) for mod, _, _ in FILES for c in p[mod]["upstream"]]
    for chunk in wrap(f"Not repeated, being already in `Outside/{UPSTREAM_MODULE}` (copied there by FS133-K1; with the derived "
                      "instance of `Spectral.DiscreteE`): " + ", ".join(f"`{s}`" for s in ups) + ".", 112):
        o.append("   " + chunk)
    for name, why in AUX_UNPORTED.items():
        for chunk in wrap_words(f"Not ported, a generated auxiliary of a declaration outside the selection: `{name}` — {why}.", 112):
            o.append("   " + chunk)
    ex = [(q["name"], no) for mod, _, _ in FILES for q in [p[mod]] for no in q["examples"]]
    if ex:
        o.append("   Left out, declaring nothing: the one-line `example`s at "
                 + ", ".join(f"`{n}:{no}`" for n, no in ex) + ".")
    o.append("2. *The namespaces*: `OAI.EuclideanFiveColor` and `OAI.PlaneFiveColor` there are one namespace here,")
    o.append(f"   `{OUR_NS}` (so `OAI.PlaneFiveColor.Spectral.dense_E` is")
    o.append(f"   `{OUR_NS}.Spectral.dense_E`, and `OAI.EuclideanFiveColor.Koopman.unitary` is")
    o.append(f"   `{OUR_NS}.Koopman.unitary`); no two ported declarations share a name (the script refuses).")
    o.append("3. *Docstrings*: every declaration's docstring opens with its source line at the commit; where the release")
    o.append("   has a docstring it follows the address, and where it has none the address is the docstring.")
    n = 4
    if scoped:
        o.append(f"{n}. *An instance scoped* ({len(scoped)}): the keyword `scoped`, and nothing else, on")
        for sf, sl, old, new, why in scoped:
            for chunk in wrap_words(f"- `{sf}:{sl}`, `{old}` — {why}.", 112):
                o.append("   " + chunk)
        n += 1
    for gf, gl, why in GLOBAL_INSTANCES:
        for chunk in wrap_words(f"An instance left global, as in the release: `{gf}:{gl}`, {why}.", 112):
            o.append("   " + chunk)
    if patches:
        o.append(f"{n}. *Patches* ({len(patches)}), each to a proof and none to a statement or a definition — Mathlib at this library's pin")
        o.append("   (v4.32.0) against the release's (v4.34.1):")
        for pf, pl, old, new, why in patches:
            for chunk in wrap_words(f"- `{pf}:{pl}`: `{old}` → `{new}` — {why}", 112):
                o.append("   " + chunk)
    else:
        o.append(f"{n}. *Patches*: none. Every proof here is the release's text, unchanged.")
    n += 1
    for (r_old, r_new, why) in RENAMES:
        at = sorted({(p[mod]["name"], ln) for mod, _, _ in FILES for ln, r in p[mod]["renamed"] if r == r_old})
        if not at:
            continue
        o.append(f"{n}. *A Mathlib name at this pin*: `{r_old}` is written `{r_new}` at each of its {len(at)} lines here, in statements")
        o.append("   as in proofs (source lines " + ", ".join(f"{a}:{b}" for a, b in at) + "). The statements say what they said:")
        for chunk in wrap_words(why + ".", 112):
            o.append("   " + chunk)
        n += 1
    if NOTES:
        o.append(f"{n}. *A sentence added to a docstring*, after the source address: "
                 + ", ".join(f"`{short(x)}`" for (_, x, _) in NOTES) + ".")
        n += 1
    if extra:
        o.append(f"{n}. *Brought in beyond the cone*: " + "; ".join(f"`{short(en)}` ({why})" for _, en, why in extra) + ".")
    o.append(f"{n + (1 if extra else 0)}. *Imports*: the Mathlib modules that declare what the selection's stored terms name at the release's pin")
    o.append("   (`data/fs133/ia1/cone/ImportsDump.out`; the release's own files import `Mathlib` whole)" + (", less:" if DROP_IMPORTS else "."))
    for m, why in DROP_IMPORTS:
        for chunk in wrap_words(f"- `{m}` — {why}.", 112):
            o.append("   " + chunk)
    for _, m, why in MORE_IMPORTS:
        for chunk in wrap_words(f"- added, `{m}` — {why}.", 112):
            o.append("   " + chunk)
    o.append("")
    for mod, path, what in FILES:
        o.extend(wrap_words(f"From `{base(path)}`: {what}.", 118))
    o.append("All of it is kernel-checked in this library: no axiom, no `sorry`. Nothing here reads the declared outside")
    o.append(f"theorem `Spectral.residual_fourier` of `Outside/{UPSTREAM_MODULE}`.")
    o.append("")
    o.extend(wrap_words(
        "**Compared with the release** as the kernel stores both (`tools/fs133_ia1_readback_port.py`; its tables are "
        "under `data/fs133/ia1/readback/`): each declaration's stored statement, and each definition's stored value, at "
        "the release's pin against this pin's — the same term up to the names Mathlib changed between the pins, or, "
        "where the table says so, the same once instance arguments and proof arguments are set aside. What that "
        "comparison leaves to trust: that Mathlib's instances of one class on one type agree at the two pins, which no "
        "print across pins can check. The proofs need no such comparison: the kernel checked them here.", 118))
    o.append("-/")
    for mod, _, _ in FILES:
        for (b0, b1, body, ns, _) in p[mod]["emitted"]:
            o.append("")
            o.append(f"-- {p[mod]['name']}:{b0}–{b1}")
            o.extend(body)
    return "\n".join(o) + "\n"


def generate(cone_text=None, patches=None, extra=None, scoped=None, upstream_text=None, clone=CLONE,
             global_instances=None):
    head = clone_commit(clone)
    if head != COMMIT:
        raise Refused(f"the clone is at {head}, not the audited commit {COMMIT}")
    cone_text = CONE.read_text() if cone_text is None else cone_text
    p = plan(cone_text, patches, extra, None, scoped, upstream_text, clone, global_instances)
    return render(p, patches, extra, scoped), p


def licence_check(outdir, clone, quiet=False) -> int:
    """0 when `outdir/LICENCE_NAME` holds the bytes of the clone's `LICENSE`; 1 when it is absent or differs."""
    src = pathlib.Path(clone) / LICENCE_SRC
    dst = pathlib.Path(outdir) / LICENCE_NAME
    if not src.exists():
        if not quiet:
            print(f"FAIL: the release's {src} is absent")
        return 1
    want = src.read_bytes()
    cur = dst.read_bytes() if dst.exists() else None
    if cur != want:
        if not quiet:
            print(f"FAIL: {dst.name} " + ("is absent" if cur is None else "differs from the release's LICENSE"))
        return 1
    if not quiet:
        print(f"OK: {dst.name} is the release's LICENSE byte for byte, {len(want)} bytes, "
              f"sha256 {hashlib.sha256(want).hexdigest()[:16]}")
    return 0


AX_BEGIN = "/-! ## FS133-IA1 — the port of `[OAIMath2026]` family 158"
AX_END = "-- FS133-IA1: end of the block"


def axioms_block(p) -> str:
    """The audit's records for this module: one `#print axioms` per ported declaration, in the module's order."""
    o = [AX_BEGIN + ": the generic lemmas FS-133's field theorem stands on (`Outside/OAI158Transfer`),",
         "generated by `tools/fs133_ia1_port.py --axioms-block`; no axiom, no outside theorem -/",
         "-- FS133-IA1", f"-- Outside/{MODULE}"]
    for mod, _, _ in FILES:
        for a, b, rel, kind in p[mod]["copied"]:
            if short(rel).startswith("inst") or ".inst" in short(rel):
                continue
            o.append(f"#print axioms {here_name(rel)}")
    o.append(AX_END)
    return "\n".join(o) + "\n"


def check(outdir=OUTDIR, cone_text=None, patches=None, extra=None, scoped=None, upstream_text=None, clone=CLONE,
          quiet=False, global_instances=None) -> int:
    try:
        text, _ = generate(cone_text, patches, extra, scoped, upstream_text, clone, global_instances)
    except Refused as e:
        if not quiet:
            print(f"FAIL: {e}")
        return 1
    bad = 0
    path = pathlib.Path(outdir) / f"{MODULE}.lean"
    cur = path.read_text() if path.exists() else None
    if cur != text:
        bad += 1
        if not quiet:
            print(f"FAIL: {path.name} " + ("is absent" if cur is None else "differs from the generated text"))
    elif not quiet:
        print(f"OK: {path.name} is the generated text, {text.count(chr(10))} lines, "
              f"sha256 {hashlib.sha256(text.encode()).hexdigest()[:16]}")
    bad += licence_check(outdir, clone, quiet)
    return 1 if bad else 0


def self_test() -> int:
    import shutil
    import tempfile
    ok = True
    if check(quiet=True) != 0:
        print("SELF-TEST FAILED: the unplanted check does not pass")
        return 1
    print("unplanted: PASS (as it must)")
    text, p = generate()
    cone_text = CONE.read_text()
    n = 0

    def expect(label, rc):
        nonlocal ok, n
        n += 1
        print(f"plant '{label}': {'REFUSED' if rc else 'SILENT'}")
        ok = ok and rc != 0

    with tempfile.TemporaryDirectory() as td:
        td = pathlib.Path(td)
        victim = td / f"{MODULE}.lean"
        victim.write_text(text)
        (td / LICENCE_NAME).write_bytes((CLONE / LICENCE_SRC).read_bytes())
        if check(outdir=td, quiet=True) != 0:
            print("SELF-TEST FAILED: the scratch copy does not pass unplanted")
            return 1
        # 1. one character of a proof changed in the generated file
        i = text.index(":= by", len(text) // 2)
        victim.write_text(text[:i] + ":= by  " + text[i + 5:])
        expect("the generated file changed by two spaces", check(outdir=td, quiet=True))
        victim.write_text(text)
        # 2. the generated file removed
        victim.rename(td / "gone")
        expect("the generated file absent", check(outdir=td, quiet=True))
        (td / "gone").rename(victim)
        # 3. a needed declaration silently dropped: every CONE line of one declaration removed
        cl = cone_text.splitlines()
        kept = [ln for ln in cl if not (ln.startswith("CONE") and ln.split("\t")[4].endswith(".positive_orthogonal"))]
        assert 0 < len(cl) - len(kept), "the plant removed nothing"
        expect(f"the {len(cl) - len(kept)} CONE line(s) of positive_orthogonal removed",
               check(outdir=td, cone_text="\n".join(kept), quiet=True))
        # 4. a declaration brought in that the cone does not hold (a CONE line added for a left-out declaration)
        mod0 = FILES[2][0]
        left0 = next(x for x in p[mod0]["left"] if x[2].endswith(".positiveSelect_pos"))
        extra_line = "\t".join(["CONE", mod0, str(left0[0]), str(left0[1]), left0[2], "theorem", left0[2], "1"])
        expect("a CONE line added (a declaration outside the cone)",
               check(outdir=td, cone_text=cone_text + extra_line + "\n", quiet=True))
        # 5. the cone leaves the three files
        far = "\t".join(["CONE", "OAI.Analysis.PlaneSpectrum.Ergodicity", "403", "410",
                         "OAI.PlaneFiveColor.Spectral.residual_fourier", "theorem",
                         "OAI.PlaneFiveColor.Spectral.residual_fourier", "1"])
        expect("a CONE line in a fourth file", check(outdir=td, cone_text=cone_text + far + "\n", quiet=True))
        # 6. a cone constant of the label model that is not the listed auxiliary
        lm = "\t".join(["CONE", mod0, "46", "46", "OAI.PlaneFiveColor.LabelModel.projected", "def",
                        "OAI.PlaneFiveColor.LabelModel.projected", "1"])
        expect("the label model's `projected` itself in the cone", check(outdir=td, cone_text=cone_text + lm + "\n", quiet=True))
        # 7–9. patches: not applying; into a statement; into a definition
        fname = base(FILES[1][1])
        src = read_sources()[FILES[1][0]]
        a, b, rel, kind = next(c for c in p[FILES[1][0]]["copied"] if c[3] == "lemma" and c[1] > c[0] + 1)
        expect("a patch that does not apply",
               check(outdir=td, patches=PATCHES + [(fname, b, "@@no such text@@", "x", "planted")], quiet=True))
        first_word = src[a - 1].split()[1]
        expect("a patch into a statement",
               check(outdir=td, patches=PATCHES + [(fname, a, first_word, first_word + "'", "planted")], quiet=True))
        a2, b2, rel2, kind2 = next(c for c in p[FILES[1][0]]["copied"] if c[3] == "def")
        tok = src[b2 - 1].split()[-1]
        expect("a patch into a definition",
               check(outdir=td, patches=PATCHES + [(fname, b2, tok, tok + " ", "planted")], quiet=True))
        # the partner: a patch into a proof is NOT refused by the script — it changes the generated text, so the
        # comparison with the file fails instead
        last_tok = src[b - 1].split()[-1]
        planted = PATCHES + [(fname, b, last_tok, last_tok + " ", "planted")]
        rc = check(outdir=td, patches=planted, quiet=True)
        try:
            generate(patches=planted)
            gen_ok = True
        except Refused:
            gen_ok = False
        print(f"partner 'a patch into a proof': generation {'ACCEPTED' if gen_ok else 'REFUSED'}, file then "
              f"{'DIFFERS' if rc else 'AGREES'}")
        ok = ok and gen_ok and rc != 0
        # 10. the scoped keyword withdrawn: the instance on Mathlib's type would be global, and is in neither table
        try:
            generate(scoped=[])
            gen_refused = False
        except Refused:
            gen_refused = True
        expect("SCOPED withdrawn (the instance on `E` in neither table): refused at generation", 1 if gen_refused else 0)
        # 10b. an instance left global with no entry
        try:
            generate(global_instances=[])
            gen_refused = False
        except Refused:
            gen_refused = True
        expect("GLOBAL_INSTANCES withdrawn (an instance in neither table): refused at generation", 1 if gen_refused else 0)
        # 11. a SCOPED entry that is more than the keyword
        sf, sl, old, new, why = SCOPED[0]
        expect("a SCOPED entry that changes more than the keyword",
               check(outdir=td, scoped=[(sf, sl, old, "scoped " + old.replace("Countable E", "Countable K"), why)], quiet=True))
        # 12. an upstream definition absent from `Outside/OAI158Rigidity`
        up = (OUTDIR / f"{UPSTREAM_MODULE}.lean").read_text()
        assert "\ndef kCoeff " in up
        expect("`kCoeff` absent upstream", check(outdir=td, upstream_text=up.replace("\ndef kCoeff ", "\ndef kCoeffX "), quiet=True))
        # 13. the `deriving` clause absent upstream
        assert "deriving CommGroup" in up
        expect("`deriving CommGroup` absent upstream",
               check(outdir=td, upstream_text=up.replace(" deriving CommGroup", ""), quiet=True))
        # 14–15. the licence copy: one byte changed; absent
        lic = td / LICENCE_NAME
        bts = lic.read_bytes()
        lic.write_bytes(bts[:100] + bytes([bts[100] ^ 1]) + bts[101:])
        expect("the licence copy changed by one byte", check(outdir=td, quiet=True))
        lic.unlink()
        expect("the licence copy absent", check(outdir=td, quiet=True))
        lic.write_bytes(bts)
        if check(outdir=td, quiet=True) != 0:
            print("SELF-TEST FAILED: the scratch copy does not pass after the plants were undone")
            return 1
        # 16. the clone at another commit
        clone2 = td / "clone"
        subprocess.run(["git", "init", "-q", str(clone2)], check=True)
        subprocess.run(["git", "-C", str(clone2), "-c", "user.name=x", "-c", "user.email=x@x", "commit", "-q",
                        "--allow-empty", "-m", "x"], check=True)
        expect("the clone at another commit", check(outdir=td, clone=clone2, quiet=True))
        shutil.rmtree(clone2)
    print(f"SELF-TEST OK: {n} plants refused and 1 partner accepted" if ok else "SELF-TEST FAILED")
    return 0 if ok else 1


def main() -> int:
    if "--self-test" in sys.argv:
        return self_test()
    if "--check" in sys.argv:
        rc = check()
        print("CHECK " + ("OK" if rc == 0 else "FAILED"))
        return rc
    try:
        text, p = generate()
    except Refused as e:
        print(f"FAIL: {e}")
        return 1
    if "--axioms-block" in sys.argv:
        sys.stdout.write(axioms_block(p))
        return 0
    if "--list" in sys.argv:
        tot = totd = 0
        for mod, path, _ in FILES:
            q = p[mod]
            n = sum(b - a + 1 for a, b, *_ in q["copied"])
            tot += n
            totd += len(q["copied"])
            print(f"{q['name']}: {q['total']} declarations — copied {len(q['copied'])} ({n} lines), upstream "
                  f"{len(q['upstream'])}, left out {len(q['left'])}")
            for g, (b0, b1, body, ns, bc) in enumerate(q["emitted"], 1):
                gl = sum(b - a + 1 for a, b, *_ in bc)
                npatch = sum(1 for (pf, pl, *_r) in PATCHES if pf == q["name"] and b0 <= pl <= b1)
                print(f"  section {q['name']}:{b0}–{b1}  namespace {ns}  {len(bc)} declarations, {gl} lines, "
                      f"{npatch} patches")
                for a, b, rel, kind in bc:
                    print(f"    {a}–{b}\t{kind}\t{short(rel)}")
            for a, b, rel in q["upstream"]:
                print(f"    {a}–{b}\t(upstream)\t{short(rel)}")
        print(f"auxiliaries of unported declarations: {p['__aux__']}")
        print(f"total copied: {totd} declarations, {tot} source lines; imports: {full_imports()}")
        return 0
    path = OUTDIR / f"{MODULE}.lean"
    path.write_text(text)
    print(f"wrote {MODULE}.lean ({text.count(chr(10))} lines, sha256 {hashlib.sha256(text.encode()).hexdigest()[:16]})")
    lic = OUTDIR / LICENCE_NAME
    if not lic.exists():
        lic.write_bytes((CLONE / LICENCE_SRC).read_bytes())
        print(f"wrote {LICENCE_NAME}")
    return licence_check(OUTDIR, CLONE)


if __name__ == "__main__":
    sys.exit(main())
