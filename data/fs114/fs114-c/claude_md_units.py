"""FS114-C: the CLAUDE.md units drafted for Keryx, old and new, with the byte count (run from the repository root)."""
s = open('CLAUDE.md').read()
def cut(a, b):
    i = s.find(a); j = s.find(b, i) + len(b); return s[i:j]
old = {
 'last': cut("*Last updated: 2026-09-27", "and git.*"),
 'open': cut("**Open milestones, in order.**", "Every earlier close: `plans/FRONTIER-STUBS.md`'s closed list."),
 'prog': cut("**The program** (`plans/STUB-regularity-wall.md`)", "the map argument."),
 'i31': cut("31. **The regularity wall", "the other half reduced."),
 'g83': cut("* **G83 —", "radius 3 with no such vertex.*"),
 'g72': cut("**The count so far — sixteen of nineteen**", "gave the reduction to four-colour vertices)."),
 'rows': "**Rows 1–136 live in `LEDGER.md`**",
}
new = {
 'last': """*Last updated: 2026-09-28 — **FS-114, the unit-arc question, closed undecided** (rows 137–138; `plans/FS114-C-close.md`): every six-map with
unit arcs has a four-colour vertex, so the NO is one exclusion at an explicit radius about such a vertex (row 137), and where the count gives six room
the configurations die locally but for named cases (row 138); its successors are FS-116 and FS-117. ‹FS-111› Before them, **FS-112** (rows 135–136),
**FS-110** (row 134), **FS-107** (row 133) and **the reframe** (Kooshi, 2026-09-26): the aim is the answer, formalized in Lean (§ The aim). **No
finite-witness search runs until 2026-10-01** (Kooshi; § Toolchain). Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*""",
 'open': """**Open milestones, in order.** **None is open.** FS-114, the unit-arc question (`plans/STUB-global-step.md`), is **closed undecided** (rows 137–138;
`plans/FS114-C-close.md`), with BASE-V beside it (row 134's base re-derived but for Lemma 4 at cusps). ‹FS-111› **Next: Poros's re-rank**
(`plans/FRONTIER-STUBS.md`); FS-114's successors are **FS-116, the local exclusion** (`plans/STUB-local-exclusion.md`, opening with round 7's queue) and
**FS-117, route T's count** (`plans/STUB-route-t-count.md`); FS-115 bears only on the four-colour density form (row 137); the finite-witness-free week
runs to 2026-10-01 (§ Toolchain). **M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it. Every earlier close:
`plans/FRONTIER-STUBS.md`'s closed list.""",
 'prog': """**The program** (`plans/STUB-regularity-wall.md`): **FS-106, the regular half — closed** (rows 131–132); **FS-107, stability — closed** (row 133):
Voronov's contradiction survives a free colour if a complementary junction pair is forced at a scale bounded below, and vanishing holes at bounded
complexity are a tight six-map; **FS-110, the tangency seam — closed** (row 134: none under Condition 5); **FS-112, the unit-arc half — closed** (rows 135–136);
**FS-114, the unit-arc question — closed** (rows 137–138: the NO is one local exclusion about a four-colour vertex); **FS-116, the local exclusion**;
**FS-117, route T's count** (the non-Siamese part); **FS-115, the stuck ray** (the density form only); ‹FS-111› **Lean throughout** — MR in full
(Einsiedler–Lindenstrauss, Einsiedler–Fish), the collapse, the measurable chain, the map argument.""",
 'i31': """31. **The regularity wall, verified; the question is stability; at bounded complexity, one four-colour vertex** (§ The aim; rows 131–138;
   FS-116, FS-117, ‹FS-111›). Regular classes need seven almost everywhere — slack, polygons, convex tilings, nice maps — and maps six; closed
   classes are the tight question itself. With no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131). At bounded complexity that is whether a tight six-map
   exists (row 133): under Condition 5 none does (row 134); with unit arcs every one has a vertex of at least four colours (rows 135, 137), so the NO is one
   exclusion at an explicit radius, above `φ²/√2`, about such a vertex; where the count gives six room the configurations die at `√3` or `1 + ε` but for
   named cases, and both printed positives are part of no such map (rows 136, 138). ‹FS-111›
   Bearing on the answer: none moved; half of door (A) closed, the other half one local statement.""",
 'g83': """* **G83 — With unit arcs, the tight question lives at one four-colour vertex. [hand, two minds, one blind (rows 135–138); the reading one mind]**
  The unit-radius tactic survives reduction only at vertices of four or more colours, and every valid map has one (row 137, two minds blind to each
  other), so the NO is an exclusion at an explicit radius about a single such vertex; the count (route T) gives six room only at degree-4 four-colour
  vertices with three or four tactic edges, and every such configuration examined died by a straddle — two tiles of one colour forced along two unit
  circles to come within 1 — at `√3` or `1 + ε` (row 138). *Reading:* what is left is four-colour vertices whose rings carry (Q) arcs, the class every
  exclusion so far had to except; killing test: a valid fragment by formula about such a vertex beyond `φ²/√2`. *Do: when a tight-map question admits
  unit arcs, take one four-colour vertex and ask what its ring carries (a (Q)-free ring's change points are four-colour vertices, N7-HUB) before
  excluding its next escape, and hunt the straddle along two unit circles. Nothing kills the theorems but a defect in row 134's base; they forbid a
  valid map with unit arcs and no four-colour vertex.*
* **G86 — Tile counts are blind to Siamese pairs: a count reaches the non-Siamese part, and a Siamese kill reads points and distances. [hand, one mind
  (FS114-N2, row 137); the reading one mind]** Euler's formula fixes a map's average number of neighbours, and a six-colouring pays for neighbours beyond
  five with repeated colours — a unit arc about a four-colour vertex, or a Siamese pair (tiles of one colour within each other's exclusion annulus).
  Where Siamese pairs are allowed a tile can be cut into any two-colour map, so no density bound exists and a Siamese vertex pays its demand at no cost:
  no count over tiles charges it (N2-REFINE). So a count gives the non-Siamese NO at best — de Grey's target (`[16.317]`), Thomassen's theorem without
  scalability — and the whole NO must be a local exclusion reading distances between points of colour classes. *Do: before a counting or discharging
  route to a map-colouring NO, ask whether the class allows Siamese pairs; if it does, put "non-Siamese" in the count's headline and aim the rest at a
  distance argument. Nothing kills the refinement lemma; it forbids a tile-count proof of a NO for a class with Siamese pairs.*""",
 'g72': """**The count so far — seventeen of twenty** (each derivation close's §IQ record; milestone by milestone in `plans/GROKKING-INSTANCES.md` §G72; the latest, FS-114, through: §IQ's per-vertex datum is route T's charge, which set FS-114's targets).""",
 'rows': "**Rows 1–‹last› live in `LEDGER.md`**",
}
if __name__ == '__main__':
    import sys
    tot = 0
    for k in old:
        assert s.count(old[k]) == 1, k
        d = len(new[k].encode()) - len(old[k].encode()); tot += d
        print(f"{k}: old {len(old[k].encode())} B, new {len(new[k].encode())} B, net {d:+d}")
    print(f"net addition to CLAUDE.md: {tot:+d} bytes (the three ‹FS-111› markers and ‹last› counted as written; FS-111's clauses are FS111-C's)")
    if '--emit' in sys.argv:
        for k in old:
            print(f"\n#### {k}: replace (verbatim, the whole unit)\n\n```text\n{old[k]}\n```\n\nwith\n\n```text\n{new[k]}\n```")
