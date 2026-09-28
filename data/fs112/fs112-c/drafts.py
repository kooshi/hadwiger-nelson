# FS112-C: the CLAUDE.md drafts as (old, new) replacements, applied to a scratch copy to measure bytes. Not the target file.
# Usage: python3 data/fs112/fs112-c/drafts.py <scratch output path>  (reads CLAUDE.md, writes the drafted copy there; the target file is never touched)
import sys, pathlib
ROOT = pathlib.Path('/home/kooshi/source/lean-dir')
S = pathlib.Path(sys.argv[1])
claude = (ROOT/'CLAUDE.md').read_text()

D = []
# D1 Last updated
D.append(("""*Last updated: 2026-09-27 — **FS-110, the tangency seam, closed** (row 134; `plans/FS110-tangency-seam.md` §R-close): under
Condition 5 no curved map six-colours the plane almost everywhere — S–V Question 2's Condition-5 half answered yes. Before it, **FS-107** (row 133),
**FS-106** (rows 131–132) and **the reframe** (Kooshi, 2026-09-26): the aim is the answer, formalized in Lean (§ The aim). **No finite-witness search
runs until 2026-10-01** (Kooshi; § Toolchain). Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*""",
"""*Last updated: 2026-09-27 — **FS-112, the unit-arc half, closed undecided** (rows 135–136; `plans/FS112-unit-arc-half.md` §R-close): the NO
reduced to four-colour and repeated-colour vertices (row 135), the YES stalled where the printed positives stop (row 136); its gaps are FS-114 and
FS-115. Before it, **FS-110** (row 134), **FS-107** (row 133) and **the reframe** (Kooshi,
2026-09-26): the aim is the answer, formalized in Lean (§ The aim). **No finite-witness search runs until 2026-10-01** (Kooshi; § Toolchain).
Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*"""))
# D2 Open milestones
D.append(("""**Open milestones, in order.** **None is open.** FS-110, the tangency seam, is **closed** (row 134; `plans/FS110-tangency-seam.md` §R-close). **Next:
FS-112, the unit-arc half** (`plans/STUB-unit-arc-half.md`), or FS-111 (Kooshi picks); the finite-witness-free week runs to 2026-10-01 (§ Toolchain).""",
"""**Open milestones, in order.** **None is open.** FS-112, the unit-arc half (`plans/STUB-unit-arc-half.md`), is **closed undecided** (rows 135–136;
`plans/FS112-unit-arc-half.md` §R-close). **Next: FS-114, the global step, and FS-115, the stuck ray** (`plans/STUB-global-step.md`, `plans/STUB-stuck-ray.md`; Kooshi, 2026-09-27:
the night on both); the finite-witness-free week runs to 2026-10-01 (§ Toolchain)."""))
# D3 the aim's program line
D.append(("""**FS-112, the unit-arc half**;""",
"""**FS-112, the unit-arc half — closed** (rows 135–136); **FS-114, the global step**; **FS-115, the stuck ray**;"""))
# D4 item 31
D.append(("""31. **The regularity wall, verified; the question is stability, and its Condition-5 half is closed** (§ The aim;
   rows 131–134; FS-111, FS-112). Regular classes need seven almost everywhere — slack, polygons, convex tilings, nice maps — and maps six; closed
   classes are the tight question itself. With no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131). At bounded complexity that is whether a tight six-map
   exists (row 133): under Condition 5 none does (row 134); with unit arcs, open. Past it, whether junctions keep a cone scale. Bearing on the answer:
   none moved; half of door (A) closed.""",
"""31. **The regularity wall, verified; the question is stability; at bounded complexity, four-colour vertices** (§ The aim; rows 131–136;
   FS-114, FS-115, FS-111). Regular classes need seven almost everywhere — slack, polygons, convex tilings, nice maps — and maps six; closed
   classes are the tight question itself. With no MR, `χ_m⁰ ≥ 7` ⟺ `lim µ₆(ε) < 1` (row 131). At bounded complexity that is whether a tight six-map
   exists (row 133): under Condition 5 none does (row 134); with unit arcs each would have a vertex of four colours or a repeated colour within 3 of
   every point, and both printed positives stop where a second four-colour vertex is missing (rows 135–136). Past it, whether junctions keep a cone scale.
   Bearing on the answer: none moved; half of door (A) closed, the other half reduced."""))
