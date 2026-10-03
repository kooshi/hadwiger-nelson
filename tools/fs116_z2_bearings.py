#!/usr/bin/env python3
"""FS116-Z2 — the bearing lines FS-116's close writes into open stubs (dated paragraphs at the end of each stub's bearing section), with FS-121's
drafted D8 lines (plans/FS121-Z1-close.md § D8) placed verbatim beside FS-116's in the two stubs they were drafted for.

Each insertion goes before an anchor that must occur exactly once; a stub that already carries FS-116's marker is refused (exit 1), so the run is
never applied twice; FS-121's lines are extracted from its close record by pattern and must be found exactly once each.

    python3 tools/fs116_z2_bearings.py            # apply
    python3 tools/fs116_z2_bearings.py --check    # dry run: every anchor and both FS-121 lines found, nothing written
    python3 tools/fs116_z2_bearings.py --plant    # one anchor altered: must exit 1 naming it

Standard library only.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MARK = "**At FS-116's close (2026-10-03, FS116-Z2).**"


def fs121_line(stub: str) -> str:
    text = (ROOT / "plans/FS121-Z1-close.md").read_text()
    pat = re.compile(r"- \*`plans/" + re.escape(stub) + r"`, § Bearing on the answer:\* \"(.*?)\"\n(?=- |\n|###)", re.S)
    found = pat.findall(text)
    if len(found) != 1:
        raise SystemExit(f"FAIL: FS-121's D8 line for {stub} found {len(found)} times")
    return " ".join(found[0].split())


LOCAL = MARK + """ **Not landed:** C114-LOCAL-F is GAP at named ring types (`plans/FS116-derivation.md` FS116-C114-LOCAL-F; the case list is
`plans/FS116-Z1-close.md` § 2.6). Held under the announcement rule: the **Γ-free four-colour vertex is excluded at radius `1 + ε`** in the non-Siamese simple
class (FS116-Y4-EMPTY, two minds, the second blind); **the YES needs no map** (FS116-O1-YESLIM: valid `k`-coloured fragments on discs of every radius give
`χ_m⁰(ℝ²) ≤ k`, at six `χ(ℝ²) ≤ 6` with no MR), so this question is decisive in both directions without FS-121, as card `the-yes-needs-no-map` said; and
**saturation pins every edge at a four-colour vertex** as split or tangent (FS116-O1-SATPIN). Every change point of a ring off (Q) arcs, and every
semi-hub but the full parallel one of three colours, places a vertex of at least four colours on the ring (FS116-RING-GERM, FS116-N3-SEMI, held). The
rest of the question is FS-123 (`plans/STUB-qfree-ring.md`: the (Q)-free ring, opening with whether a fragment's bends keep it in EMPTY's class),
FS-124 (`plans/STUB-q-ring.md`: the (Q) rings and the five- and six-colour vertices) and FS-125 (`plans/STUB-saturated-local.md`: the saturated class)."""

LOCAL_PA = """*At FS-116's close (FS116-Z2, 2026-10-03; inventory item 19):* the HNT simulator thread `a701Kwnhp_A` is held, not unheld
(`~/source/library/hadwiger-nelson-problem-group/threads/a701Kwnhp_A.txt`): a simulator thread with no exclusion statement
(`plans/FS116-local-exclusion.md` § 2.2). Sirgedas's "A biggest disc implies no 6-color-tiling of the plane exists." (`J_Tw1_hUxQI.txt` l. 4661) is filed as
prior art for the local-to-global idea (FS-116's note under FS114-CV-EXISTS); the rest of the thread stays unread beyond ll. 4290–4790 and the grep hits.
"""

ROUTE_T = MARK + """ K1's (Q)-free case: FS116-Y4-EMPTY (held) excludes at radius `1 + ε`, in the non-Siamese simple class, every vertex of at
least four colours whose ring carries no arc of `Γ`; whether FS114-N7-3T's whole class — and so K1′'s deficient configurations on (Q)-free rings — is empty
turns on whether a fragment's bends keep it in that class, FS-123's first question (`plans/STUB-qfree-ring.md`). FS116-V1-FRAME (one mind, true vacuously)
re-derives "every tactic centre is a change point" there. No FS-116 step was a count: every kill landed is a straddle."""

TOP6 = MARK + """ FS-116 did not land NO-SAT, so the parking stands. What it holds in the saturated class: every edge at a four-colour vertex
of a saturated fragment is split (a unit arc about a ring point carrying both side colours) or tangent (FS116-O1-SATPIN, held); the straight right-angled
cross whose ring carries no (Q) arc dies at `R = 2` in the non-Siamese class (FS116-S1-QF — two derivations, the second told the verdict, not held; a blind
second mind owed). NO-SAT is FS-125's (`plans/STUB-saturated-local.md`)."""

FORCED = MARK + """ A datum for the carried card `do-fs114-kills-survive-a-band`, not its answer (the card asks FS114-Y4-RSTOPALL): FS-116's held
kill, FS116-Y4-EMPTY, closes on FS116-V6-HUG's identity `|a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2)`, a deficit of order `st` in the angular
lengths `s, t` along which the two flank tiles hug the unit circles from the hubs, which nothing in its class bounds below — the second-order shape the
card's hunch names (a reading, FS116-Z2, one mind; untested at a band). FS116-O1-YESLIM (held) puts the YES side on fragments on growing discs, so a robust
NO needs its margin bounded below independently of the complexity."""

CP6 = """*At FS-116's close (2026-10-03, FS116-Z2):* FS116-O1-YESLIM (held, two minds): for every `k`, valid `k`-coloured fragments — segment-and-arc maps on
discs, no two interior points of one colour at distance 1 — on discs of every radius give `χ_m⁰(ℝ²) ≤ k`, with no map in the limit. So this stub's NO side
(a CP five-colouring) can be supplied by valid five-coloured fragments on growing discs, and its YES (`χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6`, row 130) forbids them: some
radius carries no valid five-coloured fragment on any disc.
"""

FIFTH = """*At FS-116's close (2026-10-03, FS116-Z2):* FS116-O1-YESLIM (held) at `k = 5`: valid five-coloured fragments on discs of every radius give
`χ_m⁰(ℝ²) ≤ 5`, hence `χ(ℝ²) = 5` with no MR — so a construction for this stub's YES need be neither a map of the plane nor periodic, only fragments on
growing discs.
"""

HOLE = """## At FS-116's close (2026-10-03, FS116-Z2)

FS116-O1-YESLIM (held, two minds): exact valid six-coloured fragments on discs of every radius give `χ_m⁰(ℝ²) ≤ 6`, hence `χ(ℝ²) ≤ 6` with no MR, with no
periodic tiling and no hole. So W's side of this dial can also be read on exact fragments, by the largest radius each family holds: the capped strip
`φ²/√2` about a four-colour vertex (FS114-Y-DIAL), the disk `≈ 2.1246`, a six-colour vertex below `3/2` (FS116-Y2-SIXFRAG, exact).

"""

PINCH = MARK + """ FS116-S1-RUNG (held, Siamese pairs allowed): a saturated straight edge's first rung tile reaches no farther than 1 from
the rung's points (FS116-Y1-STRIPCEIL is its case at `r(120°)`); at a four-colour vertex the rung collides with the ring's contact inside radius 2
(FS116-S1's recognition; FS116-S1-QF). A rung is a ladder's first step, so the saturated cross is this stub's pinch read at a junction of four colours, on a
fragment rather than a measurable fall colouring; FS-125 carries it."""

PENCILS = MARK + """ The same split-or-tangent dichotomy, read at a vertex of a saturated fragment: every edge at a four-colour vertex is a unit
arc about a ring point carrying both side colours, or a tangent segment or arc of radius at least 1 (FS116-O1-SATPIN, held). A NO here would leave, in an
honest saturated REG-J′ colouring, only segments as tangent edges at such a vertex — the cross of FS116-S1-QF's class (FS-125)."""


def targets() -> list[tuple[str, str, str]]:
    """(stub, anchor, insertion); the insertion goes before the anchor."""
    return [
        ("plans/STUB-local-exclusion.md", "\n## What FS-114 established (addresses in `plans/FS114-derivation.md`)\n",
         "\n" + fs121_line("STUB-local-exclusion.md") + "\n\n" + LOCAL + "\n"),
        ("plans/STUB-local-exclusion.md", "\n## Registered expectations (instruments for G21, scored at the close; never caps)\n", "\n" + LOCAL_PA),
        ("plans/STUB-route-t-count.md", "\n## What is open, named\n", "\n" + fs121_line("STUB-route-t-count.md") + "\n\n" + ROUTE_T + "\n"),
        ("plans/STUB-top-colour.md", "\n## Owed second minds\n", "\n" + TOP6 + "\n"),
        ("plans/STUB-forced-pair.md", "\n## Registered expectations (instruments, never caps)\n", "\n" + FORCED + "\n"),
        ("plans/STUB-fifth-colour-structure.md", "\n## 8. Addresses\n", "\n" + FIFTH),
        ("plans/STUB-hole-dial.md", "\n## Provisional bearings\n", "\n" + HOLE.rstrip("\n") + "\n"),
        ("plans/STUB-pinch-at-junction.md", "\n## The room and the prior art\n", "\n" + PINCH + "\n"),
        ("plans/STUB-curved-pencils.md", "\n## Owed second minds (before anything final rests on them)\n", "\n" + PENCILS + "\n"),
    ]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true")
    ap.add_argument("--plant", action="store_true")
    args = ap.parse_args()
    tg = targets()
    if args.plant:
        s, a, b = tg[3]
        tg[3] = (s, a.replace("Owed", "Owing"), b)
    texts: dict[str, str] = {}
    for stub, anchor, ins in tg:
        t = texts.get(stub) or (ROOT / stub).read_text()
        if stub not in texts and ("At FS-116's close (2026-10-03, FS116-Z2)" in t or "At FS-116's close (FS116-Z2" in t):
            print(f"FAIL: {stub} already carries FS-116's bearing line")
            return 1
        n = t.count(anchor)
        if n != 1:
            print(f"FAIL: anchor in {stub} found {n} times: {anchor.strip()[:60]!r}")
            return 1
        texts[stub] = t.replace(anchor, ins + anchor, 1)
    # the cp-plane-six stub's bearing section is its last: append there
    cp = "plans/STUB-cp-plane-six.md"
    t = (ROOT / cp).read_text()
    if "At FS-116's close" in t:
        print(f"FAIL: {cp} already carries FS-116's bearing line")
        return 1
    if not t.rstrip("\n").endswith("carried in FS-121."):
        print(f"FAIL: {cp} does not end where expected")
        return 1
    texts[cp] = t.rstrip("\n") + "\n\n" + CP6
    if args.check:
        print(f"CHECK OK: {len(tg) + 1} insertions in {len(texts)} stubs; FS-121's two lines found")
        return 0
    for stub, t in texts.items():
        (ROOT / stub).write_text(t)
    print(f"OK: {len(tg) + 1} insertions in {len(texts)} stubs")
    return 0


if __name__ == "__main__":
    sys.exit(main())
