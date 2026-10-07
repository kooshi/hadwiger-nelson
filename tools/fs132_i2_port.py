#!/usr/bin/env python3
"""FS132-I2: the port of the release's lemmas that FS-132's first theorem stands on — the generator and its check.

Generates `Proofs/HadwigerNelson/Outside/OAI158<File>.lean`, one module per release file, from the clone of
`[OAIMath2026]` (github.com/openai/math) at the audited commit.  Nothing is retyped: every declaration is copied by line
range, and which declarations are copied is not chosen here — it is read from `data/fs132/i2/cone/ConeDump.out`, the
cone of the four target statements as the release's own compiled constants give it (`ConeDump.lean`, run at the
release's pin; a `DECL` line per source declaration of the release, a `CONE` line per constant the targets' stored
types and proofs name, transitively).

What this script changes in the copied text, and nothing else:
  1. the namespace: `EuclideanFiveColor` (inside `namespace OAI`) -> `HadwigerNelson.Outside.OAI158`;
  2. a source address in every declaration's docstring (`File.lean:line` at the commit): a docstring is added where
     the release has none (this library's `linter.missingDocs`), and prefixed where it has one;
  3. declarations outside the cone are left out, and a section left with no declaration is left out whole;
  4. declarations already in `Outside/OAI158` or `Outside/OAI158Palette` (copied there by FS132-I1 and FS132-K1) are
     not repeated: a `--` comment stands where each was;
  5. the PATCHES below — each a line of a PROOF that does not elaborate at this library's pin (Lean v4.32.0, Mathlib
     v4.32.0; the release is at v4.34.1), with its reason.  The script refuses a patch that touches a definition, or a
     theorem's statement (anything before the declaration's top-level `:=`).
EXTRA lists declarations brought in although no stored term of the cone names them (a name a tactic script needs),
each with its reason.

Extended by FS132-L2 (the landing, 2026-10-07), in one place: the release's licence text travels with the ported
modules — the script writes a byte-identical copy of the clone's `LICENSE` beside them (`Outside/OAIMath2026-LICENSE.txt`),
every generated header names it, `--check` compares the two files byte for byte, and `--self-test` plants a changed
byte and an absent copy.  No declaration, statement or proof text moved.

Usage:
  tools/fs132_i2_port.py                 write the modules
  tools/fs132_i2_port.py --check         regenerate in memory, compare with the files (and run FS132-K1's check of
                                         `OAI158Palette`); exit 1 on any difference
  tools/fs132_i2_port.py --self-test     plant faults (a changed generated line, a cone line removed, a patch that
                                         does not apply, a patch into a statement, a patch into a definition, a
                                         clone at another commit) and require each refused, and the unplanted check
                                         to pass
  tools/fs132_i2_port.py --list          print the cone per file: copied / already ported / left out, with lines
"""
import hashlib
import importlib.util
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
CLONE = pathlib.Path("/home/kooshi/source/math")
COMMIT = "adc7f1241b42e322a6451854ab7e4b4c146bf78a"
SRC = CLONE / "lean/OAI/Geometry/PlaneColoring"
CONE = ROOT / "data/fs132/i2/cone/ConeDump.out"
OUTDIR = ROOT / "Proofs/HadwigerNelson/Outside"
RELNS = "OAI.EuclideanFiveColor."
MODPFX = "OAI.Geometry.PlaneColoring."
NS_OLD, NS_NEW = "EuclideanFiveColor", "HadwigerNelson.Outside.OAI158"
PFX = "Proofs.HadwigerNelson.Outside."

# (release file, module here, what it holds, this library's modules it imports) in dependency order.  The Mathlib
# imports are not chosen here: they are read from `data/fs132/i2/cone/ImportsDump.out` — per release file, the modules
# declaring the Mathlib constants its cone's stored terms name at the release's pin, reduced to those no other of the
# list imports (`ImportsDump.lean`) — plus MORE_IMPORTS, each with its reason.
FILES = [
    ("CircleMaps.lean", "OAI158CircleMaps",
     "the maps of circle geometry: the sum of two unit vectors, its inverse off the degenerate set, the circle of "
     "centre and radius as a target map, the angle chart, and their strict derivatives and local bi-Lipschitz bounds",
     ["OAI158Palette"]),
    ("Expansion.lean", "OAI158Expansion",
     "pull-backs of `L¹` convergence along maps that expand volume by a bounded factor, and the line maps that do",
     ["OAI158"]),
    ("CircleTransport.lean", "OAI158CircleTransport",
     "the angular sum `x + r·e(s) + e(t)` (`angularSum`, defined in `OAI158Palette`) as a quasi-measure-preserving map "
     "of the torus of direction pairs, `L¹` convergence along it, and the sampling parameter",
     ["OAI158CircleMaps", "OAI158Expansion"]),
    ("PaletteDensity.lean", "OAI158PaletteDensity",
     "the palette's transfer along the angular sum (`palette_transfer_pair`, the manuscript's Lemma 5.2 (1)) and the "
     "density-zero form on lines of angles",
     ["OAI158CircleTransport"]),
    ("PaletteTransport.lean", "OAI158PaletteTransport",
     "the palette's transport along a branch of the circle map, and its consequence at sixty degrees "
     "(`palette_sixty_disjoint`, the manuscript's Corollary 5.3)",
     ["OAI158PaletteDensity"]),
    ("BinaryPalettes.lean", "OAI158BinaryPalettes",
     "the triangle angle `arccos (5/6)`, the ergodicity of the rotation by twice it, and the source triangle",
     ["OAI158PaletteTransport"]),
    ("States.lean", "OAI158States",
     "two-state palettes: density-zero and density-one sets, the realization of finitely many density points, and "
     "`two_state_impossible` (the manuscript's Lemma 6.4, for every number of colours)",
     ["OAI158BinaryPalettes"]),
    ("AngularBoundary.lean", "OAI158AngularBoundary",
     "almost every point of a colour class lies in the class's essential support (`mem_spatialSupport_ae`)",
     ["OAI158Palette"]),
]
IMPORTS = ROOT / "data/fs132/i2/cone/ImportsDump.out"