# D5 paths forward rows 1-2 -> 1-3
old_r1 = [l for l in claude.split('\n') if l.startswith('| 1 | **FS-112 the unit-arc half**')][0]
old_r2 = [l for l in claude.split('\n') if l.startswith('| 2 | **FS-111 the cone scale**')][0]
new_r = """| 1 | **FS-114 the global step** — `plans/STUB-global-step.md` (FS-112's successor) | exclude a six-map with unit arcs whose four-colour or repeated-colour vertices come within 3 of every point — row 135 says every one would, so this is the NO; for periodic maps four-colour vertices alone suffice. Handles: the pinned corner where both printed positives stop, and the rhombus with four-colour corners (rows 135–136); Sirgedas's unheld non-Siamese argument | decisive both ways at bounded complexity: YES gives `χ(ℝ²) ≤ 6` with no MR; NO answers `[SokolovVoronov2025]` Question 2 and `[Polymath2021]`'s a.e. for circular-arc maps and closes door (A) |
| 2 | **FS-115 the stuck ray** — `plans/STUB-stuck-ray.md` (FS-112's successor) | can a one-sided chain of stuck vertices, its extremal form a pencil of circles of radius `k + 1`, live in a valid map with unit arcs, and are finite chains bounded (row 135)? Periodic maps have neither | none alone: FS-114 in row 135's form needs neither; decisive jointly with FS-114's four-colour form for aperiodic maps, the limits a NO at bounded complexity must cover |
| 3 | **FS-111 the cone scale** — `plans/STUB-reg-scale.md` | door (B): do near-optimal band-proper six-colourings keep junction cone scales `≥ s₀` on a set of positive measure? De Giorgi's room (link 6) | decisive jointly with row 134 and FS-114's NO (`χ_m⁰ = 7`, so `χ(ℝ²) = 7` given MR); alone a regularity theorem |"""
D.append((old_r1+'\n'+old_r2, new_r))
# D6 G72 count
D.append(("""**The count so far — fourteen of seventeen** (each derivation close's §IQ record; milestone by milestone in `plans/GROKKING-INSTANCES.md` §G72; the latest, FS-107, through: the meeting point from candidate (b), junction types).""",
"""**The count so far — sixteen of nineteen** (each derivation close's §IQ record; milestone by milestone in `plans/GROKKING-INSTANCES.md` §G72; the latest, FS-112, through: §IQ's per-centre question gave the reduction to four-colour vertices)."""))
# D7 G83, inserted before G51
G83 = """* **G83 — With unit arcs, the tight question lives at four-colour vertices. [hand, two minds, one blind (rows 135–136); the reading one mind]**
  The unit-radius tactic survives reduction only at vertices of four or more colours; the base refutes a map near any trichromatic vertex with no
  four-colour or repeated-colour vertex within 2; a close complementary pair sits on a unit rhombus with four-colour corners — and both printed
  positives stop exactly where a pair's second corner is missing. *Reading:* the unit-arc half is a placement problem for four-colour vertices, a
  discrete one (Sirgedas's quads); killing test: FS-114 decided by an argument that reads no such vertex. *Do: when a tight-map question admits unit
  arcs, list its four-colour and repeated-colour vertices first and read each close complementary pair's two rhombus corners — a construction that
  saves one has found its stop. Nothing kills the theorems but a defect in row 134's base; they forbid a valid map with unit arcs having a disc of
  radius 3 with no such vertex.*
"""
D.append(("""* **G51 — A competitor and an advisor beat one mind.""", G83 + """* **G51 — A competitor and an advisor beat one mind."""))

D.append((""" **FS-81's three** (rows 83–84): **a relation tree is a weak finder of isolated points** — it left Λ₂₆ over ℚ(√3) undecided at 171,657 nodes and 312 s where a small-order screen found the point in 3 ms, so the screen runs first and a high-order isolated point reads UNDECIDED, never NONEMPTY; the second and third, and the rest: `plans/GROKKING-INSTANCES.md` §G21.""", """ FS-81's three, and the rest: `plans/GROKKING-INSTANCES.md` §G21."""))
out = claude
report = []
for i,(o,n) in enumerate(D,1):
    c = out.count(o)
    assert c == 1, (i, c)
    out = out.replace(o, n)
    report.append((i, len(n.encode())-len(o.encode())))
# rank renumbering: rows 3..28 -> 4..29 is a digit change; row 29 FS-75 leaves for the group, label 30–65 -> 30–66
lines = out.split('\n')
h = lines.index('| rank | stub | the question | bearing on the answer |')
j = h+2; newlines=lines[:j]
rows=[]
while lines[j].startswith('|'):
    rows.append(lines[j]); j+=1
tail = lines[j:]
fixed=[]
for r in rows:
    lab = r.split('|')[1].strip()
    if lab.isdigit() and int(lab) >= 3 and not r.startswith('| 3 | **FS-111'):
        k=int(lab)
        if k==29:  # FS-75 -> group
            fs75=r; continue
        r = r.replace(f'| {k} |', f'| {k+1} |', 1)
    fixed.append(r)
before = sum(len(x.encode())+1 for x in rows)
g = [x for x in fixed if x.startswith('| 30–65 |')][0]
g2 = g.replace('| 30–65 | FS-90,', '| 30–66 | FS-75, FS-90,')
fixed[fixed.index(g)] = g2
after = sum(len(x.encode())+1 for x in fixed)
out = '\n'.join(newlines+fixed+tail)
S.write_text(out)
old_b = len(claude.encode()); new_b = len(out.encode())
for i,d in report: print(f'D{i}: {d:+d} bytes')
print('ranks renumbered and FS-75 moved into the group:', after-before, 'bytes (includes D5 rows already counted? no: D5 applied first)')
print('CLAUDE.md', old_b, '->', new_b, f'({new_b-old_b:+d})')
