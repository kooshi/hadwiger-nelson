#!/usr/bin/env python3
"""R3 stage 2: apply the approved re-rank to plans/FRONTIER-STUBS.md and prepend status blocks to the moved stubs.
Run once from the repository root; asserts on the written file."""
import re, sys
from pathlib import Path

P = Path("plans/FRONTIER-STUBS.md")
ORDER = [103,104,105,62,67,59,102,80,96,64,63,49,44,69,57,100,101,65,17,55,78,42,43,45,39,75,90,98,76,95,87,92,68,47,60,46,48,72,77,88,93,94,99,41,51,52,20,2,13,12,19,37,27,23,22,30,35,8,29,9,10,5]
F1 = ("FS-103's F1 (a candidate composition, not a result: given MR, row 120, and T-J39-3, at a real field with no non-thick stable place, "
      "`χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`)")
TAG = "**Re-ranked 2026-09-26 (R3; {old} → {new}).**"
# fs: (question prefix, bearing prefix, solver override or None, stub file or None, extra stub-block sentence)
RE = {
 62: ("**Re-aimed (the advisor's order, above FS-59):** S's exact form given MR — the adelic local–global principle folded here (R1 §2.2: given MR, `χ(F²) = min(χ_CP(ℝ²), local CP numbers)` iff product locality at every `k`); if " + F1 + " holds, S ⟹ `χ(ℝ²) ≠ 6`, and S ⟺ `χ_CP(ℝ²) = 5`, or `χ_CP(ℝ²) = 7` and no field with a non-6-thick place drops to six (a finite family of CP product statements; the advisor's formulation). §5's gate, the image of `F ↦ χ(F²)`, is an hour and unrun. The row as it stood: ",
      "**derived frame; soft as to truth** — Kooshi on this stub: *\"It's just one possibility with some soft evidence\"*. ", None, "plans/STUB-six-is-not-a-value.md"),
 67: ("**Re-aimed:** product locality (PL) in CP form at the non-mixing places, `k = 5, 6` — must a CP `k`-colouring of `UD(ℝ²) × ∏ G_v` come from `UD(ℝ²)`? The theory route B needs (R1 §2.1); `PL_∃(23, 43)` is its instance (FS-59, FS-96); given " + F1 + ", PL is the only non-archimedean content left in the target. The row as it stood: ",
      "**derived that PL is necessary for S under HN = 7 and for the conjecture's six-clauses; soft as to truth** (Hedetniemi fails for finite graphs from four colours up; these factors do not mix). ", None, "plans/STUB-tight-product-colourings.md"),
 59: ("**Re-aimed:** to `PL_∃(23, 43)` and the wall at 23 and 43. Given " + F1 + ", the plane's own six is `χ_CP(ℝ²) ≥ 6` alone at de Grey's field, so six at ℚ(√167) is rung D plus `PL_∃(23, 43)` — dearer as a route to six; what is its own is whether the conjecture's widest gap reaches the plane's value and, if HN = 7, whether ℚ(√167) is a six-chromatic field (S's product conjunct). The row as it stood: ",
      "six at ℚ(√167) ⟹ rung D (derived); ", None, "plans/STUB-four-colours-167.md"),
 102: ("If FS-103 verifies, its possible headline is `χ(ℝ²) = χ_CP(ℝ²)` given MR — the collapse Kooshi named as a write-up (*\"If we end up at a wall which collapses HN to another known open problem, that in itself would be a writeup.\"*). ",
      "", None, "plans/STUB-writeup-main-clause-five.md"),
 80: ("**Re-aimed:** to averaged certificates at five colours on the real plane — the integrality shape a six certificate must take (G24; X21D's B-3 answer), FS-104's route (c); an in-ban derivation of its shape, the LP post-ban (the advisor). The row as it stood: ",
      "**derived as the shape a six certificate must take; soft as to success** (the fractional version caps at 4.36, G60). ", "none for the shape (derivation); the LP post-ban", "plans/STUB-window-frequency-certificate.md"),
 96: ("`PL_∃(23, 43)`'s negation at five — one question with FS-59's from the other side (the advisor), kept a row. ", "", None, "plans/STUB-windows-five-nonmixing.md"),
 64: ("At six, a mixed CP six-colouring at a field with a non-6-thick place is \"six below HN\" (R1). ",
      "derived: one of the two ways six can occur if HN = 7; soft (the conjecture predicts no). ", None, "plans/STUB-adelic-window-colouring.md"),
 63: ("**Re-aimed:** the aperiodic-order gate for `Y` with `p`-adic factors — the product-locality cluster (FS-67, FS-59, FS-96, FS-64). It is **not** `χ_CP(ℝ²)`'s home: with `N_k = ∅` there is no `p`-adic factor and no model set (the advisor; FS-103's gate runs in the measurable and harmonic-analysis words). The row as it stood: ",
      "", None, "plans/STUB-moire-coincidence.md"),
 49: ("Route D, the finite-graph form of rung D, needing no MR; given " + F1 + ", such a graph exists iff `χ_CP(ℝ²) ≥ 6` (the advisor). ", "", None, "plans/STUB-distance-two-gadget.md"),
 44: ("**Re-aimed:** given MR, a five-colouring of `K(√7)²` exists iff `UD(ℝ²)` has a CP one (R1's walk, from T-J39-3), so its question becomes the shape of a CP five-colouring of the plane — FS-104's mirror. The row as it stood: ",
      "derived frame (the upper side of rung D); low as work. ", None, "plans/STUB-fifth-colour-structure.md"),
 69: ("FS-59's necessary condition (five at every level of 43) and a wall member; **post-ban** (the owner, 2026-09-26). ", "", "none (SDP); post-ban (the owner, 2026-09-26)", "plans/STUB-certificate-at-43.md"),
 57: ("Route C (47 and `U₆₄`), bearing on S's product conjunct only if HN = 7; **post-ban** (the owner, 2026-09-26). ", "", "none (SDP); post-ban (the owner, 2026-09-26)", "plans/STUB-fractional-wall.md"),
 100: ("Its left items (TR-ROT at NA₀, C-4, the exception fields, the complex-place instance, the kernel port) bear none on six; MR's hardening moves to FS-105. ", "", None, "plans/STUB-measure-rigidity-three-fields.md"),
 101: ("Trust; none on six. FS-103's F1, if verified, is a candidate for the same named-hypothesis form. ", "", None, "plans/STUB-main-clause-five-kernel.md"),
 90: ("Four-colour rigidity over the type-(B) fields; none on six; post-ban. ", "", None, "plans/STUB-sanctioned-search-fs86.md"),
 75: ("A kernel port; none on six. ", "", None, "plans/STUB-three-colour-criterion-kernel.md"),
 39: ("Partly superseded: " + F1 + ", given MR, attains `χ(ℝ²)` at a named field. ", "", None, "plans/STUB-plane-bridge.md"),
}
NEW = {
 103: "| 1 | **FS-103 the collapse** — `plans/STUB-collapse-cp-plane.md` (minted 2026-09-26 by R3 from R1's N1; **the next milestone**) | **A candidate composition, not a result** ([hand], conditional on MR, row 120, and T-J39-3; two minds blind to each other, R1 and the advisor; `plans/RERANK-2026-09-26.md` §1.1): given MR and T-J39-3, at a real field with no non-thick stable place, `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`. Two blind verifiers, the checkable instance first — ℚ(√635087) (first usable prime 103, `2√103/104 ≈ 0.195 < 1/5`) — then de Grey's field ℚ(√3,√5,√7,√11) (MR at degree 16, sixteen real places merged, its stable-place list); a prior-art gate in the words of measurable, Borel and stationary colouring and harmonic analysis (`[Falconer1981]`'s `χ_m`, not held; `χ_CP ≤ χ_m`; the claim is `χ = χ_CP`, never `χ = χ_m`); where `χ_CP` sits against `χ_m` and `χ_B` | **derived, if it holds:** six at any field is rung D, S implies `χ(ℝ²) ≠ 6`, and the problem is archimedean — Kooshi: *\"If we end up at a wall which collapses HN to another known open problem, that in itself would be a writeup.\"* | one to two days (R1) | minted 2026-09-26 | none (derivation, PARI, reading) |",
 104: "| 2 | **FS-104 `χ_CP(ℝ²)` at six** — `plans/STUB-cp-plane-six.md` (minted 2026-09-26 by R3 from R1's N2) | Is `χ_CP(ℝ²) ≥ 6`? `[Falconer1981]` read first, as a CP statement; then the density family (a CP five-colouring needs `m_j(ℝ²) ≥ j/5`; R1's Croft-translate reading at `j = 2, 3`, unchecked; `m₄(ℝ²) < 4/5`?), Falconer's mechanism in CP form, `k`-point correlation constraints (FS-80's route), `χ_g(H)` (post-ban) | derived-decisive if FS-103's F1 holds (it is rung D); success very low — the advisor's prior for six itself ≈ 0.03; a named no-go, or a tie of `χ_CP` to `χ_m`, is the likely product | unpriced; the reading first | minted 2026-09-26 | none for the reading and derivations; `χ_g(H)`'s LP post-ban |",
 105: "| 3 | **FS-105 harden MR** — `plans/STUB-harden-mr.md` (minted 2026-09-26 by R3 from R1's N3) | Read `[EinsiedlerLindenstrauss2022]` Thm 1.2's proof (§§3, 5–9 unread) as far as PE-2's hypotheses; a third derivation of EF_F⁺, blind, at ℚ(√635087); PE-2's admissibility written out there, and what changes at degree 16 | derived: rows 121–125 and FS-103 rest on MR (row 120), and this is the table's weakest link (the advisor); none on six directly | a day of reading; one derivation | minted 2026-09-26 | none (reading, derivation) |",
}
text = P.read_text()
lines = text.split("\n")
start = next(i for i, l in enumerate(lines) if l.startswith("| rank | stub | the question"))
body0 = start + 2
end = next(i for i in range(body0, len(lines)) if not lines[i].startswith("|"))
rows = {}
oldrank = {}
for l in lines[body0:end]:
    cells = re.split(r"(?<!\\)\|", l)
    fs = int(re.search(r"FS-(\d+)", cells[2]).group(1))
    assert fs not in rows, fs
    rows[fs] = cells
    oldrank[fs] = cells[1].strip()
