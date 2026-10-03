#!/usr/bin/env python3
"""FS116-Z2 — the dated errata FS-116's close appends to plans/FS114-derivation.md (the original text left standing).

Reads the file at BASE (repeatable), inserts after two anchors, each of which must occur exactly once (else exit 1, naming it), and writes the
result. Items: plans/FS116-close-inventory.md 20, 29, 32, 39, 71, 110 (item 10 was filed at 2026-09-29 by item 18; not repeated).

    python3 tools/fs116_z2_errata.py            # apply; exit 0
    python3 tools/fs116_z2_errata.py --plant    # one anchor altered: must exit 1 naming it
    python3 tools/fs116_z2_errata.py --out F    # write elsewhere

Standard library only.
"""
from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BASE = "45bdd7bf"
TARGET = "plans/FS114-derivation.md"

N7_ANCHOR = "for C114-LOCAL-F. Tools: `tools/fs114_n7_hub.py`, exact at named values.\n"
N7_ERRATUM = """
*Erratum (FS116-Z2, 2026-10-03; FS-116's close, `plans/FS116-close-inventory.md` items 29, 32, 39, 71, 110; the entry above stands as filed):*
1. *The model line.* FS114-Y2-BOWTIE's centre ring carries two (Q) arcs, its Reuleaux caps, so the bowtie is not a model of this entry's class
   (`data/fs116/n1/ring-survey-bowtie.out`: `[150°, 210°]` inner 3 | outer 1 and `[330°, 30°]` inner 1 | outer 3; `data/fs116/n3/semi.out` l. 18;
   FS116-V4's attack on KAPPA, item 8; `plans/FS116-Z1-close.md` § 2.4 F1). The line should read, in FS116-N1's drafted replacement
   (`plans/FS116-N1-proof.md` § Hand-back at stage 3, correction 1): `model: none held with a (Q)-free ring at a degree-4 four-colour vertex with three or more tactic edges (FS114-Y2-BOWTIE's centre has four tactic edges, but its ring carries two (Q) arcs, the Reuleaux caps — FS114-N6 § 4); the exclusion's scope is 1 + ε`.
   Nothing rests on the model line.
2. *The headline's setting.* Its first sentence omits the setting every step uses — non-Siamese, simple, exactly four colours at `p`, six colours, the
   ring after the bends (FS116-V1 § 3.3, § 4.3 row 6). The record's own statement carries it: "At a degree-4 four-colour vertex of a non-Siamese valid
   map in the simple class whose ring is (Q)-free after the bends, three tactic edges occur only in the pattern `+−+` (or its mirror `−+−`) with a
   Reuleaux lens and a `60°` anti-lens" (`plans/FS114-N7-proof.md` § 2.2). Read the headline in that setting.
3. *`+++`.* The enumerated list omits `+++` (with `e4` not tactic), which the record names first — "Up to rotation and reflection (which reverses the
   order and the signs) the sign patterns are `+++`, `++−`, `+−+`, `−++`" (§ 2.2) — and kills at its `b = a + 1` step; the headline covers it
   (FS116-V1 § 4.3 row 7; item 29).
4. *The parenthesis is a second claim.* "(with N7-HUB: …)" is N7-HUB, filed below as its own entry, FS114-N7-HUB (FS116-V1 § 3.3; item 32).
5. *The minds line.* The blind check it asked for ran (FS116-V1, 2026-09-29): N7-HUB stands at two minds in the reading FS116-V1 was given (see
   FS114-N7-HUB); the per-pattern kills stay **one mind** — FS116-V1's blind verdict "stalls at: the per-pattern kills at radius 1 + ε", its reading of
   the `+++`, `b = a + 1` step after its verdict a checking reading (FS116-V1 § 3.4, § 4.3 row 1; items 30, 71).
6. *What FS-116 adds to this class* (pointers; no verdict here changes): FS116-Y4-EMPTY, held (`plans/FS116-derivation.md`), excludes at radius `1 + ε`,
   in the non-Siamese simple class at six colours, every vertex of at least four colours whose ring carries no arc of `Γ`. Whether "after the bends"
   leaves arcs of `Γ` other than (Q) arcs on the ring of a fragment — so whether this entry's class is empty at `1 + ε` — is the invention signal of
   inventory item 136, carried to FS-123 unsettled (`plans/FS116-Z2-close.md` § 1.5).

derivation: FS114-N7-HUB
  statement: At a four-colour vertex (non-Siamese, simple) whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at
    least four colours: the directions toward `p` there lie in tiles of `p` reaching `y_k` (a **tip**, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its
    colour is carried at `y_{k±1}` by no other tile), and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away
  uses only: FS114-N6-NOQ's N6-RING60 (six change points, the ring tiles `R_k` alternating the two absent colours); N-E2; CL and CL-p (two tiles of one
    colour with points less than 1 apart are one tile; a tile of a colour of `p` with a point in `B(p, 1)` is `p`'s own); N3-FACE at the unit pair
    `(p, y_k)`; six colours, exactly four at `p`
  not claimed: rings with (Q) arcs (N7-HUBQ: a tip only at a change point whose `±60°` points have `κ` defined just outside); anything in the Siamese or
    non-simple class; anything at `k ≥ 7`
  argument: FS114-N7-proof.md § 2.1 N7-HUB — the six change points of a (Q)-free ring are four-colour vertices, each with a tip
  verdict: derived
  grade: hand
  minds: 2 — blind to: N7's record and this file until its verdict's commit (FS116-V1, 894db2d9), though given FS114-N7-3T's statement with this
    claim inside it and the vetted definitions (`../data/fs116/v1-n7-definitions.md`: the D-frame's shape, N7's setting, the bends on a fragment
    leaving only (Q) ring arcs), so the second mind is on the ring carrying no arc of Γ near the hubs, and on rings with (R2) arcs the count is one;
    method: FS116-V1's same-colour dichotomy and the ring's flip at `σ^{±1}y` against N7's CL and ring cones for the tip, the dichotomy against N3-FACE
    for the outward tile; the same model (Opus 5.5), one prior
  model: none held — FS114-Y2-BOWTIE's centre is not one (its ring carries two (Q) arcs, the erratum above); on rings carrying no arc of Γ none exists
    at six colours, non-Siamese and simple (FS116-Y4-EMPTY, held)
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:discharging & ab:unit distance" (1) — FS-114's gate, as FS114-N7-3T
  handoff: none — a relay-result; true vacuously where the ring carries no arc of Γ (FS116-Y4-EMPTY), and its content, if any, on (Q)-free rings
    carrying (R2) arcs (FS-123)

Split from FS114-N7-3T's statement by FS116-Z2's erratum (2026-10-03), where it rode as a parenthesis (FS116-V1 § 3.3; inventory item 32). Its two minds are on FS116-V1's reading of "(Q)-free after the bends" (no arc of `Γ` on the ring), which FS116-Y4-EMPTY (held) makes empty at six colours, so there it is true vacuously; on rings carrying (R2) arcs it is one mind (N7's), and whether a fragment's bends leave such rings is inventory item 136. Tools: `tools/fs114_n7_hub.py`, exact at named values. Rests on it: FS114-N7-3T (every pattern kill reads the tips and the six four-colour vertices); FS116-N2-HEX6's model line; the successor's (Q)-free case (FS-123).
"""

