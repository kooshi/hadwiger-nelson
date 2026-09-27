"""FS107-C: apply §R-close 4.2's CLAUDE.md drafts to a copy and report the byte count (never writes CLAUDE.md).
Usage: python3 data/fs107/fs107-c/budget_sim.py [out_path]. Each replacement asserts its anchor exists exactly once."""
import re, sys
src = open('CLAUDE.md', encoding='utf-8').read()
before = len(src.encode())
s = src
def rep(old_start, old_end, new):
    """Replace the span from old_start (inclusive) to old_end (inclusive), each unique."""
    global s
    i = s.find(old_start); assert i >= 0 and s.count(old_start) == 1, old_start[:60]
    j = s.find(old_end, i); assert j >= 0, old_end[:60]
    s = s[:i] + new + s[j+len(old_end):]
LAST = ("*Last updated: 2026-09-27 — **FS-107, stability, closed** (row 133; `plans/FS107-stability.md` §R-close): both claims GAP; R's reduction and W's\n"
"equivalence meet at the tangency seam (FS-110) and the cone scale (FS-111). Before it, **FS-106** (rows 131–132) and **the reframe** (Kooshi,\n"
"2026-09-26): the aim is the answer, formalized in Lean (§ The aim). **No finite-witness search runs until 2026-10-01** (Kooshi; § Toolchain).\n"
"Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*")
rep("*Last updated: 2026-09-27 — **FS-106", "Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*", LAST)
PROG = ("**The program** (`plans/STUB-regularity-wall.md`): **FS-106, the regular half — closed** (rows 131–132); **FS-107, stability — closed** (row 133):\n"
"Voronov's contradiction survives a free colour if a complementary junction pair is forced at a scale bounded below, and vanishing holes at bounded\n"
"complexity are a tight six-map; **FS-110, the tangency seam** — does such a map exist, its close complementary vertices tangent, bowtie or cusp;\n"
"**FS-111, the cone scale** — the same at unbounded complexity; **Lean throughout** — MR in full (Einsiedler–Lindenstrauss, Einsiedler–Fish), the\n"
"collapse, the measurable chain, the map argument.")
rep("**The program** (`plans/STUB-regularity-wall.md`)", "the collapse, the measurable chain, the map argument.", PROG)
I31 = ("31. **The regularity wall, verified; the question is stability, and it meets at one seam** (§ The aim; rows 131–133; FS-110, FS-111). Regular\n"
"   classes need seven almost everywhere — slack, polygons and convex tilings (bar `d = 2`), nice maps — and maps six; closed classes are the tight\n"
"   question itself. With no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131). At bounded complexity that is whether a tight six-map exists, its close\n"
"   complementary vertices tangent, bowtie or cusp; past it, whether junctions keep a cone scale (row 133). Bearing on the answer: none moved; the\n"
"   question located.")
rep("31. **The regularity wall, verified; the question is stability**", "the question restated exactly.", I31)
OPEN = ("**Open milestones, in order.** **None is open.** FS-107, stability, is **closed** (row 133; `plans/FS107-stability.md` §R-close). **Next: FS-110,\n"
"the tangency seam** (the owner's ruling, 2026-09-27; `plans/STUB-tangency-seam.md`); the finite-witness-free week runs to 2026-10-01 (§ Toolchain).\n"
"**M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it. Every earlier close: `plans/FRONTIER-STUBS.md`'s closed list.")
rep("**Open milestones, in order.** **None is open.** FS-106", "Every earlier close: `plans/FRONTIER-STUBS.md`'s closed list.", OPEN)
R1 = ("| 1 | **FS-110 the tangency seam** — `plans/STUB-tangency-seam.md` (FS-107's successor; SWAP-PRICE folded in) | does a full tight a.e.-proper six-colouring by a locally finite arc-bounded map exist? Its close complementary vertices must be tangent pairs, bowties or cusps (row 133), a tangent ring may still force holes at positive scale (FS107-V's C5, one mind), and equal-type pairs in `(1, 2)` must survive the bicycle | decisive both ways at bounded complexity: YES gives `χ(ℝ²) ≤ 6` with no MR; NO answers S–V Question 2 a.e. for such maps and closes door (A) |\n"
"| 2 | **FS-111 the cone scale** — `plans/STUB-reg-scale.md` | door (B): do near-optimal band-proper six-colourings keep junction cone scales `≥ s₀` on a set of positive measure? De Giorgi's room (link 6) | decisive jointly with FS-110's NO (`χ_m⁰ = 7`, so `χ(ℝ²) = 7` given MR); alone a regularity theorem |")
lines = s.split('\n')
k = [i for i,l in enumerate(lines) if l.startswith('| 1 | **FS-107 stability')]; assert len(k)==1
lines[k[0]] = R1
# renumber the explicit ranks 2..29 to 3..30, then drop the new rank 30 (FS-98) into the bucket
out=[]; dropped=None
for l in lines:
    m = re.match(r'^\| (\d+) \| (\*\*FS-\d+)', l)
    if m and l is not None and not l.startswith('| 1 | **FS-110') and not l.startswith('| 2 | **FS-111'):
        n = int(m.group(1))
        if 2 <= n <= 29:
            l = f'| {n+1} |' + l[len(f'| {n} |'):]
            if n+1 == 30: dropped = l; continue
    out.append(l)
