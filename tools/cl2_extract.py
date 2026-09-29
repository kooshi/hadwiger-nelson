#!/usr/bin/env python3
"""CL2: extract verbatim definition passages by anchors and write data/workflow3/cl2/n7-definitions.md.

Each spec is (section, label, file, start_anchor, end_anchor). The passage is the text from the first
occurrence of start_anchor to the first end_anchor after it (inclusive), taken from the file with line
breaks joined by one space. Lines are reported. A missing anchor exits 1 (fail loud). --plant runs one
spec with an anchor that is not in the file and must exit 1.
"""
import re, sys

ROOT = "/home/kooshi/source/lean-dir/"
N3 = "plans/FS114-N3-proof.md"; N4 = "plans/FS114-N4-proof.md"; N5 = "plans/FS114-N5-proof.md"
N6 = "plans/FS114-N6-proof.md"; N7 = "plans/FS114-N7-proof.md"; NB6 = "plans/FS114-NB6-verification.md"
NP = "plans/FS114-N-proof.md"; Y2 = "plans/FS114-Y2-construction.md"; DER = "plans/FS114-derivation.md"
CL = "data/fs114/claims.md"; F112 = "plans/FS112-derivation.md"; F112N = "plans/FS112-N-proof.md"

SPECS = [
 ("N1", "tactic edge, ring, change point (notation)", N3, "a **tactic edge** (a whole unit arc", "on its two sides;"),
 ("N1", "tiles, edges, tangent direction at p", N3, "`p` is a vertex of degree 4 with tiles", "touching `x_i` at `q_i` alone)."),
 ("N1", "the sign of a tactic edge; inner count; the patterns", N3, "**The patterns.** Mark a", "one lens, two rotational, one anti-lens)."),
 ("N1", "a + edge: inner tile counter-clockwise (fragment)", N7, "A `+` edge there (inner tile counter-clockwise)", "(inner tile counter-clockwise)"),
 ("N1", "a - edge: inner tile clockwise (fragment)", N7, "a `−` edge (inner tile clockwise)", "(inner tile clockwise)"),
 ("N1", "order of the edges e1, e2, e3 (fragment of the setting of the exclusion; the source sentence goes on after `e4` at `θ_4`)", N7, "Three tactic edges among four are consecutive; call them", "with `e4` at `θ_4`"),
 ("N1", "reflection reverses the order and the signs (parenthetical only)", N7, "(which reverses the order and the signs)", "(which reverses the order and the signs)"),
 ("N1", "D_m and 'reaches' (notation)", N7, "Write `D_m = y + 30° + 60m` (indices mod 6).", "when `y_k` is in its closure."),
 ("N2", "lens, its centres, gamma (N3-SEC (iii))", N3, "(iii) A tile inner to both its edges at `p` (a **lens**", "`180° − γ ∈ [120°, 180°]`"),
 ("N2", "Reuleaux lens (fragment)", N7, "a lens is Reuleaux (", "reaching its two centres)"),
 ("N2", "Reuleaux cap region", N4, "With `P = 0`, `A = e(0°)`", "`Reul(A, B, C) ∖ B̄(P, 1)` outside it,"),
 ("N2", "the cap of the bowtie (N4's frame)", N4, "the cap (an arc of `ω(p)`) leaves `q1` at `300°`", "leaves `q1` at `300°`"),
 ("N2", "the bowtie's caps as (Q) arcs", N6, "Its caps are (Q) arcs", "the colour-3 cap tile)"),
 ("N2", "a bowtie whose lenses do not border the caps", N6, "A bowtie whose lenses do **not** border the caps", "in absent-colour tiles)"),
 ("N2", "the Reuleaux bowtie (construction side's object)", Y2, "**the Reuleaux bowtie** —", "unit arcs about `q1…q4`."),
 ("N2", "a Reuleaux bowtie includes its four tactic edges", DER, "A **Reuleaux bowtie** includes its four", "item 72)."),
 ("N2", "OC: the defining clause in the D-frame (fragment of N7-3T's proof-record statement)", N7, "in the frame above, `t2 ⊂ Reul(p, y_{a+1}, y_{a+2})`", "the **open-cap family OC**."),
 ("N2", "OC with a fourth tactic edge (fragment)", N7, "With `e4` tactic OC is the Reuleaux bowtie whose lenses do not border the caps", "`θ_4 = D_{a+5}`"),
 ("N2", "OC in the bowtie frame (parenthetical of the section 'What survives')", N7, "frame of N4's bowtie: `t1 = [300°, 60°]", "on the six 60° arcs)"),
 ("N2", "OC's frame in section 3.3", N7, "*Frame of §2.3 (N4's bowtie frame), `θ_4 ∈ (180°, 240°]`.*", "`θ_4 ∈ (180°, 240°]`.*"),
 ("N3", "the (2, 1, 1, 0) patterns and the pinwheel named by pattern (N4's table cell)", N4, "`++++` (the pinwheel), `+++−` and `++−−` (the `(2, 1, 1, 0)` patterns)", "(the `(2, 1, 1, 0)` patterns)"),
 ("N3", "the (2, 1, 1, 0) patterns, read against N3-SEC's pattern list (N5's readback line)", N5, "\"the `(2, 1, 1, 0)` patterns\": faithful to N3-SEC's pattern list", "one lens, two rotational, one anti-lens)."),
 ("N4", "the pinwheel: the pattern ++++ (N5, section 4.2)", N5, "*Pattern `++++` (N3-SEC): `t_j` has cone", "of colour `c_j`, at `q_j`."),
 ("N4", "the pinwheel (construction side's parenthetical)", Y2, "the pinwheel (each tile inner for one edge, angles ≤ 180°)", "angles ≤ 180°)"),
 ("N4", "gamma: see N2 (N3-SEC (iii)); the lens with gamma = 0 (fragment of the N7 record)", N7, "or `γ = 0°` (cone `180°`, one centre)", "one centre)"),
 ("N6", "what 'no valid fragment' refers to: valid fragment on a disc, and 'reads radius R'", CL, "**Local** *(this list)*: a statement or a step", "at distance exactly 1."),
 ("N6", "the goal statement about a disc about a four-colour vertex (claim list)", CL, "there are an explicit radius `R` and a derivation that no valid fragment exists on the", "of at least four colours."),
 ("N6", "the disc the lemmas read", N3, "Every lemma reads the disc of radius `1 + ε` about `p` unless it says otherwise", "uses no complexity bound."),
 ("N6", "non-Siamese (definition)", N6, "**non-Siamese** valid maps (no two distinct tiles of one colour close)", "of one colour close)"),
 ("N6", "simple class (definition)", N6, "**simple class** (a tile's cone at a vertex is one closed interval", "never touches itself)"),
 ("N6", "close / far", NP, "two tiles of one colour are **close** when", "every such distance is `> 1`."),
 ("N7", "unit arc and (Q)", CL, "A **unit arc** is a boundary arc of radius 1; **(Q)**", "at least four colours;"),
 ("N7", "P_cl and omega (notation)", F112N, "`P_cl(x)` the colours of tiles whose closure contains `x`", "the unit circle about `x`"),
 ("N7", "the bends, in the (Q)-free setting", N7, "the map is bent on a fragment of radius `1 + ε`", "N5-BENDG)."),
 ("N7", "the bends on a fragment (verifier's setting)", NB6, "**Bends on a fragment:** run on a fragment on a neighbourhood", "`Γ`-arc-free off its (Q) arcs."),
 ("N7", "the bends: the modification (FS-112's statement)", F112, "Every valid map has a valid modification by W-MERGE and whole-arc bends", "is (Q) or (R2)"),
 ("N7", "a four-colour vertex in the setting of the exclusion", N7, "`p = 0` a vertex of a non-Siamese valid map in the simple class carrying exactly four colours", "(so degree 4)"),
 ("N7", "a four-colour vertex in the verifier record NB6", NB6, "A **four-colour vertex** here carries", "it has degree 4."),
 ("N7", "F(M): vertices of at least four colours", F112, "`F(M)`: the vertices of at least four colours", "at least four colours;"),
 ("N7", "tip", N7, "the open cone `(ψ_k + 150°, ψ_k + 210°)` at `y_k` (the directions toward `p`) lies in cones of tiles of `p` reaching `y_k`; call such a tile a", "a **tip** at `y_k`."),
 ("N7", "faces away (N3-FACE)", N3, "**N3-FACE [hand, one mind].** *Let `T ∋ u`", "at `w` in `{v : v·(u − w) ≤ 0}`."),
 ("N7", "p's own tile of a colour (CL-p)", NB6, "(CL-p) a tile of a colour of `P_cl(p)` with a point in", "own tile of that colour"),
]


