#!/usr/bin/env python3
"""Build data/viz/local-global-map/facts.json — the one table every mark of the Local–Global Map is drawn from (crunch job J43).

Every hand-authored fact carries: its value, the page's grade, the source's own grade words (`graw`), a source address, and a
pattern (`pat`, with {v} = the value, {g} = the source's grade words, {w} = the English word for value-1) that must occur verbatim
in the source after normalisation (markdown bold and backticks removed, whitespace collapsed). `gpat`, when given, is a second
pattern carrying the grade. A `scope` of {"row": n} or {"B": id} restricts both patterns to one LEDGER.md row or § B entry.
The checker (tools/viz_local_global_map_check.py) re-reads every one of them; this builder only assembles.

Usage: python3 tools/viz_local_global_map_build.py        (writes the facts table)
"""
import json, re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[1]
OUT = ROOT / "data/viz/local-global-map/facts.json"
sys.path.insert(0, str(ROOT / "tools"))
from viz_local_global_map_common import (fold, parse_ledger, row_grade, stable_state, dyadic_state, TAG_RULES, tags_of,
                                         CRUNCH_B, CRUNCH_ROWS)

W = "data/fs53/window.md"; LG = "LEDGER.md"; CM = "CLAUDE.md"; FJ = "data/fplane/map.json"
P47 = "plans/POROS-2026-09-25-wanted-poster-47.md"; P59 = "plans/POROS-2026-09-25-wanted-poster-59.md"
P167 = "plans/POROS-2026-09-25-wanted-poster-167.md"; PIMP = "plans/POROS-2026-09-25-infinitely-many-primes.md"
FS100 = "plans/STUB-measure-rigidity-three-fields.md"; KT1 = "plans/FS100-KT1-ambrus-ball.md"


def F(id, label, v, grade, graw, src, pat, gpat=None, scope=None, **kw):
    d = dict(id=id, label=label, v=v, grade=grade, graw=graw, src=src, pat=pat)
    if gpat: d["gpat"] = gpat
    if scope: d["scope"] = scope
    d.update(kw); return d

# ---------------------------------------------------------------- places (columns)
PLACES = [dict(id="inf", label="the real place", kind="real")] + [dict(id="2", label="the place above 2", kind="dyadic")] + \
    [dict(id=str(q), label=f"the prime {q}", kind="p3") for q in (3, 7, 11, 19, 23, 27, 31, 43, 47, 59, 67, 71, 79, 83)] + \
    [dict(id="big", label="every larger prime ≡ 3 (mod 4)", kind="p3big")] + \
    [dict(id=str(q), label=f"the prime {q}", kind="p1") for q in (5, 13, 17, 29)] + \
    [dict(id="p1big", label="every larger prime ≡ 1 (mod 4)", kind="p1big")]

# ---------------------------------------------------------------- the finite targets: floor = fewest colours proven needed; cap = a colouring exists
T = []
def tgt(q, end, v, grade, graw, src, pat, gpat=None, scope=None, what=None):
    T.append(F(f"t.{q}.{end}", what or (f"the plane over the {q}-element field needs at least {v} colours" if end == "floor"
               else f"a {v}-colouring of the plane over the {q}-element field exists"), v, grade, graw, src, pat, gpat, scope,
               place=str(q), end=end))
