#!/usr/bin/env python3
"""FS110-NB quotation check (standing rule 5).

Each row: (label, quotation, source path, expected verdict).  A quotation is split at
"…" and each piece must occur in the source after whitespace is deleted and line-end
hyphens joined; backticks and asterisks are ignored on both sides (markdown only).
A miss prints the longest present prefix of the first missing piece.

--plant mutates one present quotation (its longest word reversed) and adds an invented
sentence; both must read MISS while the other rows keep their verdicts.
Exit status: 0 iff every row reads its expected verdict.
"""
import re
import sys

ROWS = [
    ("M_K", "periodic designs with at most `K` circular or straight arcs per tile, arc radii at least `1/K`, at most `K` tiles per unit disc",
     "plans/FS107-derivation.md", "OK"),
    ("tight", "*Tight*: slack for no `ε > 0`", "data/fs106/claims.md", "OK"),
    ("siamese", "two distinct tiles of one colour have all cross-distances `≥ 1`, or all `≤ 1`", "plans/FS107-stability.md", "MISS"),  # claims.md's address; wrong file
    ("siamese@TQ", "two distinct tiles of one colour have all cross-distances `≥ 1`, or all `≤ 1`", "plans/FS106-TQ-derivation.md", "OK"),
    ("types", "Say which multicolour a vertex carries: the *essential* one (colours of positive density at the vertex) or the *closure* one (colours of tiles whose closure contains it). They differ exactly at cusps; W-TAN's first clause holds for essential types, and is a GAP for closure types at cusps.",
     "plans/STUB-tangency-seam.md", "OK"),
    ("K-C6", "In a six-colour palette two three-element multicolours are disjoint iff complementary", "plans/FS107-derivation.md", "OK"),
    ("tan/bowtie a", "an interface at `u` tangent to the unit circle about `w₀`", "plans/FS106-TS-derivation.md", "OK"),
    ("tan/bowtie b", "with one class in two opposite sectors (**the bowtie** `4,5,4,6`)", "plans/FS106-TS-derivation.md", "OK"),
    ("cusp", "a cusp is a cone point whose tile has angle 0**: its colour has density 0 at the vertex, so a vertex with three colours in the closure has `|P(u)| = 2`, and C-T-TAN does not apply",
     "plans/FS107-VW-verification.md", "MISS"),  # verbatim bar a dropped list bullet "-" after "0**:"
    ("cusp-bullet", "a cusp is a cone point whose tile has angle 0**: - its colour has density 0 at the vertex, so a vertex with three colours in the closure has `|P(u)| = 2`, and C-T-TAN does not apply",
     "plans/FS107-VW-verification.md", "OK"),
    ("ring junction", "a ring junction (three colours filling `B(x, s) ∖ B(x, r)`)", "plans/FS107-derivation.md", "OK"),
    ("sliver", "unless a colour is a sliver near `θ ± 90°`", "plans/FS107-derivation.md", "OK"),
    ("fat junction", "three arcs `I_a, I_b, I_c` with truncated cones `K(x, I_j; r, s) ⊆ C_j` (`r` the void's radius, `s` the scale); it **blocks direction `θ` on side `σ` with margin `µ`** if each `I_j` meets the open arc of half-width `π/2 − µ` about `θ` (or `θ + π`)",
     "plans/FS107-derivation.md", "OK"),
    ("V-C5", "At a fixed scale `s`, a ring junction (three colours filling `B(x, s) ∖ B(x, r)`) with an interface exactly along `e_u^⊥` still forces a band of depth `≍ s²/2` on the inner side: configuration C5 forces area `6.8·10⁻⁵` at `s = 0.1` against an exactly tangent interface.",
     "plans/FS107-derivation.md", "OK"),
    ("V-C5 kill", "a ring junction and a direction `θ` with no forced band on either side.", "plans/FS107-V-verification.md", "OK"),
    ("W-TAN", "In a full tight a.e.-proper six-colouring by a locally finite map whose boundaries are C¹ arcs with tangents at the vertices, two vertices at distance `< 2` whose essential multicolours are complementary three-sets form a tangent pair or include a bowtie; off those and the collinear distance-2 configuration, the three-element (and larger) vertex types of two adjacent tiles pairwise intersect. At a cusp vertex (a tile of angle 0), with types read as closure multicolours, it is a GAP.",
     "plans/FS107-derivation.md", "OK"),
    ("C-T-TAN", "Let `k = 6`, `|u − v| < 2`, `P(u) ∩ P(v) = ∅`, `|P(u)| = |P(v)| = 3`. Suppose that along one sequence `r_n → 0` the rescaled classes … converge in `L¹_loc` … **If `T_u` and `T_v` both have positive length, the configuration does not occur.**",
     "plans/FS106-TS-derivation.md", "OK"),
    ("C-T-TAN six", "(all six classes are in `P(u) ∪ P(v)`)", "plans/FS106-TS-derivation.md", "OK"),
    ("TS-U", "a unit-arc boundary with colours `c | c′` puts `c` in the wedge facing it and `c′` in the wedge facing away at its centre, and neither in the two side cones",
     "plans/FS106-TS-derivation.md", "OK"),
    ("K-KILL 2", "Same multicolour at distance in `(1, 2)`: Lemma 3's transplanted bicycle needs C-T-ANN's curves and C-T-IND's finiteness.", "plans/FS106-TS-derivation.md", "OK"),
    ("C-T-BIKE", "**GAP — undecided here**; the step named: an explicit proper 3-colouring of `T₁(u) ∪ T₁(v)` by finitely many arcs (or a proof none exists), for each `d = |u − v| ∈ (1, 2)`",
     "plans/FS106-TS-derivation.md", "OK"),
    ("K-CHR4", "**GAP** — proved for `|P(x)| ≥ 5` off a null set; `|P(x)| = 4` open", "plans/FS106-TS-derivation.md", "OK"),
    ("Townsend", "So the counterexample is right, and **sharp at `2π/3`**. It uses a boundary that is a **unit arc**", "plans/FS106-V-verification.md", "OK"),
    ("VW 2b.4", "**But a bichromatic vertex of degree `≥ 4` has a two-element type**, e.g. `{1, 2}`. It can be disjoint from a three-set `{3, 4, 5}` or a four-set `{3, 4, 5, 6}` without either being a complementary three-set, and C-T-TAN says nothing about such pairs. These vertices are live: row 132 names them as where hole-filling fails.",
     "plans/FS107-VW-verification.md", "OK"),
    ("IND-X", "At a unit-arc interface facing a bowtie (or a 4-chromatic point) — configuration C5 with a colour in the side cones at y — complementary translate curves swap and |Ind γ₁ − Ind γ₂| = 2; the swap needs a unit-arc interface whenever the curves cross non-tangentially.",
     "plans/FS106-derivation.md", "OK"),
    ("AE-Q2 G2", "[G2] Cor. 2's annulus at a bowtie, at a unit-arc boundary through u, at spiralling boundaries", "plans/FS106-derivation.md", "OK"),
    ("rule0", "From here on out, you may doubt your ability to tackle the difficulty of the problems we encounter. Don't. You are capable, and you will surprise yourself.", "CLAUDE.md", "OK"),
    ("rule3", "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time", "CLAUDE.md", "OK"),
    ("rule3b", "search for a finite graph is out. It would be huge, not feasible.", "CLAUDE.md", "OK"),
    ("rule4", "A proven theorem about why its impossible is also valid. All novel knowledge is a success", "CLAUDE.md", "OK"),
]


