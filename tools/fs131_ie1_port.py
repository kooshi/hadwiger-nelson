#!/usr/bin/env python3
"""FS131-IE1: the port of the entropy base of `[OAIMath2026]` family 015 — the generator and its checks.

Generates three modules under `Proofs/HadwigerNelson/Outside/` from the clone of the release (github.com/openai/math)
at the audited commit — `OAI015Shannon` (the release's `PrimePackets/ShannonEntropy.lean`, whole), `OAI015Mixtures`
(`PrimePackets/EntropyMixtures.lean`, whole) and `OAI015Maximal` (three declarations of `PrimePackets/InverseEntropy.lean`,
then `DukePrimeDegree/Dynamics/HopfMaximal.lean` and `MaximalOccupation.lean`, whole); and, for FS131-IP23 (lanes P3
and P2), `OAI015Generating` (the nine files of `PrimePackets/` from `ConditionalShannon.lean` to
`EntropyGeneratingSupremum.lean`, whole) and `OAI015ErgodicDecomposition` (line ranges of `PrimePackets/KernelEntropy.lean`
and `PrimePackets/ErgodicDecomposition.lean`, RANGES).  Nothing is retyped: every declaration is copied by line range.  The kernel then checks every proof in this library; no axiom enters.
(`tools/fs132_i2_port.py` is the pattern, and is not edited; that one selects a cone inside each file from the
release's compiled constants, this one copies whole files — and, for the one partial file, the declarations SELECT
names — so it reads the declarations off the text: a declaration starts at a keyword in column 0 and runs to the next
line that starts in column 0.)

What this script changes in the copied text, and nothing else:
  1. the namespaces: `OAI` -> `HadwigerNelson.Outside`; `PrimeDegreePackets` and `DukePrimeDegree` (inside it) ->
     `OAI015`, so every ported name is `HadwigerNelson.Outside.OAI015.<the release's name>`; a name that two of the
     ported declarations would share is refused; a `namespace … end` pair left with nothing inside is left out;
  2. the `import` lines: each module imports the Mathlib modules of MATHLIB (found by measurement, each list's reason
     beside it) and this job's modules of its `ours`, never `Mathlib` whole and never a module of the release;
  3. the `open` lines: a namespace that does not exist under those imports is taken out of its `open` line (DROP_OPEN;
     `open` of a namespace that is not there is an error, and no name of the text can have resolved through one that
     the text still elaborates without), and so is `PrimeDegreePackets` where it is opened inside `DukePrimeDegree`
     (the two are one namespace here); an `open` line left with no namespace is left out;
  4. a source address in every declaration's docstring (`File.lean:line` at the commit): a docstring is added where
     the release has none (this library's `linter.missingDocs`), and prefixed where it has one;
  5. the PATCHES below — each a token of a PROOF that does not elaborate at this library's pin (Lean v4.32.0, Mathlib
     v4.32.0; the release is at v4.34.1), with its reason.  The script refuses a patch that touches a definition, an
     instance whose value is a term, or a theorem's statement (anything before the declaration's top-level `:=`);
  6. for the partial file, declarations outside SELECT are left out; for a file in RANGES, the lines outside its ranges
     (FS131-IP23), the declarations inside them checked against RANGE_DECLS.
A declaration's `omit … in` lines above it and an attribute block alone on a line above its keyword are part of it
(FS131-IP23): copied with it, scanned, and refused to every patch, as its statement is.  Each module's header names the
job that added it (JOB).
Every `instance` of the text must be in exactly one of SCOPED (on a type that is Mathlib's: the keyword `scoped` is
added, `LEAN.md` § Assumptions) or GLOBAL_INSTANCES (on a term whose head is the release's own definition), or the
script refuses.

Before anything is generated the text to be copied is SCANNED for anything that runs code while a file elaborates
(`#eval`, `run_cmd`/`run_elab`/`run_meta`, `initialize`, `unsafe`, `IO.`, a `macro`/`elab`/`syntax`/`macro_rules`/
`elab_rules` declaration, `#`-commands, `set_option`, `attribute`, `deriving`, `notation`, `open … in` are refused as
unclassified lines or hits): a hit refuses the generation.  (The planner's `tools/fs131_kn6_release_copy.py scan` is
the same list on a scratch copy; this is the generator's own, on exactly the lines it copies.)

The release's licence text travels with the ported modules: `Outside/OAIMath2026-LICENSE.txt` (written by FS132-L2)
must be the clone's `LICENSE` byte for byte; `--check` compares, every generated header names it.

Usage:
  tools/fs131_ie1_port.py                 write the modules
  tools/fs131_ie1_port.py --check         regenerate in memory, compare with the files and the licence copy; exit 1 on
                                          any difference
  tools/fs131_ie1_port.py --self-test     plant faults and require each refused, and the unplanted check to pass
  tools/fs131_ie1_port.py --list          per module: every copied declaration with its kind and source lines
  tools/fs131_ie1_port.py --names         one line per ported declaration: module, kind, full name here, release name
  tools/fs131_ie1_port.py --axioms-block  the audit's records for these modules (a draft for the landing)
  tools/fs131_ie1_port.py --mathlib-whole write the modules with `import Mathlib` in place of the MATHLIB lists (to
                                          measure them; never committed: `--check` fails on such files)
"""
import hashlib
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
CLONE = pathlib.Path("/home/kooshi/source/math")
COMMIT = "adc7f1241b42e322a6451854ab7e4b4c146bf78a"
SRC = "lean/OAI/NumberTheory/"
OUTDIR = ROOT / "Proofs/HadwigerNelson/Outside"
PFX = "Proofs.HadwigerNelson.Outside."
NS_ROOT = ("OAI", "HadwigerNelson.Outside")
NS_MAP = {"PrimeDegreePackets": "OAI015", "DukePrimeDegree": "OAI015"}
NS_NEW = "HadwigerNelson.Outside.OAI015"
LICENCE_NAME, LICENCE_SRC = "OAIMath2026-LICENSE.txt", "LICENSE"

SHANNON = "PrimePackets/ShannonEntropy.lean"
MIXTURES = "PrimePackets/EntropyMixtures.lean"
INVERSE = "PrimePackets/InverseEntropy.lean"
HOPF = "DukePrimeDegree/Dynamics/HopfMaximal.lean"
OCCUPATION = "DukePrimeDegree/Dynamics/MaximalOccupation.lean"
# FS131-IP23: lane P2 (the ergodic decomposition) and lane P3 (the generating-sequence theorem)
KERNEL = "PrimePackets/KernelEntropy.lean"
ERGDEC = "PrimePackets/ErgodicDecomposition.lean"
GENERATING = ["PrimePackets/" + f + ".lean" for f in (
    "ConditionalShannon", "ConditionalObservations", "ObservationRefinement", "ConditionalOrbitEntropy",
    "ObservationConditionalProbability", "ObservationSigmaAlgebra", "ConditionalProbabilityExpectation",
    "GeneratingObservationEntropy", "EntropyGeneratingSupremum")]