tgt(3, "floor", 3, "measured", "exact", FJ, '"3": {{ "kind": "{g}", "value": {v},')
tgt(3, "cap", 3, "measured", "exact", FJ, '"3": {{ "kind": "{g}", "value": {v},')
tgt(7, "floor", 4, "certificate", "[cert]", LG, "none at 7 {w}-colourable", gpat="{g} Exact integer sum-of-squares certificates", scope={"row": 75})
tgt(7, "cap", 4, "measured", "exact", FJ, '"7": {{ "kind": "{g}", "value": {v},')
tgt(11, "floor", 5, "kernel", "[kernel]", W, "χ(UD(𝔽₁₁,2)) = {v} {g}")
tgt(11, "cap", 5, "kernel", "[kernel]", W, "χ(UD(𝔽₁₁,2)) = {v} {g}")
tgt(19, "floor", 5, "certificate", "[cert]", LG, "no level at 11 or 19 is {w}-colourable", gpat="{g} Exact integer sum-of-squares certificates", scope={"row": 75})
tgt(19, "cap", 5, "measured", "[solver]", W, "χ(UD(𝔽₁₉,2)) = {v} {g}")
tgt(23, "floor", 6, "certificate", "[cert]", W, "| {v} {g} (FS-56) | 8 [kernel]")
tgt(23, "cap", 8, "kernel", "[kernel]", W, "6 [cert] (FS-56) | {v} {g} |")
tgt(27, "floor", 6, "certificate", "[cert]", W, "three-point 147) | {v} {g} |")
tgt(27, "cap", 7, "measured", "[search]", W, "three-point 147) | 6 [cert] | {v} {g} |")
tgt(31, "floor", 5, "measured", "[exact]", W, "| 200 [cert] | {v} {g} |")
tgt(31, "cap", 8, "measured", "[search]", W, "| 200 [cert] | 5 [exact] | {v} {g} |")
tgt(43, "floor", 6, "certificate", "[cert]", W, "| 365 [cert] | {v} {g} |")
tgt(43, "cap", 8, "measured", "[search]", W, "| 365 [cert] | 6 [cert] | {v} {g} |")
tgt(47, "floor", 6, "certificate", "[cert]", W, "| 371 [cert] | {v} {g} |")
tgt(47, "cap", 10, "measured", "[search]", W, "| 371 [cert] | 6 [cert] | {v} {g} |")
tgt(59, "floor", 7, "certificate", "[cert]", W, "| 575 [cert] | {v} {g} |")
tgt(59, "cap", 10, "measured", "[search]", W, "| 575 [cert] | 7 [cert] | {v} {g} |")
tgt(67, "floor", 7, "certificate", "[cert]", W, "| 745 [cert] | {v} {g} |")
tgt(67, "cap", 12, "measured", "[search]", W, "| 745 [cert] | 7 [cert] | {v} {g} |")
tgt(71, "floor", 7, "measured", "[exact]", W, "χ(UD(𝔽₇₁,2)) ≥ {v} {g}")
tgt(79, "floor", 7, "certificate", "[cert]", W, "| 1023 [cert] | {v} {g} |")
tgt(83, "floor", 7, "certificate", "[cert]", W, "χ(UD(𝔽₈₃,2)) ≥ {v} {g}")
tgt("big", "floor", 7, "measured", "[derived + measured; ω facts prior art]", CM, "χ > 6 from p = 103",
    gpat="G44 — Kloosterman control. {g}", what="every plane at a prime ≡ 3 (mod 4) from 103 up needs at least 7 colours (Weil's bound on its spectrum)")
tgt("2r", "cap", 2, "hand-1", "[proof]", LG, "ramified gives χ(F²) ≤ {v} at any norm", gpat="{g} The 2-adic trichotomy", scope={"row": 70},
    what="where the place above 2 is ramified in F(i), the plane is 2-coloured through it")
tgt("2i", "cap", 4, "hand-1", "[proof]", LG, "U_Q is {v}-colourable for Q ≤ 32", gpat="{g} The 2-adic trichotomy", scope={"row": 70},
    what="where the place above 2 is inert in F(i) with residue field of at most 32 elements, its target is 4-colourable")
tgt("2i64", "floor", 6, "hand-1", "[proof]", LG, "{v} ≤ χ(U₆₄) ≤ 8", gpat="{g} The 2-adic trichotomy", scope={"row": 70},
    what="the inert target of norm 64 (fields of degree 12 and up only) needs 6 to 8 colours: the wall at six's sixth member")
tgt("inf", "floor", 5, "kernel", "@lean", LG, "chromaticNumber_plane_interval: {v} ≤ χ(ℝ²) ≤ 7", scope={"row": 33},
    what="the real place's plane is ℝ² itself: it needs at least 5 colours")
tgt("inf", "cap", 7, "kernel", "@lean", LG, "chromaticNumber_plane_interval: 5 ≤ χ(ℝ²) ≤ {v}", scope={"row": 33},
    what="the hexagonal 7-colouring of the plane (by the norm-7 Eisenstein ideal) — pulled back, it colours every field's plane")

# character chromatic numbers (a character colouring is x ↦ ⌊kθ(x)⌋; it sits above the plain colourings)
CH = [F("ch.11", "character colourings of the plane at 11 need 6 colours (one more than its 5)", 6, "hand-2", "@row", LG,
        "χ_char(Γ₁₁) = {v} > χ(Γ₁₁) = 5", scope={"row": 101}, place="11"),
      F("ch.23", "character colourings of the plane at 23 need 8 colours", 8, "hand-2", "@row", LG, "χ_char(Γ₂₃) = {v}", scope={"row": 101}, place="23"),
      F("ch.43", "character colourings of the plane at 43 need 9 colours", 9, "hand-2", "@row", LG, "χ_char(Γ₄₃) = {v}", scope={"row": 101}, place="43"),
      F("ch.27", "the plane at 27 has no character colouring at all", "∞", "hand-2", "@row", LG, "χ_char(Γ₂₇) = {v}", scope={"row": 101}, place="27")]

