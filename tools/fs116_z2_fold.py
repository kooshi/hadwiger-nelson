#!/usr/bin/env python3
"""FS116-Z2 — fold FS116-V6's verdict into plans/FS116-derivation.md (FS-116's close, part 2, stage 1).

Reads the derivation file as part 1 left it (git object at BASE, so the run is repeatable), applies named substitutions, each of which must find
its old text exactly the expected number of times (else exit 1, naming it), inserts FS116-V6's lemmas as entries at one mind after FS116-Y4-OBST,
and writes the result to plans/FS116-derivation.md (or to --out).

    python3 tools/fs116_z2_fold.py                 # apply; exit 0
    python3 tools/fs116_z2_fold.py --plant         # one substitution's old text altered: must exit 1 naming it
    python3 tools/fs116_z2_fold.py --out FILE      # write elsewhere (a dry run)

Standard library only.
"""
from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BASE = "45bdd7bf"  # the tree this job started from; part 1's derivation file is unchanged there since d1a02629/dd076d2f
TARGET = "plans/FS116-derivation.md"

HEADER_OLD = """***Vacuity.** FS116-Y4-EMPTY (one mind; FS116-V6, blind, running) says the non-Siamese simple six-coloured class with a ring carrying no arc of Γ is
empty. If it is held, every entry below marked "vac." is true vacuously — its class has no member — at the count its own verifier gave; its argument
stays valid as an argument."""

HEADER_NEW = """*Updated by the close's part 2, FS116-Z2 (Ephodos, Opus 5.5), 2026-10-03, by `../tools/fs116_z2_fold.py`: FS116-V6's verdict folded into
FS116-Y4-EMPTY, every vacuity note made definite, FS116-V6's five lemmas filed at one mind, and the case list's Γ-free case held.*

***Vacuity.** FS116-Y4-EMPTY is **held** (inventory item 139: two minds, the second, FS116-V6, blind, its verdict committed before it compared, by a
route resting on none of round 3's statements): the non-Siamese simple six-coloured class with a ring carrying no arc of Γ is empty. Every entry below
marked "**True vacuously**" has its class inside that one (items 124, 135), so it is true with no member, at the count its own verifier gave; its
argument stays valid as an argument."""

EMPTY_MINDS_OLD = "  minds: 1 — a blind second mind running (FS116-V6, the list's § 15)\n"
EMPTY_MINDS_NEW = """  minds: 2 — blind to: FS116-Y4's record until its verdict's commit (2429e200), though given the frozen list with round 3's construction-side
    statements and their setting (§ 14), route-shaped and unused; method: a different route at the count (FS116-V6-COUNT and -ANTI in place of
    FS116-Y3-TIPS) and at the flank step (FS116-V6-HUG's exact identity in place of FS116-Y4-FLANK's curvature bound); the same model (Opus 5.5),
    one prior
"""

EMPTY_HANDOFF_OLD = """  handoff: de Bruijn — with SIX, TIPS and RING-GERM, after a blind second mind; for D2, the Γ-free ring type removed from C114-LOCAL-F's case list at
    1 + ε
"""
EMPTY_HANDOFF_NEW = """  handoff: de Bruijn — by either route, the first with FLANK, SIX, TIPS and RING-GERM, or FS116-V6's (FS116-V6-HUBS, -HUG, -COUNT, -ANTI, hand, using
    no statement of the frozen list), the shorter; for D2, the Γ-free ring type removed from C114-LOCAL-F's case list at 1 + ε
"""

EMPTY_NOTE_OLD = """**One mind; FS116-V6 runs blind on it** — part 2 folds V6's verdict in here and in every "vac." note. It removes"""
EMPTY_NOTE_NEW = """**Held** (item 139): FS116-V6, blind, the same model, committed TRUE (2429e200) before it opened FS116-Y4's record, by its own route — six hubs by a
tip count (FS116-V6-HUBS), the hugging identity (FS116-V6-HUG), an incidence count forcing two antipodal doubly tipped hubs (FS116-V6-COUNT) and
antipodal tippers sharing no edge at `p` (FS116-V6-ANTI) — resting on neither FS116-Y3-SIX nor -TIPS; divergences truth 0, route 7, wording 1; no
retraction (`FS116-V6-verification.md` § 3.2). Caveats stated with it (item 139): one model; § 14's statements, about this class, were in V6's view
though unused. Six colours are spent twice on V6's route (two absent colours; the tip sector holding only colours of `p`) and once on Y4's (the
alternation). V6's wording note: "radius above 1" and "radius 1" name one class, since an open set containing `B̄(p, 1)` contains a larger closed disc
(V6 § 3.2 row 7). It removes"""