# module -> (this job's modules it imports, [release file, ...] in order, what it holds)
MODULES = [
    ("OAI015Shannon", [], [SHANNON],
     "the Shannon entropy of a finite distribution and of a finite-valued observation (`finiteShannon`, "
     "`observationEntropy`), its subadditivity under joins (`observationEntropy_joint_le`) and its invariance under a "
     "measure-preserving map, the names of an orbit (`orbitName`), the subadditivity of the entropy of names "
     "(`orbitEntropy_subadditive`), the rate as an infimum and as a limit (`observationEntropyRate`, "
     "`tendsto_observationEntropyRate`), the entropy of a map as a supremum over finite partitions (`measureEntropy`), "
     "and lower bounds from small atoms"),
    ("OAI015Mixtures", ["OAI015Shannon"], [MIXTURES],
     "entropy under mixtures: the rate of a finite convex combination of invariant measures is the combination of the "
     "rates (`observationEntropyRate_finite_mixture`), the cells of a kernel (`kernelCell`), and the mixture lemma — a "
     "kernel mixture of invariant measures of entropy zero has entropy zero (`measureEntropy_kernel_zero`)"),
    ("OAI015Maximal", [], [INVERSE, HOPF, OCCUPATION],
     "the maximal ergodic inequality in its finite Hopf form (`finite_hopf_maximal`), the count of visits of an orbit "
     "to a set (`visitCount`), and the bound `δ · μ {x | some time n has more than δ n visits to A} ≤ μ A` "
     "(`excessiveOccupation_measure_bound`) with its almost-sure consequence along decreasing sets"),
    ("OAI015Generating", ["OAI015Mixtures"], GENERATING,
     "conditional Shannon entropy of finite observations and its chain rule, submodularity and refinement inequalities "
     "(`conditionalObservationEntropy`, `observationEntropy_submodular`), the one-step comparison of entropy rates "
     "(`observationEntropyRate_le_add_conditional`), conditional probabilities of a finite observation as conditional "
     "expectations on the σ-algebra it generates (`observationSigma`, `observationConditionalProbability_ae_eq_condExp`), "
     "their convergence along an increasing generating sequence (`conditionalObservationEntropy_tendsto_zero`), and the "
     "entropy of a map as the supremum of the rates of a generating sequence of finite observations "
     "(`measureEntropy_eq_iSup_generating`)"),
    ("OAI015ErgodicDecomposition", [], [KERNEL, ERGDEC],
     "the fixed point in the closed convex hull of an orbit of a unitary representation "
     "(`fixedPoint_mem_closed_convex_orbit`), the σ-algebra of the sets fixed by every element of a group acting "
     "(`actionInvariantSigma`), invariant representatives and orbit averages for a countable group "
     "(`exists_pointwise_invariant_representative`, `exists_invariant_orbit_average_limit`), ergodicity from limits of "
     "orbit averages of indicators (`ergodicSMul_of_orbit_indicator_limits`), the invariance of the conditional-"
     "expectation kernel on an invariant σ-algebra (`condExpKernel_invariant`), and the ergodic decomposition in "
     "canonical form for a countable group acting on a standard Borel space (`action_ergodic_decomposition`)"),
]
# the job that added each module (its header names it); a module not listed is FS131-IE1's
JOB = {"OAI015Generating": "FS131-IP23", "OAI015ErgodicDecomposition": "FS131-IP23"}
# a partial file: release file -> the names copied, in source order; every other declaration of it is left out
SELECT = {INVERSE: ["visitCount", "visitCount_cast", "measurable_visitCount"]}
# a file copied by line ranges (FS131-IP23): release file -> [(first, last), ...], 1-based inclusive, in source order,
# and the declarations those ranges hold, in source order (refused unless exactly these).  Every line of a range is
# copied as the whole-file parser classifies it; a range that begins or ends inside a declaration, a docstring or a
# module docstring is refused.  Each range's reason is RANGE_WHY's.  The cut is FS131-KN7's trial (its § Stage 4): the
# release's ll. 48–219 of KernelEntropy (the entropy of kernels) and ll. 180–505 of ErgodicDecomposition (the packet
# applications) are not read by the decomposition.
RANGES = {
    KERNEL: [(4, 47), (220, 558)],
    ERGDEC: [(4, 179), (506, 509)],
}
RANGE_DECLS = {
    KERNEL: ["fixedPoint_mem_closed_convex_orbit", "exists_convex_orbit_approximants", "actionInvariantSigma",
             "actionInvariantSigma_le", "measurable_actionInvariantSigma", "exists_pointwise_invariant_representative",
             "orbitConvexHull", "orbitConvexHull_measurable", "orbitConvexHull_interval", "orbitConvexHull_integral",
             "orbitConvexHull_setIntegral", "lp_convex_orbit_representative", "exists_invariant_orbit_average_limit",
             "orbitConvexHull_aeSetIntegral", "invariant_set_independent_of_orbit_indicator_limit",
             "ergodicSMul_of_orbit_indicator_limits"],
    ERGDEC: ["condExpKernel_invariant", "invariant_kernel_decomposition", "condExpKernel_ae_constant",
             "action_ergodic_decomposition"],
}
RANGE_WHY = {
    KERNEL: ("the file's header (lines 4–47: its namespaces, sections and `open` lines) and its second half (lines "
             "220–558), which is what the ergodic decomposition reads of it; its first half, the entropy of kernels, "
             "is not read"),
    ERGDEC: ("the file's header and its first four declarations (lines 4–179), ending with "
             "`action_ergodic_decomposition`, and its closing lines (506–509); the packet applications between are not "
             "read"),
}

# module -> the Mathlib modules it imports.  Measured, not chosen: the last `Imports increased to` of Mathlib's
# `linter.minImports` on the module generated with `--mathlib-whole` (data/fs131/ie1/logs/minimports-*.log), which is
# the least set under which every command of the text elaborates as it does under `import Mathlib` — syntax, tactics
# and instances included.
# Measured instead (the linter ran five minutes on one file with no output and was stopped): the modules declaring the
# constants that the modules' stored terms name when compiled under `import Mathlib` (`data/fs131/ie1/lean/ImportsDump.lean`),
# reduced, then the elaboration at this pin decides.  Left out of that list, each with its reason:
#   `Mathlib.Order.CompletePartialOrder` (listed for Shannon and Maximal): the module of `CompletePartialOrder.toSupSet`.
#     Under it a supremum in `ℝ≥0∞` is stored through that instance; `Rigidity/Entropy`, which imports these modules,
#     stored `ksEntropyOn`'s value through another (`ConditionallyCompletePartialOrder…`), and imported it would move a
#     definition the chain's statements read (`data/fs131/ie1/statements-compare-1.out`); no other import brings it
#     (`tools/fs131_ie1_closure.py`, `data/fs131/ie1/logs/closure.out`).  Without it the ported modules elaborate, and
#     the read-back records the instance path by which their suprema differ from the release's;
#   `Mathlib.RingTheory.Etale.Weakly`, `Mathlib.RingTheory.Flat.TorsionFree`, `Mathlib.RingTheory.TotallySplit` (listed
#     for Mixtures): not needed to elaborate, and the read-back shows no stored term moved without them.
MATHLIB = {
    "OAI015Shannon": ["Mathlib.Algebra.Order.Ring.Star", "Mathlib.Analysis.SpecialFunctions.Log.NegMulLog",
                      "Mathlib.Analysis.Subadditive", "Mathlib.Dynamics.Ergodic.MeasurePreserving",
                      "Mathlib.MeasureTheory.Measure.Real"],
    "OAI015Mixtures": ["Mathlib.Algebra.Order.Star.Real", "Mathlib.MeasureTheory.Integral.DominatedConvergence",
                       "Mathlib.Probability.Kernel.Composition.MeasureComp"],
    "OAI015Maximal": ["Mathlib.Algebra.Order.Ring.Star", "Mathlib.Algebra.Order.Star.Real",
                      "Mathlib.Analysis.InnerProductSpace.Basic", "Mathlib.Dynamics.BirkhoffSum.Basic",
                      "Mathlib.MeasureTheory.Integral.Bochner.Set"],
    # FS131-IP23
    "OAI015Generating": ["Mathlib.Probability.Martingale.Convergence"],
    "OAI015ErgodicDecomposition": ["Mathlib.Algebra.Ring.IsFormallyReal", "Mathlib.Dynamics.Ergodic.Action.Basic",
                                   "Mathlib.MeasureTheory.MeasurableSpace.Invariants", "Mathlib.MeasureTheory.SetAlgebra",
                                   "Mathlib.Probability.Kernel.Condexp", "Mathlib.Topology.EMetricSpace.Paracompact",
                                   "Mathlib.Topology.Separation.CompletelyRegular"],
}

# `open` tokens taken out, per module: exactly the namespaces that do not exist under that module's imports, as
# `--open-probe` reads them (`data/fs131/ie1/lean/OpenProbe-<module>.lean`: each namespace the release's files open,
# opened alone; its log `data/fs131/ie1/logs/openprobe-<module>.log` names each absent one, and every other is present).  The release's entropy
# files carry the flattened `open` header of a number-theory development; nothing of the entropy text names anything
# through these.
DROP_OPEN = {
    "OAI015Shannon": {"IsDiscreteValuationRing", "IsLocalRing", "NumberField", "ArithmeticFunction.zeta",
                      "ArithmeticFunction", "BoundingSieve", "UniqueFactorizationMonoid", "FractionalIdeal",
                      "RealInnerProductSpace"},
    "OAI015Mixtures": {"IsDiscreteValuationRing", "NumberField", "ArithmeticFunction.zeta", "ArithmeticFunction",
                       "BoundingSieve", "FractionalIdeal", "Matrix.Norms.Elementwise"},
    "OAI015Maximal": {"IsDiscreteValuationRing", "NumberField", "ArithmeticFunction.zeta", "ArithmeticFunction",
                      "BoundingSieve", "FractionalIdeal", "Matrix.Norms.Elementwise"},
    # FS131-IP23 (`data/fs131/ip23/lean/OpenProbe-<module>.lean`, `data/fs131/ip23/logs/openprobe-<module>.log`)
    "OAI015Generating": set(),
    "OAI015ErgodicDecomposition": {"ArithmeticFunction", "ArithmeticFunction.zeta", "BoundingSieve", "FractionalIdeal",
                                   "IsDiscreteValuationRing", "NumberField"},
}
# where `--open-probe <job>` writes its files
PROBE_DIR = {"FS131-IE1": "data/fs131/ie1/lean", "FS131-IP23": "data/fs131/ip23/lean"}
# opened inside `namespace DukePrimeDegree`, which is the same namespace here
SELF_OPEN = {"PrimeDegreePackets"}

