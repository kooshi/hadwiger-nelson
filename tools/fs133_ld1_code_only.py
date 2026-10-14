#!/usr/bin/env python3
"""FS133-LD1: the join's and the corrections' edits to the density equality's Lean files, in text — every character
outside block comments (docstrings `/-- … -/` and module docs `/-! … -/` are block comments) is the same at the
branch's head before the merge and now, except the edits listed here, each applied to the old code once (it must
occur exactly once) before the comparison.  FS131-LC1's `code_only_diff.py` (its `strip`, copied) with the
expected edits made explicit, so that an unlisted code change fails and a listed one that did not happen fails too.

  EDITS    Field          the recipe's step 5: the import of `Outside/OAI158Transfer` becomes `OAI158BorelTransfer`
           SectionDensity the ruled correction (inventory item 789, ruling 1): `[IsProbabilityMeasure μ]` dropped
                          from `ofReal_integral_le_measure_pos`
           Rigidity       the recipe's step 4: an import of `Outside/OAI158Ergodicity` added; the six copied
                          definitions (the `deriving` clause with them) and the `axiom residual_fourier` deleted —
                          checked as: the code from `theorem residual_fourier_cross` to the end is the same, and
                          the code before it is the base's with exactly those declarations removed
  SAME     Defs, InvariantLaw, Algebraic, Fractional, Pair: no code character changed (docstrings may differ)

Usage: fs133_ld1_code_only.py BASE_COMMIT [--plant]
--plant alters one code character of each working file in memory (the first `:=` after the imports becomes `:≡`):
every file must then read DIFFERS.  Exit 0: every file as expected (with --plant: every file DIFFERS); 1 otherwise.
"""
import re
import subprocess
import sys

D = "Proofs/HadwigerNelson/"
P = D + "Plane/OneClass/"


def strip(src):
    out, i, depth, n = [], 0, 0, len(src)
    while i < n:
        two = src[i:i + 2]
        if two == "/-":
            depth += 1
            i += 2
        elif two == "-/" and depth:
            depth -= 1
            i += 2
        else:
            if not depth:
                out.append(src[i])
            i += 1
    if depth:
        raise SystemExit("unbalanced block comment")
    return re.sub(r"\s+", " ", "".join(out)).strip()


EDITS = {
    P + "Field.lean": [("import Proofs.HadwigerNelson.Outside.OAI158Transfer",
                        "import Proofs.HadwigerNelson.Outside.OAI158BorelTransfer")],
    P + "SectionDensity.lean": [("theorem ofReal_integral_le_measure_pos (μ : Measure Ω) [IsProbabilityMeasure μ] {h",
                                 "theorem ofReal_integral_le_measure_pos (μ : Measure Ω) {h")],
}
SAME = [P + f + ".lean" for f in ("Defs", "InvariantLaw", "Algebraic", "Fractional", "Pair")]
RIG = D + "Outside/OAI158Rigidity.lean"
RIG_DELETED = ["abbrev E :=", "def K : Subgroup Circle where", "def DiscreteE := Multiplicative E deriving CommGroup",
               "def kCoeff (u : K) : E :=", "def op (a : A) : H →L[ℂ] H :=", "def space : Submodule ℂ H where",
               "axiom residual_fourier "]
MARK = "theorem residual_fourier_cross "

args = [a for a in sys.argv[1:] if not a.startswith("--")]
plant = "--plant" in sys.argv
base = args[0]
bad = 0


def old_new(f):
    old = subprocess.run(["git", "show", f"{base}:{f}"], capture_output=True, text=True, check=True).stdout
    new = open(f, encoding="utf-8").read()
    a, b = strip(old), strip(new)
    if plant:
        k = b.find(":=", b.rfind("import ") if "import " in b else 0)
        b = b[:k] + ":≡" + b[k + 2:]
    return a, b


for f in SAME + list(EDITS):
    a, b = old_new(f)
    note = ""
    for x, y in EDITS.get(f, []):
        c = a.count(x)
        if c != 1:
            note += f" [listed edit found {c} times in the old code: {x[:50]}…]"
            a = None
            break
        a = a.replace(x, y)
        if b.count(y) != 1:
            note += f" [listed edit's result found {b.count(y)} times in the new code]"
    same = a is not None and a == b
    print(f"{'AS-LISTED' if same else 'DIFFERS  '} {f}: {len(EDITS.get(f, []))} listed edit(s){note}")
    bad += same if plant else not same

a, b = old_new(RIG)
ia, ib = a.find(MARK), b.find(MARK)
tail_same = ia >= 0 and ib >= 0 and a[ia:] == b[ib:]
head_old, head_new = a[:ia], b[:ib]
# the head: the base's imports plus Ergodicity's, the same opens and namespaces, the deleted declarations gone
ok_head = "import Proofs.HadwigerNelson.Outside.OAI158Ergodicity" in head_new and \
    "import Proofs.HadwigerNelson.Outside.OAI158Ergodicity" not in head_old
gone = [d for d in RIG_DELETED if d in head_old and d not in head_new]
kept_tokens = [t for t in ("open scoped InnerProductSpace", "namespace HadwigerNelson.Outside.OAI158",
                           "noncomputable section", "namespace Spectral") if t in head_new]
# nothing new in the head beyond the import: every word of the new head is a word of the old head
new_words = sorted(set(head_new.split()) - set(head_old.split()))
rig_ok = tail_same and ok_head and len(gone) == len(RIG_DELETED) and len(kept_tokens) == 4 and \
    new_words == ["Proofs.HadwigerNelson.Outside.OAI158Ergodicity"]
print(f"{'AS-LISTED' if rig_ok else 'DIFFERS  '} {RIG}: the code from `{MARK.strip()}` to the end "
      f"{'the same' if tail_same else 'CHANGED'} ({len(a) - ia} characters); deleted {len(gone)} of "
      f"{len(RIG_DELETED)} listed declarations; the import added: {ok_head}; words new in the head: {new_words}")
bad += rig_ok if plant else not rig_ok
print(("plant: " if plant else "") + ("OK" if not bad else f"FAIL ({bad})"))
sys.exit(1 if bad else 0)