C114_OLD = "    (FS116-Y4-EMPTY, one mind) and the saturated right-angled straight cross"
C114_NEW = "    (FS116-Y4-EMPTY, held) and the saturated right-angled straight cross"

C114_NOTE_OLD = """its structural form carried the rounds (`FS116-Z1-close.md` § 2.5). Rests on it:"""
C114_NOTE_NEW = """its structural form carried the rounds (`FS116-Z1-close.md` § 2.5). Whether FS-112's bends, run on a fragment, leave a (Q)-free ring with (R2) arcs at all
— if not, the Γ-free case is the whole (Q)-free case — is the invention signal of inventory item 136, carried to FS-123 unsettled (`FS116-Z2-close.md`
§ 1.5). Rests on it:"""

SUBS: list[tuple[str, str, str, int]] = [
    ("header", HEADER_OLD, HEADER_NEW, 1),
    ("v1-frame-not-claimed", "(FS116-Y4-EMPTY excludes the class at\n    six colours, one mind)",
     "(FS116-Y4-EMPTY excludes the class at\n    six colours, held)", 1),
    ("v1-frame-handoff",
     "  handoff: none — in its class FS116-Y4-EMPTY, if held, leaves it vacuous; it carries N7-HUB's second mind to FS-114's filing (part 2)\n",
     "  handoff: none — FS116-Y4-EMPTY (held) leaves it vacuous; it carried N7-HUB's second mind to FS-114's filing (FS114-N7-HUB, FS116-Z2's\n"
     "    erratum)\n", 1),
    ("v1-frame-note",
     "vac. — its class lies inside FS116-Y4-EMPTY's. V1's second route to the six change points and the tactic centres (F5, F6), derived blind beside "
     "N7-HUB (b), (c), which now stand at two minds in FS-114's filing (part 2).",
     "**True vacuously** — its class lies inside FS116-Y4-EMPTY's (item 135). V1's second route to the six change points and the tactic centres (F5, F6), "
     "derived blind beside N7-HUB (b), (c), which stand at two minds in FS-114's filing (`FS114-derivation.md` FS114-N7-HUB, FS116-Z2's erratum).", 1),
    ("hex6-note", "vac. — its class is FS116-Y4-EMPTY's (item 124).",
     "**True vacuously** — its class is FS116-Y4-EMPTY's (items 124, 139).", 1),
    ("hex3-note", "vac. — as HEX6.", "**True vacuously** — as HEX6.", 1),
    ("transfer-c-note", "vac. by FS116-Y4-EMPTY (item 124).", "true vacuously by FS116-Y4-EMPTY, held (items 124, 139).", 1),
    ("the-rest", "\nvac. — ", "\n**True vacuously** — ", 13),
    ("round-4-heading", "## Round 4 — the Γ-free type is empty (FS116-Y4; FS116-V6 blind, running)",
     "## Round 4 — the Γ-free type is empty (FS116-Y4; FS116-V6 blind on EMPTY)", 1),
    ("empty-minds", EMPTY_MINDS_OLD, EMPTY_MINDS_NEW, 1),
    ("empty-handoff", EMPTY_HANDOFF_OLD, EMPTY_HANDOFF_NEW, 1),
    ("empty-note", EMPTY_NOTE_OLD, EMPTY_NOTE_NEW, 1),
    ("empty-rests", "the vacuity of every entry marked vac.;", "the vacuity of every entry marked True vacuously;", 1),
    ("c114-verdict", C114_OLD, C114_NEW, 1),
    ("c114-note", C114_NOTE_OLD, C114_NOTE_NEW, 1),
]

ANCHOR = "\n## The close's case list (FS116-Z1)\n"