# ---------------------------------------------------------------- fields (rows)
GROUPS = [
    ("g2", "Two colours: the place above 2 is ramified, and the plane splits in two"),
    ("g3", "Three colours: a prime whose plane has 9 points caps the field at three"),
    ("g4a", "Four, capped at the place above 2 — the 2-adic wall stands"),
    ("g4b", "Four, capped by the plane at 7 — the 2-adic wall is broken"),
    ("g5", "The lowest plane is at 11 or 19: the conjecture says five"),
    ("g6", "The lowest plane is in the window (23, 27, 31, 43, 47): six or more"),
    ("g7", "Every plane needs seven or more"),
    ("gR", "The plane itself"),
]
FIELDS = [
    dict(id="Q", name="ℚ", group="g2", rad=[]), dict(id="Q2", name="ℚ(√2)", group="g2", rad=[2]),
    dict(id="Q5", name="ℚ(√5)", group="g2", rad=[5], note="the golden-ratio plane"),
    dict(id="Q3", name="ℚ(√3)", group="g3", rad=[3]), dict(id="Q7", name="ℚ(√7)", group="g3", rad=[7]),
    dict(id="Q11", name="ℚ(√11)", group="g4a", rad=[11]), dict(id="K", name="K = ℚ(√3,√11)", group="g4a", rad=[3, 11], note="the Moser spindle's field"),
    dict(id="K35", name="K(√35)", group="g4a", rad=[3, 11, 35]), dict(id="Q2_3", name="ℚ(√2,√3)", group="g4a", rad=[2, 3]),
    dict(id="Q59", name="ℚ(√59)", group="g4a", rad=[59], note="type (B): triangle-free, one tight place"),
    dict(id="Q83", name="ℚ(√83)", group="g4a", rad=[83], note="type (B)"), dict(id="Q131", name="ℚ(√131)", group="g4a", rad=[131], note="type (B)"),
    dict(id="Q23", name="ℚ(√23)", group="g4b", rad=[23]), dict(id="Q71", name="ℚ(√71)", group="g4b", rad=[71]),
    dict(id="Q95", name="ℚ(√95)", group="g4b", rad=[95]), dict(id="Q191", name="ℚ(√191)", group="g4b", rad=[191]),
    dict(id="Qa7", name="ℚ(α,√7), α³ = α + 1", group="g4b", rad=None, special={"7": "stable"}, note="a cubic field; only its plane at 7 is recorded here"),
    dict(id="Q47", name="ℚ(√47)", group="g5", rad=[47], note="the conjecture's cheapest exposed five"),
    dict(id="Q143", name="ℚ(√143)", group="g5", rad=[143]), dict(id="Q311", name="ℚ(√311)", group="g5", rad=[311]),
    dict(id="Q335", name="ℚ(√335)", group="g5", rad=[335]), dict(id="Q3_5", name="ℚ(√3,√5)", group="g5", rad=[3, 5]),
    dict(id="K5", name="K(√5)", group="g5", rad=[3, 5, 11], note="Heule's field"), dict(id="K247", name="K(√247)", group="g5", rad=[3, 11, 247]),
    dict(id="Q167", name="ℚ(√167)", group="g6", rad=[167], note="the widest gap: proven 4, predicted six or more"),
    dict(id="Q1055", name="ℚ(√1055)", group="g6", rad=[1055]), dict(id="Q4703", name="ℚ(√4703)", group="g6", rad=[4703]),
    dict(id="Q2351", name="ℚ(√2351)", group="g6", rad=[2351]),
    dict(id="C79", name="a cubic field × ℚ(√79)", group="g6", rad=None, special={"27": "stable", "43": "stable", "79": "stable", "2": "split"},
         note="x³ + 2x² − 3x − 2 with √79: the smallest field found that sees 27; places recorded below 100 only"),
    dict(id="K7", name="K(√7)", group="g7", rad=[3, 7, 11], note="where the ρ₆₃ arena lives; the conjecture says seven"),
    dict(id="DG", name="de Grey's field K(√5,√7)", group="g7", rad=[3, 5, 7, 11]),
    dict(id="R", name="ℝ — the whole plane", group="gR", rad=None, special="R"),
]

# field-level facts: the proven lower bound (and, where recorded, an upper bound that beats the lowest cap)
R82 = dict(grade="hand-2", graw="@row", src=LG, pat="χ(ℚ(√d)²) ≥ 4 for every squarefree d ≡ 11 (mod 12)", scope={"row": 82})
FL = []
def lo(fid, v, **k):
    d = dict(k); FL.append(F(f"f.{fid}.lo", d.pop("label", f"{fid}: at least {v} colours"), v, d.pop("grade"), d.pop("graw"), d.pop("src"), d.pop("pat"),
                             d.pop("gpat", None), d.pop("scope", None), field=fid, end="lo", **d))
def hi(fid, v, **k):
    d = dict(k); FL.append(F(f"f.{fid}.hi", d.pop("label", f"{fid}: at most {v} colours"), v, d.pop("grade"), d.pop("graw"), d.pop("src"), d.pop("pat"),
                             d.pop("gpat", None), d.pop("scope", None), field=fid, end="hi", **d))