# (release file, line, old substring, new substring, reason) — differences between v4.34.1 (theirs) and v4.32.0 (ours).
# A patch is a change to a PROOF; the script refuses one that touches a statement or a definition.
SETOF = ("Mathlib renamed `setOf` to `Set.ofPred` on 2026-07-09 and its lemmas with it; at v4.32.0 the lemma has the "
         "old name, the same statement")
ITE = ("core's `if_neg` and `if_pos` were renamed `ite_eq_right` and `ite_eq_left` on 2026-07-21 (`Init/Core.lean`; at "
       "v4.34.1 the old names are deprecated aliases); at v4.32.0 the lemmas have only the old names")
EVCONST = ("Mathlib defined `EventuallyEmptyOrUniv s l := EventuallyConst (· ∈ s) l` on 2026-08-25 and restated the "
           "field of `ErgodicSMul` and the set form of `eventuallyConst_pred` with it (`eventuallyEmptyOrUniv_iff`); at "
           "v4.32.0 that field is `EventuallyConst s (ae μ)`, and the same two disjuncts in the same order are "
           "`eventuallyConst_set`")
DIAG = ("`Function.diag` (`fun a ↦ (a, a)`) is a definition of the later pin, with which v4.34.1 states "
        "`compProd_trim_condExpKernel`; at v4.32.0 that lemma is stated with `fun ω ↦ (id ω, id ω)`, which is written "
        "out here")
PATCHES = [
    (SHANNON, 190, "Set.ofPred_and", "Set.setOf_and", SETOF),
    (SHANNON, 205, "Set.ofPred_and", "Set.setOf_and", SETOF),
    (OCCUPATION, 109, "Set.ofPred_mem_eq", "Set.setOf_mem_eq", SETOF),
    (MIXTURES, 220, "ite_eq_right h", "if_neg h", ITE),
    (MIXTURES, 264, "ite_eq_left hzi", "if_pos hzi", ITE),
    (MIXTURES, 264, "ite_eq_right hn", "if_neg hn", ITE),
    (HOPF, 47, "birkhoffSum_succ_apply'", "birkhoffSum_succ'",
     "at v4.32.0 the pointwise lemma `birkhoffSum f g (n + 1) x = g x + birkhoffSum f g n (f x)` is named "
     "`birkhoffSum_succ'`; Mathlib renamed it between the pins"),
    # FS131-IP23 (each measured: the module generated without it does not elaborate at this pin, `data/fs131/ip23/logs/`)
    (KERNEL, 306, "Set.ofPred_forall", "Set.setOf_forall", SETOF),
    (KERNEL, 542, "eventuallyEmptyOrUniv_iff", "eventuallyConst_set", EVCONST),
    (ERGDEC, 63, "Function.diag", "(fun y => (id y, id y))", DIAG),
    (ERGDEC, 69, "Function.diag", "(fun y => (id y, id y))", DIAG),
    (ERGDEC, 114, "Function.diag", "(fun y => (id y, id y))", DIAG),
    (ERGDEC, 116, "Function.diag", "(fun y => (id y, id y))", DIAG),
    (GENERATING[1], 25, "Set.ofPred_and", "Set.setOf_and", SETOF),
    (GENERATING[1], 92, "Set.mem_ofPred_eq", "Set.mem_setOf_eq", SETOF),
    (GENERATING[1], 102, "Set.mem_ofPred_eq", "Set.mem_setOf_eq", SETOF),
    (GENERATING[2], 25, "Set.mem_ofPred_eq", "Set.mem_setOf_eq", SETOF),
    (GENERATING[2], 66, "Set.mem_ofPred_eq", "Set.mem_setOf_eq", SETOF),
    (GENERATING[5], 24, "Set.mem_ofPred_eq", "Set.mem_setOf_eq", SETOF),
    (GENERATING[5], 47, "Set.mem_ofPred_eq", "Set.mem_setOf_eq", SETOF),
    (GENERATING[6], 53, "Set.mem_ofPred_eq", "Set.mem_setOf_eq", SETOF),
]

# (release file, declaration, linter) -> the one-line comment placed beside the attribute.  A ported statement keeps the
# source's arguments, used or not; the linter that reports an unused one is silenced BY NAME on that declaration
# (Amendment 1 of the brief, FS131-IE1: the coordinator's ruling).  The script refuses an entry whose declaration is
# not ported, a linter not in NOLINT_LINTERS, and any `nolint` the release's text itself carries.
NOLINT_LINTERS = {"unusedArguments"}
_UNUSED = ("-- the release's statement takes this instance and its proof does not read it; kept so that the statement "
           "stays the release's")
NOLINT = {
    (MIXTURES, "observationEntropy_finite_mixture_bounds", "unusedArguments"): _UNUSED,
    (MIXTURES, "kernelCell_preserving", "unusedArguments"): _UNUSED,
    (MIXTURES, "kernelCell_real", "unusedArguments"): _UNUSED,
}

# module -> a sentence for the header's item on imports (what was measured and left out, and what it costs)
IMPORT_NOTES = {
    "OAI015Shannon": ("Left out of the measured list: `Mathlib.Order.CompletePartialOrder`. Under it a supremum in `ℝ≥0∞` is "
                      "stored through `CompletePartialOrder.toSupSet`, and `Rigidity/Entropy`, which imports this module, "
                      "would store its own definition `ksEntropyOn` through it too, moving a definition the chain's "
                      "statements read; without it `measureEntropy` is the release's up to that instance path (the "
                      "read-back records it), and is stored as `ksEntropy` is."),
    "OAI015Mixtures": ("Left out of the measured list: three `Mathlib.RingTheory` modules (`Etale.Weakly`, "
                       "`Flat.TorsionFree`, `TotallySplit`), which the text does not need and without which no stored "
                       "term moves (the read-back)."),
    "OAI015Maximal": ("Left out of the measured list: `Mathlib.Order.CompletePartialOrder`, for the reason given in "
                      "`Outside/OAI015Shannon`'s header."),
    # FS131-IP23: TO BE MEASURED
    "OAI015Generating": "",
    "OAI015ErgodicDecomposition": "",
}
READBACK_NOTES = {
    "OAI015Shannon": "read back",
    "OAI015Mixtures": "read back",
    "OAI015Maximal": "not read back",
    "OAI015Generating": "read back",
    "OAI015ErgodicDecomposition": "read back",
}
# module -> (the read-back tool, its tables) when it is not FS131-IE1's, and a sentence the header adds (FS131-IP23)
READBACK_TOOL = {
    "OAI015Generating": ("tools/fs131_ip23_port_readback.py", "data/fs131/ip23/readback/"),
    "OAI015ErgodicDecomposition": ("tools/fs131_ip23_port_readback.py", "data/fs131/ip23/readback/"),
}
READBACK_EXTRA = {
    "OAI015ErgodicDecomposition": (
        " Two statements, `orbitConvexHull_aeSetIntegral` and `invariant_set_independent_of_orbit_indicator_limit`, "
        "are the release's under one named rule of that tool (EVENTUALLYEQSET): `s =ᵐ[μ] t` on sets is stored as "
        "`Filter.EventuallyEqSet` at the release's pin, a definition of its own equal by unfolding to "
        "`Filter.EventuallyEq` on the sets read as predicates, which is how it is stored here (the kernel checks the "
        "unfolding at the release's pin). And one Mathlib definition these statements name moved between the pins "
        "without moving its meaning, which no comparison of statements can see: the field of `ErgodicSMul` is "
        "`EventuallyConst s (ae μ)` here and `EventuallyEmptyOrUniv s (ae μ)` there, where "
        "`EventuallyEmptyOrUniv s l` is defined as `EventuallyConst (· ∈ s) l`."),
}
# module -> the clause of the header's item on imports that says what the release's files import
RELEASE_IMPORTS_IE1 = ("the release's files import `Mathlib` whole and, for the maximal inequality, modules of the "
                       "release that its text does not use.")