assert set(rows) - {84, 97} == set(ORDER) - set(NEW), (set(rows) ^ set(ORDER))
out = []
for n, fs in enumerate(ORDER, 1):
    if fs in NEW:
        out.append(NEW[fs]); continue
    c = list(rows[fs])
    c[1] = f" {n} "
    if fs in RE:
        qp, bp, solver, _ = RE[fs]
        c[3] = " " + TAG.format(old=oldrank[fs], new=n) + " " + qp + c[3].lstrip()
        if bp:
            c[4] = " " + bp + c[4].lstrip()
        c[6] = c[6].rstrip() + "; re-ranked 2026-09-26 (R3) "
        if solver:
            c[7] = " " + solver + " "
    out.append("|".join(c))
lines[body0:end] = out
text = "\n".join(lines)
PARA = ("*Re-ranked 2026-09-26 (job R3; Kooshi: *\"I agree and approve all suggestions. Set things up, then prepare for compaction, and we'll "
        "focus on that as the milestone.\"*), one rank per row, renumbered from 1: R1's proposal (`plans/RERANK-2026-09-26.md` §3.1), with the "
        "advisor's order where the two disagreed (`plans/POROS-2026-09-26-rerank.md` stage 4) — FS-62 above FS-59, and FS-49 and FS-44 above "
        "FS-69 and FS-57, which the owner ruled post-ban. **Minted:** FS-103 (the collapse, rank 1 — the next milestone), FS-104 "
        "(`χ_CP(ℝ²)` at six, 2), FS-105 (harden MR, 3). **Left the table for the closed list:** FS-84 (answered, row 121) and FS-97 (absorbed "
        "and answered, row 120). **Re-aimed:** FS-59, FS-62, FS-63, FS-67, FS-80, FS-44 (each row's opening sentence; its stub's head block). "
        "The frame the bearings are stated in is FS-103's F1 — a candidate composition, not a result. The earlier paragraphs follow.*\n\n")