G55two = dict(grade="hand-1", graw="hand, GPT Astra", src=CM, pat="χ(F²) = {v} ⟺ L(F) = 2 for every real number field", gpat="[{g} (OpenAI,")
for f in ("Q", "Q2", "Q5"): lo(f, 2, label="two colours are needed (a unit edge) and suffice (the local bound is 2)", **G55two)
FI3 = dict(grade="hand-1", graw="[external]", src=CM, pat="[Fischer1990] Thms 8–9: χ = 2 iff d ≢ 3 mod 4, χ = {v} for d ≡ 3, 7 mod 12", external=True,
           gpat="{g} (claimed in the literature, unchecked here)", rule="d ≡ 3, 7 (mod 12)")
for f in ("Q3", "Q7"): lo(f, 3, label="three colours: Fischer 1990 (d ≡ 3, 7 mod 12)", **FI3)
lo("Q11", 4, label="at least 4, by a 204-point graph checked in the kernel", grade="kernel", graw="[kernel, standard three axioms", src=LG,
   pat="four_le_chromaticNumber_planeOver_eleven: {v} ≤ χ", gpat="{g}", scope={"row": 73})
lo("K", 4, label="exactly 4 — Theorem B, kernel-checked (the value is Fischer 1994's)", grade="kernel", graw="@lean", src=LG,
   pat="chromaticNumber_seamPlane, χ(K²) = {v}", scope={"row": 57})
hi("K", 4, label="Theorem B's colouring: residue maps onto the 4-element field at the two primes above 2", grade="kernel", graw="@lean",
   src=LG, pat="chromaticNumber_seamPlane, χ(K²) = {v}", scope={"row": 57})
lo("K35", 4, label="at least 4, because it contains K", grade="kernel", graw="@lean", src=LG,
   pat="chromaticNumber_seamPlane, χ(K²) = {v}", scope={"row": 57}, rule="contains K")
lo("Q2_3", 4, label="at least 4, by six chained rhombi, checked in the kernel", grade="kernel", graw="@row", src=LG,
   pat="χ(ℚ(√2,√3)²) ≥ {v} by six chained rhombi", scope={"row": 103})
for f in ("Q59", "Q83", "Q131", "Q23", "Q71", "Q95", "Q191", "Q47", "Q143", "Q311", "Q335", "Q167", "Q1055", "Q4703", "Q2351"):
    lo(f, 4, label="at least 4: every real quadratic field with d ≡ 11 (mod 12) needs four", rule="d ≡ 11 (mod 12)", **R82)
lo("Qa7", 4, label="exactly 4", grade="hand-2", graw="@row", src=LG, pat="χ(ℚ(α,√7)²) = {v}, α³ = α + 1", scope={"row": 99})
hi("Qa7", 4, label="exactly 4 (by its plane at 7)", grade="hand-2", graw="@row", src=LG, pat="χ(ℚ(α,√7)²) = {v}, α³ = α + 1", scope={"row": 99})
lo("Q3_5", 4, label="at least 4 (no prime with a 3-point residue field; √3 in the field)", grade="hand-1", graw="hand, GPT Astra", src=CM,
   pat="ℚ(√335) and ℚ(√3,√5), where four is proven", gpat="[{g} (OpenAI,")
lo("K5", 5, label="at least 5: Heule's 510-point graph lies in this field (kernel)", grade="kernel", graw="@lean", src=LG,
   pat="chromaticNumber_heule510 (= {v})", scope={"row": 53}, rule="Heule-510 ⊂ K(√5)")
lo("DG", 5, label="at least 5: it contains Heule's field (and holds de Grey's graph)", grade="kernel", graw="@lean", src=LG,
   pat="chromaticNumber_heule510 (= {v})", scope={"row": 53}, rule="K(√5) ⊂ de Grey's field")
lo("K247", 5, label="exactly 5", grade="measured", graw="[hand + tools]", src=LG, pat="χ(K(√5)²) = χ(K(√247)²) = {v}", gpat="{g} The finite-plane bound", scope={"row": 52})
lo("K7", 5, label="at least 5: the ρ₆₃ arena, 51,133 points, refuses four (solver; one object)", grade="measured", graw="[tools]", src=LG,
   pat="At n = 16: χ(arena) = {v} exactly", gpat="{g} A five-chromatic unit-distance graph in a 6-OPEN field", scope={"row": 64})
lo("C79", 3, label="at least 3: it contains ℚ(√79), and 79 ≡ 7 (mod 12)", **dict(FI3, rule="contains ℚ(√79); 79 ≡ 7 (mod 12)"))
lo("R", 5, label="at least 5 (de Grey's graph, kernel-checked here)", grade="kernel", graw="@lean", src=LG,
   pat="chromaticNumber_plane_interval: {v} ≤ χ(ℝ²) ≤ 7", scope={"row": 33})
