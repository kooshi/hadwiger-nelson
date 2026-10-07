#!/usr/bin/env python3
"""FS132-Z2: build and check the drafts for the front page.

Emits the markdown of the record's section `## Drafts for the front page` (stdout) after checking:
  * every `{S:NAME}` in a ledger row is replaced by the statement field of that entry of
    plans/FS132-derivation.md, verbatim;
  * every span between straight double quotes (12 characters or more) in a ledger row or an instance draft
    occurs verbatim in one of the source files;
  * every slot string ("the words it replaces or follows") occurs exactly once in the file it names;
  * no row 155 exists yet in LEDGER.md; every Proof Atlas quote is a substring of the drafted row it cites.
Net change in bytes is computed for each CLAUDE.md draft and for the grokkings file.
`--fault` corrupts one slot string; the run must then exit 1 (the planted fault).

Run from the repository root:  python3 tools/fs132_z2_frontpage.py [--fault] > data/fs132/z2/frontpage.md
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
rd = lambda p: (ROOT / p).read_text(encoding="utf-8")  # noqa: E731
DER = rd("plans/FS132-derivation.md")
SOURCES = "\n".join(rd(p) for p in (
    "plans/FS132-derivation.md", "plans/FS132-close-inventory.md", "plans/SEARCH-2026-10-07.md", "LEDGER.md",
    "plans/POROS-2026-10-07-fs132-round2.md", "plans/FS132-E6-derivation.md", "plans/FS132-six-by-the-nerve.md"))
NORM = lambda s: re.sub(r"\s+", " ", s)  # noqa: E731
SRC_N = NORM(SOURCES)
STMT = dict(re.findall(r"^derivation: (\S+)\n  statement: (.*)$", DER, flags=re.M))
ERR = []


def fill(t):
    def sub(m):
        if m.group(1) not in STMT:
            ERR.append(f"no entry {m.group(1)}")
            return "??"
        return STMT[m.group(1)]
    return re.sub(r"\{S:([A-Za-z0-9-]+)\}", sub, t)


def check_quotes(name, text):
    for q in re.findall(r'"([^"\n]{12,})"', text):
        if NORM(q) not in SRC_N:
            ERR.append(f"{name}: quoted span not found verbatim: {q[:70]!r}")


def slot(path, s, fault=False):
    body = rd(path)
    if fault:
        s = s[::-1]
    n = body.count(s)
    if n != 1:
        ERR.append(f"{path}: slot occurs {n} times: {s[:60]!r}")


GRADE = "[hand] or derived from [hand] entries, one mind each, kernel pending"

ROWS = {}
ROWS[155] = (
    '| 155 | **The (Q)-free exclusion with no map and no Siamese clause: for every measurable six-colouring proper at almost every unit pair on an open set containing the closed unit disc about a point, if four labels meet at the point in a witnessed cycle, the palettes on its unit circle cannot almost everywhere hold one of the two other labels.** The orbit form, over four points: "{S:C132-WIT-ORBIT}" (C132-WIT-ORBIT; C132-M-ORBIT is the same theorem over four compact sets through `p`). The ring form: "{S:C132-WIT-EXCL}" (C132-WIT-EXCL, which is C132-M-EXCL); at an extracted centre with a cycle of four labels, C132-M-EMPTY. **[hand], one mind, with a line-by-line checking reading of its steps M4–M9 by a second mind — the kernel lane\'s planner, whose own blind route reached the state, the chart, a forced label at each hub, the unit-pair relation and the kill for a clean change, and stopped at the step lemma; steps M6 and M8 have one derivation each; kernel pending (the first module of FS-132\'s Lean phase).** **What it stands on:** for a colouring of the whole plane, two statements of `[OAIMath2026]`, kernel-checked there at every number of labels (the transfer of palettes for a pair; the 60° disjointness), and its nine steps M1–M9; on an open set, as the statement is written, also one mind\'s reading of those two proofs as local (M0). **Where it sits:** its hypothesis asks an outside label in almost every palette near all six orbit directions — in the map class, no (Q) arc at the orbit; every held positive escapes there (at each of the eight change points of the held fragments\' four-colour vertices at least two of the four germs at ±60° lie on (Q) arcs), so nothing held is excluded. It is rows 148–149\'s exclusion in measure, and covers those rows\' fragments given two facts about maps — a map\'s edge carries the two-colour exclusion (derived for connected open tiles, C132-WITNESS, row 157; the composition unwritten) and a map\'s palette is its ring read two-sidedly (underived; FS-134). **Not claimed:** "anything when the palettes near one of the six directions ψ + kπ/3 hold no outside label on a set of positive measure (rings with (Q) arcs at the orbit: FS-124)"; "that a six-colouring with hypothesis (a) exists"; "anything at seven labels or more (M2 and M9 spend six)"; "anything about a cycle of three, five or six labels"; "any value of χ(ℝ²)". Beside it, and not this milestone\'s: no ring alternates under the 60° rotation between two disjoint pairs of labels (C132-DIAG-WIDE) — for the whole plane an instance of `[OAIMath2026]`\'s Lean theorem `two_state_impossible`; this milestone adds its reading on an open set, one mind. **Prior art:** partly — the palette calculus is `[OAIMath2026]` §§ 5.1–5.3; steps M1–M5 and M9 are row 148\'s steps restated in measure; M6, M8 and the statement are not in the release; the search in print is owed. It moves no value. | `plans/FS132-derivation.md` § 1 (C132-M-ORBIT, C132-WIT-ORBIT, C132-M-EXCL, C132-WIT-EXCL, C132-DIAG-WIDE), § 10 (C132-M-EMPTY, C132-DIAG); `plans/FS132-E3-derivation.md`, `plans/FS132-E5-derivation.md`; `plans/FS132-kernel-plan.md` on branch `fs132-wk1` | FS-132 (2026-10-07) |')
ROWS[156] = (
    '| 156 | **Cyclic centres exist at every number of colours with no hypothesis; one carries the release\'s data wherever the centres are finite in a disc; and the step that reads isolation is located:** "{S:C132-CORES-FREE}" (C132-CORES-FREE). On a closed disc of radius above 1 with finitely many cyclic centres, some centre in its interior, isolated among them, carries a simple cycle of 3 to `k` labels with, for each consecutive pair, a compact connected set through it, a limiting direction, and the exclusion of both labels\' closed essential supports from the set\'s straddle set — `[OAIMath2026]` Proposition 7.1 read at every `k` and on a disc, with two clauses its manuscript does not state: (4) each set lies in both its labels\' supports; (5) each edge of the cycle is an edge of the centre\'s own transition graph (C132-EXT-DISC; clause (5) is one mind\'s, against the letter of the manuscript\'s sentence "The extracted cycle need not consist of edges of Γ_x", and no exclusion reads it). What its argument reads of the hypothesis is zero length of the centres and isolation of the one essential centre; at the island colouring\'s accumulation centre the conclusion with clause (4) is false. The exclusion clause needs no centre: "{S:C132-WIT-SUPER}" (C132-WIT-SUPER). **GAP:** the data with no hypothesis on the centres (C132-WIT-EX) — stalls at "the selection of a point through which connected pieces of two smoothed classes pass and reach a common second point". The data are free at every point with a margin for three labels, points that are no centres (C132-WIT-MARGIN): a witnessed cycle is a property of the unit circle about a point, a cyclic centre a property of its small balls. **GAP:** a square form of the first statement, side above 1, posed by the kernel planner with a route not written out (C132-CORES-SQUARE). ' + GRADE + '. **Not claimed:** "the conclusion when 𝓛 ∩ D is infinite"; "that the hypothesis holds for any six-colouring"; "that ℓ ≥ 4 at any centre"; "sharpness of the radius 1". **Prior art:** partly — `[OAIMath2026]` Proposition 7.1 with Lemmas 7.2–7.8 at five labels on a square of side ten; the statement at every `k`, the disc, the hypothesis read and clauses (4), (5) not found in print; zbMATH owed. By Kooshi\'s word (2026-10-07) whether every such colouring has a point with usable data is FS-127\'s and FS-128\'s question. | `plans/FS132-derivation.md` §§ 2, 3, 8; `plans/FS132-E1-derivation.md`, `plans/FS132-E5-derivation.md` | FS-132 (2026-10-07) |')
ROWS[157] = (
    '| 157 | **One witness blocks one side of a unit circle, with no properness; and two points less than 2 apart carrying witnessed triangles on disjoint triples of six labels force an edge set onto the unit circle about each common unit point — the regular chain\'s last line in the exact class, its one exception named:** "{S:C132-WIT-SIDE}" (C132-WIT-SIDE; the leaf under the strips, C132-WIT-STRIP and C132-TRI-STRIP: at a point with a witnessed triangle, at every direction but at most six, one side of its unit circle carries only the other labels). The same rule from a piece of the colouring in place of an exclusion set: "{S:C132-SHADOW}" (C132-SHADOW). A connected open region of one label keeps that label\'s whole essential support off the straddle set of every compact subset of its closure, so a map\'s edges are witnessed edges (C132-WITNESS). The covering count at a common unit point reads no properness (C132-CROSS), and: "{S:C132-COMP-SHARP}" (C132-COMP-SHARP). Fragment T2 realizes the exception, with three of its six edge sets arcs of the unit circle about the crossing point; so row 133\'s "tangent pairs or bowties" are, in the exact class, an edge set on the unit circle about the common unit point, and a point with no third edge. ' + GRADE + ' (C132-WIT-SIDE is also the first step of C132-CROSS, written the same night in another record). **Not claimed:** "anything when |w − q| = 1" (C132-WIT-SIDE); "anything when v is tangent at p′ to the unit circle about p" (C132-SHADOW); "which of the six sets it is, or that it is one of x\'s"; "anything with seven labels or more"; "that a configuration with a set on the unit circle about w is impossible — fragment T2 is one" (C132-COMP-SHARP). **Prior art:** partly — the mechanism of `[OAIMath2026]` Lemma 8.1 for continua; for maps the composition behind row 133\'s W-TAN; these forms owed. | `plans/FS132-derivation.md` §§ 2, 4; `plans/FS132-E4-derivation.md`, `plans/FS132-E5-derivation.md`, `plans/FS132-E6-derivation.md` | FS-132 (2026-10-07) |')
ROWS[158] = (
    '| 158 | **Three labels outside a triangle wind, and six is the one count at which they do; the forcing of a centre that is not a triangle stalls at one circle:** "{S:C132-INDEX}" (C132-INDEX — no colouring in it; so at least nine changes; with two labels the ring is rigid, which is the release\'s kill at five, and four labels, at seven, have no winding number). The same for a step function with finitely many changes, no two 60° apart (C132-RING-WIND); with no tameness, an orbit index in {2, 3, 4} at almost every direction (C132-ORBIT); the classes of the cyclic centres inside a circle add up to the circle\'s (C132-REL); and in the complete graph on the labels with every triangle filled every loop bounds, at every `k`, so no obstruction lives there (C132-FILL, C132-NOESS). **GAP:** "{S:C132-LONG}" (C132-LONG; with it C132-M-CV, an extracted centre with a cycle of at least four labels) — stalls at the winding of the three outside labels on a triangle centre\'s unit circle, that is at the finiteness of that ring\'s changes (C132-RING-TAME, first clause: "for three labels on a strip no rigidity is held, by the release or here"; false wherever a colouring has local slack along the strip), and behind it "two further steps of the regular chain have no weak form (two centres of one type at distance between 1 and 2, and the bicycle)". ' + GRADE + ' (a second derivation of C132-INDEX by the kernel planner, blind, a paragraph by hand, is not counted). **Not claimed** (C132-INDEX): "anything for a ring that is only measurable"; "for four labels (the target is then a graph of rank three, with no degree)"; "that the ring of any colouring satisfies the hypothesis". **Prior art:** partly — the index of a three-coloured circle and its nine bichromatic points are `[Voronov2023]`\'s and `[SokolovVoronov2025]`\'s by this project\'s records; the congruence modulo 6 in this form not searched. | `plans/FS132-derivation.md` §§ 3, 4, 8; `plans/FS132-E2-derivation.md` | FS-132 (2026-10-07) |')
ROWS[159] = (
    '| 159 | **What a triangle point\'s ring is forced to do where it changes — the alternating ring excluded in step form, the turning ring placing a four-label point whose own unit circle runs along two unit arcs — each where no edge set of the centre lies on a unit circle about a ring point:** on a pure side near a ring point the label lies among the three outside labels and outside the palettes of its two ring neighbours (C132-PLACE). The alternating ring `a, b, a, b, a, b` is excluded in step form wherever two adjacent ring points each have a pure side (C132-ALT; for a ring only measurable, derived for two adjacent inner-pure ring points only; its residue is an orbit at which three alternate ring points each have one of the three sets on their unit circle). At a step of a turning ring `a, b, n, a, b, n` whose two neighbours are outer-pure the two ring labels are never a witnessed edge at the ring point (C132-TURN-EDGE). On a turning seed: "{S:C132-LENS}" (C132-LENS — hypotheses at the two neighbours, none at the ring point itself); the middle ring point then has no pure inner side (C132-LENS-SIDE); three consecutive outer-pure ring points make the middle one a point where four labels are present (C132-LENS-FOUR), and three such exist when each of the three sets has a point strictly inside three of the six unit circles about the ring points and strictly outside the other three (C132-LENS-GERM); and the placed point\'s own unit circle runs, at its two neighbours, along an interface between the two ring labels, oppositely oriented: "{S:C132-PLACED-RING}" (C132-PLACED-RING — a measurable instance of FS-124\'s first question, every hypothesis derived from the seed\'s data). **GAPs:** C132-TURN (stalls at a witness at the ring point; not re-posed in that form); C132-LENS-II ("pure sides are opposite at antipodes" holds one way only; sixteen patterns of sides open, seeds whose sets witness from far away); C132-PLACED (whether any pair containing a label of the centre\'s triple is a witnessed edge at the placed point). ' + GRADE + '. **No model is known at six for any of them** — no weak six-colouring with a turning seed is held — and the one model the day\'s search kept (row 160) is the other case, to which no statement here applies. **Not claimed:** the existence of a seed; anything at a ring point with no pure side; "anything for an outside state that is not a step at ψ and ψ ± 2π/3" (C132-LENS); and nothing here "excludes, builds or bounds a boundary that is a unit arc about a ring point". **Prior art:** partly — at five labels `[OAIMath2026]`\'s lemma "Polynomial three-label region" is the neighbouring statement; in the map class, the ring calculus of row 148; owed in print. | `plans/FS132-derivation.md` §§ 4, 5, 8; `plans/FS132-E4-derivation.md`, `plans/FS132-E6-derivation.md` | FS-132 (2026-10-07) |')
ROWS[160] = (
    '| 160 | **In one finite family — a centre and its six ring points, each a *flower* of wedges — the three-label turning ring does not exist, the alternating ring does not exist, and with four labels at alternate ring points the turning ring exists in a shape this project already holds:** the family F is seven flowers; each ring flower is the six 60° wedges cut by the three unit circles through the ring point, one label of six per wedge; the centre\'s flower is twelve 30° sub-sectors bounded by straight rays or by arcs of unit circles about ring points. "{S:SEARCH-1007-TURN3}" (SEARCH-1007-TURN3; **[cert]**: four LRAT refutations accepted by `cake_lpr`, re-run by the coordinator). "{S:SEARCH-1007-TURN-SS}" (SEARCH-1007-TURN-SS; [cert], four refutations). "{S:SEARCH-1007-ALT}" (SEARCH-1007-ALT; [cert], sixteen refutations — the positive control of row 159\'s C132-ALT, not a second derivation of it). "{S:SEARCH-1007-TURN4}" (SEARCH-1007-TURN4; [cert] by a cold check of the kept models at two radii): by the search\'s census — a count, not a certificate — with a simple three-sector centre all 192 models are of one shape, each interface at the centre an arc of the unit circle about a ring point, those three alternate ring points exactly the ones with four labels: fragment T2\'s shape; local (flowers of radius about 0.25), with nothing between the flowers built. The first null also by a five-step hand argument, for any finite sector structure at the centre (SEARCH-1007-TURN3-HAND; [hand], one mind, unchecked by a second); for germs that are only measurable its step 3\'s second rule fails, so the null is its family\'s. **What the nulls are not:** a wedge split along another curve, twelve sectors, unequal sectors, curved sector boundaries, a sector with two outside labels, measurable germs; and nobody but the Searcher has checked that the formulas say what F is. **Prior art:** owed — the family is this project\'s. | `plans/FS132-derivation.md` § 6; `plans/SEARCH-2026-10-07.md`; `data/search/2026-10-07/` (the proofs\' archive, the kept models, `cold_check.py`) | FS-132 (2026-10-07), the Searcher |')

# ---------------------------------------------------------------- CLAUDE.md: (label, old, new)
CL = [
    ("§ Frontier, the \"Last updated\" line",
     "Last filed: **the landing of FS-132's import**",
     "Last filed: **FS-132, six by the nerve**, Derived (rows 155–160; `plans/FS132-derivation.md`, 57 entries: 47 derived, 10 stalls and gaps; [hand], one mind each, the day's search [cert] in its finite family; no value moved; its Lean phase begun); before it **the landing of FS-132's import**"),
    ("§ Paths forward, the open-milestones paragraph — the sentence on FS-132",
     "**Opened 2026-10-07: the top of the ranking, FS-132, six by the nerve** (`plans/STUB-six-by-the-nerve.md`), opening on the release's extraction stated at every `k` (C132-EXT) and on whether FS114-CV-EXISTS and FS116-Y4-EMPTY run on it with no map.",
     "**Derived 2026-10-07: FS-132, six by the nerve** (`plans/FS132-derivation.md`, 57 entries: 47 derived, 10 stalls and gaps; [hand], one mind each, the day's search [cert] in its finite family; rows 155–160; stub `plans/STUB-six-by-the-nerve.md`): what a point with data on its unit circle is forced to carry, for every measurable colouring proper at almost every unit pair, with no map — by Kooshi's word (2026-10-07) that is what it delivers, and whether every such colouring has such a point is FS-127's and FS-128's. Its Lean phase has begun, on the first night's exclusion (row 155; branches `fs132-wk1`, `fs132-wi2`), what the module rests on being formalized in that phase (his word of the same day); Closed when the module passes the gate. **Next, chosen by Kooshi (2026-10-07): FS-124, the (Q) ring** (`plans/STUB-q-ring.md`) — the boundary that is a unit arc about a ring point, where every exclusion of FS-132 stops."),
    ("§ Paths forward, the open-milestones paragraph — the sentence on the Lean backlog (made stale by Kooshi's word of 2026-10-07; optional, the coordinator's to take or leave)",
     "is paused at Kooshi's word (2026-10-07) and restarts on his word — what is formalized is reprioritized after FS-132's exploration (his word of the same day); the asking lane's recommendation is the table of `plans/POROS-2026-10-07-after-release.md` § 4.4: the import first, then wave 7, wave 9 restated over the import, wave 6's in-flight jobs; wave 10 waits.",
     "stays paused at Kooshi's word (2026-10-07) and restarts on his word; what a milestone's Lean module rests on is formalized in that milestone's own Lean phase."),
    ("§ Where the problem stands, item 31 — its heading's row range and stubs",
     "rows 131–154; FS-117,\n   FS-120, FS-122–FS-128, FS-130)",
     "rows 131–160; FS-117,\n   FS-120, FS-122–FS-128, FS-130, FS-134, FS-135)"),
    ("§ Where the problem stands, item 31 — its last sentence",
     "What is open is this item's question at six; of door (A)'s local statement the (Q)-free half is closed in the non-Siamese class, and what is left is a case list — the Siamese (Q)-free ring (FS-123), the (Q) rings\n   and many-colour vertices (FS-124), the saturated class (FS-125).",
     "For measurable colourings with no map (FS-132; rows 155–160; [hand], one mind each, kernel pending): cyclic centres exist in every closed disc of radius above 1 at every number of colours; at a point where four labels meet in a witnessed cycle the palettes cannot almost everywhere hold an outside label — rows 148–149's exclusion with no Siamese clause; two triangle points on disjoint triples less than 2 apart force an edge set onto a unit circle about their common unit point; the alternating ring is excluded in step form, and the turning ring places a four-label point whose own unit circle runs along two unit arcs. Each stops at one object, a boundary that is a unit arc about a ring point, which nothing here excludes, builds or bounds; none produces a point with such data in an arbitrary colouring. What is open is this item's question at six; of door (A)'s local statement the (Q)-free half is closed in the non-Siamese class, and what is left is a case list — the (Q) rings\n   and many-colour vertices, now the unit arc in measure (FS-124), a centre that is not a triangle (FS-122, FS-130), a point with data in every colouring (FS-127, FS-128), the seed's remainder (FS-135), and in the map class the Siamese (Q)-free ring (FS-123, after FS-134) and the saturated class (FS-125)."),
    ("§ The aim, point 6 — the sentence on what the nerve needs at six (made incomplete by FS-132; quoted entries beside it, the coordinator's to choose)",
     "At six it needs two statements that are false under local slack at seven and so belong to a saturated normal form: at most two labels along a ring, and local finiteness of the centres where three classes meet cyclically (`plans/EXT-OAI2-reading.md` § 4.3).",
     "At six, where no boundary is a unit arc about a ring point, the exclusions it feeds read no regularity and no normal form, and cyclic centres exist with no hypothesis (FS-132, rows 155–157, 159; [hand], one mind each); what still asks for a normal form, not yet chosen, is existence — a centre isolated among the centres, and finitely many changes of the three outside labels on a triangle centre's ring (rows 156, 158) — each false under local slack (`plans/EXT-OAI2-reading.md` § 4.3; G95)."),
]

# ---------------------------------------------------------------- slots in other files
LEDGER_SLOTS = [
    ("LEDGER.md", "a GAP at cusp vertices"),
    ("LEDGER.md", "(SQ9 at nine meets every other hypothesis)."),
    ("LEDGER.md", "(FS129-SR1's attacks on the chain's two named steps found no gap — checking readings, not second minds)."),
]
G = ".claude/skills/grokkings/SKILL.md"
G_SLOTS = [
    (G, "never ask a selection from a cover to be saturated unless the cover is a partition."),
    (G, "and given a NO for honest saturated colourings it is the answer (FS121-D3-EQ)."),
    (G, "a control the instrument cannot see is\n  not a control."),
    (G, "finiteness on a disc of radius above 1 suffices and is not necessary)."),
]
BIB_SLOT = ("BIBLIOGRAPHY.md", "| **[Hatcher2002]** A. Hatcher, *Algebraic Topology* (2002) | Cited by `[OAIMath2026]` family 158; **not held, not read.**")

G96 = ("* **G96 — Circle data and ball data: an exclusion reads the unit circle about a point, a meeting of classes is a property of its small balls, and only one passage between them is free. [hand for its halves (FS-132: C132-WIT-MARGIN, C132-WIT-SIDE, C132-WIT-SUPER; one mind each); the reading one mind, reached by two lanes]** Everything FS-132 derived at a point reads a *witnessed cycle*: the point, a cycle of labels, and one further point per edge whose straddle set — two thin lunes along the point's unit circle — misses both labels' supports. Nothing in that data is near the point: labels whose supports keep off an annulus about the unit circle are witnessed by every nearby point, at points that are no centres (row 156). A cyclic centre is the other kind of fact, a property of every small ball. From circle to balls the passage is properness alone (one witness, or one open piece, blocks one side of the circle near every ring point: row 157); from balls to circle the one derived passage is a connected piece of a class of definite size, which an isolated centre supplies (row 156), and three cards that asked for it in the class of all weak colourings were answered off their tables. *Do: when a statement is posed at a point of a measurable colouring, say of each hypothesis whether it is circle data (exclusion sets, palettes, witnesses) or ball data (a transition graph, labels present, a centre), and pose it with one kind — a claim that attaches circle data to a ball-defined point with nothing joining them is not well posed (FS-132's C132-TURN); derive from a seed outward; send \"every colouring has a seed\" to the regularity stubs (FS-127, FS-128). Killing test: a derivation, in the class of all weak measurable six-colourings, of a witnessed cycle at a cyclic centre from its small balls, with no connected piece of definite size and no margin.*")
G97 = ("* **G97 — On the measurable road every exclusion stops at one object: a boundary that is an arc of the unit circle about the other end of a unit distance. [reading, one mind (the asking lane's identification of the two appearances as one object, unchecked); measured on three rounds and one search]** FS-132's exclusions — the outside-labelled four-cycle, the complementary pair, the alternating ring in step form (rows 155, 157, 159) — run with no map and no normal form exactly where no such arc is: (α) no arc of the centre's ring carries the centre's own labels (in the map class, no (Q) arc); (β) no edge set of the centre lies on the unit circle about one of its ring points. Each residue is that object (fragment T2; three alternate ring points; a ring point with no pure side), the search's survivors are built from it (row 160), and the turning ring's placed point is the centre of two such arcs. It is rows 134–135 in measure — with no unit arcs no tight six-map exists, and the unit-arc case is the open one — and G84 says why a tight colouring has it everywhere: contact. *Do: before calling an exclusion in the measurable class progress on six against seven, plant an edge set on the unit circle about a ring point (fragment T2; the search's kept model) and put in the headline which side of the line the statement sits on — no side, arc-free (α), arc-free (β), or reaching the hard case; aim new work at the arc itself (FS-124). Killing test: an exclusion on the arc-free side whose residue is some other object; or a statement by the same tools that excludes, builds or bounds a unit arc about a ring point — then the line was no wall.*")
G98 = ("* **G98 — Six is the one count at which the labels left for a ring can wind. [hand (C132-INDEX, C132-RING-WIND; one mind, a second derivation blind and not counted); the reading one mind]** On the unit circle about a point where three labels meet, `k − 3` labels are left for the ring. At five, two: the ring is rigid, and that is the release's kill. At seven, four: the target is a graph of rank three with no degree, and the honeycomb's ring changes nine times, no two changes 60° apart — seven escapes by its count, not by wildness. At six, three: a loop in the triangle of three labels with the 60° exclusion has degree 3 modulo 6, so at least nine changes, and with no tameness an orbit index in {2, 3, 4} survives at almost every direction (row 158). So the existence side of six against seven sits on one circle: a six-colouring living on triangle points alone spends each ring by infinitely many changes, by turning (index 2 or 4) or by alternating, or its centres accumulate; and what turns the winding into a count is finiteness of the changes, which no held statement gives a weak colouring (C132-RING-TAME). *Do: at a triangle point at six ask for the ring's winding and its orbit index before anything else, and transplant neither five's palette bound nor seven's freedom; when a forcing statement at six stalls, look for the step where a winding number must be taken. It forbids a three-labelled ring with finitely many changes, no two 60° apart, whose winding is not congruent to 3 modulo 6. Killing test of the reading: a forcing of a centre that is not a triangle, at six, that takes no winding number; or a rigidity for three labels on a strip.*")
G84_ADD = (" Before calling an exclusion in the measurable class progress on a tight colouring, ask whether its hypothesis excludes a contact arc — an interface on the unit circle about a point one unit away — and run its controls on a model with no margin (G97).")
G89_ADD = (" The construction takes a maximal element at each step, so it defines a family of outputs and never one \"Grundy-ization\", and a colouring with a margin is Grundy in no order (FS-132, C132-GRUNDY7, C132-GRUNDY7-NOT): honesty cannot be tested on slack planted in a colouring with a margin.")
G21_ADD = (" **A control satisfied with room measures the room** (FS-132): run each control where the hypothesis is tight as well as where it is comfortable, and say in its line which.")

INST = {
    "G21": [
        "FS-132 (2026-10-07), controls with a margin: the second round's seven-colour controls read clean zeros on the honeycomb at circumradius 2/5; re-run at circumradius 1/2, \"two counts move, none against an entry\" — own labels near a crossing point 0 → 36 of 432, witnesses by margin 0 → 6,672 — and \"The zeros at 2/5 were the margin.\" The asking lane had named the absence first: \"all 21 controls of the five derivation records run at seven on the honeycomb with a margin, or at six on the held seam fragments; none runs on a tight colouring.\" A control whose model satisfies the statement with room measures the room. Source: `plans/FS132-close-inventory.md` items 21, 28; `plans/FS132-derivation.md` § 5.",
        "FS-132 (2026-10-07), a count of minds: the coordinator's ruling called the first night's exclusion \"derived, two minds on every step, kernel pending\" on a second mind's reading made with the argument open; the record job, briefed to raise no grade, wrote `minds: 1` with the account of who derived, reworked and read each step, and the ruling was corrected to \"derived, one mind, with a line-by-line checking reading of its last six steps by a second mind\". The coordinator's own line: \"ruling 30 (a) raised a count of minds — the one thing this role exists not to do — and was caught by the record job\". A second look is the result one likes; audit what it was a look *at*. Source: `plans/FS132-close-inventory.md` items 30 (a), 31 (1); `plans/FS132-derivation.md` § 1.",
        "FS-132 (2026-10-07), a reading with no control: the asking lane read the tight seven-colouring R7 as the common exception of three results — \"its reading, no computation\" — and the sentence reached Kooshi before its author caught it: R7 has \"**no three-label point**\", so the results do not speak of it at all. Source: `plans/FS132-close-inventory.md` items 21 (4), 23.",
    ],
    "G92": [
        "FS-132 (2026-10-07): four statements moved to the class their arguments read — the release's extraction to every `k` and to any closed disc of radius above 1, with existence needing no hypothesis (\"G92 applied to an outside proof\"); the first night's exclusion, which reads two clauses of the extraction's data and neither the centre's isolation nor a Siamese clause; the covering count, which reads no properness; the confinement statement, for any set (the kernel planner, blind). Two widenings were found not to be: the two-point form of the exclusion \"is therefore a restatement, not a generalization\", and the two-pair ring, entered as wider than posed, was the release's own Lean theorem. Source: `plans/FS132-close-inventory.md` items 3, 6, 15, 18, 25; `plans/FS132-derivation.md` §§ 1–3.",
    ],
    "G87": [
        "FS-132 (2026-10-07): three signals were raised in one night and none needed an invention job. Card 3's collision was read by the deriver that took it — \"both sides true, of two targets\". The manuscript's \"The extracted cycle need not consist of edges of Γ_x\" against the extraction's clause (5) stays on record with no side picked. And the two stalls of the second round, first called one place met from two sides, were re-read as \"the two opposite inclusions between two graphs on the labels at a point\" — the premise both sides shared, that a point's cycle of meetings and the cycle it witnesses are one cycle, was the one to drop (proposed G96). Source: `plans/FS132-close-inventory.md` items 7, 12, 17, 21; `plans/POROS-2026-10-07-fs132-round2.md` § 1.6.",
    ],
    "G84": [
        "FS-132 (2026-10-07): the side rule for an open one-label piece (C132-SHADOW) is this entry's shadow identity read for an open piece, with no saturation; and the object every exclusion of the milestone stopped at — an interface on the unit circle about a point one unit away — is this entry's first sentence. The opening's re-grokking listed the entry only for \"who supplies EXT's hypothesis\" and extracted neither. Source: `plans/FS132-derivation.md` § 2 (C132-SHADOW's prior-art line), § 12; `plans/FS132-six-by-the-nerve.md` §G; `plans/FS132-Z2-record.md` Stage 5.",
    ],
    "G89": [
        "FS-132 (2026-10-07): honesty was tested as the cost-free normal form on two slack seven-colourings and the test was not well posed — no order makes the hexagonal seven-colouring or either slack colouring Grundy, \"true already of the unmodified hexagonal colouring\", and the construction has no one output. Source: `plans/FS132-close-inventory.md` item 19; `plans/FS132-derivation.md` § 7.",
    ],
    "G95": [
        "FS-132 (2026-10-07): the stalled regularity statement of the existence side carries this entry's caution in its own entry — \"its first clause is false wherever local slack exists along the strip, so it is a statement for a normal form or false at six\" (C132-RING-TAME) — and the extraction's conclusion with its clause (4) is false at the island colouring's accumulation centre and true at the isolated ones. Source: `plans/FS132-close-inventory.md` items 3, 7; `plans/FS132-derivation.md` §§ 3, 8.",
    ],
}

ATLAS = [
    ('N("MEXCL", "the (Q)-free exclusion, with no map", "nogo", "For every measurable six-colouring proper at almost every unit pair: where four labels meet in a witnessed cycle, the palettes on the point\'s unit circle cannot almost everywhere hold one of the two other labels. No map, no Siamese clause.", L(155), "the palettes on its unit circle cannot almost everywhere hold one of the two other labels", "[hand], one mind, with a line-by-line checking reading of its steps M4–M9 by a second mind", at=(88, 500), sector="seven")', 155),
    ('N("CENTRES", "cyclic centres exist at every k", "held", "Every closed disc of radius above 1 holds a point where classes meet in a cycle, at every number of colours, with no hypothesis; the data at a centre need the centres finite in a disc.", L(156), "every closed disc of radius greater than 1 contains a cyclic centre", "[hand] or derived from [hand] entries, one mind each, kernel pending", at=(96, 470), sector="seven")', 156),
    ('N("COMPSHARP", "the complementary pair, in the exact class", "held", "Two triangle points on disjoint triples of six labels, less than 2 apart, force an edge set onto the unit circle about each common unit point. No cone scale.", L(157), "then one of the six sets K_0, K_1, K_2, K′_0, K′_1, K′_2 is contained in the unit circle about w", "[hand] or derived from [hand] entries, one mind each, kernel pending", at=(100, 525), sector="seven")', 157),
    ('N("WIND6", "three outside labels wind", "held", "A loop among three labels with the 60° exclusion has degree 3 modulo 6: six is the one count at which the labels left for a ring can wind. The forcing of a centre that is not a triangle stalls at this circle.", L(158), "then the degree of φ, for the orientation a → b → c of Θ, is congruent to 3 modulo 6", "[hand] or derived from [hand] entries, one mind each, kernel pending", at=(104, 495), sector="seven")', 158),
    ('N("PLACEDARC", "the turning ring places a unit-arc centre", "held", "In step form with witnesses near the centre, a turning ring forces a point with four labels present whose own unit circle runs along two unit arcs. No model is known.", L(159), "a measurable instance of FS-124\'s first question, every hypothesis derived from the seed\'s data", "[hand] or derived from [hand] entries, one mind each, kernel pending", at=(92, 545), sector="seven")', 159),
    ('N("FLOWERS", "the turning ring in a finite family", "held", "In a family of seven flowers of wedges the three-label turning ring and the alternating ring do not exist; with four labels at alternate ring points the turning ring exists, in fragment T2\'s shape.", L(160), "no model has the turning ring `a, b, n, a, b, n` and at most three labels at every ring point", "[cert]", at=(108, 550), sector="seven")', 160),
    ('E("MEXCL", "QFREE", "context", L(155), "It is rows 148–149\'s exclusion in measure", label="the same exclusion, with no map")', 155),
    ('E("PLACEDARC", "FLOWERS", "context", L(159), "the one model the day\'s search kept (row 160) is the other case", label="the kept model is the hard case")', 159),
]


def main():
    fault = "--fault" in sys.argv
    rows = {n: fill(t) for n, t in ROWS.items()}
    for n, t in rows.items():
        check_quotes(f"row {n}", t)
        assert t.count("\n") == 0
    ledger = rd("LEDGER.md")
    if "| 155 |" in ledger:
        ERR.append("LEDGER.md already has a row 155")
    if "| 154 |" not in ledger:
        ERR.append("LEDGER.md has no row 154")
    claude = rd("CLAUDE.md")
    deltas = []
    for i, (label, old, new) in enumerate(CL):
        o = old[::-1] if (fault and i == 0) else old
        if claude.count(o) != 1:
            ERR.append(f"CLAUDE.md: slot occurs {claude.count(o)} times: {o[:60]!r}")
        deltas.append(len(new.encode()) - len(old.encode()))
    for p, s in LEDGER_SLOTS + G_SLOTS + [BIB_SLOT]:
        slot(p, s)
    for k, items in INST.items():
        for it in items:
            check_quotes(f"instance {k}", it.replace('\\"', '"'))
    for code, n in ATLAS:
        m = re.findall(r'L\(%d\), "((?:[^"\\]|\\.)*)"' % n, code)
        for q in m:
            if q.replace("\\'", "'") not in rows[n]:
                ERR.append(f"atlas quote not in row {n}: {q[:60]!r}")
    if ERR:
        for e in ERR:
            print("ERROR", e, file=sys.stderr)
        sys.exit(1)

    out = []
    w = out.append
    gsize = len(rd(G).encode())
    gadd = sum(len(x.encode()) + 1 for x in (G96, G97, G98)) + sum(len(x.encode()) for x in (G84_ADD, G89_ADD, G21_ADD))
    w("## Drafts for the front page\n")
    w("*Built and checked by `tools/fs132_z2_frontpage.py` (every statement inside a ledger row is the entry's `statement:` field, "
      "copied by the script; every other quoted span of twelve characters or more in a row or an instance is checked verbatim against its "
      "source; every slot string is checked to occur exactly once in the file it names; `--fault` corrupts one slot and the run exits 1). "
      "Each draft is written as it should stand, current state only. No grade is raised: every row says \"one mind\" where the entry does.*\n")
    w("### `LEDGER.md` — six rows, 155–160\n")
    w("**Slot**: § A, the table of rows, to follow row 154 (the line beginning `| 154 | **The map step at five, as an equivalence:**`). "
      "Six lines, in this order, each one table row. Sizes in bytes: "
      + ", ".join(f"row {n} {len(t.encode()):,}" for n, t in rows.items()) + ".\n")
    for n in sorted(rows):
        w(rows[n] + "\n")
    w("**Where a headline might be read larger than its entry — the entry's own words beside it, for the coordinator to choose.**\n")
    w("- Row 155's headline says \"cannot almost everywhere hold one of the two other labels\". C132-M-EXCL's statement: \""
      + STMT["C132-M-EXCL"] + "\" Its *not claimed*: \"what C132-M-ORBIT does not claim; that the centre is binary for no pair at all "
      "(only for the pair outside the cycle)\". The row never says \"excluded\" without its hypothesis, and never \"two minds\".")
    w("- Row 159's headline says the turning ring \"plac[es] a four-label point\". C132-LENS-FOUR's statement: \"" + STMT["C132-LENS-FOUR"]
      + "\" — three consecutive outer-pure ring points are its hypothesis, and C132-LENS-GERM says when they exist; the row says both. "
      "If the headline is to be shorter, cut \"placing a four-label point whose own unit circle runs along two unit arcs\" to \"forcing, "
      "between outer-pure neighbours, a lens of the centre's own labels\" — that is C132-LENS alone.")
    w("- Row 158's headline says \"six is the one count\". The derivation file's sentence: \"Three labels outside a triangle wind — degree 3 "
      "modulo 6, so at least nine changes; four labels have no winding number; two are rigid.\" The inventory's (item 7): \"six is the one "
      "count at which the outside labels wind\".\n")
    w("**Carried from part 1, by address** (`plans/FS132-Z1-record.md` Stage 5; each slot re-checked here to occur once in `LEDGER.md`):\n")
    w("- § 5.1 — row 133, to follow the words \"a GAP at cusp vertices\": FS132-E4's sharpening, verbatim there.")
    w("- § 5.2 — rows 148 and 149, the note \"**Since FS-132 (2026-10-07):** …\", the same text in both, to follow \"(SQ9 at nine meets "
      "every other hypothesis).\" in row 148 and \"(FS129-SR1's attacks on the chain's two named steps found no gap — checking readings, "
      "not second minds).\" in row 149. With rows 155 and 157 filed, its \"(C132-M-EXCL, `plans/FS132-derivation.md` § 1; …)\" may read "
      "\"(row 155)\" and its \"C132-WITNESS\" \"(row 157)\"; the text as part 1 drafted it is true as it stands.\n")
    w("**One more note, optional — row 139.** The asking lane found (`plans/FS132-close-inventory.md` item 12) that rows 133 and 139 pose "
      "route R with a cone-scale bound that has no consumer in the exact class once the complementary pair is excluded there. It is now "
      "derived up to one residue. **Slot**: row 139, at the end of its statement cell. **Text**: \" **Since FS-132 (2026-10-07):** for exact "
      "colourings — the plane's own class since `[OAIMath2026]` — the complementary pair's exclusion needs no cone scale, up to one residue, "
      "an edge set on the unit circle about the common unit point (row 157; [hand], one mind, kernel pending); what is left of route R there "
      "is the forcing (row 158's gap).\" I have not read row 139 beyond the front page's summary of it; the coordinator reads the note "
      "against the row before filing it, or drops it.\n")

    w("### `CLAUDE.md` — § Frontier and § The aim\n")
    w(f"The file is {len(claude.encode()):,} bytes on disk (budget 80,000). Each slot below occurs exactly once in it. Net change of all six: "
      f"**+{sum(deltas):,} bytes**, to {len(claude.encode()) + sum(deltas):,}. The ranked table is the asking lane's and is not drafted.\n")
    for (label, old, new), d in zip(CL, deltas):
        w(f"**{label}** (net {d:+,} bytes).\n")
        w("Replaces:\n")
        w("> " + old.replace("\n", "\n> ") + "\n")
        w("With:\n")
        w("> " + new.replace("\n", "\n> ") + "\n")
    w("**Beside the draft for § The aim, point 6 — the entries it summarizes, so that the coordinator can choose.** \"The exclusions it "
      "feeds read no regularity and no normal form\": the derivation file's § 12, \"on the arc-free side the exclusions of centres that are "
      "not triangles, the complementary pair and the alternating ring run with no map and no normal form, at one mind each\". \"Not yet "
      "chosen\": the asking lane ruled that saturation is not the class for the ring's finiteness (item 11: \"saturation is not the class "
      "(at six it binds the top colour, 'the answer restated')\") and the test of honesty did not decide it (C132-GRUNDY7, a stall). "
      "\"At most two labels along a ring\", which the standing sentence names, is the release's bound at five; at six a triangle centre's "
      "ring carries three outside labels and what stands in the bound's place is the winding (row 158). If the coordinator prefers to "
      "leave the standing sentence, it is incomplete and not false: its two statements are still false under local slack.\n")
    w("**Not drafted, and why.** § The mission's table, § The aim's points 1–5, \"The problem\" and \"What the kernel holds\": nothing in "
      "FS-132 changes them — no value moved, and nothing of FS-132 is in the kernel on `main`. § Grokkings' \"theory in one paragraph\": "
      "its last sentence stands; a clause on FS-132 would repeat item 31's.\n")

    w("### `.claude/skills/grokkings/SKILL.md` — three proposed entries, G96–G98, and three sentences\n")
    w(f"The file is {gsize:,} bytes (budget 200,000). The three entries and three sentences add **{gadd:,} bytes**, to {gsize + gadd:,}. "
      "**Slot for the entries**: to follow G95's entry, before the line beginning `* **G51 —`. Each is in G67's form: status, body, a *Do* "
      "with its trigger, a killing test or what it forbids. They cite rows 155–160 and so are filed after the ledger rows.\n")
    for g in (G96, G97, G98):
        w(g + "\n")
    w("**A fourth candidate, declined as an entry**: \"clean control counts can be the margin's\". It is G21's rule — \"a control the "
      "instrument cannot see is not a control\" — met in a new shape, and is drafted as an instance of G21 below with one sentence for the "
      "entry. **Slot**: G21, to follow \"a control the instrument cannot see is not a control.\" **Text**:\n")
    w(">" + G21_ADD + "\n")
    w("**G84, the entry the opening's §G should have used (Stage 5's sweep).** **Slot**: inside its *Do*, to follow \"never ask a selection "
      "from a cover to be saturated unless the cover is a partition.\" **Text**:\n")
    w(">" + G84_ADD + "\n")
    w("**G89.** **Slot**: to follow \"and given a NO for honest saturated colourings it is the answer (FS121-D3-EQ).\" **Text**:\n")
    w(">" + G89_ADD + "\n")
    w("**G94 — two sentences already drafted by the asking lane and not filed** (`plans/POROS-2026-10-07-fs132-night.md` § Draft for "
      "`.claude/skills/grokkings/SKILL.md`, G94; `plans/POROS-2026-10-07-fs132-round2.md` § Draft re-rank, last paragraph), both for the "
      "slot after \"finiteness on a disc of radius above 1 suffices and is not necessary).\" The first (\"What the exclusions derived so far "
      "read at a centre is less than its continua …\") stands as drafted. The second (\"The nerve gives the point and not the data …\") is "
      "G96's content: if G96 is filed, a pointer \"(G96)\" in G94 serves and the second sentence need not be filed; if G96 is declined, "
      "file the second sentence. Not minted again here.\n")

    w("### `plans/GROKKING-INSTANCES.md` — new instances, verbatim with their sources\n")
    w("**Slots**: each under its entry's heading, at the end of that section — `## G21`, `## G84`, `## G87`, `## G92` exist; `## G89` and "
      "`## G95` do not and are new headings in numerical order (`## G89 — Honesty is free`, after G87's section; `## G95 — Tightness is not "
      "regularity`, after G92's).\n")
    for k in ("G21", "G84", "G87", "G89", "G92", "G95"):
        for it in INST[k]:
            w(f"- **{k}.** " + it.replace('\\"', '"'))
    w("")
    w("### `tools/viz_proof_atlas_facts.py` — six nodes and two edges\n")
    w("**Slot**: after the node `QPRUNE` (the nodes) and after the edge `E(\"QFREE\", \"LOCALF\", …)` (the edges). Filed after rows 155–160, "
      "because the atlas checker quotes filed rows: each quote below is a substring of the row it cites, checked by the script against the "
      "drafted row. Grades are in the project's words. **The positions `at=(θ, r)` are proposals** — placed beside `QFREE` (84, 520) and "
      "`QPRUNE` (80, 540) in sector \"seven\"; I did not render the atlas, and the coordinator moves them where they collide.\n")
    w("```python")
    for code, _ in ATLAS:
        w(code)
    w("```\n")
    w("### `BIBLIOGRAPHY.md` — no new row; one clause\n")
    w("Every key FS-132's derivation file cites resolves: `[OAIMath2026]`, `[SokolovVoronov2025]`, `[Voronov2023]`, `[HurewiczWallman1948]` "
      "(held), `[Hatcher2002]`. One row would change: `[Hatcher2002]` reads \"Cited by `[OAIMath2026]` family 158; **not held, not read.**\" "
      "and is now also cited by an entry of ours. **Slot**: the row beginning `| **[Hatcher2002]** A. Hatcher, *Algebraic Topology* (2002) |`, to follow its words \"**not held, not read.**\" **Text**: \" Cited by FS-132's "
      "C132-NOESS for a textbook fact (§ 1.2 and Proposition 1.26), recalled, not read.\"\n")
    print("\n".join(out))


if __name__ == "__main__":
    main()
