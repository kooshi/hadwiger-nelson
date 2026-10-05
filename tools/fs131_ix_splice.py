#!/usr/bin/env python3
"""FS131-IX1: splice the crossing lemma's proof and children from the scratch file into `Plane/PlaneTopology.lean`.

The scratch (`data/fs131/ix/Crossing.lean`) proves the leaf under the primed name `inter_nonempty_of_interleaved'`. This tool
  1. checks that the primed statement is byte-identical to the module's leaf statement (the name's prime aside) — refusing otherwise;
  2. inserts the scratch's children (every declaration before the primed theorem), each given the docstring in DOCS, plus a section
     header, just above the leaf's docstring;
  3. replaces the leaf's `  sorry` with the primed theorem's proof body;
  4. rewrites the leaf docstring's planned-proof sentences into the proof's actual route (the statement sentence kept verbatim).

`--check-only` runs step 1 alone. `--module` and `--scratch` override the paths (the negative control runs on planted copies).
Exit 0 on success; 2 on a refused statement; 3 on a malformed input.
"""
import argparse
import re
import sys

LEAF = "inter_nonempty_of_interleaved"

DOCS = {
    "e_mul_e_neg": "/-- `e θ · e (−θ) = 1`. -/",
    "arg_one_sub_e": "/-- The principal argument of `1 − e x` for `0 < x < 2π` is `(x − π)/2`: `1 − e x = 2 cos θ · e θ` with "
                     "`θ = (x − π)/2 ∈ (−π/2, π/2)`. -/",
    "arg_one_sub_e_of_neg": "/-- The principal argument of `1 − e x` for `−2π < x < 0` is `(x + π)/2` (`arg_one_sub_e` at `x + 2π`). -/",
    "re_pos_of_mem_closedBall": "/-- **A point of the closed disc other than `r(θ)` sees `r(θ)` in an open half-plane**: "
                                "`(r(θ) − z) · e(−θ)` has positive real part,\nsince it is `1 − w` with `‖w‖ ≤ 1`, and `Re w = 1` "
                                "forces `w = 1`, i.e. `z = r(θ)`. -/",
    "ringPt_sub_ringPt_mul_e_neg": "/-- `(r(a) − r(b)) · e(−a) = 1 − e(b − a)`. -/",
    "im_sub_eq_arg_sub": "/-- **The argument along an edge**: if `exp ∘ f = κ · v` on `[0, 1]`, with `f`, `v` continuous there and "
                         "`Re v > 0`, the imaginary part of `f`\nchanges by `arg (v 1) − arg (v 0)` (`Im f − arg v − Im (log κ)` is a "
                         "continuous integer multiple of `2π` on `[0, 1]`, hence constant). -/",
    "exists_eq_of_interleaved_paths": "/-- **Two paths in a closed disc joining interleaved points of its circle meet** (the crossing "
                                      "lemma for paths). Were they disjoint,\n`Ψ(x + iy) = γ(x) − γ'(y)` (the paths extended by "
                                      "clamping) would be a continuous map `ℂ → ℂ ∖ {0}`, lifting through `exp` to `F` over the\n"
                                      "simply connected `ℂ` (`Complex.isCoveringMap_exp.existsUnique_continuousMap_lifts`). On each edge "
                                      "of the unit square one path sits at a\ncircle point `r(θ)` and the other in `B̄(u, 1) ∖ {r(θ)}`, so "
                                      "`Im F` changes there by a difference of principal arguments\n(`re_pos_of_mem_closedBall`, "
                                      "`im_sub_eq_arg_sub`, `arg_one_sub_e`): `(t − s)/2 − π`, `(t' − s')/2 − π`, `(t − s)/2`, "
                                      "`(t' − s')/2`. Around\nthe square these sum to `−2π`, while the corner values of `F` telescope "
                                      "to `0`. -/",
    "discRetract": "/-- The radial retraction of `ℂ` onto `B̄(u, 1)`: `z ↦ u + (z − u)/max(1, ‖z − u‖)`. -/",
    "continuous_discRetract": "/-- The radial retraction is continuous. -/",
    "discRetract_mem": "/-- The radial retraction lands in `B̄(u, 1)`. -/",
    "discRetract_of_mem": "/-- The radial retraction fixes `B̄(u, 1)`. -/",
    "dist_discRetract_le": "/-- The radial retraction moves a point at most its distance to any point `k` of the disc, so "
                           "`dist (ρ z) k ≤ 2 dist z k`. -/",
    "isPreconnected_thickening": "/-- A thickening of a preconnected set in a real normed space is preconnected (each point lies in a "
                                 "ball about a point of the set, and\nthe set with that ball is preconnected). -/",
}

SECTION = """/-! ### The crossing lemma (FS131-IX1)

Paths first, then continua. Two paths in `B̄(u, 1)` joining interleaved circle points meet (`exists_eq_of_interleaved_paths`): were they
disjoint, `x + iy ↦ γ(x) − γ'(y)` would lift through `exp` over the simply connected `ℂ`, and the change of its argument around the unit
square, computed edge by edge from principal arguments, is `−2π`, not `0`. Two disjoint continua would have disjoint `δ`-thickenings, and
paths in the `δ/2`-thickenings pushed into the disc by the radial retraction `discRetract` would be disjoint paths of that kind. -/

"""