FL.append(F("f.all.hi7", "every field's plane is 7-colourable: the plane's own hexagonal colouring restricts to it", 7, "kernel", "@lean",
            LG, "chromaticNumber_plane_interval: 5 ≤ χ(ℝ²) ≤ {v}", scope={"row": 33}, field="*", end="hi"))

# ---------------------------------------------------------------- colourings we own, beyond the caps
OWN = [
    F("own.K.dyadic", "every four-colouring of K's plane is, on each coset, a pullback from one of the two places above 2 — local at one place", 4,
      "hand-2", "@row", LG, "Every four-colouring of the plane over K = ℚ(√3, √11) is, on each R_K-coset, a pullback", scope={"row": 89}, field="K", place="2", kind="dyadic"),
    F("own.K.fischer", "Fischer's additive ℤ/4-colouring of K's plane (1994): a different four-colouring, local at 2 at a deeper level", 4,
      "hand-1", "[external]", LG, "an additive ℤ/4-colouring of the whole plane over his congruence family", gpat="read in full and verified 2026-09-22",
      scope={"row": 57}, field="K", place="2", kind="additive", external=True),
    F("own.dG.9120", "de Grey's lattice has exactly 9,120 four-colourings, each periodic and local at one prime above 2", 4, "hand-2", "@row", LG,
      "exactly 9,120", scope={"row": 85}, field="K", place="2", kind="periodic"),
    F("own.B.pull", "over the type-(B) fields every periodic four-colouring is a pullback from the place above 2", 4, "hand-2", "@row", LG,
      "every periodic one is local at the dyadic place", scope={"row": 88}, field="Q59", place="2", kind="dyadic"),
    F("own.Q11.nonper", "an explicit non-periodic four-colouring of ℚ(√11)'s plane, by formula — possible because its plane at 7 is slack", 4,
      "hand-2", "@row", LG, "an explicit non-periodic four-colouring of ℚ(√11)'s plane by formula", scope={"row": 94}, field="Q11", place="7", kind="nonperiodic"),
    F("own.chi.167", "given the class theorem for characters: character colourings of ℚ(√167)'s plane need exactly 8", 8, "hand-2", "@row",
      LG, "ℚ(√167)'s, K(√7)'s and de Grey's planes need exactly {v}, 17 and 22 colours", scope={"row": 101}, field="Q167", kind="character"),
    F("own.chi.K7", "given the class theorem: character colourings of K(√7)'s plane need 17", 17, "hand-2", "@row", LG,
      "ℚ(√167)'s, K(√7)'s and de Grey's planes need exactly 8, {v} and 22 colours", scope={"row": 101}, field="K7", kind="character"),
    F("own.chi.DG", "given the class theorem: character colourings of de Grey's field's plane need 22", 22, "hand-2", "@row", LG,
      "ℚ(√167)'s, K(√7)'s and de Grey's planes need exactly 8, 17 and {v} colours", scope={"row": 101}, field="DG", kind="character"),
]

# ---------------------------------------------------------------- the shadows (wanted posters)
def carve(id, what, extent, grade, graw, src, pat, gpat=None, scope=None, places=None):
    return F(id, what, "", grade, graw, src, pat, gpat, scope, extent=extent, places=places)