# (file, Mathlib module, reason) — imports the stored terms do not show (a tactic, a notation, an instance found by
# search), found against the build at this pin.
MORE_IMPORTS = [
]

# (file, line, old substring, new substring, reason) — Mathlib differences between v4.34.1 (theirs) and v4.32.0 (ours).
# A patch is a change to a PROOF; the script refuses one that touches a statement or a definition.
PATCHES = [
    ("CircleMaps.lean", 385, ")) K.2", ")) K.coe_nonneg",
     "`K.2 : 0 ≤ K.val` names the coercion `ℝ≥0 → ℝ` as `Subtype.val`; at v4.32.0 `nlinarith` does not take it for the "
     "atom `(K : ℝ)` of the other hypotheses, and fails. `NNReal.coe_nonneg K` is the same fact stated at `(K : ℝ)`"),
    ("CircleMaps.lean", 466, "linarith [K.2]", "linarith [K.coe_nonneg]",
     "the same: `linarith` at v4.32.0 does not identify `K.val` with `(K : ℝ)`"),
    ("PaletteDensity.lean", 182, "using 1; rfl", "using 1 <;> rfl",
     "at v4.32.0 `convert … using 1` leaves two goals where the release's pin leaves one (the equality of the two "
     "maps, and `volume = volume.prod volume`); each is closed by `rfl`"),
    ("PaletteDensity.lean", 480, "ite_eq_right hi", "if_neg hi",
     "core's `if_neg` was renamed `ite_eq_right` on 2026-07-21 (`Init/Core.lean`; at v4.34.1 `if_neg` is its deprecated "
     "alias); at v4.32.0 the lemma has only the old name"),
    ("PaletteTransport.lean", 447, "Set.mem_ofPred_eq", "Set.mem_setOf_eq",
     "Mathlib renamed `setOf` to `Set.ofPred` on 2026-07-09 and its lemmas with it (`Mathlib/Data/Set/Defs.lean`, "
     "`Operations.lean:79–81`); at v4.32.0 the lemma is `Set.mem_setOf_eq`, the same statement"),
    ("States.lean", 122, "mem_ofPred_eq", "mem_setOf_eq", "the same rename of Mathlib's"),
    ("States.lean", 183, "preimage_ofPred_eq", "preimage_setOf_eq", "the same rename of Mathlib's"),
]

# (name at the release's Mathlib, name at this library's Mathlib, the evidence) — a Mathlib constant RENAMED between
# the two pins, the same definition under both names.  A rename is applied to every occurrence of the token, in
# statements as in proofs: the statement then names the same Mathlib function by the name it has at this pin, and
# says what it said.  It is not a patch (a patch never touches a statement), it is listed apart in every header, and
# `tools/fs132_i2_readback.py` checks, on the stored terms at the two pins, that the two names carry one type and
# one value and that nothing else in a ported statement differs.  The script refuses a rename inside a definition.
RENAMES = [
    ("domRestrict", "restrict",
     "Mathlib's `Set.restrict` (v4.32.0, `Mathlib/Data/Set/Restrict.lean:32`) was renamed `Set.domRestrict` on "
     "2026-07-19 with its lemmas (`restrict_apply` → `domRestrict_apply`, …); at v4.34.1 the old names are "
     "deprecated aliases of the new (`Restrict.lean:202–209` there) and the definition's text is the same at both "
     "tags: `(s : Set α) (f : ∀ a : α, π a) : ∀ a : s, π a := fun x => f x`"),
]

# (file, release name without its namespace, a sentence) — a sentence added to a declaration's docstring after its
# source address: what a reader of that statement must know about it at this pin.
NOTES = [
    ("States.lean", "two_state_impossible",
     "As the kernel stores it, this statement is the release's but for one Mathlib name: its two set-builders "
     "`{t : ℝ | …}` are `setOf` at this library's pin and `Set.ofPred` at the release's — one definition, which Mathlib "
     "renamed on 2026-07-09 and which the text never names (`tools/fs132_i2_readback.py`)."),
]