RELEASE_IMPORTS = {
    "OAI015Generating": ("the release's files import one another in a chain that starts at `EntropyMixtures.lean` "
                         "(here `Outside/OAI015Mixtures`), and through it `Mathlib` whole."),
    "OAI015ErgodicDecomposition": ("the release's files import `Mathlib` whole, `ErgodicDecomposition.lean` imports "
                                   "`KernelEntropy.lean`, and `KernelEntropy.lean` imports two files of the release "
                                   "(`AtomMass.lean`, `EntropyMixtures.lean`) that the copied lines do not use."),
}

# instances: release name -> why it is scoped / why it may be global
SCOPED = {}
GLOBAL_INSTANCES = {
    "kernelCell_probability":
        "`IsProbabilityMeasure (kernelCell τ κ Q i)`: the class is Mathlib's, the term's head `kernelCell` is the "
        "release's own definition (not reducible), so the instance can fire only on a term that names it",
}

KEYWORD = re.compile(r"^(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|scoped|local)\s+)*"
                     r"(lemma|theorem|def|abbrev|instance|structure|inductive|class)\s+([^\s:({\[]+)")
# FS131-IP23: lines that belong to the declaration below them — `omit … in` (above its docstring) and an attribute
# block alone on its line (between its docstring and its keyword).  Both are part of the statement: a patch on one is
# refused as a patch to the statement.
OMIT_LINE = re.compile(r"^omit\s.*\sin$")
ATTR_LINE = re.compile(r"^@\[[^\]]*\]$")
PROOFKINDS = ("lemma", "theorem")
IMPORT = re.compile(r"^\s*(?:public\s+)?import\s")
HIT = [
    ("#-command", re.compile(r"^\s*#\w+")),
    ("#eval", re.compile(r"#eval")),
    ("run_cmd/run_elab/run_meta", re.compile(r"\brun_(cmd|elab|meta)\b")),
    ("initialize", re.compile(r"\binitialize\b")),
    ("unsafe", re.compile(r"\bunsafe\b")),
    ("IO.", re.compile(r"\bIO\.")),
    ("macro/elab/syntax declaration",
     re.compile(r"^\s*(?:@\[[^\]]*\]\s*)?(?:(?:private|protected|local|scoped)\s+)*"
                r"(?:macro|elab|syntax|macro_rules|elab_rules|notation|infix|infixl|infixr|prefix|postfix)\b")),
    ("implemented_by/extern/csimp/an attribute command",
     re.compile(r"\bimplemented_by\b|\bextern\b|\bcsimp\b|^\s*(?:local |scoped )?attribute\b|^\s*set_option\b|\bderiving\b")),
]


class Refused(Exception):
    """A condition under which nothing may be generated."""


def clone_commit(clone=CLONE) -> str:
    return subprocess.run(["git", "-C", str(clone), "rev-parse", "HEAD"], check=True, capture_output=True,
                          text=True).stdout.strip()


def scan(rel, lines, numbers):
    """Refuse on anything that runs code at elaboration, in the lines this script copies (`numbers`: 1-based)."""
    for no in numbers:
        s = lines[no - 1]
        for kind, rx in HIT:
            if rx.search(s):
                raise Refused(f"SCAN HIT {rel}:{no}: [{kind}] {s.strip()[:120]}")


def statement_end(text):
    """(row, column) of the declaration's top-level `:=`, counted from its keyword; None when it has none (a
    definition by pattern matching, a structure)."""
    depth, started = 0, False
    for r, s in enumerate(text):
        i = 0
        if not started:
            m = KEYWORD.match(s)
            if not m:
                continue
            started, i = True, m.end(1)
        while i < len(s):
            ch = s[i]
            if ch in "([{⟨":
                depth += 1
            elif ch in ")]}⟩":
                depth -= 1
            elif depth == 0 and s.startswith(":=", i):
                return r, i
            elif s.startswith("--", i):
                break
            i += 1
    return None


def parse(rel, lines, start=1, stop=None):
    """-> items in source order: ('blank', no) | ('scaffold', no, text) | ('moddoc', a, b) | ('decl', a, b, kind,
    name, (omit_rows, doc_rows, attr_rows)) where a..b are 1-based inclusive source lines (a is the first line of the
    declaration's `omit … in` lines, docstring or attribute lines when it has any, in that order above its keyword).
    With `start`/`stop` (FS131-IP23: a line range of the file) only lines start..stop are read, and nothing may run
    past `stop`: a docstring or module docstring not closed by it, or a declaration that continues after it, is
    refused."""
    n = len(lines)
    stop = n if stop is None else stop
    if not (1 <= start <= stop <= n):
        raise Refused(f"{rel}: the range {start}–{stop} is not inside the file's {n} lines")
    items, no = [], start
    while no <= stop:
        s = lines[no - 1]
        if s.strip() == "":
            items.append(("blank", no))
            no += 1
        elif IMPORT.match(s):
            items.append(("import", no, s))
            no += 1
        elif s.startswith("/-!"):
            b = no
            while "-/" not in lines[b - 1]:
                b += 1
                if b > stop:
                    raise Refused(f"{rel}:{no}: a module docstring is not closed" + ("" if stop == n else
                                                                                    f" by line {stop}"))
            items.append(("moddoc", no, b))
            no = b + 1
        elif s.startswith("/--") or KEYWORD.match(s) or OMIT_LINE.match(s) or ATTR_LINE.match(s):
            a = k = no
            while k <= stop and OMIT_LINE.match(lines[k - 1]):
                k += 1
            orows = k - a
            if k <= stop and lines[k - 1].startswith("/--"):
                d = k
                while "-/" not in lines[d - 1]:
                    d += 1
                    if d > stop:
                        raise Refused(f"{rel}:{k}: a docstring is not closed" + ("" if stop == n else
                                                                                f" by line {stop}"))
                k = d + 1
            drows = k - a - orows
            while k <= stop and ATTR_LINE.match(lines[k - 1]):
                k += 1
            arows = k - a - orows - drows
            kwno = k
            if kwno > stop or not KEYWORD.match(lines[kwno - 1]):
                raise Refused(f"{rel}:{no}: " + ("a docstring" if drows else "an `omit … in` line" if orows else
                                                 "an attribute line") + " not followed by a declaration")
            m = KEYWORD.match(lines[kwno - 1])
            b = kwno
            while b + 1 <= stop and (lines[b].strip() == "" or lines[b][0] in " \t"):
                b += 1
            if b == stop and stop < n:
                nxt = stop + 1
                while nxt <= n and lines[nxt - 1].strip() == "":
                    nxt += 1
                if nxt <= n and lines[nxt - 1][0] in " \t":
                    raise Refused(f"{rel}: the range ending at line {stop} ends inside the declaration "
                                  f"{m.group(2)} (line {nxt} continues it)")
            while lines[b - 1].strip() == "":
                b -= 1
            items.append(("decl", a, b, m.group(1), m.group(2), (orows, drows, arows)))
            no = b + 1
        elif re.match(r"^(namespace \S+|end(?: \S+)?|section(?: \S+)?|noncomputable section|open .*|universe .*)$", s):
            if re.search(r"\sin$", s):
                raise Refused(f"{rel}:{no}: an `… in` line: not handled")
            items.append(("scaffold", no, s))
            no += 1
        elif s.startswith("variable "):
            b = no
            while b + 1 <= stop and lines[b].strip() != "" and lines[b][0] in " \t":
                b += 1
            if b == stop and stop < n and lines[stop].strip() != "" and lines[stop][0] in " \t":
                raise Refused(f"{rel}: the range ending at line {stop} ends inside a `variable` line")
            for k in range(no, b + 1):
                items.append(("scaffold", k, lines[k - 1]))
            no = b + 1
        else:
            raise Refused(f"{rel}:{no}: a line this script does not classify: {s!r}")
    return items