anchor = "*At the 2026-09-26 consolidation (job C3b;"
assert text.count(anchor) == 1
text = text.replace(anchor, PARA + anchor)
REPL = [
 ("FS-84 (ℚ(√47): five colours, rank 4; `plans/FS84-five-colours-47.md`)", "FS-84 (ℚ(√47): five colours; `plans/FS84-five-colours-47.md`)"),
 ("**Next:** Kooshi's choice, with a next-step advisor; the default is the top of the table.",
  "**Next: FS-103, the collapse** (`plans/STUB-collapse-cp-plane.md`, rank 1; Kooshi, 2026-09-26: *\"Set things up, then prepare for compaction, and we'll focus on that as the milestone.\"*)."),
 ("`plans/FS100-derivation.md` §3; the stub re-aimed, rank 3;", "`plans/FS100-derivation.md` §3; the stub re-aimed;"),
 ("the stub re-aimed, rank 5)", "the stub re-aimed)"),
 ("the stub re-aimed, rank 3)", "the stub re-aimed)"),
 ("the stub re-aimed, rank 11)", "the stub re-aimed)"),
 ("the milestone kept open at rank 3", "the milestone kept open"),
 ("the stub re-aimed and kept at rank 5", "the stub re-aimed and kept"),
 ("the stub re-aimed and kept at rank 11", "the stub re-aimed and kept"),
 ("its rank 4 held so the numbering stands", "it left the ranked table at the 2026-09-26 re-rank (R3)"),
 ("it keeps rank 13 in the table so the numbering stands", "it left the ranked table at the 2026-09-26 re-rank (R3)"),
]
for a, b in REPL:
    k = text.count(a)
    assert k >= 1, a
    text = text.replace(a, b)
    print(k, "x", a[:60])