NOTES = {
 "N1": "No line states outright that a sign string such as `+-+` reads `e1 e2 e3` in counter-clockwise order; the passages above are all the source gives (`CHECK:` in the report).",
 "N2": "No separate definition found for: \"non-Reuleaux lens\" (a lens with `gamma` not 60 degrees, by the two lens passages above, is my reading only); \"60 degree anti-lens\" (anti-lens is inner count 0; \"60 degrees\" not defined, the D-frame OC passage shows `t3 = [D_{a+2}, D_{a+3}]`); \"open-cap\" (why open) ; \"members\" of OC; the word \"lune\". Defined in use, see the report's CHECK lines.",
 "N3": "No line states what the 4-tuple orders or counts. N3-SEC's inner counts (0, 1 or 2: anti-lens, rotational, lens) and its pattern list are the nearest source: see the N1 passage `The patterns`.",
 "N5": "No separate definition found; \"die in every member\" is defined in use only. Used at `plans/FS114-N7-proof.md` line 144 (\"in every member\") and in the entry's `statement:` below; not copied, since the sentence says what dies.",
}

def load(rel):
    lines = open(ROOT + rel, encoding="utf-8").read().split("\n")
    text = ""; starts = []
    for l in lines:
        starts.append(len(text)); text += l.strip() + " "
    return lines, text, starts