def parse_ranges(rel, lines, ranges, want):
    """FS131-IP23: the items of the line ranges of a file, each range read by `parse`; the declarations found must be
    exactly `want`, in source order."""
    items, last = [], 0
    for a, b in ranges:
        if a <= last:
            raise Refused(f"{rel}: the ranges {ranges} are not increasing and disjoint")
        items.extend(parse(rel, lines, a, b))
        last = b
    found = [it[4] for it in items if it[0] == "decl"]
    if found != list(want):
        raise Refused(f"{rel}: RANGES hold {found} but RANGE_DECLS lists {list(want)} (in source order)")
    return items


def parse_partial(rel, lines, select):
    """The scaffold of the whole file and the SELECT declarations only: every other line is left out unread (the file
    is not copied, and its other declarations need not parse)."""
    items, no, n, found = [], 1, len(lines), []
    scaffold = re.compile(r"^(namespace \S+|end(?: \S+)?|section(?: \S+)?|noncomputable section|open .*|universe .*)$")
    while no <= n:
        s = lines[no - 1]
        m = KEYWORD.match(s)
        if m and m.group(2) in select:
            if lines[no - 2].strip() != "":
                raise Refused(f"{rel}:{no}: {m.group(2)} is not preceded by a blank line (a docstring or an attribute "
                              "above it is not handled in a partial file)")
            b = no
            while b + 1 <= n and (lines[b].strip() == "" or lines[b][0] in " \t"):
                b += 1
            while lines[b - 1].strip() == "":
                b -= 1
            items.append(("decl", no, b, m.group(1), m.group(2), (0, 0, 0)))
            found.append(m.group(2))
            no = b + 1
        elif scaffold.match(s):
            if re.search(r"\sin$", s):
                raise Refused(f"{rel}:{no}: an `… in` line: not handled")
            items.append(("scaffold", no, s))
            no += 1
        elif s.startswith("variable "):
            raise Refused(f"{rel}:{no}: a `variable` line in a partial file: not handled")
        else:
            no += 1
    if found != list(select):
        raise Refused(f"{rel}: SELECT {list(select)} but found {found} (in source order)")
    return items


def convert_scaffold(rel, no, s, drop_open, dropped):
    m = re.match(r"^(namespace|end) (\S+)$", s)
    if m:
        if m.group(2) == NS_ROOT[0]:
            return f"{m.group(1)} {NS_ROOT[1]}"
        if m.group(2) in NS_MAP:
            return f"{m.group(1)} {NS_MAP[m.group(2)]}"
        raise Refused(f"{rel}:{no}: a namespace this script does not map: {m.group(2)}")
    if s.startswith("open "):
        toks = s.split()
        scoped = toks[1] == "scoped"
        names = toks[2:] if scoped else toks[1:]
        if any(not re.match(r"^[A-Za-z_][\w.]*$", t) for t in names):
            raise Refused(f"{rel}:{no}: an `open` line this script does not read: {s!r}")
        keep = []
        for t in names:
            if t in drop_open or t in SELF_OPEN:
                dropped.append((no, t))
            else:
                keep.append(t)
        if not keep:
            return None
        return "open " + ("scoped " if scoped else "") + " ".join(keep)
    return s


nolint_used = set()


def plan_module(module, ours, files, patches, select, clone, ranges=None, range_decls=None):
    ranges = RANGES if ranges is None else ranges
    range_decls = RANGE_DECLS if range_decls is None else range_decls
    body, decls, dropped, used = [], [], [], set()
    stats = []
    for rel in files:
        lines = (clone / SRC / rel).read_text().split("\n")
        if lines and lines[-1] == "":
            lines = lines[:-1]
        fname = rel.rsplit("/", 1)[-1]
        if rel in select and rel in ranges:
            raise Refused(f"{rel}: in both SELECT and RANGES")
        items = (parse_partial(rel, lines, select[rel]) if rel in select else
                 parse_ranges(rel, lines, ranges[rel], range_decls[rel]) if rel in ranges else parse(rel, lines))
        copied = [no for it in items if it[0] in ("scaffold",) for no in [it[1]]]
        for it in items:
            if it[0] in ("decl", "moddoc"):
                copied.extend(range(it[1], it[2] + 1))
        scan(rel, lines, sorted(copied))
        out = [f"-- ==== `[OAIMath2026]` `{SRC[5:]}{rel}`"
               + (" (the declarations " + ", ".join(f"`{x}`" for x in select[rel]) + " only)" if rel in select else "")
               + (" (lines " + ", ".join(f"{a}–{b}" for a, b in ranges[rel]) + " only)" if rel in ranges else "")
               + " ===="]
        nd = 0
        for it in items:
            if it[0] == "blank":
                out.append("")
            elif it[0] == "import":
                continue
            elif it[0] == "moddoc":
                out.extend(lines[it[1] - 1:it[2]])
            elif it[0] == "scaffold":
                c = convert_scaffold(rel, it[1], it[2], DROP_OPEN[module], dropped)
                if c is not None:
                    out.append(c)
            else:
                _, a, b, kind, name, (orows, drows, arows) = it
                text = lines[a - 1:b]
                kwrow = orows + drows + arows
                kwno = a + kwrow
                se = statement_end(text[kwrow:])
                if se is not None:
                    se = (se[0] + kwrow, se[1])
                for i, (pf, pl, old, new, _) in enumerate(patches):
                    if pf != rel or not (a <= pl <= b):
                        continue
                    if kind == "instance":
                        if se is None or "by" not in text[se[0]][se[1]:].split()[:2]:
                            raise Refused(f"patch {i} ({fname}:{pl}) is inside the instance {name}, whose value is a "
                                          "term: not patched")
                    elif kind not in PROOFKINDS:
                        raise Refused(f"patch {i} ({fname}:{pl}) is inside the {kind} {name}: a definition is never "
                                      "patched")
                    if se is None:
                        raise Refused(f"patch {i} ({fname}:{pl}): no top-level `:=` found in {name}")
                    row = text[pl - a]
                    pos = row.find(old)
                    if pos < 0:
                        raise Refused(f"patch {i} does not apply at {fname}:{pl}")
                    if (pl - a, pos) <= se:
                        raise Refused(f"patch {i} ({fname}:{pl}) touches the statement of {name} (its `:=` is at line "
                                      f"{a + se[0]}, column {se[1]})")
                    text[pl - a] = row.replace(old, new)
                    used.add(i)
                if kind == "instance":
                    if (name in SCOPED) == (name in GLOBAL_INSTANCES):
                        raise Refused(f"{fname}:{kwno}: the instance {name} must be in exactly one of SCOPED and "
                                      "GLOBAL_INSTANCES")
                    if name in SCOPED:
                        if not text[kwrow].startswith("instance "):
                            raise Refused(f"{fname}:{kwno}: a scoped instance that does not begin with the keyword")
                        text[kwrow] = "scoped " + text[kwrow]
                addr = f"`[OAIMath2026]` `{fname}:{kwno}`."
                if any("nolint" in row for row in text):
                    raise Refused(f"{fname}:{kwno}: the release's text of {name} carries a `nolint`: not handled")
                nl = [(lint, why) for (nf, nn, lint), why in NOLINT.items() if nf == rel and nn == name]
                for lint, _ in nl:
                    if lint not in NOLINT_LINTERS:
                        raise Refused(f"NOLINT entry for {name}: the linter {lint} is not one this script silences")
                    nolint_used.add((rel, name, lint))
                if nl and (arows or not KEYWORD.match(text[kwrow]).group(0).startswith(("lemma", "theorem"))):
                    raise Refused(f"{fname}:{kwno}: a `nolint` on {name}, whose keyword line carries attributes or "
                                  "modifiers: not handled")
                # the `omit … in` lines, then the docstring (the address, then the release's docstring if any), then
                # the attribute lines and the declaration
                out.extend(text[:orows])
                text = text[orows:]
                if drows == 0:
                    out.append(f"/-- {addr} -/")
                else:
                    text[0] = f"/-- {addr} " + text[0][3:].lstrip()
                    out.extend(text[:drows])
                    text = text[drows:]
                for lint, why in nl:
                    out.append(why)
                    out.append(f"@[nolint {lint}]")
                out.extend(text)
                decls.append((rel, kwno, b, kind, name))
                nd += 1
        stats.append((rel, len(lines), nd, sum(1 for it in items if it[0] == "decl")))
        body.extend(out)
        body.append("")
    # a `namespace X … end X` pair left with nothing between is left out
    changed = True
    while changed:
        changed = False
        for i, s in enumerate(body):
            m = re.match(r"^namespace (\S+)$", s)
            if not m:
                continue
            j = i + 1
            while j < len(body) and body[j].strip() == "":
                j += 1
            if j < len(body) and body[j] == f"end {m.group(1)}":
                del body[i:j + 1]
                changed = True
                break
    # runs of blank lines are one blank line
    squeezed = []
    for s in body:
        if s.strip() == "" and squeezed and squeezed[-1] == "":
            continue
        squeezed.append("" if s.strip() == "" else s)
    return squeezed, decls, dropped, used, stats