# (file, release name without its namespace, reason) — declarations no stored term of the cone names.
EXTRA = [
]

# The release's `Coloring.lean` is not generated: FS132-I1 copied its definitions into `Outside/OAI158` by hand (the
# read-back of `tools/fs132_i1_readback.py` is on them) and FS132-K1 the rest into `Outside/OAI158Palette`'s header.
# release name -> (name here, the file that declares it)
COLORING = {
    "anglePeriodPositive": ("anglePeriodPositive", "OAI158.lean"),
    "Angles": ("Angles", "OAI158.lean"),
    "angularMeasure": ("angularMeasure", "OAI158.lean"),
    "direction": ("direction", "OAI158.lean"),
    "instIsProbabilityMeasureAnglesAngularMeasure": ("angularMeasure.instIsProbabilityMeasure", "OAI158.lean"),
    "instIsAddHaarMeasureAnglesAngularMeasure": ("angularMeasure.instIsAddHaarMeasure", "OAI158Palette.lean"),
    "direction_continuous": ("direction_continuous", "OAI158Palette.lean"),
    "direction_norm": ("direction_norm", "OAI158Palette.lean"),
    "direction_real": ("direction_real", "OAI158Palette.lean"),
    "WeakColoring": ("WeakColoring", "OAI158.lean"),
}

KEYWORD = re.compile(r"^(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|scoped|local)\s+)*"
                     r"(lemma|theorem|def|abbrev|instance|structure|inductive|class)\b")
SCAFFOLD = re.compile(r"^(?:|noncomputable section|open .*|namespace EuclideanFiveColor|end EuclideanFiveColor|end|"
                      r"variable .*|include .*|omit .*|--.*)$")
PROOFKINDS = ("lemma", "theorem")


class Refused(Exception):
    """A condition under which nothing may be generated."""


def k1():
    spec = importlib.util.spec_from_file_location("fs132_k1_port", ROOT / "tools/fs132_k1_port.py")
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def clone_commit(clone=CLONE) -> str:
    return subprocess.run(["git", "-C", str(clone), "rev-parse", "HEAD"], check=True, capture_output=True,
                          text=True).stdout.strip()


def load_cone(text: str):
    """-> decls[file] = [(first, last, owner)], cone[file] = {owner}, uses[file] = {file of a dependency}."""
    decls, cone, where, edges = {}, {}, {}, []
    # A structure's generated constants carry ranges inside the structure's own (`S.mk` and the fields at their
    # lines, `S.casesOn` at the whole): one source declaration per outermost range, named by the owner the others
    # extend.  Anything else that overlaps is refused.
    rows = {}
    for ln in text.splitlines():
        f = ln.split("\t")
        if f[0] in ("DECL", "CONE"):
            rows.setdefault(f[1], set()).add((int(f[2]), int(f[3]), f[4]))
    top = {}
    for mod, rs in rows.items():
        cur = None
        for (a, b, o) in sorted(rs, key=lambda r: (r[0], -r[1], len(r[2]))):
            if cur is not None and a <= cur[1]:
                if b > cur[1] or not (o + ".").startswith(cur[2] + "."):
                    raise Refused(f"{mod}: declarations {cur[2]} ({cur[0]}–{cur[1]}) and {o} ({a}–{b}) overlap")
            else:
                cur = (a, b, o)
            top[(mod, a, b, o)] = cur
    for ln in text.splitlines():
        f = ln.split("\t")
        if f[0] == "DECL" and f[1].startswith(MODPFX):
            row = top[(f[1], int(f[2]), int(f[3]), f[4])]
            lst = decls.setdefault(f[1][len(MODPFX):] + ".lean", [])
            if row not in lst:
                lst.append(row)
        elif f[0] == "CONE":
            if not f[1].startswith(MODPFX):
                raise Refused(f"the cone leaves `{MODPFX}*`: {f[6]} is in {f[1]} — nothing of that module is planned")
            name = f[1][len(MODPFX):] + ".lean"
            cone.setdefault(name, set()).add(top[(f[1], int(f[2]), int(f[3]), f[4])])
            where[f[6]] = name
        elif f[0] == "EDGE":
            edges.append((f[1], f[2]))
        elif f[0] == "NORANGE":
            raise Refused(f"a cone constant with no source declaration: {f[1]}")
    if not cone:
        raise Refused("the cone file holds no CONE line")
    for name, owners in cone.items():
        have = set(decls.get(name, []))
        for o in owners:
            if o not in have:
                raise Refused(f"cone declaration {o} of {name} is not among the file's DECL lines")
    uses = {}
    for a, b in edges:
        if a in where and b in where and where[a] != where[b]:
            uses.setdefault(where[a], set()).add(where[b])
    for name in decls:
        decls[name].sort()
        for (a1, b1, o1), (a2, b2, o2) in zip(decls[name], decls[name][1:]):
            if a2 <= b1:
                raise Refused(f"{name}: declarations {o1} ({a1}–{b1}) and {o2} ({a2}–{b2}) overlap")
    return decls, cone, uses


def short(owner: str) -> str:
    return owner[len(RELNS):] if owner.startswith(RELNS) else owner