def norm(s: str) -> str:
    s = re.sub(r"-\s*\n\s*", "", s)
    return re.sub(r"[\s`*]", "", s)


def check(rows):
    bad = 0
    for label, quote, src, want in rows:
        try:
            text = norm(open(src, encoding="utf-8").read())
        except FileNotFoundError:
            print(f"{label:14} MISSING-SOURCE {src}")
            bad += 1
            continue
        got, detail = "OK", ""
        for piece in quote.split("…"):
            p = norm(piece)
            if p and p not in text:
                got = "MISS"
                k = 0
                while k < len(p) and p[: k + 1] in text:
                    k += 1
                detail = f"longest present prefix {k}/{len(p)}: {p[:k][-40:]!r}"
                break
        flag = "" if got == want else "   <-- UNEXPECTED"
        bad += got != want
        print(f"{label:14} {got:4} (want {want}) {src} {detail}{flag}")
    return bad


def planted(rows):
    rows = list(rows)
    label, quote, src, _ = rows[3]
    w = max(quote.split(), key=len)
    rows[3] = (label + "-PLANT", quote.replace(w, w[::-1], 1), src, "MISS")
    rows.append(("invented", "The tangency seam is closed at every scale by Theorem Z.", "plans/FS107-derivation.md", "MISS"))
    return rows


if __name__ == "__main__":
    rows = planted(ROWS) if "--plant" in sys.argv else ROWS
    bad = check(rows)
    print(f"rows={len(rows)} unexpected={bad}")
    sys.exit(1 if bad else 0)