def render(module, ours, files, what, p, patches, mathlib):
    body, decls, dropped, used, stats = p
    o = [f"import {PFX}{m}" for m in ours] + [f"import {m}" for m in mathlib]
    o += ["", "/-!",
          f"# `[OAIMath2026]` family 015, ported: {', '.join('`' + f.rsplit('/', 1)[-1] + '`' for f in files)} "
          f"(job {JOB.get(module, 'FS131-IE1')})",
          "",
          "**GENERATED by `tools/fs131_ie1_port.py` from `[OAIMath2026]` family 015 (github.com/openai/math at commit",
          f"`{COMMIT}`), under `{SRC}`:",
          "do not edit by hand; rerun the script.**",
          "",
          "**Licence and notice of change.** The source is licensed under the Apache License, Version 2.0 (`LICENSE` at the",
          "root of the release; http://www.apache.org/licenses/LICENSE-2.0); a byte-identical copy of that licence text is",
          f"beside this file, `Outside/{LICENCE_NAME}` (this script's `--check` compares the two). **This file is a",
          "changed copy of " + " and ".join(
              (f"part of `{f}`" if f in SELECT or f in RANGES else f"`{f}`") for f in files)
          + ".** The changes, all of them:",
          ""]
    for (rel, nl, nd, _) in stats:
        if rel in SELECT:
            rows = [d for d in decls if d[0] == rel]
            o.append(f"- *A selection.* Of `{rel}` ({nl} lines), {nd} declarations are copied: "
                     + ", ".join(f"`{d[4]}` (lines {d[1]}–{d[2]})" for d in rows)
                     + " — what the maximal inequality's text names of that file; with the file's `namespace`, "
                     "`section` and `open` lines, so that they elaborate in the release's context.")
        elif rel in RANGES:
            rows = [d for d in decls if d[0] == rel]
            o.append(f"- *A selection by lines.* Of `{rel}` ({nl} lines), lines "
                     + ", ".join(f"{a}–{b}" for a, b in RANGES[rel]) + f" are copied, holding {nd} declarations: "
                     + ", ".join(f"`{d[4]}` (lines {d[1]}–{d[2]})" for d in rows) + " — " + RANGE_WHY[rel] + ".")
        else:
            o.append(f"- `{rel}`: the whole file, {nl} lines, {nd} declarations.")
    o.append("")
    o.append("1. *The namespaces*: `OAI.PrimeDegreePackets` and `OAI.DukePrimeDegree` there, `HadwigerNelson.Outside.OAI015`")
    o.append("   here (one namespace; no two ported declarations share a name).")
    o.append("2. *The imports*: " + ", ".join(f"`{m}`" for m in ([PFX + x for x in ours] + mathlib))
             + " — the least set under which the text elaborates as it does under `import Mathlib`"
             " (measured: `tools/fs131_ie1_port.py`, MATHLIB); " + RELEASE_IMPORTS.get(module, RELEASE_IMPORTS_IE1)
             + " " + IMPORT_NOTES[module])
    dt = sorted({t for _, t in dropped})
    if dt:
        o.append(f"3. *The `open` lines*: taken out, being namespaces that do not exist under these imports — "
                 + ", ".join(f"`{t}`" for t in dt if t not in SELF_OPEN)
                 + (" — and `PrimeDegreePackets` where it is opened inside `DukePrimeDegree` (one namespace here)"
                    if any(t in SELF_OPEN for t in dt) else "")
                 + ". Every other `open` is the release's.")
    else:
        o.append("3. *The `open` lines*: the release's, unchanged.")
    o.append("4. *Docstrings*: every declaration's docstring opens with its source line at the commit; where the release")
    o.append("   has a docstring it follows the address, and where it has none the address is the docstring.")
    mine = [(pf, pl, old, new, why) for (pf, pl, old, new, why) in patches if pf in files]
    if mine:
        o.append(f"5. *Patches* ({len(mine)}), each to a proof and none to a statement or a definition — Mathlib at this "
                 "library's pin")
        o.append("   (v4.32.0) against the release's (v4.34.1):")
        for pf, pl, old, new, why in mine:
            o.append(f"   - `{pf.rsplit('/', 1)[-1]}` line {pl}: `{old}` → `{new}` — {why}")
    else:
        o.append("5. *Patches*: none. Every proof here is the release's text, unchanged.")
    inst = [d for d in decls if d[3] == "instance"]
    if inst:
        o.append("6. *Instances*: " + "; ".join(
            f"`{d[4]}` is " + ("`scoped` here — " + SCOPED[d[4]] if d[4] in SCOPED else
                               "global, as in the release — " + GLOBAL_INSTANCES[d[4]]) for d in inst) + ".")
    nlm = sorted({nn for (nf, nn, _) in NOLINT if nf in files})
    if nlm:
        o.append("7. *Linter attributes*: `@[nolint unusedArguments]` on " + ", ".join(f"`{x}`" for x in nlm)
                 + " — each release statement takes an instance argument its proof does not read; it is kept so that the"
                 " statement stays the release's, and the linter is silenced by name on that declaration, with a"
                 " comment beside the attribute (Amendment 1 of FS131-IE1's brief). The attribute is not part of the"
                 " stored statement.")
    o.append("")
    o.extend(wrap_words(f"What is here: {what}. All of it is kernel-checked in this library: no axiom, no `sorry`.", 118))
    o.append("")
    if READBACK_NOTES[module] == "read back":
        tool, tables = READBACK_TOOL.get(module, ("tools/fs131_ie1_port_readback.py", "data/fs131/ie1/readback/"))
        o.extend(wrap_words(
            f"**Compared with the release** as the kernel stores both (`{tool}`, FS132-I2's "
            f"comparator; its tables under `{tables}`): each declaration's stored statement and each "
            "definition's stored value at the release's pin against this pin's — the same term, or, where the table says "
            "so, the same once instance arguments and proof arguments are set aside. What that comparison leaves to "
            "trust: that Mathlib's instances of one class on one type agree at the two pins. The proofs need no such "
            "comparison: the kernel checked them here." + READBACK_EXTRA.get(module, ""), 118))
    else:
        o.extend(wrap_words(
            "**Not read back across the pins**: the release's print of these files would need 89 files of the release "
            "compiled (FS131-KN6's measurement); what stands for it is that this script copies the text and refuses to "
            "touch a statement or a definition. The proofs are the kernel's here either way.", 118))
    o.append("-/")
    o.append("")
    o.extend(body)
    while o[-1] == "":
        o.pop()
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


def generate(patches=None, clone=CLONE, select=None, mathlib=None, modules=None, ranges=None, range_decls=None):
    patches = PATCHES if patches is None else patches
    select = SELECT if select is None else select
    mathlib = MATHLIB if mathlib is None else mathlib
    modules = MODULES if modules is None else modules
    head = clone_commit(clone)
    if head != COMMIT:
        raise Refused(f"the clone is at {head}, not the audited commit {COMMIT}")
    texts, plans, used, names = {}, {}, set(), {}
    nolint_used.clear()
    for module, ours, files, what in modules:
        p = plan_module(module, ours, files, patches, select, clone, ranges, range_decls)
        used |= p[3]
        for (rel, a, b, kind, name) in p[1]:
            if name in names:
                raise Refused(f"two ported declarations share the name {name}: {names[name]} and {rel}:{a}")
            names[name] = f"{rel}:{a}"
        plans[module] = p
        texts[module] = render(module, ours, files, what, p, patches, mathlib[module])
    if len(used) != len(patches):
        raise Refused(f"patches not used: {sorted(set(range(len(patches))) - used)}")
    if nolint_used != set(NOLINT):
        raise Refused(f"NOLINT entries not placed: {sorted(set(NOLINT) - nolint_used)}")
    for nm in list(SCOPED) + list(GLOBAL_INSTANCES):
        if nm not in names:
            raise Refused(f"instance table entry {nm} is not a ported declaration")
    return texts, plans