def statement_end(lines, first, last):
    """The (line, column) of the declaration's top-level `:=` (or `where`/`|` for a structure): everything before it
    is the signature.  Brackets are counted from the declaration keyword on."""
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


def already_ported():
    """file -> set of lines FS132-K1's script copies into `OAI158Palette`."""
    m = k1()
    got = {}
    for name, a, b in m.SEGMENTS:
        got.setdefault(name, set()).update(range(a, b + 1))
    for name, ranges, _ in m.SNIPPETS:
        for a, b in ranges:
            got.setdefault(name, set()).update(range(a, b + 1))
    return got


def plan(cone_text: str, patches=None, extra=None, renames=None):
    """-> per file: the blocks to emit, and the bookkeeping the header prints."""
    patches = PATCHES if patches is None else patches
    extra = EXTRA if extra is None else extra
    renames = RENAMES if renames is None else renames
    decls, cone, uses = load_cone(cone_text)
    ported = already_ported()
    names = [f[0] for f in FILES]
    k1mod = k1()
    covered = set(names) | {s[0] for s in k1mod.SEGMENTS} | {"Coloring.lean"}
    for name in cone:
        if name not in covered:
            raise Refused(f"the cone reaches {name}, which no module here is planned for")
    # Coloring.lean: by name, against the two hand-made copies
    for (_, _, owner) in cone.get("Coloring.lean", ()):
        s = short(owner)
        if s not in COLORING:
            raise Refused(f"cone declaration {s} of Coloring.lean has no counterpart listed")
        here, mod = COLORING[s]
        if not re.search(r"\b(def|abbrev|instance|lemma|theorem)\s+" + re.escape(here) + r"\b", (OUTDIR / mod).read_text()):
            raise Refused(f"{here} is not declared in {mod}")
    # files wholly in FS132-K1's module
    for name in cone:
        if name in names or name == "Coloring.lean":
            continue
        for (a, b, owner) in cone[name]:
            if not set(range(a, b + 1)) <= ported.get(name, set()):
                raise Refused(f"cone declaration {short(owner)} ({name}:{a}–{b}) is not in OAI158Palette")
    out = {}
    noted = set()
    used_patches, used_extra = set(), set()
    for name, module, _, imports in FILES:
        imports = full_imports(name, imports)
        lines = (SRC / name).read_text().split("\n")
        want = {o for (_, _, o) in cone.get(name, ())}
        for i, (ef, en, _) in enumerate(extra):
            if ef == name:
                full = RELNS + en
                if full not in {o for (_, _, o) in decls.get(name, [])}:
                    raise Refused(f"EXTRA {en} is not a declaration of {name}")
                if full in want:
                    raise Refused(f"EXTRA {en} is already in the cone")
                want.add(full)
                used_extra.add(i)
        owner_at = {}
        for (a, b, o) in decls.get(name, []):
            for no in range(a, b + 1):
                owner_at[no] = (a, b, o)
        # blocks
        blocks, cur = [], None
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
                # a continuation line of a `variable` command
                prev = lines[no - 2]
                k = no - 1
                while k >= 1 and lines[k - 1].startswith((" ", "\t")) and k not in owner_at:
                    k -= 1
                if not (s.startswith((" ", "\t")) and (no - 1) not in owner_at and lines[k - 1].startswith("variable ")):
                    raise Refused(f"{name}:{no}: a line this script does not classify: {s!r}")
        if cur is not None:
            raise Refused(f"{name}: a section is not closed")
        emitted, copied, skipped, left, renamed = [], [], [], [], []
        for (b0, b1) in blocks:
            body, any_decl, no = [], False, b0
            pending = []
            while no <= b1:
                s = lines[no - 1]
                if no not in owner_at:
                    if re.search(r"\sin$", s) and (no + 1) in owner_at:
                        pending.append(s)
                    else:
                        if pending:
                            raise Refused(f"{name}:{no}: an `… in` line not followed by a declaration")
                        body.append(s.replace(f"namespace {NS_OLD}", f"namespace {NS_NEW}")
                                    .replace(f"end {NS_OLD}", f"end {NS_NEW}"))
                    no += 1
                    continue
                a, b, o = owner_at[no]
                if no != a:
                    raise Refused(f"{name}:{no}: inside {o} but not at its first line")
                sh = short(o)
                is_ported = set(range(a, b + 1)) <= ported.get(name, set())
                if not is_ported and set(range(a, b + 1)) & ported.get(name, set()):
                    raise Refused(f"{name}:{a}–{b}: {sh} is only partly in OAI158Palette")
                if o not in want:
                    left.append((a, b, sh))
                elif is_ported:
                    skipped.append((a, b, sh))
                    body.append(f"-- `{sh}` ({name}:{a}" + (f"–{b}" if b > a else "") + "): in `Outside/OAI158Palette`, "
                                "copied there by FS132-K1.")
                else:
                    text = lines[a - 1:b]
                    # the keyword line
                    kw = next((i for i, t in enumerate(text) if KEYWORD.match(t)), None)
                    if kw is None:
                        raise Refused(f"{name}:{a}–{b}: no declaration keyword found in {sh}")
                    kind = KEYWORD.match(text[kw]).group(1)
                    addr = f"`[OAIMath2026]` `{name}:{a + kw}`."
                    se = statement_end(lines, a, b)
                    for i, (pf, pl, old, new, _) in enumerate(patches):
                        if pf == name and a <= pl <= b:
                            if kind not in PROOFKINDS and not (kind == "instance" and se is not None):
                                raise Refused(f"patch {i} ({name}:{pl}) is inside the {kind} {sh}: a definition is "
                                              "never patched")
                            if kind == "instance":
                                # an instance is patched only where it is a proof: after `:= by`
                                if "by" not in lines[se[0] - 1][se[1]:].split():
                                    raise Refused(f"patch {i} ({name}:{pl}) is inside the instance {sh}, whose value "
                                                  "is a term: not patched")
                            if se is None:
                                raise Refused(f"patch {i} ({name}:{pl}): no top-level `:=` found in {sh}")
                            row = text[pl - a]
                            pos = row.find(old)
                            if pos < 0:
                                raise Refused(f"patch {i} does not apply at {name}:{pl}")
                            if (pl, pos) < se:
                                raise Refused(f"patch {i} ({name}:{pl}) touches the statement of {sh} (its `:=` is "
                                              f"at line {se[0]}, column {se[1]})")
                            text[pl - a] = row.replace(old, new)
                            used_patches.add(i)
                    for (r_old, r_new, _) in renames:
                        pat = re.compile(r"(?<![A-Za-z0-9_'])" + re.escape(r_old) + r"(?![A-Za-z0-9'])")
                        for j, row in enumerate(text):
                            if pat.search(row):
                                if kind not in PROOFKINDS:
                                    raise Refused(f"rename `{r_old}` occurs in the {kind} {sh} ({name}:{a + j}): a "
                                                  "definition is never changed")
                                text[j] = pat.sub(r_new, row)
                                renamed.append((a + j, r_old))
                    note = [t for (nf, nn, t) in NOTES if nf == name and nn == sh]
                    if note:
                        noted.add((name, sh))
                    if kw == 0:
                        body.extend(pending)
                        if note:
                            doc = wrap_words(f"/-- {addr} {note[0]} -/", 118)
                            body.extend(doc)
                        else:
                            body.append(f"/-- {addr} -/")
                    elif note:
                        raise Refused(f"{name}: a note on {sh}, which has a docstring of its own: not handled")
                    elif text[0].startswith("/--"):
                        text[0] = f"/-- {addr} " + text[0][3:].lstrip()
                        body.extend(pending)
                    else:
                        raise Refused(f"{name}:{a}: {sh} begins with neither a keyword nor a docstring")
                    body.extend(text)
                    copied.append((a, b, sh, kind))
                    any_decl = True
                pending = []
                no = b + 1
            if pending:
                raise Refused(f"{name}:{b1}: an `… in` line at the end of a section")
            if any_decl:
                emitted.append((b0, b1, body))
        missing = want - {RELNS + c[2] for c in copied} - {RELNS + c[2] for c in skipped}
        if missing:
            raise Refused(f"{name}: cone declarations not placed: {sorted(missing)}")
        # the imports must cover what the cone's own edges say this file uses
        mods = {f[0]: f[1] for f in FILES}
        reach, todo = set(), [m for m in imports if m.startswith("OAI158")]
        while todo:
            m = todo.pop()
            if m in reach:
                continue
            reach.add(m)
            for f in FILES:
                if f[1] == m:
                    todo.extend(x for x in f[3] if x.startswith("OAI158"))
        for dep in uses.get(name, ()):
            need = mods.get(dep, "OAI158Palette" if dep != "Coloring.lean" else "OAI158")
            if need not in reach and not (need == "OAI158" and "OAI158Palette" in reach):
                raise Refused(f"{module} uses {dep} (by the cone's edges) and does not import {need}")
        out[name] = dict(module=module, emitted=emitted, copied=copied, skipped=skipped, left=left, renamed=renamed,
                         total=len(decls.get(name, [])), nlines=len(lines) - (1 if lines[-1] == "" else 0))
    if len(used_patches) != len(patches):
        raise Refused(f"patches not used: {sorted(set(range(len(patches))) - used_patches)}")
    if len(noted) != len(NOTES):
        raise Refused(f"NOTES not placed: {sorted({(a, b) for a, b, _ in NOTES} - noted)}")
    if len(used_extra) != len(extra):
        raise Refused(f"EXTRA entries not used: {sorted(set(range(len(extra))) - used_extra)}")
    return out


