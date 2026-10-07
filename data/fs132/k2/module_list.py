#!/usr/bin/env python3
"""FS132-K2 stage 7: the draft list of second- and third-round entries the FS-132 module should state.
Statements are copied verbatim from the derivation file's `statement:` fields (never retyped); the one line under each
is the planner's. Usage: module_list.py <path to plans/FS132-derivation.md>  -> markdown on stdout.
--check: exit 1 if a named entry is missing from the derivation file or a statement field is empty."""
import re, sys
src = sys.argv[1]
L = open(src).read().split('\n')
ents = {}
cur = None
for l in L:
    if l.startswith('derivation: '):
        cur = l[12:].strip(); ents.setdefault(cur, {})
    elif cur and l.startswith('  statement:'):
        ents[cur]['statement'] = l.strip()[len('statement:'):].strip()
    elif cur and l.startswith('  grade:'):
        ents[cur]['grade'] = l.strip()[len('grade:'):].strip()
    elif cur and not l.startswith('  '):
        cur = None
ORDER = [
 ('A', 'C132-WIT-MARGIN', "rests on: the definitions (`Straddle`, `spatialSupport`) and the triangle inequality; about 15 lines; not a corollary. **Stated because it gives the four-point hypothesis of `no_outside_orbit_points` a kernel model** (the gate's inhabitant rule): labels absent near the ring are witnessed by every nearby point."),
 ('A', 'C132-WIT-SIDE', "rests on: the definitions and `mem_spatialSupport_ae`; no properness, no palette; about 50 lines; not a corollary. The leaf under WIT-STRIP, CROSS, PLACE and LENS-SIDE (the asking lane's \"item 1's first leaf\"). The open-set form costs nothing here (no ported lemma is read)."),
 ('A', 'C132-WIT-STRIP', "rests on: C132-WIT-SIDE and one inequality on `|x + r f − q|`; about 100 lines for the strips and the count. **Its last clause (the palette meets `N` almost everywhere) rests on the release's `outer_strip_trace` and `inner_strip_trace`** (`BoundaryTrace.lean:182, 210`), not in the port's present cone: state that clause as a separate theorem and ask for the two lemmas' port. Carries C132-TRI-STRIP's strip clauses."),
 ('A', 'C132-SHADOW', "rests on: weak properness alone (`WeakColoring`, Fubini for `(z, u) ↦ z + u`), an intermediate value; about 120 lines; not a corollary. The third round's base (C132-LENS)."),
 ('A', 'C132-CROSS', "rests on: C132-WIT-SIDE (its step B1) and that `z ↦ (|z − x|, |z − y|)` is a local homeomorphism at `w` (four non-empty open quadrants); no properness; about 150 lines."),
 ('A', 'C132-COMP-SHARP', "corollary of C132-CROSS by one pigeonhole; about 40 lines."),
 ('A', 'C132-PLACE', "rests on: the release's `palette_transfer_pair` (port), this module's `chart`, `chart_quasiMeasurePreserving`, `chart_eq_angularSum` (leaves of the exclusion), and C132-WIT-SIDE; about 120 lines; whole plane first. The base of the third round with C132-SHADOW."),
 ('B', 'C132-LENS', "rests on: C132-PLACE at two ring points and C132-SHADOW; the entry's own handoff: \"two charts read at y_1 and y_{−1}, then C132-SHADOW with the four segments\"; about 200 lines."),
 ('B', 'C132-LENS-SIDE', "corollary of C132-LENS and C132-WIT-SIDE by one open set of positive measure; about 50 lines."),
 ('B', 'C132-LENS-FOUR', "corollary of C132-LENS and C132-PLACE; about 80 lines."),
 ('B', 'C132-LENS-GERM', "a finite count on `ℤ/6` and C132-LENS-SIDE; about 80 lines."),
 ('B', 'C132-ALT', "rests on: C132-PLACE at two adjacent ring points and the unit-pair relation of the exclusion's `Shift` module **for both signs of `d` and `d'`** — the exclusion's leaves state it for `d, d' ≥ 0` only, so `dist_chart_chart_shift` and `ShiftBounds` need signed companions (the same proofs on `[−1/4, 1/4]²`; numerically the unit distance holds there); about 250 lines. After the exclusion's module is green."),
 ('C', 'C132-WIT-SUPER', "rests on: the ported `weak_all_directions` (in `Outside/OAI158Palette`) and the release's disc averages (`DiskAverages.lean`, 333 lines, at every `k`: a port); about 150 lines beside it. The asking lane's replacement for C132-EXT-DISC."),
 ('C', 'C132-CORES-SQUARE', "the skeleton's `exists_cyclicCentre_square`; rests on: `no_fine_cover_square` (from this library's `lebesgue_covering_square` and Mathlib's shrinking lemma: about 40 lines, nothing ported) and the hole chain of the release at `Fin k` on a square (`GraphRealization`, `HoleApproximation`, `Mesh`, `DiskExtension`, parts of `PlanarCovers`: about 1,900 lines with changed types, **and the mesh theorem's `2 < dist x y` made `1 + c₀ < dist x y`**): a planner-and-implementer job of its own. C132-CORES-FREE is its corollary (in the skeleton)."),
 ('C', 'C132-INDEX', "in the claim list; the skeleton `Winding.lean` (9 leaves); nothing ported, no colouring; about 250 lines. An implementer can start at any time."),
 ('C', 'C132-RING-WIND', "in the claim list; `Winding.lean` (6 leaves and a model); from `sixStep` directly (the planner's route) — the derivers' route through C132-INDEX is the second route; about 300 lines."),
]
if '--check' in sys.argv:
    bad = [n for _, n, _ in ORDER if not ents.get(n, {}).get('statement')]
    print('missing:', bad); sys.exit(1 if bad else 0)
tier = {'A': 'A — next, on the exclusion\'s leaves and the port (second round)', 'B': 'B — the third round, on A', 'C': 'C — beside them: one label\'s superlevel sets, the centres, the index lemmas'}
last = None
n = 0
for t, name, line in ORDER:
    if t != last:
        print(f"\n**Tier {tier[t]}**\n"); last = t
    n += 1
    e = ents[name]
    print(f"{n}. **{name}** (grade as filed: {e.get('grade','?')}) — {line}\n")
    print(f"   > {e['statement']}\n   > — source: plans/FS132-derivation.md, entry {name}, `statement:`\n")