SHADOWS = [
  dict(id="sh.47", field="Q47", k=4, title="A four-colouring of ℚ(√47)'s plane",
       why="It would falsify the conjecture's cheapest exposed prediction (exactly five).",
       carves=[
         carve("sh.47.c1", "not a colouring through any place with a finite plane, at any depth: every such plane needs five or more", "every finite plane",
               "certificate", "[cert + hand] at 11, 19", P47, "{g}; [tools exact] at 23, 31, 43", places="bars"),
         carve("sh.47.c2", "not periodic: no four-colouring is invariant under any finite-index subgroup", "every period",
               "hand-2", "[hand + cert + tools exact; two derivations (S1, S1V blind)]", P47, "No proper four-colouring of Cay(R, U) is invariant under a finite-index subgroup", gpat="{g}"),
         carve("sh.47.c3", "not a character colouring (no character puts every unit vector in the band)", "one character",
               "hand-2", "@row", LG, "ℚ(√47)'s plane has no character four-colouring (Θ₄ = ∅)", scope={"row": 96}),
         carve("sh.47.c4", "not a measurable window read off finitely many places", "finitely many places",
               "hand-2", "[hand, two derivations]", P47, "no measurable window four-colouring exists at all", gpat="{g}; rests on [AmbrusEtAl2023]"),
         carve("sh.47.c5", "its invariant measure's spectrum is carried by no finite set of split places (torsion + archimedean + finitely many): it reads infinitely many split places in aggregate", "any finite set of places",
               "hand-2", "@row", LG, "reading infinitely many split places in aggregate", scope={"row": 113}, places="horizon"),
       ],
       remains="the invariant random four-colourings with no proper factor colouring continuous at finitely many places",
       remains_src=dict(src=FS100, pat="the invariant random four-colourings with no proper factor colouring continuous at finitely many places"),
       closes="FS-100's one missing lemma, MR (a Furstenberg-type measure rigidity statement), would close it: then χ(ℚ(√47)²) = 5"),
  dict(id="sh.59", field="Q59", k=4, title="A four-colouring of ℚ(√59)'s plane that is not a pullback from the place above 2",
       why="Its existence is the whole of four-colour rigidity over the type-(B) fields ℚ(√59), ℚ(√83), ℚ(√131) — one forced pair, (0, 4), undecided.",
       carves=[
         carve("sh.59.c1", "not periodic: every periodic four-colouring is local at the place above 2", "every period",
               "hand-2", "[hand, two derivations]", P59, "every periodic one is local at the dyadic place (P(R) = R ∩ 𝔓⁴)\" | every finite-index period | {g}"),
         carve("sh.59.c2", "not a character colouring: every band character is a dyadic pullback (HD1)", "one character",
               "hand-2", "@row", LG, "HD1 holds for ℚ(√59), ℚ(√83), ℚ(√131)", scope={"row": 96}),
         carve("sh.59.c3", "not a measurable window read off finitely many places", "finitely many places",
               "hand-2", "[hand, two derivations]", P59, "a four-colouring read off finitely many local coordinates through measurable windows is one pullback at the tight place, hence periodic\" | measurable windows over finitely many places; proper off a null set gives this for a.e. placement (C14′) | {g}"),
         carve("sh.59.c4", "no patchwork, half-space defect, wall, stripe or Kempe swap", "every natural construction",
               "hand-2", "@row", LG, "Every natural construction of a non-periodic four-colouring of a type-(B) plane is impossible", scope={"row": 91}),
         carve("sh.59.c5", "an invariant measure reading finitely many places is carried by the pullbacks (Theorem C)", "any finite set of places",
               "hand-2", "@row", LG, "Theorem C over the real fields", scope={"row": 112}, places="horizon"),
       ],
       remains="transient colourings, defect processes over a pullback, and the class left at ℚ(√47)",
       remains_src=dict(src=FS100, pat="at type (B), J38's three pieces \"transient; defect processes over a pullback, DP; J37's class verbatim\""),
       closes="MR together with the isolation statement T-B1 would close it"),
  dict(id="sh.167", field="Q167", k=5, title="A five-colouring of ℚ(√167)'s plane",
       why="The conjecture predicts six or more; four is proven. A five-colouring would falsify the main clause.",
       carves=[
         carve("sh.167.c1", "not a colouring through any finite plane at any depth — except the plane at 43 at depth two and beyond", "every finite plane but 43 at depth",
               "certificate", "[cert]", P167, "except 43 at level ≥ 2; so c is a residue colouring at no place and no depth, 43 at depth excepted | {g} at 23", places="bars-but-43"),
         carve("sh.167.c2", "not a character colouring (characters need 8 here)", "one character",
               "hand-2", "@row", LG, "ℚ(√167)'s has no character five-colouring (Θ₅ = ∅)", scope={"row": 96}),
         carve("sh.167.c3", "not a measurable window over finitely many places with no real place and none above 43", "finitely many places, no real place",
               "hand-2", "@row", LG, "no measurable window five-colouring reads a finite set of places with no real place and none above 43", scope={"row": 110}),
       ],
       remains="the real place stays open (at five colours it refuses nothing), and 43 at depth: the question becomes the plane's own measurable one",
       remains_src=dict(src=PIMP, pat="So no: the method does not say that a five-colouring of ℚ(√167)'s plane must read infinitely many primes."),
       closes="MR gives five as a lower bound (T-J39-4); six would need the plane's measurable question, χ_CP(ℝ²) ≥ 6, which no field-level method bypasses",
       open_places=["inf", "43"]),
  dict(id="sh.R6", field="R", k=6, title="A six-colouring of the plane",
       why="It would make χ(ℝ²) = 6. The fields may skip six altogether (a claim about fields, stronger than χ(ℝ²) ≠ 6).",
       carves=[
         carve("sh.R6.c1", "no colouring constant on a triangular lattice's cells, and no polygonal colouring, uses six colours", "polygonal colourings",
               "kernel", "[kernel + prior art]", CM, "G22 — Where a six-colouring cannot live. {g}"),
         carve("sh.R6.c2", "every finite plane at a prime from 59 up refuses six; the window 23, 27, 31, 43, 47 (and the norm-64 target) is undecided", "finite planes",
               "certificate", "[cert]", LG, "{g} Six refused at 59, 67, 79", scope={"row": 69}, places="bars-from-59"),
         carve("sh.R6.c3", "no character colouring through the window: characters need 8 at 23 and 9 at 43", "one character",
               "hand-2", "@row", LG, "χ_char(Γ₂₃) = 8, χ_char(Γ₄₃) = 9", scope={"row": 101}),
       ],
       remains="non-polygonal classes finer than half the unit distance; six hides only in the gap between a field's local bound and its chromatic number",
       remains_src=dict(src=CM, pat="six hides only in the gap between L(F) and χ(F²), where every ceiling we own is silent but FS-64"),
       closes="no route is named; FS-64's adelic window is the one ceiling instrument aimed at the gap",
       open_places=["inf", "23", "27", "31", "43", "47"]),
]