def full_imports(name, ours):
    """This library's modules, then the Mathlib modules of the dump and of MORE_IMPORTS, sorted."""
    got = set()
    for ln in IMPORTS.read_text().splitlines():
        f = ln.split("\t")
        if len(f) == 3 and f[0] == "IMPORT" and f[1] == MODPFX + name[:-5]:
            if f[2].startswith("OAI."):
                raise Refused(f"the import dump lists a release module for {name}: {f[2]}")
            got.add(f[2])
    if not got:
        raise Refused(f"the import dump has no line for {name}")
    got |= {m for (ef, m, _) in MORE_IMPORTS if ef == name}
    return list(ours) + sorted(got)


def ranges_text(rows):
    return ", ".join(f"{a}–{b}" if b > a else f"{a}" for a, b, *_ in rows)


def render(name, module, what, imports, p, patches=None, extra=None) -> str:
    patches = PATCHES if patches is None else patches
    extra = EXTRA if extra is None else extra
    o = [f"import {m if m.startswith('Mathlib') else PFX + m}" for m in imports]
    ncopy = sum(b - a + 1 for a, b, *_ in p["copied"])
    o.append("")
    o.append("/-!")
    o.append(f"# `[OAIMath2026]` `{name}`, the part FS-132 stands on, ported (job FS132-I2)")
    o.append("")
    o.append(f"**GENERATED by `tools/fs132_i2_port.py` from `[OAIMath2026]` family 158 (github.com/openai/math at commit")
    o.append(f"`{COMMIT}`), file `lean/OAI/Geometry/PlaneColoring/{name}`:")
    o.append("do not edit by hand; rerun the script.**")
    o.append("")
    o.append("**Licence and notice of change.** The source is licensed under the Apache License, Version 2.0 (`LICENSE` at the")
    o.append("root of the release; http://www.apache.org/licenses/LICENSE-2.0); a byte-identical copy of that licence text is")
    o.append(f"beside this file, `Outside/{LICENCE_NAME}` (this script's `--check` compares the two). **This file is a")
    o.append(f"changed copy of part of `{name}`.** The changes, all of them:")
    o.append("")
    o.append(f"1. *A selection.* Of the file's {p['total']} declarations, {len(p['copied'])} are copied here ({ncopy} of its")
    o.append(f"   {p['nlines']} lines) — those that the proofs of `palette_transfer_pair`, `palette_sixty_disjoint`,")
    o.append("   `two_state_impossible` and `mem_spatialSupport_ae` use, as the release's own compiled constants give them")
    o.append("   (`data/fs132/i2/cone/ConeDump.out`). Source lines copied:")
    for chunk in wrap(ranges_text(p["copied"]), 112):
        o.append("   " + chunk)
    if p["skipped"]:
        o.append(f"   Not repeated, being already in `Outside/OAI158Palette` (FS132-K1): "
                 + ", ".join(f"`{s}`" for _, _, s in p["skipped"]) + ".")
    o.append("2. *The namespace*: `OAI.EuclideanFiveColor` there, `HadwigerNelson.Outside.OAI158` here.")
    o.append("3. *Docstrings*: every declaration's docstring opens with its source line at the commit; where the release")
    o.append("   has a docstring it follows the address, and where it has none the address is the docstring.")
    mine = [(pf, pl, old, new, why) for (pf, pl, old, new, why) in patches if pf == name]
    if mine:
        o.append(f"4. *Patches* ({len(mine)}), each to a proof and none to a statement or a definition — Mathlib at this library's pin")
        o.append("   (v4.32.0) against the release's (v4.34.1):")
        for pf, pl, old, new, why in mine:
            o.append(f"   - line {pl}: `{old}` → `{new}` — {why}")
    else:
        o.append("4. *Patches*: none. Every proof here is the release's text, unchanged.")
    n = 5
    if p["renamed"]:
        for (r_old, r_new, why) in RENAMES:
            at = sorted({ln for ln, r in p["renamed"] if r == r_old})
            if not at:
                continue
            o.append(f"{n}. *A Mathlib name at this pin*: `{r_old}` is written `{r_new}` at each of its {len(at)} lines here, in statements")
            o.append("   as in proofs (source lines " + ", ".join(str(x) for x in at) + "). The statements say what they said:")
            for chunk in wrap_words(why + ".", 112):
                o.append("   " + chunk)
            n += 1
    nt = [nn for (nf, nn, _) in NOTES if nf == name]
    if nt:
        o.append(f"{n}. *A sentence added to a docstring*, after the source address: " + ", ".join(f"`{x}`" for x in nt) + ".")
        n += 1
    ex = [(en, why) for (ef, en, why) in extra if ef == name]
    if ex:
        o.append(f"{n}. *Brought in beyond the cone*: " + "; ".join(f"`{en}` ({why})" for en, why in ex) + ".")
    o.append("")
    o.extend(wrap_words(f"What is here: {what}. All of it is kernel-checked in this library: no axiom, no `sorry`.", 118))
    o.append("")
    o.extend(wrap_words(
        "**Compared with the release** as the kernel stores both (`tools/fs132_i2_readback.py`; its tables are under "
        "`data/fs132/i2/readback/`): each declaration's stored statement, and each definition's stored value, at the "
        "release's pin against this pin's — the same term up to the names Mathlib changed between the pins, or, where "
        "the table says so, the same once instance arguments and proof arguments are set aside. What that comparison "
        "leaves to trust: that Mathlib's instances of one class on one type agree at the two pins, which no print "
        "across pins can check. The proofs need no such comparison: the kernel checked them here.", 118))
    o.append("-/")
    for (b0, b1, body) in p["emitted"]:
        o.append("")
        o.extend(body)
    return "\n".join(o) + "\n"


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