OLD_PLAN = """theorem). Proof planned (plan § 3.2): from unicoherence through the Phragmén–Brouwer property (in a connected, locally connected space
unicoherence is equivalent to: if closed `A`, `B` with `A ∩ B` preconnected each leave `x`, `y` in one complementary component, so does
`A ∪ B`), applied to `K` and `K'` each completed by the outward rays from their two circle points, which turns the crossing into "a line
from infinity to infinity separates its two sides". **H**: the implementer measures it from its first
child and reports; Keryx may split it into its own job. -/"""

NEW_PLAN = """theorem). Proved (FS131-IX1) without a separation theorem: disjoint `K`, `K'` (compact) would have disjoint `δ`-thickenings
(`Disjoint.exists_thickenings`); the `δ/2`-thickenings are open and connected (`isPreconnected_thickening`), hence path-connected, so they
hold paths `r(s) ⇝ r(t)` and `r(s') ⇝ r(t')`, which the radial retraction `discRetract` pushes into `B̄(u, 1)` within `δ` of `K` and `K'`
(`dist_discRetract_le`); those paths meet (`exists_eq_of_interleaved_paths`), at a point of both `δ`-thickenings. The planned route through
the Phragmén–Brouwer property was not taken (unicoherence alone gives no separation: FS131-IP1's record § 2.3). -/"""


def decl_spans(text):
    """Top-level declarations: (name, start, end) with start at the keyword line, end before the next top-level item."""
    pat = re.compile(r"^(?:noncomputable )?(theorem|lemma|def) (\S+)", re.M)
    hits = [(m.group(2), m.start()) for m in pat.finditer(text)]
    tail = re.compile(r"^(end |/-!|/--|#|example)", re.M)
    spans = []
    for i, (name, st) in enumerate(hits):
        nxt = hits[i + 1][1] if i + 1 < len(hits) else len(text)
        m = tail.search(text, st + 1, nxt)
        en = m.start() if m else nxt
        spans.append((name, st, en))
    return spans


def statement(text, name):
    """The text from `theorem <name>` up to and including the first `:= by`."""
    m = re.search(r"^theorem " + re.escape(name) + r"\s", text, re.M)
    if not m:
        return None
    k = text.find(":= by", m.start())
    return text[m.start():k + len(":= by")] if k >= 0 else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--module", default="Proofs/HadwigerNelson/Plane/PlaneTopology.lean")
    ap.add_argument("--scratch", default="data/fs131/ix/Crossing.lean")
    ap.add_argument("--check-only", action="store_true")
    a = ap.parse_args()
    mod = open(a.module).read()
    scr = open(a.scratch).read()
    sm = statement(mod, LEAF)
    ss = statement(scr, LEAF + "'")
    if sm is None or ss is None:
        print(f"MALFORMED: statement not found (module: {sm is not None}, scratch: {ss is not None})")
        return 3
    if ss.replace(LEAF + "'", LEAF, 1) != sm:
        print(f"REFUSED: {LEAF}: STATEMENT DIFFERS between module and scratch")
        return 2
    print(f"OK: {LEAF}: statement byte-identical (module vs scratch, prime aside)")
    if a.check_only:
        return 0
    if "  sorry\n" not in mod[mod.index(sm):mod.index(sm) + len(sm) + 20]:
        print("MALFORMED: the module's leaf is not `sorry`")
        return 3
    spans = decl_spans(scr)
    children, body = [], None
    for name, st, en in spans:
        chunk = scr[st:en].rstrip() + "\n"
        if name == LEAF + "'":
            body = scr[st + len(ss):en].rstrip() + "\n"
            break
        if name not in DOCS:
            print(f"MALFORMED: no docstring for child {name}")
            return 3
        children.append(DOCS[name] + "\n" + chunk)
    if body is None:
        print("MALFORMED: primed theorem not found among declarations")
        return 3
    leaf_doc = mod.rfind("/-- **Two continua in a closed disc", 0, mod.index(sm))
    if leaf_doc < 0 or OLD_PLAN not in mod:
        print("MALFORMED: leaf docstring not as expected")
        return 3
    new = mod[:leaf_doc] + SECTION + "\n".join(children) + "\n" + mod[leaf_doc:]
    new = new.replace(OLD_PLAN, NEW_PLAN, 1)
    i = new.index(sm) + len(sm)
    assert new[i:i + len("\n  sorry\n")] == "\n  sorry\n"
    new = new[:i] + "\n" + body + new[i + len("\n  sorry\n"):]
    open(a.module, "w").write(new)
    print(f"SPLICED: {len(children)} children, the leaf's proof ({body.count(chr(10))} lines)")
    # re-check after writing
    if statement(open(a.module).read(), LEAF) != sm:
        print("REFUSED: statement changed by the splice")
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
