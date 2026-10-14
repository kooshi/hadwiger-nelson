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
FS131-IPB1's rules (lane B's remainder and lane C), each with its planted controls in `--self-test`:
  * CLASS_PARAMS (on the standing word of the coordinator's item 769 ruling 2): ANTIDIAG's pattern for other Mathlib
    classes — a projection takes its class's instance parameters as implicit arguments, which the erased print keeps;
    the one listed argument (`Algebra.algebraMap`'s `[Semiring A]`, position 3) is written `_` in both erased prints.
    Controls: another argument of the projection changed; the rule withdrawn;
  * COEFF (the coordinator's ruling of 2026-10-14): `Polynomial.coeff` is `R[X] → ℕ →₀ R` at the release's pin and
    `R[X] → ℕ → R` here, so `p.coeff n` is stored through the `Finsupp`'s coercion there; on the release's side the
    coercion `DFunLike.coe (ℕ →₀ R) … (Polynomial.coeff p) n` is written `Polynomial.coeff p n`, only at the
    declarations COEFF_LEMMAS lists, each then PIN-DIFFERENCE (COEFF).  Controls: another coercion head at a site; the
    rule withdrawn; a listed lemma taken out of the list;
  * STRIP (the ruled cascade of `frequencyLaw`, the coordinator's item 767 ruling (a) and item 768, and the closed-term
    adaptations, plan § 4.3): the table below, measured by the read-back, per declaration the binders and the heads
    whose applications carry inserted arguments.  Controls: one other binder inserted; a second `MeasurableInv`
    inserted; another argument changed at a `center` site; the map changed at a `ProbabilityMeasure.map` site; the rule
    withdrawn; a head listed where it does not occur.
A LABEL holding a `/` is a directory under the repository root (FS131-IPB1's labels are `data/fs131/ipb1/readback/…`).
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
    # FS131-IPB1: a label holding a `/` is a directory under the repository root (that job's prints live under
    # `data/fs131/ipb1/readback/`); a bare label is FS131-IPA1's, under BASE
    return ROOT / label if "/" in label else BASE / label


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
        # the release-side rewrites read a stored term; a level-one line (`levels=… | type = … | …`) is compared as it
        # stands, its differences read by hand
        if s.startswith("(") and STATE.get("coeff", True):
            s = coeff_rewrite(s)
        if s.startswith("(") and STATE.get("eqset", True):
            s = eqset_rewrite(s)
    return s


ANTIDIAG = "Finset.HasAntidiagonal.antidiagonal"
# CLASS_PARAMS (FS131-IPB1, on the standing word of the coordinator's item 769 ruling 2): a projection of a Mathlib
# class takes the class's instance parameters as implicit arguments, so the erased print keeps them, and the hierarchy's
# reflow between the pins reaches them by another instance path.  head -> the position of that one argument, written `_`
# in both erased prints.  `Algebra.algebraMap {R} {A} {_ : CommSemiring R} {_ : Semiring A} [self : Algebra R A]`: its
# `[Semiring A]` (position 3) is `CommSemiring.toSemiring L _` / `Ring.toSemiring _ _` at the release and
# `DivisionSemiring.toSemiring L _` here (seven lemmas and `realLine` of `NumberFields`).
CLASS_PARAMS = {"Algebra.algebraMap": 3}
# COEFF (the coordinator's ruling of 2026-10-14, by message): `coeff_rewrite` below, on the release's side; the
# constants it may touch, by name — each then classed PIN-DIFFERENCE (COEFF).
COEFF_HEAD = "DFunLike.coe"
COEFF_LEMMAS = {"§.AlgebraicCayley.reciprocal_denominator", "§.AlgebraicCayley.coeff_polyLinear"}
# EQSET (FS131-IPB1, on the coordinator's standing word of 2026-10-14: a Mathlib definition interposed between the pins
# that changes how an application is stored and not what it names): `s =ᵐ[μ] t` of SETS elaborates at v4.34.1 to
# `Filter.EventuallyEqSet l s t`, a definition new there (`Mathlib/Order/Filter/Defs.lean:310`: `EventuallyEq l (· ∈ s)
# (· ∈ t)`), and at v4.32.0 to `Filter.EventuallyEq l s t` at `Prop` (a set is `α → Prop`).  On the release's side
# `(c Filter.EventuallyEqSet [u]) α` is written `((c Filter.EventuallyEq [u,0]) α) (Sort 0)`, only at the declarations
# EQSET_LEMMAS lists, each then PIN-DIFFERENCE (EQSET); the release's kernel checks `EventuallyEqSet l s t =
# EventuallyEq l s t` by `rfl` in the level-one print (`ReleaseLevel1.lean`).
EQSET_HEAD = "Filter.EventuallyEqSet"
EQSET_LEMMAS = {"§.KernelCompact.exists_invariant_set"}
# ADAPTED_INSTANCE (FS131-IPB1, plan § 4.3): a statement adapted at an INSTANCE argument — `IsProbabilityMeasure (μ.map f)`
# supplied by an inlined `haveI := Measure.isProbabilityMeasure_map h` from a measurability the statement names.  The
# instance is a proof, so the erased prints agree and the verdict would be UP-TO-INSTANCES; each listed declaration is
# then flagged ADAPTED, and one listed that is not UP-TO-INSTANCES is fatal (the list is stale or the site moved).
ADAPTED_INSTANCE = {"§.BoundedMeasurable.covariance_mean_zero"}
# ADAPTED_ASCRIPTION (the coordinator's ruling of 2026-10-14, option (a)): a statement whose text elaborates in another
# order at this pin, given a type ascription that restores the release's stored term; flagged ADAPTED when the read-back
# reads IDENTICAL or UP-TO-INSTANCES, fatal otherwise.  Its control is the elaboration without the ascription, kept:
# `data/fs131/ipb1/readback/laneC2/compare-noascription.out` (DIFFERENT).
ADAPTED_ASCRIPTION = {"§.BoundedMeasurable.prod_act_project_lift"}
# FS131-IPD1's rules (lane D: the coordinator's rulings of 2026-10-14 on `SpectralMeasure`, FS131-IPD1 Amendment 1),
# each with its planted controls in `--self-test`:
#   * ADAPTED_VALUE (ruling (1)): a definition's VALUE adapted at one token — `CommutingSpectral.algebra_commRing`, its
#     `inferInstance` given the release's own instance `IsMulCommutative.instCommRing` with the `Prop` it asks proved
#     explicitly — flagged ADAPTED when the read-back reads IDENTICAL or UP-TO-INSTANCES (the proof erased), fatal
#     otherwise.  Its elaboration control (another instance path, `StarSubalgebra.commRingTopologicalClosure`, as the
#     whole value) is kept under the label and reads DIFFERENT;
#   * PROOF_ONLY (ruling (2)): a proof patch inside a definition's proof argument — `BoundedMeasurable.mulLp` — leaves
#     the definition IDENTICAL and only the named auxiliary differing (AUX-DIFFERS); anything else is fatal;
#   * PIN-DIFFERENCE (ruling (3), item 763 (3)'s class): `CommutingSpectral.algebra_commCStar`, same text and full type,
#     its value elaborated through this pin's instances (the release's `IsMulCommutative.instCommCStarAlgebra` is not
#     at v4.32.0); its note in PIN_NOTES;
#   * TARGETS_HERE (plan § 4.3): the two target statements, which no table entry may touch, must read IDENTICAL.
ADAPTED_VALUE = {"§.CommutingSpectral.algebra_commRing"}
PROOF_ONLY = {"§.BoundedMeasurable.mulLp": "§.BoundedMeasurable.mulLp._proof_1"}
TARGETS_HERE = {"§.proper_to_borel_weak", "§.Spectral.residual_fourier"}
# rule -> (the declarations it may touch, the note its PIN-DIFFERENCE carries); each rule's flag is STATE[rule.lower()]
RELEASE_REWRITES = {
    "COEFF": (COEFF_LEMMAS, "`Polynomial.coeff` is `R[X] → ℕ →₀ R` at the release's pin and `R[X] → ℕ → R` here; the "
                            "same coefficient"),
    "EQSET": (EQSET_LEMMAS, "`s =ᵐ[μ] t` of sets is `Filter.EventuallyEqSet` at the release's pin and `Filter.EventuallyEq` "
                            "at `Prop` here; the same proposition by definition"),
}
PIN_DIFFERENCE = {"§.Spectral.instCommGroupDiscreteE", "§.Spectral.instCommGroupDiscreteF",
                  "§.InvariantMean.instAddCommGroupPeriodGroup", "§.CommutingSpectral.algebra_commCStar"}
PIN_NOTES = {"§.CommutingSpectral.algebra_commCStar":
             "its value is elaborated through this pin's instances (the release's goes through "
             "`IsMulCommutative.instCommCStarAlgebra`, which v4.32.0 does not have); the text is the release's"}
RULED = {"§.DifferenceFourier.differenceLaw_probability": ["MeasurableMul₂", "MeasurableInv"]}
# label -> [(head constant, number of arguments here, position of the inserted argument)]
ADAPTED = {}
# STRIP (FS131-IPB1): the ruled cascade of `frequencyLaw` (the coordinator's item 767 ruling (a), and item 768) and the
# closed-term adaptations of `Outside/OAI158Centers` (plan § 4.3), MEASURED by that job's read-back of Centers: every
# declaration listed here, and no other, may differ from the release's erased print, and only by
#   * the binders it lists (one of each class, the release's own section variables `[MeasurableMul₂ G] [MeasurableInv
#     G]`, `Centers.lean:426`) — on the stored type's `∀`s and, for a definition, on its value's `fun`s; and
#   * the arguments a ruled head takes at this pin and not at the release's, at each application of a head it lists:
#     `frequencyLaw` and `center` take the two instances after `e` (positions 4, 5, at six or more arguments), and
#     `ProbabilityMeasure.map` takes the map's measurability (position 6 of exactly seven: `ProbabilityMeasure.map ν
#     {f} (f_aemble : AEMeasurable f ν)` at v4.32.0, `ProbabilityMeasure.map ν f` at v4.34.1).
# Each listed head must occur in the declaration's prints.  Verdict RULED where a binder or a cascade head is listed
# (the release's statement with exactly the ruled binders and arguments inserted), ADAPTED where only
# `ProbabilityMeasure.map` is (the release's print once the inserted measurability is removed).
CASCADE_HEADS = {"§.CosetCenter.Embedding.frequencyLaw": (6, False, (4, 5)),
                 "§.CosetCenter.Embedding.center": (6, False, (4, 5)),
                 "MeasureTheory.ProbabilityMeasure.map": (7, True, (6,)),
                 # `Outside/OAI158RelativeCenters`: the two definitions whose values name `center` take the two
                 # instances after `[MeasurableSpace G]` (`{Y G} [MeasurableSpace Y] [CommGroup G] [MeasurableSpace G]`,
                 # positions 5, 6, at seven or more arguments; `RelativeCenters.lean:214–215`)
                 "§.RelativeCenters.centerMap": (7, False, (5, 6)),
                 "§.RelativeCenters.centerKernel": (7, False, (5, 6))}
_MM = ["MeasurableMul₂", "MeasurableInv"]
_FL, _CE, _PM = "§.CosetCenter.Embedding.frequencyLaw", "§.CosetCenter.Embedding.center", \
    "MeasureTheory.ProbabilityMeasure.map"
_CM, _CK = "§.RelativeCenters.centerMap", "§.RelativeCenters.centerKernel"
STRIP = {
    # the ruled definitions (Centers.lean:496–501 and the definition after it): the two binders
    "§.CosetCenter.Embedding.frequencyLaw": (_MM, []),
    "§.CosetCenter.Embedding.center": (_MM, [_FL]),
    # the three whose `omit … in` was dropped (`drop_omit` 578, 600, 615): the two binders
    "§.CosetCenter.Embedding.center_mem_coset": (_MM, [_CE]),
    "§.CosetCenter.Embedding.quotient_center": (_MM, [_CE]),
    "§.CosetCenter.Embedding.center_mem_ordinary_iff": (_MM, [_CE]),
    # statements that name `frequencyLaw` or `center` and already had the two binders at the release
    "§.CosetCenter.Embedding.frequencyLaw_measure": ([], [_FL]),
    "§.CosetCenter.Embedding.measurable_frequencyLaw": ([], [_FL]),
    "§.CosetCenter.Embedding.frequencyLaw_shift": ([], [_FL, _PM]),
    "§.CosetCenter.Embedding.measurable_center": ([], [_CE]),
    "§.CosetCenter.Embedding.center_mul_j": ([], [_CE]),
    "§.CosetCenter.Embedding.center_eq_of_mem_coset": ([], [_CE]),
    "§.CosetCenter.Embedding.center_eq_iff": ([], [_CE]),
    "§.CosetCenter.Embedding.preimage_center_singleton": ([], [_CE]),
    "§.CosetCenter.Embedding.measurable_center_fixed": ([], [_CE]),
    "§.CosetCenter.Embedding.frequencyLaw_equiv": ([], [_FL, _PM]),
    "§.CosetCenter.Embedding.center_equivariant": ([], [_CE, _PM]),
    # closed-term adaptations only (`adaptations` 350, 371)
    "§.Location.center_translate": ([], [_PM]),
    "§.Location.center_orthogonal": ([], [_PM]),
    # `Outside/OAI158RelativeCenters` (FS131-IPB1, measured by its read-back `data/fs131/ipb1/readback/laneB`):
    # the two definitions whose values name `center`, gaining the two binders through variable inclusion
    "§.RelativeCenters.centerMap": (_MM, [_CE]),
    "§.RelativeCenters.centerKernel": (_MM, [_CE]),
    # the one whose `omit … in` was dropped (`drop_omit` 343)
    "§.RelativeCenters.centerMap_mem_ordinary_iff": (_MM, [_CM]),
    # statements that name `center`, `centerMap` or `centerKernel` and already had the two binders
    "§.CosetCenter.Embedding.finite_uniform_centers": ([], [_CE]),
    "§.CosetCenter.Embedding.center_law_ordinary": ([], [_CE, _PM]),
    "§.RelativeCenters.positive_mass_finite_centers": ([], [_CE]),
    "§.RelativeCenters.measurable_centerMap": ([], [_CM]),
    "§.RelativeCenters.centerMap_law_ordinary": ([], [_CM]),
    "§.RelativeCenters.centerMap_equivariant": ([], [_CM]),
    "§.RelativeCenters.measurable_fiberCenter": ([], [_CE]),
    "§.RelativeCenters.centerKernel_markov": ([], [_CK]),
    "§.RelativeCenters.centerKernel_apply": ([], [_CK, _CE]),
    "§.RelativeCenters.condDistrib_centerMap": ([], [_CM, _CK]),
    "§.RelativeCenters.centerKernel_comp_map": ([], [_CK, _CM]),
    "§.RelativeCenters.finite_center_reduction": ([], [_CM]),
}
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
    if ANTIDIAG not in s and not any(h in s for h in CLASS_PARAMS):
        return s
    t = parse(s)
    assert unparse(t) == s

    def f(h, args):
        if isinstance(h, list) and len(h) == 3 and h[0] == "c" and h[1] == ANTIDIAG and len(args) >= 2:
            args = args[:1] + ["_"] + args[2:]
        if isinstance(h, list) and len(h) == 3 and h[0] == "c" and h[1] in CLASS_PARAMS:
            i = CLASS_PARAMS[h[1]]
            if len(args) > i:
                args = args[:i] + ["_"] + args[i + 1:]
        return args
    return unparse(rewrite(t, f))


def eqset_rewrite(s):
    """EQSET (above): on the release's side, the head `Filter.EventuallyEqSet.{u} α` is written
    `Filter.EventuallyEq.{u,0} α (Sort 0)`, wherever it is applied to its type argument."""
    key = f"(c {EQSET_HEAD} ["
    if key not in s:
        return s
    t = parse(s)
    assert unparse(t) == s

    def go(x):
        if isinstance(x, str):
            return x
        if is_app(x):
            h, args = spine(x)
            h, args = go(h), [go(a) for a in args]
            if isinstance(h, list) and len(h) == 3 and h[:2] == ["c", EQSET_HEAD] and args:
                lv = h[2][1:-1]
                return build(["c", "Filter.EventuallyEq", f"[{lv},0]"], [args[0], ["Sort", "0"]] + args[1:])
            return build(h, args)
        return [go(y) for y in x]
    return unparse(go(t))


def coeff_rewrite(s):
    """COEFF (FS131-IPB1, the coordinator's ruling of 2026-10-14): on the RELEASE's side only, every
    `DFunLike.coe (Finsupp ℕ R) ℕ _ _ (Polynomial.coeff R _ p) n` (six arguments; the first a `Finsupp` over `Nat`;
    the fifth `Polynomial.coeff` with three) is written `Polynomial.coeff R _ p n`.  Mathlib's `Polynomial.coeff` is
    `R[X] → ℕ →₀ R` at v4.34.1 and `R[X] → ℕ → R` at v4.32.0 (`Mathlib/Algebra/Polynomial/Basic.lean` l. 562 there,
    l. 563 here), so `p.coeff n` is stored through the `Finsupp`'s coercion there and as an application here; both name
    the coefficient of `X ^ n`."""
    if COEFF_HEAD not in s or "(c Polynomial.coeff [" not in s:
        return s
    t = parse(s)
    assert unparse(t) == s

    def site(h, args):
        if not (isinstance(h, list) and len(h) == 3 and h[0] == "c" and h[1] == COEFF_HEAD and len(args) == 6):
            return False
        th, targs = spine(args[0])
        ih, iargs = spine(args[4])
        return (isinstance(th, list) and th[:2] == ["c", "Finsupp"] and len(targs) >= 1
                and targs[0] == ["c", "Nat", "[]"]
                and isinstance(ih, list) and ih[:2] == ["c", "Polynomial.coeff"] and len(iargs) == 3)

    def go(x):
        if isinstance(x, str):
            return x
        if is_app(x):
            h, args = spine(x)
            h, args = go(h), [go(a) for a in args]
            # the coercion of `Polynomial.coeff R _ p` applied to `n` is the application `Polynomial.coeff R _ p n`
            return [args[4], args[5]] if site(h, args) else build(h, args)
        return [go(y) for y in x]
    return unparse(go(t))


def strip_args(s, heads):
    """STRIP: at every application of a head of `heads` (head -> (number of arguments, exact?, positions)), the
    arguments at those positions removed.  -> (print, {head: applications hit})."""
    t = parse(s)
    assert unparse(t) == s
    hits = {}

    def go(x):
        if isinstance(x, str):
            return x
        if is_app(x):
            h, args = spine(x)
            h, args = go(h), [go(a) for a in args]
            if isinstance(h, list) and len(h) == 3 and h[0] == "c" and h[1] in heads:
                nargs, exact, pos = heads[h[1]]
                if (len(args) == nargs) if exact else (len(args) >= nargs):
                    hits[h[1]] = hits.get(h[1], 0) + 1
                    args = [a for i, a in enumerate(args) if i not in pos]
            return build(h, args)
        return [go(y) for y in x]
    return unparse(go(t)), hits


def strip_check(r, o, lab):
    """STRIP's check for one listed declaration: (ok, why)."""
    binders, hl = STRIP[lab]
    if r["kind"] != o["kind"] or r["levels"] != o["levels"]:
        return False, "STRIP refused: kind or universe parameters differ"
    heads = {h: CASCADE_HEADS[h] for h in hl}
    hits = {}
    for er, pfx in (("etype", "pi."), ("evalue", "lam.")):
        if r[er] is None and o[er] is None:
            continue
        if r[er] is None or o[er] is None:
            return False, f"STRIP refused: no {er} at one pin"
        s, h = strip_args(o[er], heads)
        for k, v in h.items():
            hits[k] = hits.get(k, 0) + v
        if binders:
            s = strip_binders(s, binders, pfx)
        if s != r[er]:
            return False, f"STRIP refused at the {er} (binders {binders}, heads {hl})"
    if set(hits) != set(hl):
        return False, f"STRIP refused: a listed head does not occur ({sorted(set(hl) - set(hits))})"
    return True, f"binders {binders or 'none'}; inserted arguments at {', '.join(f'{k} ×{v}' for k, v in sorted(hits.items())) or 'none'}"


def strip_binders(s, classes, pfx="pi."):
    """Remove one top-level binder of each class in `classes` from an erased print; renumber `@k`.  None if a listed
    class is not found exactly once or a removed binder is referenced.  `pfx` "lam." reads a definition's value."""
    t = parse(s)
    assert unparse(t) == s
    want, removed, depth = list(classes), [], 0
    node, path = t, []
    while isinstance(node, list) and node and isinstance(node[0], str) and node[0].startswith(pfx):
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
    # COEFF, EQSET: the constants whose release print each rewrite changed (the prints read once more without it)
    touched_by = {}
    for rule in RELEASE_REWRITES:
        flag = rule.lower()
        saved = STATE.get(flag, True)
        STATE[flag] = False
        try:
            rel_raw, _ = rb.load(rel_text, renamed)
        finally:
            STATE[flag] = saved
        for lab, d in rel.items():
            if lab in rel_raw and any(d[f] != rel_raw[lab][f] for f in ("type", "etype", "value", "evalue")):
                touched_by.setdefault(lab, set()).add(rule)
        for lab in sorted(RELEASE_REWRITES[rule][0] & {t[1] for t in table}):
            if rule not in touched_by.get(lab, set()) and STATE.get(flag, True):
                fatal.append(f"{rule} lists {lab}, which the rewrite does not touch (the list is stale)")
    out = []
    for (cls, lab, kind, verdict, there, here, why) in table:
        r, o = rel.get(lab), our.get(lab)
        owner = next((p for p in PIN_DIFFERENCE if lab == p or lab.startswith(p + ".")), None)
        rules = touched_by.get(lab)
        if rules:
            unlisted = sorted(x for x in rules if lab not in RELEASE_REWRITES[x][0])
            if unlisted:
                verdict, why = "DIFFERENT", f"{', '.join(unlisted)} rewrote a constant it does not list"
            elif verdict in ("IDENTICAL", "UP-TO-INSTANCES"):
                verdict, why = "PIN-DIFFERENCE", "; ".join(f"{x}: {RELEASE_REWRITES[x][1]}" for x in sorted(rules))
        elif owner is not None and verdict not in ("IDENTICAL", "UP-TO-INSTANCES"):
            ro, oo = rel.get(owner), our.get(owner)
            if ro and oo and ro["kind"] == oo["kind"] == "def" and ro["levels"] == oo["levels"] \
                    and ro["type"] == oo["type"]:
                verdict, why = "PIN-DIFFERENCE", PIN_NOTES.get(owner, "`Monoid`'s parents changed between the pins") + \
                    f"; {owner}'s type is identical"
            else:
                verdict, why = "DIFFERENT", f"PIN-DIFFERENCE refused: {owner}'s kind, levels or full type differ"
        elif lab in STRIP and verdict == "DIFFERENT":
            good, note = strip_check(r, o, lab)
            binders, hl = STRIP[lab]
            cls_ = "RULED" if binders or any(h != _PM for h in hl) else "ADAPTED"
            verdict, why = (cls_, note) if good else ("DIFFERENT", note)
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
    for k, t in enumerate(out):
        if t[1] in ADAPTED_ASCRIPTION:
            if t[3] in ("IDENTICAL", "UP-TO-INSTANCES"):
                out[k] = t[:3] + ("ADAPTED", t[4], t[5], f"ADAPTED_ASCRIPTION: an ascription restores the release's "
                                  f"stored term; the read-back reads {t[3]}")
            else:
                fatal.append(f"ADAPTED_ASCRIPTION lists {t[1]}, which reads {t[3]}")
        if t[1] in ADAPTED_INSTANCE:
            if t[3] == "UP-TO-INSTANCES":
                out[k] = t[:3] + ("ADAPTED", t[4], t[5], "ADAPTED_INSTANCE: an instance argument supplied from the "
                                  "statement's own measurability; a proof, erased, so the erased prints agree")
            else:
                fatal.append(f"ADAPTED_INSTANCE lists {t[1]}, which reads {t[3]}, not UP-TO-INSTANCES")
        if t[1] in ADAPTED_VALUE:
            if t[3] in ("IDENTICAL", "UP-TO-INSTANCES"):
                out[k] = t[:3] + ("ADAPTED", t[4], t[5], f"ADAPTED_VALUE: the release's own instance named with the Prop "
                                  f"it asks proved explicitly; the read-back reads {t[3]}")
            else:
                fatal.append(f"ADAPTED_VALUE lists {t[1]}, which reads {t[3]}")
    vmap = {t[1]: t[3] for t in out}
    for d, aux in PROOF_ONLY.items():
        if d in vmap or aux in vmap:
            if vmap.get(d) != "IDENTICAL" or vmap.get(aux) != "AUX-DIFFERS":
                fatal.append(f"PROOF_ONLY: {d} reads {vmap.get(d)} and {aux} {vmap.get(aux)}, not IDENTICAL and "
                             "AUX-DIFFERS")
    for tg in sorted(TARGETS_HERE):
        if tg in vmap and vmap[tg] != "IDENTICAL":
            fatal.append(f"TARGETS_HERE: the target {tg} reads {vmap[tg]}, not IDENTICAL")
    for t in out:
        if t[1] in STRIP and t[3] in ("IDENTICAL", "UP-TO-INSTANCES"):
            fatal.append(f"STRIP lists {t[1]}, which does not differ (the list is stale)")
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

    def expect(what, text=None, renamed=None, rec=None, want_fatal=None, rel_planted=None):
        nonlocal ok, n
        n += 1
        _, f, ft, _ = ruled_compare(rel_text if rel_planted is None else rel_planted,
                                 our_text if text is None else text, renamed=renamed, quiet=True,
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
    # CLASS_PARAMS (FS131-IPB1): another argument of the projection changed must be refused, and the rule withdrawn
    def plant_arg(src_lines, lab, head, pos, new, field="etype "):
        i, j = block(lab) if src_lines is lines else rel_block(lab)
        out = src_lines[:]
        k = next(x for x in range(i + 1, j) if out[x][7:13] == field)
        t = parse(out[k][15:])
        done = [0]

        def go(x):
            if isinstance(x, str):
                return x
            if is_app(x):
                h, args = spine(x)
                h, args = go(h), [go(a) for a in args]
                if not done[0] and isinstance(h, list) and h[:2] == ["c", head] and len(args) > pos:
                    done[0] = 1
                    if callable(new):
                        return new(h, args)
                    args = args[:pos] + [new] + args[pos + 1:]
                return build(h, args)
            return [go(y) for y in x]
        out[k] = out[k][:15] + unparse(go(t))
        assert done[0], (lab, head)
        return "\n".join(out)

    rel_lines = rel_text.splitlines()

    def rel_block(lab):
        i = next(k for k, ln in enumerate(rel_lines) if ln.startswith(f"DUMP {lab} : "))
        j = i + 1
        while j < len(rel_lines) and rel_lines[j].startswith("DUMP   "):
            j += 1
        return i, j

    for head, pos in sorted(CLASS_PARAMS.items()):
        users = [lab for lab, d in rel.items() if f"(c {head} [" in (d["etype"] or "") and not rb.AUXNAME.search(lab)]
        if not users:
            continue
        u0 = users[0]
        expect(f"CLASS_PARAMS {head}: its argument {pos - 1} changed ({u0})",
               plant_arg(lines, u0, head, pos - 1, "(c Planted.instance [])"))
        saved_cp = dict(CLASS_PARAMS)
        CLASS_PARAMS.clear()
        try:
            expect(f"CLASS_PARAMS {head} withdrawn ({len(users)} users)")
        finally:
            CLASS_PARAMS.update(saved_cp)
    # COEFF (FS131-IPB1): another coercion head at a listed site, the rule withdrawn, a listed lemma unlisted
    coeff_here = sorted(COEFF_LEMMAS & set(rel))
    if coeff_here:
        c0 = coeff_here[0]
        # the first coercion of the release's print whose type is a `Finsupp` gets another head (a coercion that is
        # not the one the rule names)
        i, j = rel_block(c0)
        k = next(x for x in range(i + 1, j) if rel_lines[x][7:13] == "etype ")
        t = parse(rel_lines[k][15:])
        hit = [0]

        def go2(x):
            if isinstance(x, str):
                return x
            if is_app(x):
                h, args = spine(x)
                h, args = go2(h), [go2(a) for a in args]
                if not hit[0] and isinstance(h, list) and h[:2] == ["c", COEFF_HEAD] and len(args) == 6 and \
                        isinstance(args[0], list) and spine(args[0])[0][:2] == ["c", "Finsupp"]:
                    hit[0] = 1
                    return build(["c", COEFF_HEAD + "'", h[2]], args)
                return build(h, args)
            return [go2(y) for y in x]
        out = rel_lines[:]
        out[k] = out[k][:15] + unparse(go2(t))
        assert hit[0], c0
        planted_rel = "\n".join(out)
        expect(f"COEFF: another coercion head at a site ({c0})", rel_planted=planted_rel)
        STATE["coeff"] = False
        try:
            expect(f"COEFF withdrawn ({len(coeff_here)} lemmas)")
        finally:
            STATE["coeff"] = True
        saved_cl = set(COEFF_LEMMAS)
        COEFF_LEMMAS.discard(c0)
        try:
            expect(f"COEFF: {c0} taken out of the list")
        finally:
            COEFF_LEMMAS.clear()
            COEFF_LEMMAS.update(saved_cl)
    # EQSET (FS131-IPB1): another head at a site, the rule withdrawn, a listed lemma taken out of the list
    eq_here = sorted(EQSET_LEMMAS & set(rel))
    if eq_here:
        e0 = eq_here[0]
        i, j = rel_block(e0)
        k = next(x for x in range(i + 1, j) if rel_lines[x][7:13] == "etype ")
        out = rel_lines[:]
        assert f"(c {EQSET_HEAD} [" in out[k], e0
        out[k] = out[k].replace(f"(c {EQSET_HEAD} [", f"(c {EQSET_HEAD}' [", 1)
        expect(f"EQSET: another head at a site ({e0})", rel_planted="\n".join(out))
        STATE["eqset"] = False
        try:
            expect(f"EQSET withdrawn ({len(eq_here)} lemmas)")
        finally:
            STATE["eqset"] = True
        saved_el = set(EQSET_LEMMAS)
        EQSET_LEMMAS.discard(e0)
        try:
            expect(f"EQSET: {e0} taken out of the list")
        finally:
            EQSET_LEMMAS.clear()
            EQSET_LEMMAS.update(saved_el)
    # ADAPTED_INSTANCE (FS131-IPB1): a listed declaration that is not UP-TO-INSTANCES must be refused
    ai_here = sorted((ADAPTED_INSTANCE | ADAPTED_ASCRIPTION) & set(rel))
    if ai_here:
        our, _ = rb.load(our_text, here=True)
        ident = next(lab for lab, d in rel.items() if lab not in ai_here and d["kind"] == "theorem"
                     and our.get(lab) and our[lab]["type"] == d["type"])
        ADAPTED_INSTANCE.add(ident)
        try:
            expect(f"ADAPTED_INSTANCE lists an IDENTICAL declaration ({ident})", want_fatal="ADAPTED_INSTANCE")
        finally:
            ADAPTED_INSTANCE.discard(ident)
    # STRIP (FS131-IPB1): each part of the check must refuse what the ruling does not cover
    strip_here = [lab for lab in STRIP if lab in rel]
    if strip_here:
        def raw(h):
            return h if not h.startswith("§.") else "HadwigerNelson.Outside.OAI158." + h[2:]
        bmem = next(lab for lab in strip_here if STRIP[lab][0] and rel[lab]["kind"] == "theorem")
        i, j = block(bmem)
        k = next(x for x in range(i + 1, j) if lines[x][7:13] == "etype ")
        first = re.search(r"\(pi\.d ", lines[k])
        for what, ins in (("one other binder inserted", "(pi.c inst ((c MeasurableSpace [(p u_1)]) @0) "),
                          ("a second MeasurableInv binder inserted",
                           "(pi.c inst ((((c MeasurableInv [(p u_1)]) @0) _) _) ")):
            out = lines[:]
            out[k] = out[k][:first.start()] + ins + out[k][first.start():] + ")"
            expect(f"STRIP {bmem}: {what}", "\n".join(out))
        amem = next(lab for lab in strip_here if not STRIP[lab][0] and _CE in STRIP[lab][1])
        expect(f"STRIP {amem}: another argument (3) changed at a `center` site",
               plant_arg(lines, amem, raw(_CE), 3, "(c Planted.embedding [])"))
        pmem = next(lab for lab in strip_here if STRIP[lab][1] == [_PM])
        expect(f"STRIP {pmem}: the map (argument 5) changed at a `ProbabilityMeasure.map` site",
               plant_arg(lines, pmem, _PM, 5, "(c Planted.map [])"))
        saved_st = dict(STRIP)
        STRIP.clear()
        try:
            expect(f"STRIP withdrawn ({len(strip_here)} declarations)")
        finally:
            STRIP.update(saved_st)
        lmem = next(lab for lab in strip_here if STRIP[lab] == ([], [_CE]))
        STRIP[lmem] = ([], [_CE, _PM])
        try:
            expect(f"STRIP {lmem}: a head listed that does not occur in it")
        finally:
            STRIP[lmem] = ([], [_CE])
    # FS131-IPD1's rules: each refuses what its ruling does not cover
    for lab in sorted(ADAPTED_VALUE & set(rel)):
        expect(f"ADAPTED_VALUE: {lab}'s value changed outright", plant(lab, "(c IsMulCommutative.instCommRing [",
               "(c Planted.instCommRing [", fields=("value ", "evalue")), want_fatal="ADAPTED_VALUE")
    for d, aux in sorted(PROOF_ONLY.items()):
        if d in rel:
            expect(f"PROOF_ONLY: {d}'s value changed", plant(d, "(c MeasureTheory.MemLp.toLp [",
                   "(c Planted.toLp [", fields=("value ", "evalue")), want_fatal="PROOF_ONLY")
        if aux in rel:
            saved_po = dict(PROOF_ONLY)
            PROOF_ONLY[d] = d + "._proof_99"
            try:
                expect(f"PROOF_ONLY: the auxiliary named wrongly ({d}._proof_99)", want_fatal="PROOF_ONLY")
            finally:
                PROOF_ONLY.clear()
                PROOF_ONLY.update(saved_po)
    for tg in sorted(TARGETS_HERE & set(rel)):
        expect(f"TARGETS_HERE: {tg}'s full type changed in an instance argument",
               plant(tg, "(c Nat.instMulZeroClass [", "(c Planted.instMulZeroClass [", fields=("type  ",))
               if "(c Nat.instMulZeroClass [" in rel[tg]["type"] else
               plant(tg, "(c Complex [", "(c Planted.Complex [", fields=("type  ",)), want_fatal="TARGETS_HERE")
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