def generate(cone_text=None, patches=None, extra=None, clone=CLONE):
    head = clone_commit(clone)
    if head != COMMIT:
        raise Refused(f"the clone is at {head}, not the audited commit {COMMIT}")
    cone_text = CONE.read_text() if cone_text is None else cone_text
    p = plan(cone_text, patches, extra)
    return {module: render(name, module, what, full_imports(name, imports), p[name], patches, extra)
            for name, module, what, imports in FILES}, p


# FS132-L2 (the landing): the release's licence text travels with the ported modules (Apache-2.0 § 4 (a)) — a
# byte-identical copy beside them, written by this script and compared by `--check`.
LICENCE_NAME = "OAIMath2026-LICENSE.txt"
LICENCE_SRC = "LICENSE"


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


AXIOMS = ROOT / "scripts/Axioms.lean"
AX_BEGIN = "/-! ## FS132-I2 — the port of `[OAIMath2026]` family 158"
AX_END = "-- FS132-I2: end of the block"


def axioms_block(p) -> str:
    """The audit's records for this job: one `#print axioms` per ported declaration, in the order of the modules."""
    o = [AX_BEGIN + ": the lemmas FS-132's first theorem stands on (`Outside/OAI158CircleMaps` … `OAI158States`,",
         "`OAI158AngularBoundary`), generated by `tools/fs132_i2_port.py --axioms-block`; no axiom, no outside theorem -/",
         "-- FS132-I2"]
    for name, module, _, _ in FILES:
        o.append(f"-- Outside/{module}")
        for a, b, sh, kind in p[name]["copied"]:
            o.append(f"#print axioms {NS_NEW}.{sh}")
    o.append(AX_END)
    return "\n".join(o) + "\n"