V6_ENTRIES = """
### FS116-V6's lemmas — the second route to FS116-Y4-EMPTY (one mind each; inventory item 140)

*Stated in V6's setting, FS116-Y4-EMPTY's class (`FS116-V6-verification.md` § 2.2, its readings R-RAD, R-SIAM, R-ARC, R-TILE at § 1.2); each statement is
V6's sentence verbatim after the setting clause, from § 2.2's bold statements or its "Theorems this phase proved" list. V6's preliminaries — V6-DIAM,
V6-E1, V6-DICH (two tiles of one colour have interior distances all below or all above 1), V6-RING, V6-WIN, V6-GERM (FS116-N1-GERM-R by V6's route) and
V6-TIP (every change point has a tip) — are steps of § 2.2, not filed apart; V6-GERM is held as GERM-R and is not filed twice.*

derivation: FS116-V6-HUBS
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, m = 1: the change points are y_k = r(ψ₀ + 60°k), six of them; a tile of p tips at most two, and two only if consecutive
  uses only: V6-DIAM (a tile has diameter at most 1, so its tipped change points lie in one closed 60° arc); V6-RING (six colours, at least four at p:
    exactly two absent colours, the ring alternating them under the 60° rotation); V6-WIN (an odd number m of change points in each half-open 60°
    window); V6-TIP (every change point has a tip, by B(u) ∩ B(v) ⊂ B(p), non-Siamese and six colours); four tiles at p, so 4(m + 1) ≥ 6m
  not claimed: anything in the Siamese class; anything at k ≥ 7 (SQ9 at k = 9 meets every other hypothesis with twelve points of Γ on its ring, control
    v6-sq9); that any such fragment exists
  argument: FS116-V6-verification.md § 2.2 The derivation — the class is empty
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours (FS116-Y4-EMPTY, held: the class is empty); SQ9 at k = 9 for the hypotheses but the colour count (control v6-sq9)
  prior art: partly: FS116-Y3-SIX (held) and FS116-V1-FRAME's F5 state the count, FS114-N6-RING60 the hexagon; no outside search — owed
  handoff: none — a step of FS116-V6's route to FS116-Y4-EMPTY; it travels with EMPTY's handoff

**True vacuously** — V6's lemma, one mind; the third route to FS116-Y3-SIX's first clause (after Y3's tip count and FS116-V5-RING's reach), "simple" idle by V6's own uses-only line (§ 2.2: simplicity enters at V6-COUNT's last step only). Rests on it: FS116-V6-HUG; FS116-V6-COUNT; FS116-V6-ANTI; FS116-V6's route to FS116-Y4-EMPTY.

derivation: FS116-V6-HUG
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, with its change points y_k = e(60°k) (FS116-V6-HUBS), no tile T of p tips both y_0 and y_1 while being the only tip at each
  uses only: V6-GERM (near a change point the X-tiles lie in B̄(u) ∖ B(v) and the X̄-tiles in B̄(v) ∖ B(u)); V6-TIP (the tip sector holds only
    colours of p, six colours); V6-DICH (non-Siamese: a point lies in the closure of at most one tile of each colour; two distinct tiles of one colour
    have interior distances all below or all above 1); V6-DIAM; the identity |a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2) for a(s) =
    y_0 + e(120° + s), b(t) = y_1 + e(300° − t), 0 < s, t ≤ 60° (control v6-hug)
  not claimed: anything about a tile tipping two adjacent hubs with a second tip at either; anything in the Siamese class (non-Siamese gives the
    uniqueness of the tip and of the two X̄-tiles; V6: "Validity alone kills it here; non-Siamese was used only for the uniqueness of R⁻, R⁺ and of the
    tip"); anything at k ≥ 7
  converse: one-way — "the only" is the hypothesis "the only tip at each hub", not a characterization; nothing two-way is stated
  argument: FS116-V6-verification.md § 2.2 The derivation — the class is empty
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours; V6's stage-1 candidate (a star with two five-colour hubs, § 2.3 item 1) fails exactly here, its two X̄ ring tiles
    √3 − 1 apart at s = t = 30°
  prior art: partly: FS116-Y4-FLANK (its second-order, colour-free form) and FS114-Y5-PXKILL — G83's straddle along two unit circles; this identity not
    searched — owed
  handoff: de Bruijn — the pinning of the two edges to ω(y_1) and ω(y_0) and the trigonometric identity, a short kernel target, with EMPTY

**True vacuously** — V6's lemma, one mind: FS116-Y4-FLANK's content in the case EMPTY uses, by a second route (V6 § 3.2 row 3; at curvature 1 and turning angle `φ` both give `(2cos φ − 1)²`). The identity was checked symbolically by its control and numerically by the coordinator at 20,000 random `(s, t)` (item 138). Rests on it: FS116-V6-COUNT; FS116-V6's route to FS116-Y4-EMPTY.

control: v6-hug
  of: FS116-V6-HUG — the identity, and the two hugging arcs inward from y_0 and y_1 within 1 on the grid s, t in 1..60 degrees
  run: python3 ../tools/fs116_v6_hug.py inward
  expect: identity holds; below 1: 3600 of 3600
  fault: python3 ../tools/fs116_v6_hug.py outward

derivation: FS116-V6-COUNT
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, with V6-HUG, the tips force two antipodal doubly-tipped hubs and four double tiles: M = 4, s = 2, each hub of S has exactly
    two tips, and every tip at a hub of S is a double tile; the two hubs of S are antipodal, y_k and y_(k+3), each tipped by two of the four tiles
  uses only: FS116-V6-HUBS (six hubs; a tile tips at most two, consecutive); FS116-V6-HUG (each double tile has a hub with two or more tips); V6-TIP
    (every hub has a tip); four tiles at p; counting incidences, Σ_h t_h ≤ M + 4; the edges of the hexagon y_0 … y_5
  not claimed: the contradiction (FS116-V6-ANTI and simplicity finish it); anything in the Siamese class; anything at k ≥ 7
  argument: FS116-V6-verification.md § 2.2 The derivation — the class is empty
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours
  prior art: owed — no search run
  handoff: none — a step of FS116-V6's route; with EMPTY

**True vacuously** — V6's lemma, one mind; it replaces FS116-Y3-TIPS's "exactly one tip per hub" on V6's route (V6 § 3.2 row 2). Rests on it: FS116-V6's route to FS116-Y4-EMPTY.

derivation: FS116-V6-ANTI
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, with its change points y_k (FS116-V6-HUBS), a tile tipping y_k and a tile tipping y_(k+3) share no edge at p
  uses only: V6-DIAM (a tile tipping y lies in B̄(y)); B̄(y_k) ∩ B̄(y_(k+3)) = {p}
  not claimed: that the four tiles at p form a cycle of shared edges (that is simplicity, V6-COUNT's last step); anything at k ≥ 7
  argument: FS116-V6-verification.md § 2.2 The derivation — the class is empty
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours
  prior art: owed — no search run
  handoff: none — a step of FS116-V6's route; with EMPTY

**True vacuously** — V6's lemma, one mind; it uses only that a tile has diameter at most 1. Rests on it: FS116-V6's route to FS116-Y4-EMPTY (V6-COUNT's last step).

derivation: FS116-V6-ADJ
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, outer tiles of one colour at adjacent hubs cannot both hug the lens arcs beyond their hubs (ω(y_1) beyond y_0, ω(y_0) beyond
    y_1)
  uses only: V6-DICH; the identity of FS116-V6-HUG with both arcs run outward, a = y_1 + e(−60° + s), b = y_0 + e(120° − t)
  not claimed: anything FS116-Y4-EMPTY needs (it is not used there); anything at k ≥ 7
  argument: FS116-V6-verification.md § 2.3 The attack
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours; V6's stage-1 candidate needed five-colour hubs because of it (§ 2.3 item 2)
  prior art: owed — no search run
  handoff: none — not needed by EMPTY

**True vacuously** — V6's lemma, one mind, not needed by EMPTY; V6: "It is why a single outer colour per hub is impossible on the forced colours of `y_2`, `y_5` (§ 12's NBTIP) and why a construction needs five-colour hubs — which V6-HUG then kills from the inside." Its outward identity was re-checked numerically on the 60 × 60 grid by this close (a checking reading, not a mind: `FS116-Z2-close.md` § 1.4). Rests on it: nothing in this file.

control: v6-sq9
  of: FS116-V6-HUBS — the k = 9 control: SQ9 meets every hypothesis but six colours, its ring carries no arc of Γ, and five colours
  run: python3 ../tools/fs116_v6_sq9.py 3
  expect: period 3: 9 colours; least same-colour squared gap 4 half-units^2 (valid and non-Siamese: True); colours at p: 4; Gamma on the ring: 12 points; ring colours: 5; ring colours of p: 0
  fault: python3 ../tools/fs116_v6_sq9.py 2
"""


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", action="store_true", help="alter one old text; the run must exit 1")
    ap.add_argument("--out", default=TARGET)
    args = ap.parse_args()
    text = subprocess.run(["git", "show", f"{BASE}:{TARGET}"], cwd=ROOT, capture_output=True, text=True, check=True).stdout
    subs = list(SUBS)
    if args.plant:
        name, old, new, n = subs[9]
        subs[9] = (name, old.replace("blind second mind running", "blind second mind runing"), new, n)
    for name, old, new, n in subs:
        found = text.count(old)
        if found != n:
            print(f"FAIL: substitution {name!r}: old text found {found} times, expected {n}")
            return 1
        text = text.replace(old, new)
    if text.count(ANCHOR) != 1:
        print("FAIL: the insertion anchor is not unique")
        return 1
    text = text.replace(ANCHOR, "\n" + V6_ENTRIES.strip("\n") + "\n" + ANCHOR, 1)
    if "\nvac. — " in text:
        print("FAIL: a 'vac.' note survived")
        return 1
    Path(ROOT / args.out).write_text(text)
    print(f"OK: {len(subs)} substitutions applied, 5 entries and 2 controls inserted; wrote {args.out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