CV_ANCHOR = "It rests on FS112-N3-DENSE3, hence on row 134's base, whose Lemma 4 at cusps is still one mind (BASE-V).\n"
CV_ERRATUM = """
*Prior-art note (FS116-Z2, 2026-10-03; `plans/FS116-close-inventory.md` item 20, found at FS116-O1's gate, `plans/FS116-local-exclusion.md` § 2.2):
the local-to-global idea is Sirgedas's, informally and for non-Siamese tilings found by search — "A biggest disc implies no 6-color-tiling of the plane
exists." (Google group thread "Graph Coloring by Simulation", 2020-03-17; `~/source/library/hadwiger-nelson-problem-group/threads/J_Tw1_hUxQI.txt`
l. 4661). The prior-art line above should read "partly" for the idea; a four-colour vertex in every valid map, and the reduction to a disc about one with
Siamese pairs allowed and the radius uniform in the complexity, are not in the thread as read (ll. 4290–4790 and the grep hits).*
"""

INSERTS = [("n7-3t", N7_ANCHOR, N7_ERRATUM), ("cv-exists", CV_ANCHOR, CV_ERRATUM)]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", action="store_true")
    ap.add_argument("--out", default=TARGET)
    args = ap.parse_args()
    text = subprocess.run(["git", "show", f"{BASE}:{TARGET}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout
    inserts = list(INSERTS)
    if args.plant:
        name, anchor, body = inserts[0]
        inserts[0] = (name, anchor.replace("named values", "named value"), body)
    for name, anchor, body in inserts:
        n = text.count(anchor)
        if n != 1:
            print(f"FAIL: anchor {name!r} found {n} times, expected 1")
            return 1
        text = text.replace(anchor, anchor + body, 1)
    Path(ROOT / args.out).write_text(text)
    print(f"OK: {len(inserts)} errata inserted; wrote {args.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