def check_axioms_block(p, quiet=False) -> int:
    text = AXIOMS.read_text()
    want = axioms_block(p)
    if want not in text:
        if not quiet:
            print("FAIL: scripts/Axioms.lean does not hold this job's block as generated (--axioms-block)")
        return 1
    if not quiet:
        print(f"OK: scripts/Axioms.lean holds the block, {want.count('#print axioms')} records")
    return 0


def check(outdir=OUTDIR, cone_text=None, patches=None, extra=None, clone=CLONE, quiet=False) -> int:
    try:
        texts, _ = generate(cone_text, patches, extra, clone)
    except Refused as e:
        if not quiet:
            print(f"FAIL: {e}")
        return 1
    bad = 0
    for module, text in texts.items():
        path = pathlib.Path(outdir) / f"{module}.lean"
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
    texts, p = generate()
    cone_text = CONE.read_text()

    def expect(label, rc):
        nonlocal ok
        print(f"plant '{label}': {'REFUSED' if rc else 'SILENT'}")
        ok = ok and rc != 0

    with tempfile.TemporaryDirectory() as td:
        td = pathlib.Path(td)
        for module, text in texts.items():
            (td / f"{module}.lean").write_text(text)
        (td / LICENCE_NAME).write_bytes((CLONE / LICENCE_SRC).read_bytes())
        if check(outdir=td, quiet=True) != 0:
            print("SELF-TEST FAILED: the scratch copy does not pass unplanted")
            return 1
        # 1. one character of a proof changed in a generated file
        victim = td / f"{FILES[0][1]}.lean"
        s = victim.read_text()
        i = s.index(":= by", len(s) // 2)
        victim.write_text(s[:i] + ":= by  " + s[i + 5:])
        expect("a generated file changed by two spaces", check(outdir=td, quiet=True))
        victim.write_text(s)
        # 2. a generated file removed
        victim.rename(td / "gone")
        expect("a generated file absent", check(outdir=td, quiet=True))
        (td / "gone").rename(victim)
        # 3. a cone line removed: a needed declaration silently dropped from the generation
        # (every CONE line of the declaration: its generated constants `X._simp_1_1` carry its range too, and one of
        # them left in the cone keeps the declaration wanted — removing one line only was a plant that could not fire)
        cl = cone_text.splitlines()
        kept = [ln for ln in cl if not (ln.startswith("CONE") and ln.split("\t")[4].endswith(".palette_transfer_pair"))]
        assert 0 < len(cl) - len(kept), "the plant removed nothing"
        expect(f"the {len(cl) - len(kept)} CONE lines of palette_transfer_pair removed",
               check(outdir=td, cone_text="\n".join(kept), quiet=True))
        # 4. a cone line added: a declaration brought in that the cone does not hold
        name0 = FILES[2][0]
        left0 = p[name0]["left"][0]
        extra_line = "\t".join(["CONE", MODPFX + name0[:-5], str(left0[0]), str(left0[1]), RELNS + left0[2], "theorem",
                                RELNS + left0[2], "1"])
        expect("a CONE line added (a declaration outside the cone)", check(outdir=td, cone_text=cone_text + extra_line + "\n", quiet=True))
        # 5–7. patches: not applying; into a statement; into a definition
        a, b, sh, kind = next(c for c in p[FILES[0][0]]["copied"] if c[3] == "lemma" and c[1] > c[0] + 1)
        src = (SRC / FILES[0][0]).read_text().split("\n")
        expect("a patch that does not apply", check(outdir=td, patches=PATCHES + [(FILES[0][0], b, "@@no such text@@", "x", "planted")], quiet=True))
        first_word = src[a - 1].split()[1]
        expect("a patch into a statement", check(outdir=td, patches=PATCHES + [(FILES[0][0], a, first_word, first_word + "'", "planted")], quiet=True))
        a2, b2, sh2, kind2 = next(c for c in p[FILES[0][0]]["copied"] if c[3] == "def")
        tok = src[b2 - 1].split()[-1]
        expect("a patch into a definition", check(outdir=td, patches=PATCHES + [(FILES[0][0], b2, tok, tok + " ", "planted")], quiet=True))
        # 8. a patch into a proof is NOT refused by the script (the partner that must pass the refusals) — it changes
        #    the generated text, so the comparison with the files fails instead
        last_tok = src[b - 1].split()[-1]
        rc = check(outdir=td, patches=PATCHES + [(FILES[0][0], b, last_tok, last_tok + " ", "planted")], quiet=True)
        try:
            generate(patches=PATCHES + [(FILES[0][0], b, last_tok, last_tok + " ", "planted")])
            gen_ok = True
        except Refused:
            gen_ok = False
        print(f"partner 'a patch into a proof': generation {'ACCEPTED' if gen_ok else 'REFUSED'}, files then "
              f"{'DIFFER' if rc else 'AGREE'}")
        ok = ok and gen_ok and rc != 0
        # 10–11 (FS132-L2). the licence copy: one byte changed; absent
        lic = td / LICENCE_NAME
        b = lic.read_bytes()
        lic.write_bytes(b[:100] + bytes([b[100] ^ 1]) + b[101:])
        expect("the licence copy changed by one byte", check(outdir=td, quiet=True))
        lic.unlink()
        expect("the licence copy absent", check(outdir=td, quiet=True))
        lic.write_bytes(b)
        if check(outdir=td, quiet=True) != 0:
            print("SELF-TEST FAILED: the scratch copy does not pass after the licence plants were undone")
            return 1
        # 9. the clone at another commit
        clone2 = td / "clone"
        subprocess.run(["git", "init", "-q", str(clone2)], check=True)
        subprocess.run(["git", "-C", str(clone2), "-c", "user.name=x", "-c", "user.email=x@x", "commit", "-q",
                        "--allow-empty", "-m", "x"], check=True)
        expect("the clone at another commit", check(outdir=td, clone=clone2, quiet=True))
        shutil.rmtree(clone2)
    print(f"SELF-TEST {'OK' if ok else 'FAILED'}: 10 plants refused and 1 partner accepted" if ok else "SELF-TEST FAILED")
    return 0 if ok else 1


def main() -> int:
    if "--self-test" in sys.argv:
        return self_test()
    if "--check" in sys.argv:
        rc = check()
        rc2 = subprocess.run([sys.executable, str(ROOT / "tools/fs132_k1_port.py"), "--check"]).returncode
        try:
            rc3 = check_axioms_block(generate()[1])
        except Refused:
            rc3 = 1
        print("CHECK " + ("OK" if rc == 0 and rc2 == 0 and rc3 == 0 else "FAILED"))
        return 1 if rc or rc2 or rc3 else 0
    try:
        texts, p = generate()
    except Refused as e:
        print(f"FAIL: {e}")
        return 1
    if "--axioms-block" in sys.argv:
        sys.stdout.write(axioms_block(p))
        return 0
    if "--list" in sys.argv:
        tot = 0
        for name, module, _, _ in FILES:
            q = p[name]
            n = sum(b - a + 1 for a, b, *_ in q["copied"])
            tot += n
            print(f"{name}: {q['total']} declarations — copied {len(q['copied'])} ({n} lines), already ported "
                  f"{len(q['skipped'])}, left out {len(q['left'])}")
            for a, b, sh, kind in q["copied"]:
                print(f"    {a}–{b}\t{kind}\t{sh}")
            for a, b, sh in q["skipped"]:
                print(f"    {a}–{b}\t(ported)\t{sh}")
        print(f"total copied: {sum(len(p[f[0]]['copied']) for f in FILES)} declarations, {tot} source lines")
        return 0
    for module, text in texts.items():
        (OUTDIR / f"{module}.lean").write_text(text)
        print(f"wrote {module}.lean ({text.count(chr(10))} lines, sha256 {hashlib.sha256(text.encode()).hexdigest()[:16]})")
    lic = (CLONE / LICENCE_SRC).read_bytes()
    (OUTDIR / LICENCE_NAME).write_bytes(lic)
    print(f"wrote {LICENCE_NAME} ({len(lic)} bytes, sha256 {hashlib.sha256(lic).hexdigest()[:16]})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