def licence_check(outdir, clone, quiet=False) -> int:
    src, dst = pathlib.Path(clone) / LICENCE_SRC, pathlib.Path(outdir) / LICENCE_NAME
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


def check(outdir=OUTDIR, quiet=False, **kw) -> int:
    try:
        texts, _ = generate(**kw)
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
    bad += licence_check(outdir, kw.get("clone", CLONE), quiet)
    return 1 if bad else 0


AXIOMS_TITLE = {
    "FS131-IE1": ["/-! ## FS131-IE1 — the port of `[OAIMath2026]` family 015's entropy base (`Outside/OAI015Shannon`,",
                  "`OAI015Mixtures`, `OAI015Maximal`), generated by `tools/fs131_ie1_port.py --axioms-block`; no axiom, "
                  "no outside", "theorem -/"],
    "FS131-IP23": ["/-! ## FS131-IP23 — the port of `[OAIMath2026]` family 015's generating-sequence theorem and ergodic",
                   "decomposition (`Outside/OAI015Generating`, `OAI015ErgodicDecomposition`), generated by",
                   "`tools/fs131_ie1_port.py --axioms-block FS131-IP23`; no axiom, no outside theorem -/"],
}


def axioms_block(plans, job="FS131-IE1") -> str:
    """the audit's records for the modules of one job (FS131-IE1's by default, as before)"""
    o = AXIOMS_TITLE[job] + [f"-- {job}"]
    for module, _, _, _ in MODULES:
        if JOB.get(module, "FS131-IE1") != job:
            continue
        o.append(f"-- Outside/{module}")
        for (rel, a, b, kind, name) in plans[module][1]:
            o.append(f"#print axioms {NS_NEW}.{name}")
    o.append(f"-- {job}: end of the block")
    return "\n".join(o) + "\n"