# ---------------------------------------------------------------- walls
def wall(id, name, where, status, need, broke, grade, graw, src, pat, gpat=None, scope=None, broke_kind=None, **kw):
    return F(id, name, status, grade, graw, src, pat, gpat, scope, where=where, need=need, broke=broke, broke_kind=broke_kind, **kw)
WALLS = [
  wall("w.2adic", "the 2-adic wall", dict(place="2"), "both",
       "an odd square class ≡ 7 (mod 8) among the coordinates — a fifth colour is impossible where the place above 2 is inert or ramified",
       "the chain theorem: a forced pair at 8/3 makes every colouring periodic, so over K breaking the wall is enough for five",
       "hand-1", "hand, GPT Astra", CM, "every wall-broken real F ⊇ K has χ(F²) ≥ 5", gpat="[{g} (OpenAI,", broke_kind="example invariant",
       per_row=True),
  wall("w.3adic", "the 3-adic barrier", dict(place="3", k=3.5), "broken",
       "a direction with 3 in a denominator — directions integral at 3 are 3-colourable outright",
       "the slope every three-colouring carries: 1/3 in the unit-vector ring plus an odd cycle refuses three (row 82, row 99)",
       "hand-2", "@row", LG, "χ(F²) ≥ 4 whenever 1/3 ∈ ℤ[U_F] and F² is not bipartite", scope={"row": 82}, broke_kind="example invariant",
       stands_src=dict(src=LG, pat="the plane over ℚ(√d) restricted to directions whose coordinates have denominators prime to 3 is 3-colourable", scope={"row": 72})),
  wall("w.six", "the wall at six", dict(k=6, places=["23", "27", "31", "43", "47", "59", "67", "71", "79", "83", "big"]), "standing",
       "an independent set of ⌈q²/6⌉ points in a window plane (89 at 23, 309 at 43, 369 at 47)", None,
       "certificate", "[cert]", LG, "so a plane can be exactly six-chromatic only at q ∈ {{23, 27, 31, 43, 47}}", gpat="{g} Six refused at 59, 67, 79", scope={"row": 69}),
  wall("w.linear", "linear instruments go blind above four", dict(k=4.36, all=True), "standing",
       "a linear or fractional certificate above 4.36 — none exists: additive colourings give 2, 3, 4 and then 7", None,
       "hand-1", "[hand theorem; Fischer's framework]", CM, "Linear instruments are blind to 5–7", gpat="G38 — The linear method's thresholds. {g}"),
  wall("w.tower", "the residue ceiling does not drop up the tower", dict(places=["7", "11", "19", "23"]), "standing",
       "a deeper residue level (ℤ/p², ℤ/p³, …) with fewer colours than the plane at p", None,
       "certificate", "[cert]", LG, "The residue ceiling does not drop up the tower at 7, 11, 19 or 23", gpat="{g} Exact integer sum-of-squares certificates", scope={"row": 75}),
  wall("w.oneprime", "one prime is not enough for band rigidity", dict(lane="p1"), "both",
       "exotic band characters exist when only one prime ≡ 1 (mod 4) is inverted",
       "band rigidity at two or more primes: every band character is torsion plus archimedean — an invariant every character carries",
       "hand-2", "@row", LG, "One prime fails three ways, at every split prime", scope={"row": 102}, broke_kind="example invariant",
       broke_src=dict(src=LG, pat="Band rigidity at every band", scope={"row": 98})),
  wall("w.cell", "cell-local four-colour certificates", dict(k=4.5, rows=["Q59", "Q83", "Q131", "Q47", "Q167", "K"]), "both",
       "an edge height, loop winding, face flux or coindex bound — each empty or blind at four colours, one cell at a time",
       "on de Grey's lattice, a structure-derived certificate: an eigen-equation every colouring satisfies (from Parts's trees)",
       "hand-2", "@row", LG, "Four colours, cell by cell: no certificate of non-four-colourability comes from the colour complex one cell at a time",
       scope={"row": 80}, broke_kind="example invariant", broke_src=dict(src=LG, pat="Four colours on de Grey's lattice, derived", scope={"row": 85})),
  wall("w.descent", "no in-field descent over K reaches five", dict(rows=["K"], k=4.5), "both",
       "a five-chromatic graph with every point in K — impossible, K's plane is four-colourable (Theorem B)",
       "adjunction: Heule's graph in K(√5), the ρ₆₃ arena in K(√7) — constructions, not invariants",
       "measured", "[measured + theorem]", CM, "G34 — The field is the selection. {g}", broke_kind="construction"),
  wall("w.chars", "characters stop at the window", dict(places=["23", "43"], k=6), "standing",
       "a band six-character of a window plane: none exists (8 at 23, 9 at 43)", None,
       "hand-2", "@row", LG, "band six and seven characters exist only at q ∈ {{3, 7, 11, 19}}", scope={"row": 101}),
  wall("w.real4", "the real place refuses four — and only four", dict(place="inf", k=4), "standing",
       "a measurable independent set of density 1/4 in the plane: the densest is at most 0.246989",
       None, "certificate", "[cert + hand]", KT1, "m₁(ℝ²) ≤ 0.246989 < 0.2470 {g}"),
  wall("w.horizon", "finitely many places (the horizon)", dict(horizon=True, rows=["Q47", "Q59", "Q83", "Q131"]), "standing",
       "an invariant measure whose spectrum reads infinitely many split places in aggregate", None,
       "hand-2", "@row", LG, "At ℚ(√47) no invariant random four-colouring reads finitely many places", scope={"row": 113}),
]