s='\n'.join(out)
assert dropped and 'FS-98' in dropped, dropped
assert s.count('| 30–63 | FS-76, ')==1
s = s.replace('| 30–63 | FS-76, ', '| 30–64 | FS-98, FS-76, ')
assert s.count("is FS-107's sub-question")==1; s = s.replace("is FS-107's sub-question", "is row 131's sub-question")
assert s.count("a dial on FS-107's question")==1; s = s.replace("a dial on FS-107's question", "a dial on row 131's question; C-VOID's thin-hole test runs in the ban, by formula")
G72old = s[s.find('**The count so far — thirteen of sixteen**'):]
G72old = G72old[:G72old.find('\n')]
assert G72old.startswith('**The count so far')
G72new = "**The count so far — fourteen of seventeen** (each derivation close's §IQ record; milestone by milestone in `plans/GROKKING-INSTANCES.md` §G72; the latest, FS-107, through: the meeting point from candidate (b), junction types)."
assert G72old.endswith('no-go).'), G72old[-40:]
s = s.replace(G72old, G72new)
G82 = ("* **G82 — The measurable question is a stability question: a refutation is regular, and only its limit is wild. [hand, two minds, one blind\n"
"  (row 131); the reading one mind, corrected at FS-107]** A weak-* limit of near-colourings is a colouring (the circle measure is Rajchman), so\n"
"  `χ_m⁰ ≥ 7` is the stability of a regular theorem: W's objects are periodic tilings checked exactly, and R must count a defect at a scale\n"
"  independent of `ε` — spread over positive measure, or at features whose own scale is bounded below (row 133's (B)). *Demotion record:* as minted it\n"
"  read \"R must count a defect non-locally, Voronov's contradiction being feature-local\"; row 133's cone lemma is feature-local and `ε`-independent —\n"
"  feature scale is not band scale. *Do: when a question asks whether a class of colourings exists, ask whether its limit object is a weak-* limit of\n"
"  regular near-solutions; if so, pose it as stability, build on the regular objects, test a stability proof against strips and erosion (row 131's\n"
"  no-gos) first, and price each certificate at its feature's scale, never at `ε`'s. Nothing kills the equivalence; it forbids a construction needing a\n"
"  wild set. Killing test of the reading: a proof of `lim µ₆(ε) < 1` whose features' scale is not bounded below.*")
rep("* **G82 — The measurable question is a stability question", "a feature-local proof of `lim µ₆(ε) < 1`.*", G82)
after = len(s.encode())
print(f'before {before}  after {after}  delta {after-before:+d}  limit 300000  margin {300000-after}')
if len(sys.argv) > 1: open(sys.argv[1],'w',encoding='utf-8').write(s)