def self_test() -> int:
    import shutil
    import tempfile
    ok, n = True, 0
    if check(quiet=True) != 0:
        print("SELF-TEST FAILED: the unplanted check does not pass")
        return 1
    print("unplanted: PASS (as it must)")
    texts, plans = generate()

    def expect(label, rc):
        nonlocal ok, n
        n += 1
        print(f"plant '{label}': {'REFUSED' if rc else 'SILENT'}")
        ok = ok and rc != 0

    def refused(want=None, **kw):
        """1 when the generation is refused — and, with `want`, refused with a message that holds `want` (a refusal
        for another reason is reported and counts as silent: the plant did not test what it names)"""
        try:
            generate(**kw)
            return 0
        except Refused as e:
            if want is not None and want not in str(e):
                print(f"    refused for another reason: {e}")
                return 0
            return 1

    with tempfile.TemporaryDirectory() as td:
        td = pathlib.Path(td)
        for module, text in texts.items():
            (td / f"{module}.lean").write_text(text)
        (td / LICENCE_NAME).write_bytes((CLONE / LICENCE_SRC).read_bytes())
        if check(outdir=td, quiet=True) != 0:
            print("SELF-TEST FAILED: the scratch copy does not pass unplanted")
            return 1
        # 1. a generated file changed by two spaces inside a proof
        victim = td / f"{MODULES[0][0]}.lean"
        s = victim.read_text()
        i = s.index(":= by", len(s) // 2)
        victim.write_text(s[:i] + ":= by  " + s[i + 5:])
        expect("a generated file changed by two spaces", check(outdir=td, quiet=True))
        victim.write_text(s)
        # 2. a generated file absent
        victim.rename(td / "gone")
        expect("a generated file absent", check(outdir=td, quiet=True))
        (td / "gone").rename(victim)
        # 3. a patch that does not apply
        expect("a patch that does not apply",
               check(outdir=td, quiet=True, patches=PATCHES + [(SHANNON, 228, "@@no such text@@", "x", "planted")]))
        # 4. a patch into a theorem's statement (`observationEntropy_comp_preserving`, line 219: its name)
        expect("a patch into a statement",
               refused("touches the statement",
                       patches=PATCHES + [(SHANNON, 221, "MeasurePreserving", "MeasurePreserving'", "planted")]))
        # 5. a patch into a definition (`observationEntropyRate`, line 278)
        expect("a patch into a definition",
           refused("a definition is never patched", patches=PATCHES + [(SHANNON, 278, "sInf", "sSup", "planted")]))
        # 6. a patch into a definition by pattern matching (`positiveRunningSum`, HopfMaximal line 23)
        expect("a patch into a definition without `:=`",
           refused("a definition is never patched", patches=PATCHES + [(HOPF, 23, "max 0", "min 0", "planted")]))
        # 7. the partner: a patch into a proof is accepted by the generator, and the files then differ
        last = (CLONE / SRC / SHANNON).read_text().split("\n")[227]
        tok = last.split()[-1]
        pp = PATCHES + [(SHANNON, 228, tok, tok + " ", "planted")]
        gen_ok = refused(patches=pp) == 0
        rc = check(outdir=td, quiet=True, patches=pp)
        print(f"partner 'a patch into a proof': generation {'ACCEPTED' if gen_ok else 'REFUSED'}, files then "
              f"{'DIFFER' if rc else 'AGREE'}")
        ok = ok and gen_ok and rc != 0
        # 8. a declared patch withdrawn: the text keeps the release's token, and the files differ
        expect("a declared patch withdrawn", check(outdir=td, quiet=True, patches=PATCHES[1:]))
        # 9–12. a clone whose text is changed: planted on a copy of the five files in a scratch repository at a
        #        commit of its own, with COMMIT pointed at it for the plant
        clone2 = td / "clone"
        (clone2 / SRC / "PrimePackets").mkdir(parents=True)
        (clone2 / SRC / "DukePrimeDegree/Dynamics").mkdir(parents=True)
        for rel in sorted({f for _, _, files, _ in MODULES for f in files}):
            shutil.copy(CLONE / SRC / rel, clone2 / SRC / rel)
        shutil.copy(CLONE / LICENCE_SRC, clone2 / LICENCE_SRC)
        subprocess.run(["git", "init", "-q", str(clone2)], check=True)

        def commit():
            subprocess.run(["git", "-C", str(clone2), "add", "-A"], check=True)
            subprocess.run(["git", "-C", str(clone2), "-c", "user.name=x", "-c", "user.email=x@x", "commit", "-q",
                            "--allow-empty", "-m", "x"], check=True)
            return clone_commit(clone2)

        global COMMIT
        real = COMMIT
        expect("the clone at another commit", (commit(), check(outdir=td, quiet=True, clone=clone2))[1])
        try:
            COMMIT = commit()
            base = refused(clone=clone2)
            print(f"the scratch clone at its own commit, unplanted: {'REFUSED' if base else 'accepted (as it must)'}")
            ok = ok and base == 0

            def with_edit(rel, fn, label, want, **kw):
                global COMMIT
                path = clone2 / SRC / rel
                keep = path.read_text()
                new = fn(keep)
                assert new != keep, f"the plant '{label}' changed nothing"
                path.write_text(new)
                COMMIT = commit()
                expect(label, refused(want, clone=clone2, **kw))
                path.write_text(keep)
                COMMIT = commit()

            with_edit(SHANNON, lambda t: t.replace("\ndef finiteShannon", "\n#eval (1 : Nat)\n\ndef finiteShannon", 1),
                      "an `#eval` in a copied file", "does not classify")
            with_edit(HOPF, lambda t: t.replace("\nlemma positiveRunningSum_nonneg",
                                                "\ninitialize foo : Nat ← pure 1\n\nlemma positiveRunningSum_nonneg", 1),
                      "an `initialize` in a copied file", "does not classify")
            with_edit(MIXTURES, lambda t: t.replace("  split_ifs with h\n  · infer_instance",
                                                    "  split_ifs with h\n  · exact unsafe (inferInstance)", 1),
                      "`unsafe` inside a proof of a copied file (the scan)", "SCAN HIT")
            with_edit(OCCUPATION, lambda t: t.replace("  classical\n  unfold visitCount",
                                                        "  classical\n  have := IO.println \"x\"\n  unfold visitCount", 1),
                      "`IO.` inside a proof of a copied file (the scan)", "SCAN HIT")
            with_edit(MIXTURES, lambda t: t.replace("\ninstance kernelCell_probability", "\ninstance kernelCell_other", 1),
                      "an instance that is in neither table", "exactly one of SCOPED")
            with_edit(OCCUPATION, lambda t: t.replace("\nlemma visitCount_mono", "\nlemma visitCount_cast", 1),
                      "two ported declarations of one name", "share the name")
            with_edit(INVERSE, lambda t: t.replace("\nlemma measurable_visitCount", "\nlemma measurable_visitCount'", 1),
                      "a selected declaration absent from the partial file", "SELECT")
            with_edit(SHANNON, lambda t: t.replace("\nnamespace PrimeDegreePackets", "\nnamespace Elsewhere", 1),
                      "a namespace the script does not map", "does not map")
            # FS131-IP23: an attribute line above a keyword is part of the statement; one followed by no declaration
            # is refused (`ConditionalShannon.lean`: `lemma finiteShannon_mul` is line 17)
            with_edit(GENERATING[0], lambda t: t.replace("\nlemma finiteShannon_mul", "\n@[simp]\nlemma finiteShannon_mul", 1),
                      "a patch into an attribute line above a keyword (the statement)", "touches the statement",
                      patches=PATCHES + [(GENERATING[0], 17, "simp", "simp ", "planted")])
            with_edit(GENERATING[0], lambda t: t.replace("\nlemma finiteShannon_mul", "\n@[simp]\n\nlemma finiteShannon_mul", 1),
                      "an attribute line followed by no declaration", "not followed by a declaration")
        finally:
            COMMIT = real
        # FS131-IP23: an `omit … in` line is part of the statement (`ConditionalOrbitEntropy.lean` line 27)
        expect("a patch into an `omit … in` line (the statement)",
               refused("touches the statement",
                       patches=PATCHES + [(GENERATING[3], 27, "MeasurableSpace", "MeasurableSpace'", "planted")]))
        # FS131-IP23: line ranges — one that ends inside a declaration (`exists_pointwise_invariant_representative`,
        # KernelEntropy lines 297–328), one that begins inside one (line 230, inside `fixedPoint_mem_closed_convex_orbit`),
        # and declarations that are not RANGE_DECLS's
        expect("a range that ends inside a declaration",
               refused("ends inside the declaration", ranges={**RANGES, KERNEL: [(4, 47), (220, 300)]}))
        expect("a range that begins inside a declaration",
               refused("does not classify", ranges={**RANGES, KERNEL: [(4, 47), (230, 558)]}))
        expect("a range whose declarations are not RANGE_DECLS's",
               refused("RANGE_DECLS lists", range_decls={**RANGE_DECLS, ERGDEC: RANGE_DECLS[ERGDEC][:-1]}))
        expect("a file in both SELECT and RANGES", refused("in both SELECT and RANGES",
                                                           select={**SELECT, KERNEL: ["actionInvariantSigma"]}))
        # a NOLINT entry whose declaration is not ported; a NOLINT entry for a linter this script does not silence
        global NOLINT
        keep_nl = dict(NOLINT)
        try:
            NOLINT = dict(keep_nl)
            NOLINT[(MIXTURES, "no_such_declaration", "unusedArguments")] = "-- planted"
            expect("a NOLINT entry whose declaration is not ported", refused("NOLINT entries not placed"))
            NOLINT = dict(keep_nl)
            NOLINT[(MIXTURES, "kernelCell_real", "docBlame")] = "-- planted"
            expect("a NOLINT entry for another linter", refused("is not one this script silences"))
            NOLINT = dict(keep_nl)
            del NOLINT[(MIXTURES, "kernelCell_real", "unusedArguments")]
            expect("a NOLINT entry withdrawn (the files then differ)", check(outdir=td, quiet=True))
        finally:
            NOLINT = keep_nl
        # the licence copy: one byte changed; absent
        lic = td / LICENCE_NAME
        b = lic.read_bytes()
        lic.write_bytes(b[:100] + bytes([b[100] ^ 1]) + b[101:])
        expect("the licence copy changed by one byte", check(outdir=td, quiet=True))
        lic.unlink()
        expect("the licence copy absent", check(outdir=td, quiet=True))
        lic.write_bytes(b)
        # an import list changed (`import Mathlib` whole in place of the measured list)
        expect("a module generated with `import Mathlib` whole",
               check(outdir=td, quiet=True, mathlib={m: ["Mathlib", "Mathlib.Planted"] for m in MATHLIB}))
        if check(outdir=td, quiet=True) != 0:
            print("SELF-TEST FAILED: the scratch copy does not pass after the plants were undone")
            return 1
    print(f"SELF-TEST OK: {n} plants refused and 1 partner accepted" if ok else "SELF-TEST FAILED")
    return 0 if ok else 1


def main() -> int:
    if "--self-test" in sys.argv:
        return self_test()
    if "--check" in sys.argv:
        rc = check()
        print("CHECK " + ("OK" if rc == 0 else "FAILED"))
        return rc
    whole = "--mathlib-whole" in sys.argv
    try:
        texts, plans = generate(mathlib={m: ["Mathlib"] for m in MATHLIB} if whole else None)
    except Refused as e:
        print(f"FAIL: {e}")
        return 1
    if "--open-probe" in sys.argv:
        # one file per module: its imports, then every namespace its release files `open`, each in a section of its
        # own, so that each that does not exist is reported on its own line (`unknown namespace`); read with the log
        job = sys.argv[sys.argv.index("--open-probe") + 1] if len(sys.argv) > sys.argv.index("--open-probe") + 1 \
            else "FS131-IE1"
        pdir = ROOT / PROBE_DIR[job]
        for module, ours, files, _ in MODULES:
            if JOB.get(module, "FS131-IE1") != job:
                continue
            toks = []
            for rel in files:
                for ln in (CLONE / SRC / rel).read_text().split("\n"):
                    if ln.startswith("open "):
                        for t in ln.split()[1:]:
                            if t != "scoped" and t not in toks:
                                toks.append(t)
            o = [f"import {PFX}{m}" for m in ours] + [f"import {m}" for m in MATHLIB[module]]
            o.append(f"-- {job} (generated by tools/fs131_ie1_port.py --open-probe): every namespace the release's "
                     f"files of {module} open, each opened alone under the module's imports; `unknown namespace` names "
                     "the ones that do not exist there")
            for t in toks:
                o += ["section", f"open {t}", "end"]
            (pdir / f"OpenProbe-{module}.lean").write_text("\n".join(o) + "\n")
            print(f"wrote OpenProbe-{module}.lean: {len(toks)} namespaces")
        return 0
    if "--axioms-block" in sys.argv:
        i = sys.argv.index("--axioms-block")
        sys.stdout.write(axioms_block(plans, sys.argv[i + 1] if len(sys.argv) > i + 1 else "FS131-IE1"))
        return 0
    if "--names" in sys.argv:
        for module, _, _, _ in MODULES:
            for (rel, a, b, kind, name) in plans[module][1]:
                relns = "OAI.DukePrimeDegree." if "DukePrimeDegree" in rel else "OAI.PrimeDegreePackets."
                print(f"{module}\t{kind}\t{NS_NEW}.{name}\t{relns}{name}\t{rel}:{a}")
        return 0
    if "--list" in sys.argv:
        tot = totl = 0
        for module, _, files, _ in MODULES:
            body, decls, dropped, used, stats = plans[module]
            for (rel, nl, nd, ndall) in stats:
                rows = [d for d in decls if d[0] == rel]
                nlines = sum(d[2] - d[1] + 1 for d in rows)
                print(f"{module} <- {rel}: {nl} lines; {nd} declarations copied ({nlines} lines)"
                      + (f" of a partial file" if rel in SELECT or rel in RANGES else ""))
                for (_, a, b, kind, name) in rows:
                    print(f"    {a}–{b}\t{kind}\t{name}")
                tot += nd
                totl += nlines
            dt = sorted({t for _, t in dropped})
            print(f"    `open` tokens taken out in {module}: {dt if dt else 'none'}")
        print(f"total copied: {tot} declarations, {totl} source lines")
        return 0
    for module, text in texts.items():
        (OUTDIR / f"{module}.lean").write_text(text)
        print(f"wrote {module}.lean ({text.count(chr(10))} lines, sha256 {hashlib.sha256(text.encode()).hexdigest()[:16]})"
              + (" WITH `import Mathlib` WHOLE — a measuring copy, not to be committed" if whole else ""))
    return licence_check(OUTDIR, CLONE)


if __name__ == "__main__":
    sys.exit(main())