P.write_text(text)
# assert on the written file
w = P.read_text()
ls = w.split("\n")
s = next(i for i, l in enumerate(ls) if l.startswith("| rank | stub | the question")) + 2
e = next(i for i in range(s, len(ls)) if not ls[i].startswith("|"))
got = [int(re.search(r"FS-(\d+)", re.split(r"(?<!\\)\|", l)[2]).group(1)) for l in ls[s:e]]
ranks = [re.split(r"(?<!\\)\|", l)[1].strip() for l in ls[s:e]]
assert got == ORDER and ranks == [str(i) for i in range(1, 63)], "table order"
closed = w[w.index("## Closed, absorbed and demoted"):]
for n in range(1, 106):
    inrank = n in got
    inclosed = re.search(rf"FS-{n}\b", closed) is not None
    if not (inrank or inclosed):
        print("MISSING FS-%d" % n)
    if inrank and n in (84, 97):
        print("STILL RANKED FS-%d" % n)
print("table rows:", len(got), "OK")
# stub head blocks
for fs, (qp, bp, solver, path) in RE.items():
    n = ORDER.index(fs) + 1
    sp = Path(path)
    st = sp.read_text()
    first, rest = st.split("\n", 1)
    block = (f"\n**At the 2026-09-26 re-rank (job R3; `plans/RERANK-2026-09-26.md` § Application — R3): rank {oldrank[fs]} → {n} in "
             f"`plans/FRONTIER-STUBS.md`.** " + qp.replace(" The row as it stood: ", " ").rstrip() + " " + (bp.strip() + " " if bp else "") +
             "Provisional bearings add: FS-103 (the collapse — F1, a candidate composition, not a result), FS-104 (`χ_CP(ℝ²)` at six), "
             "FS-105 (harden MR).\n")
    assert "At the 2026-09-26 re-rank (job R3" not in st
    sp.write_text(first + "\n" + block + rest)
    print("head block:", path)