def line_of(starts, off):
    lo, hi = 0, len(starts) - 1
    while lo < hi:
        mid = (lo + hi + 1) // 2
        if starts[mid] <= off: lo = mid
        else: hi = mid - 1
    return lo + 1

def extract(rel, a, b):
    lines, text, starts = load(rel)
    norm = lambda s: s
    i = text.find(a)
    if i < 0:
        # allow indentation runs between wrapped lines: collapse runs of spaces in the file text
        raise SystemExit("ANCHOR NOT FOUND (start): %s :: %r" % (rel, a))
    j = text.find(b, i + (len(a) if a == b else 0)) if a != b else i
    if j < 0:
        raise SystemExit("ANCHOR NOT FOUND (end): %s :: %r" % (rel, b))
    end = j + len(b)
    piece = re.sub(r"\s+", " ", text[i:end]).strip()
    return piece, line_of(starts, i), line_of(starts, end - 1)

def fields(rel, l1, l2):
    lines = open(ROOT + rel, encoding="utf-8").read().split("\n")
    return "\n".join(x[2:] if x.startswith("  ") else x for x in lines[l1 - 1:l2]), l1, l2

HEADER = """# CL2 -- definitions for FS116-V1 (statement FS114-N7-3T), copied verbatim

*Job CL2, the Clerk, 2026-09-29. Every passage is a blockquote with its source file and lines. Within a passage, source line breaks are joined by one space; nothing else is changed. A fragment is a cut of one sentence at the quoted words. Sections N1-N7 are the verifier's questions. N5 has no passage (see its note). No route, verdict, `argument:`, `uses only:`, `minds:` or `model:` field is copied.*
"""

def main():
    if "--plant" in sys.argv:
        extract(DER, "THIS ANCHOR IS NOT IN THE FILE", "x")
        print("PLANT DID NOT FIRE"); sys.exit(0)
    out = []
    sec = None
    for s, label, rel, a, b in SPECS:
        piece, l1, l2 = extract(rel, a, b)
        if s != sec:
            if sec in NOTES: out.append("\n*Note: " + NOTES[sec] + "*\n")
            if sec == "N4" and s == "N6":
                out.append("\n## N5\n\n*Note: " + NOTES["N5"] + "*\n")
            out.append("\n## %s\n" % s); sec = s
        out.append("**%s**\n\n> %s\n\n*Source: `%s` lines %d-%d.*\n" % (label, piece.replace("\n", " "), rel, l1, l2))
    out.append("\n*Note: " + "No separate definition found for \"(Q)-free ring\" and \"(Q)-free after the bends\" as phrases; the passages above (unit arc and (Q); the bends) are what the sources give. \"tiles of p\" / \"p-tiles\": no separate definition; see the last two passages.*\n")
    out.insert(0, HEADER)
    st, a1, a2 = fields(DER, 712, 717)
    nc, b1, b2 = fields(DER, 719, 721)
    out.append("\n## The entry `derivation: FS114-N7-3T`: `statement:` and `not claimed:` (nothing else)\n")
    out.append("*Line breaks kept; the two-space indentation of the entry removed from each line; all other characters as in the file.*\n")
    out.append("**statement:**\n\n" + "\n".join("> " + x for x in st.split("\n")) + "\n\n*Source: `%s` lines %d-%d.*\n" % (DER, a1, a2))
    out.append("**not claimed:**\n\n" + "\n".join("> " + x for x in nc.split("\n")) + "\n\n*Source: `%s` lines %d-%d.*\n" % (DER, b1, b2))
    open(ROOT + "data/workflow3/cl2/n7-definitions.body.md", "w", encoding="utf-8").write("".join(out))
    print("ok", len(SPECS), "passages")

main()
