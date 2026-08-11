# M34 — Act One as a kernel theorem, and the union question (PRE-SUBPLAN STUB)

*Written 2026-08-10 at M33's close, minutes after the P12 gate fired OPEN.
Read order for a fresh session: `plans/M33-mechanism-hunt.md` WHOLE (§0a
carries the criticality factorization and the phase-3 architecture A5; §R
carries every measured verdict), then CLAUDE.md § Grokkings G15–G17.*

## What M33 handed this milestone

* **The object**: `build/m33-core-hexchunkB2-eq-pair-2.json` — 122 vertices
  of the M26-certified hexagram chunk at seam depth B = 2 (object ids into
  the chunk's point list, `closure.hexagram_points(2)` currency), with:
  every proper 4-colouring making some distance-2 pair monochromatic
  (solver-UNSAT in TWO independent encodings — one-hot with
  first-occurrence breaking, and binary-2bit), 1-minimality (every member's
  deletion un-fires, each with a validated countermodel IN the artifact),
  12 near-rot6 shells about the metapivot. De Grey's L was 121 vertices —
  the size echo is striking and unexplained.
* **The law it instantiates** (G16): the seam fabric cannot stay clean at
  d = 2 once it has seam depth ≥ 2 — measured on four objects; d = 2 is
  the ρ₁₅ spindle distance (4·2² − 1 = 15), so every kill needs √15: the
  field wall (G1) is the wall between the acts.
* **The lesson**: shrink from slack, not onset (onset-radius cores stay
  floppy: fabric 276/330, 510 201/280 vs the chunk's tight 122/378).
* **The 3-cover companion** (G17): 13 interior points on
  (7−√33)/6 ∪ {1/3} ∪ (9−√33)/6 deliver min-cover 3 onto Heule-510's
  36-circle — the 3rd colour's delivery web, with addresses.
* Annex (may land after this stub): the 1581 √3-pair core (assembly-created
  pigeonhole, onset at the √21 shell).

## The three rungs (expected order)

1. **The pigeonhole certificates.** FIRST the free one: the 1581's
   9-vertex √3-pair core (M33 §R annex) as a kernel theorem by plain
   `decide` (4⁹ colourings) over M18's certified √3-triangle geometry —
   likely a same-day landing that exercises the whole statement shape.
   THEN the main one: "Every proper 4-colouring of the
   122-core has a mono d2 pair among its instances" is ONE finite CNF
   UNSAT — route it through the M05/M06 kernel-LRAT pipeline (emit CNF via
   the M33 encoding, CaDiCaL proposes LRAT, the kernel checks). The CNF is
   ~1/50th the 1581's; the geometry (every vertex a chunk lattice point,
   every edge a certified chord family member) is ALREADY kernel-certified
   at M26 — the statement composes `Hexagram.lean`'s objects with the
   avoidance clause set. Also state A1 (fan ⟺ χ, the two-line general
   lemma — `Coverage.lean` vocabulary meeting `Compulsion.lean`'s genre)
   while the file is open; §0f F6 named its shape.
2. **The kill act, per placement.** Each mono-d2 placement dies by a ρ₁₅
   spindle (Quadrature.lean holds the ρ₁₅ instance of the law; the M26
   transport genre collapses congruent placements). The census question
   FIRST (design script, before Lean): how many of the core's d2 instances
   are congruent under the chunk's symmetries — the A3 width budget.
   Warm-up option if the engine wants it: the pair-web completeness at
   axis 2 (`build/m32-pairweb.json`, the standing Lean warm-up).
3. **The union question — the research.** fabric ∪ (a kill gadget per
   placement class) : is it 5-chromatic, and what is the LEAST such union?
   The honest gap: the pigeonhole forces a mono pair SOMEWHERE; the union
   must kill EVERY placement; the composition theorem (χ ≥ 5 of the union
   from certificate + transported kills, no monolithic SAT) is the M20
   compulsion genre at assembly scale. If the union lands, its closure
   becomes the certification programme's new, far smaller object
   (`plans/M33-witness-closure.md` remains the fallback).

## Standing adoptions for this milestone

* The write-up trigger's artifact shape is now decided (Kooshi,
  2026-08-10): the zeta-23 comparator pattern — see the memory note and
  CLAUDE.md § paths. If rung 1 lands, consider standing up `comparator/`
  (ChallengeDeps + Challenge with the pigeonhole statement) EARLY so the
  trusted surface accretes; `leanprover/comparator` with nanoda can serve
  as the deferred independent-kernel gate.
* All M33 instruments (`tools/mechanism.py`, `rigidity.class_avoid`) are
  standing; the m33-core schema is the handoff contract; the parallelism
  rule (threads bounded by RAM) is standing.

## Beyond this milestone — the k = 5 transfer (recorded 2026-08-11, the
## close discussion with Kooshi; NOT M34 scope, the first stone of the 6-hunt)

The class-avoidance instrument transfers to five colours with one flag,
and the question it asks there has never been asked: a 6-forcer needs an
Act One over 5-COLOURINGS ("no 5-colouring of this region avoids pattern
P everywhere"), and all prior k = 5 measurements were instance meters —
structurally blind to it (that blindness is exactly what M33 broke at
k = 4). The natural first class is the fan itself: "every 5-colouring
puts 5 colours on some circle-plus-centre" is the 6-transition in our own
coverage vocabulary. Sweep objects: the witnesses, their gen-1 closures,
enriched assemblies. If ANY class fires at k = 5, it is the first
concrete piece of a χ ≥ 6 argument anyone has held. Minimality note from
the same discussion: "smallest 5-witness" is now an explicit optimization
— minimize |pigeonhole| + #placement-classes × |kill gadget| — with the
pigeonhole term measured to be a rounding error (9 vertices); the game is
placement symmetry and kill-gadget size.

**Hunting heuristics (the M33 patterns, stated once for reuse):**
(1) compulsion onsets land on NAMED shells — predict from the shell
vocabulary (glue shell, √33 family, cross-system √21) before running
solvers; (2) seam DEPTH switches compulsions on where radius does not —
probe deep, not wide; (3) cores concentrate where class instances
organize into secondary structure (√3-pairs → triangles with shared unit
circumcentres) — hunt the organizing gadget, not the bare class;
(4) the field ladder — each colour step's pigeonhole is native to the
current field, its kills one field up (4: seam group; 5: seam pigeonhole,
√15 kills) — if it echoes, it names the 6-forcer's kill arithmetic in
advance.

## Failure clauses (sharpen at subplan registration)

* The LRAT certificate for the 122-core exceeds kernel budget: measure the
  certificate size FIRST (it should be tiny next to M06's); if it somehow
  balloons, the M05 spike's segmentation machinery exists.
* The placement census fragments (no small congruence-class set): the A3
  width budget explodes — report the measured shape; the union question
  re-ladders rather than rescoping silently.
* The union goes 4-colourable at every affordable size: THE two-act
  assembly reading (G15's remaining [reading] half) is refuted for this
  pigeonhole — a first-class finding; report and re-rank.
* Any segfault, any process: HALT and report to Kooshi (standing).

## Deliverables

* The kernel-checked pigeonhole theorem (rung 1) + A1 stated.
* The placement census + width budget (design script artifact).
* The union experiment's registered predictions and face-value verdicts.
* Frontier/Grokkings close per standing rule; the explorer gains the
  union object if one lands.
