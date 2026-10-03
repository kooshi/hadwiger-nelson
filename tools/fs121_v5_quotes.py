#!/usr/bin/env python3
"""FS121-V5 readback: quotation checks (standing rule 3).

Two checks, standard library only, paths relative to the repository root.

1. The brief's three statements (blockquoted lines in data/fs121/briefs/FS121-V5-verify.md, read only for
   this check, the brief being this job's own) against data/fs121/claims.md section 8, character for
   character: the brief line with its leading "> " removed must equal a line of the list exactly.
2. Each definitional quotation the list (data/fs121/claims.md) makes "verbatim" and that this job uses,
   against its named source: the quotation must occur in the source after whitespace runs are collapsed
   to one space (line wrapping is the only freedom allowed).

Usage:
  python3 tools/fs121_v5_quotes.py            # prints one line per check, then a count; exit 0 iff all pass
  python3 tools/fs121_v5_quotes.py --quiet    # the count line only (for the gate's control)
  python3 tools/fs121_v5_quotes.py --fault    # plants one changed character in every quotation and every
                                              # brief statement; every check must then FAIL (exit 0 iff all fail)
"""
import re
import sys

BRIEF = "data/fs121/briefs/FS121-V5-verify.md"
LIST = "data/fs121/claims.md"
NAMES = ["FS121-D2-SYM", "FS121-D4-FACE", "FS121-D4-GRID"]

# (label, source file, a substring of the list that is the quotation, as the list prints it)
QUOTES = [
    ("D-NF", "data/fs106/claims.md",
     "proper at `Leb ⊗ σ`-almost every edge: `S_j = f⁻¹(j)`; `S̃_j` the points of density 1 of `S_j`; `E = ℝ² ∖ ⋃_j S̃_j` (Falconer's null set)"),
    ("D-NF P(x)", "data/fs106/claims.md",
     "`d̄_j(x) = limsup_{r→0} |S_j ∩ B(x, r)|/|B(x, r)|`; **`P(x) = {j : d̄_j(x) > 0}`**, the *essential multicolour*."),
    ("saturated", "plans/FS111-M-regularity.md",
     "every essential boundary point is at distance exactly 1 from the support of each colour of its essential multicolour"),
    ("honest", "plans/FS111-derivation.md", "an honest (one colour per point) saturated one"),
    ("H1 H2", "plans/FS111-M-regularity.md",
     "**(H1)** at `x`: a ball `N = B(x, ρ)` in which `S_c` is null for `c ∉ {a, b}`. **(H2)** at `x`: in `N`, `S_a` and `S_b` are each a.e. equal to a connected open set of density points, `P_a ⊆ S̃_a`, `P_b ⊆ S̃_b`, with `x ∈ cl P_a ∩ cl P_b`"),
    ("Sigma", "plans/FS111-M2-regularity.md",
     "the essential boundary points at which M-PINCH's hypotheses (H1), (H2) fail, together with every point of `supp S_j` at which `S_j` has density 0 (cusps)"),
    ("REG-J'", "data/fs111/claims.md",
     "**REG-J′_k**: a saturated colouring whose singular set Σ is locally finite, **each point of Σ meeting finitely many interface arcs** (the clause two briefs dropped)"),
    ("LRA", "plans/FS111-M2-regularity.md",
     "**infinitely many arcs can accumulate at a point only with radii tending to infinity** (call that **LRA**, large-radius accumulation; not excluded here)"),
    ("kind both", "plans/FS111-M-regularity.md",
     "(split) is a **unit arc of kind both** (row 135's term): its centre `y` carries both side colours."),
    ("M-PINCH", "plans/FS111-derivation.md",
     "at a saturated point x of an honest a.e.-proper colouring with a neighbourhood N in which only two colours a, b have positive measure and each is a.e. one connected open set of density points (H1, H2): either N is split by one unit circle T₁(y) with a inside and b outside or the reverse, y a contact of both colours, or two open unit discs tangent at x from opposite sides lie a.e. in S_a and in S_b; the case (in, in) is impossible; no positive density of the partner is needed"),
    ("M2-INTRAD", "plans/FS111-derivation.md",
     "in an honest saturated colouring whose singular set Σ is locally finite with finitely many interface arcs at each point (REG-J′), the unit parallel of every tangent-type interface arc is again an interface arc, so radii of curvature drop by exactly 1 toward the centre and stop at 1: every interface has integer radius of curvature almost everywhere and is locally a chain of segments and circular arcs, finitely many of each radius"),
    ("FS112-N3-NOBOTH", "plans/FS112-derivation.md",
     "The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour."),
    ("W-NOREP", "plans/FS111-derivation.md",
     "at a cone vertex of a saturated map without cusps, no colour occupies two sectors"),
    ("W-LADDER", "plans/FS111-derivation.md",
     "a flat edge of a saturated map carries interfaces at every unit translate along its normal, with the colour rule β_{k+1} = τ_{k−1}"),
]


def norm(s):
    return re.sub(r"\s+", " ", s).strip()


def plant(s):
    """Change one character near the middle (a letter becomes 'Q', anything else becomes 'Q' too)."""
    i = len(s) // 2
    return s[:i] + ("Z" if s[i] == "Q" else "Q") + s[i + 1:]


def main():
    fault = "--fault" in sys.argv[1:]
    quiet = "--quiet" in sys.argv[1:]
    results = []
    with open(LIST, encoding="utf-8") as fh:
        list_text = fh.read()
    list_lines = list_text.splitlines()
    with open(BRIEF, encoding="utf-8") as fh:
        brief_lines = fh.read().splitlines()
    # 1. the brief's statements against the list, verbatim
    for name in NAMES:
        bl = [ln for ln in brief_lines if ln.startswith("> - **" + name + "**")]
        if len(bl) != 1:
            results.append((f"brief {name}", False, f"{len(bl)} brief lines"))
            continue
        stmt = bl[0][2:]
        if fault:
            stmt = plant(stmt)
        hit = stmt in list_lines
        results.append((f"brief {name} vs {LIST} §8", hit, f"{len(stmt)} chars"))
    # 2. the list's quotations against their sources
    nlist = norm(list_text)
    for label, src, q in QUOTES:
        in_list = norm(q) in nlist
        with open(src, encoding="utf-8") as fh:
            srctext = norm(fh.read())
        qq = plant(q) if fault else q
        in_src = norm(qq) in srctext
        results.append((f"quote {label}: in list {in_list}, in {src}", in_list and in_src, f"{len(q)} chars"))
    npass = sum(1 for _, ok, _ in results if ok)
    for lab, ok, info in results:
        if not quiet:
            print(("PASS " if ok else "FAIL ") + lab + f" ({info})")
    print(f"checks: {len(results)}  pass: {npass}  fail: {len(results) - npass}  mode: {'fault' if fault else 'clean'}")
    if fault:
        return 0 if npass == 0 else 1
    return 0 if npass == len(results) else 1


if __name__ == "__main__":
    sys.exit(main())