def main():
    ledger = parse_ledger(ROOT / "LEDGER.md")
    thms = []
    for r in ledger["rows"]:
        g = row_grade(r["text"], r["where"])
        thms.append(dict(id=f"row{r['n']}", kind="row", n=r["n"], milestone=r["when"], text=r["text"][:420], graw=g, grade=fold(g),
                         tags=tags_of(r["text"]), crunch=r["n"] in CRUNCH_ROWS, where=r["where"][:160]))
    for b in ledger["B"]:
        thms.append(dict(id=b["id"], kind="B", milestone=b["milestone"], text=b["text"][:320], graw=b["grade"], grade=fold(b["grade"]),
                         tags=tags_of(b["text"]), crunch=b["milestone"] in CRUNCH_B, where=b["proof"][:160]))
    fields = []
    for f in FIELDS:
        f = dict(f); st = {}
        for p in PLACES:
            pid = p["id"]
            if f.get("special") == "R": st[pid] = "real" if pid == "inf" else "none"; continue
            if pid == "inf": st[pid] = "real"; continue
            if f["rad"] is None:
                sp = f.get("special", {}); st[pid] = sp.get(pid, "unrecorded");
                if p["kind"] in ("p1", "p1big"): st[pid] = "split"
                if pid == "big": st[pid] = "stable"
                continue
            if pid == "2": st[pid] = dyadic_state(f["rad"]); continue
            if p["kind"] in ("p1", "p1big"): st[pid] = "split"; continue
            if pid == "big": st[pid] = "stable"; continue
            if pid == "27": st[pid] = "absent"; continue
            st[pid] = stable_state(f["rad"], int(pid))
        f["places"] = st; fields.append(f)
    from viz_local_global_map_common import scoped_text
    cache, warn = {}, 0
    def resolve(f):
        nonlocal warn
        if f.get("graw") == "@row":
            r = [x for x in ledger["rows"] if x["n"] == f["scope"]["row"]][0]; f["graw"] = row_grade(r["text"], r["where"])
            g = "kernel" if f["graw"].startswith("[kernel] (a Lean") else fold(f["graw"])
        elif f.get("graw") == "@lean": g = "kernel"
        else: g = fold(f["graw"])
        if g != f["grade"]: print(f"  note {f['id']}: typed grade {f['grade']!r}, the source's words fold to {g!r} — using {g!r}"); warn += 1
        f["grade"] = g
    for f in T + CH + FL + OWN + WALLS: resolve(f)
    for sh in SHADOWS:
        for c in sh["carves"]: resolve(c)
    out = dict(meta=dict(title="The Local–Global Map", built="2026-09-26", job="J43",
                         grade_order=["kernel", "certificate", "hand-2", "hand-1", "measured", "reading", "open"]),
               places=PLACES, groups=[dict(id=a, label=b) for a, b in GROUPS], fields=fields, targets=T + CH, field_facts=FL,
               owned=OWN, shadows=SHADOWS, walls=WALLS, theorems=thms, tag_rules=TAG_RULES,
               crunch=dict(rows=sorted(CRUNCH_ROWS), milestones=sorted(CRUNCH_B)))
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(out, ensure_ascii=False, indent=1))
    print(f"wrote {OUT.relative_to(ROOT)}: {len(T)+len(CH)} targets, {len(FL)} field facts, {len(OWN)} owned, {len(SHADOWS)} shadows, "
          f"{len(WALLS)} walls, {len(thms)} theorems ({sum(t['kind']=='B' for t in thms)} in § B)")


if __name__ == "__main__":
    main()
