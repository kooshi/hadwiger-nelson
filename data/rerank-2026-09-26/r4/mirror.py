#!/usr/bin/env python3
"""R4 (2026-09-26): rewrite CLAUDE.md's paths-forward table to plans/FRONTIER-STUBS.md's order (R3's re-rank).

Ranks 1-29 as rows, 30-62 as the one pointer row. Retained rows whose FRONTIER-STUBS row did not change keep their CLAUDE.md
text (only the rank cell moves); re-aimed and new rows are written below from their FRONTIER-STUBS rows. Asserts on the written
file: the table's FS order equals FRONTIER-STUBS's ranks 1-29, and the pointer row lists ranks 30-62 in order.
Run from the repository root; it reads the old rows from data/rerank-2026-09-26/r4/old_rows.json (saved before the edit).
"""
import json
import re
from pathlib import Path

OLD = {int(k): v for k, v in json.loads(Path("data/rerank-2026-09-26/r4/old_rows.json").read_text())["old"].items()}

def keep(fs: int, rank: int) -> str:
    row = OLD[fs]
    return re.sub(r"^\| [^|]+ \|", f"| {rank} |", row, count=1)

NEW = {
    103: "**FS-103 the collapse** — `plans/STUB-collapse-cp-plane.md` (**the next milestone**) | **a candidate composition, not a result** — R1's F1, conditional on MR (row 120) and T-J39-3, reached by R1 and the advisor blind to each other, with no derivation of its own: given MR and T-J39-3, at a real field with no non-thick stable place, `χ(ℝ²) = χ_CP(ℝ²) = χ(F²)`. To verify: two blind verifiers, ℚ(√635087) first (first usable prime 103, `2√103/104 ≈ 0.195 < 1/5`), then de Grey's field; a prior-art gate in the words of measurable colouring (`[Falconer1981]`'s `χ_m`, not held; `χ_CP ≤ χ_m`; the claim is `χ = χ_CP`, never `χ = χ_m`) | **derived, if it holds:** six at any field is rung D, S implies `χ(ℝ²) ≠ 6`, and the problem is archimedean — the collapse Kooshi counts as a write-up (§ Publication) |",
    104: "**FS-104 `χ_CP(ℝ²)` at six** — `plans/STUB-cp-plane-six.md` | is `χ_CP(ℝ²) ≥ 6`? `[Falconer1981]` read first, as a CP statement; then the density family, Falconer's mechanism in CP form, `k`-point correlation constraints (FS-80's route) | derived-decisive if FS-103's F1 holds (it is rung D); success very low — the advisor's prior for six itself ≈ 0.03; a named no-go, or a tie of `χ_CP` to `χ_m`, the likely product |",
    105: "**FS-105 harden MR** — `plans/STUB-harden-mr.md` | read `[EinsiedlerLindenstrauss2022]` Thm 1.2's proof (§§3, 5–9 unread) as far as PE-2's hypotheses; a third derivation of EF_F⁺, blind, at ℚ(√635087) | rows 121–125 and FS-103 rest on MR (row 120), the table's weakest link (the advisor); none on six directly |",
    62: "**FS-62 six is not a value** — `plans/STUB-six-is-not-a-value.md` | re-aimed (the advisor's order, above FS-59): S's exact form given MR — if FS-103's F1 (a candidate) holds, S ⟹ `χ(ℝ²) ≠ 6`, and S ⟺ `χ_CP(ℝ²) = 5`, or `χ_CP(ℝ²) = 7` and no field with a non-6-thick place drops to six, a finite family of CP product statements (the advisor); the gate on the image of `F ↦ χ(F²)`, an hour, unrun | a derived frame, soft as to truth — Kooshi: *\"It's just one possibility with some soft evidence\"*; his 2026-09-26 target names its strong statement, G64's S |",
    67: "**FS-67 colourings of gap-free products** — `plans/STUB-tight-product-colourings.md` | re-aimed: product locality (PL) in CP form at the non-mixing places, `k = 5, 6` — must a CP `k`-colouring of `UD(ℝ²) × ∏ G_v` come from `UD(ℝ²)`? `PL_∃(23, 43)` is its instance; given FS-103's F1 (a candidate), PL is the only non-archimedean content left in the target. Closed as a milestone (rows 114–115); **left from it:** three colours, a Hoffman-tight counterexample (a regular Hedetniemi factor with `μ_min ≥ −d/(k−1)`), Zhang's IS-imprimitive exception … | derived: PL is necessary for S under HN = 7 and for the conjecture's six-clauses; soft as to truth (Hedetniemi fails from four colours up; these factors do not mix); mechanism — G61 (3)'s 11 half now a theorem, its 7 half measured; `PL_∃(23, 43)` is one conjunct of six at ℚ(√167) (row 125) |",
    59: "**FS-59 ℚ(√167): six colours** — `plans/STUB-four-colours-167.md` (its head block first) | re-aimed to `PL_∃(23, 43)` and the wall at 23 and 43: given FS-103's F1 (a candidate), six at ℚ(√167) is rung D plus `PL_∃(23, 43)`, dearer as a route to six; its own question is whether the conjecture's widest gap reaches the plane's value. Five is answered at [hand], through MR, by two routes (row 123). The finite routes stood so: row 84 priced a matched ball out; `L21cc6506` is loose at four, row 81; 7 minimal lattices of a finite part of the saturated chain survive capped screens and P3b (no quotient colouring to `N = 15`, undecided at Λ₂₃₂₈'s 13 and Λ₂₄₄₈'s 15) … | **the conjecture's widest gap** — predicted ≥ 6 against a proven 5 at [hand] (4 in the kernel, row 119), robust to every level of the tower at 23 (row 75); the five confirms and cannot falsify (FS-64); its ≥ 6 is archimedean modulo PL, MR being held (row 120); six contains `χ_CP(ℝ²) ≥ 6 ∧ PL_∃(23, 43)` (row 125, which makes J39's T-J39-5 exact) — both conjuncts open, no density bound can give the first … |",
    102: "**FS-102 the fallback write-up** — `plans/STUB-writeup-main-clause-five.md` | rows 120–123 written up at [hand]; the publication rule half fires (§ Publication); if FS-103 verifies, its possible headline is `χ(ℝ²) = χ_CP(ℝ²)` given MR; `[Johnson2000]`, `[Johnson2006]` first (Kooshi, acquiring) | none; Kooshi's fallback if the push toward six stalls |",
    80: "**FS-80 a window-frequency certificate at four colours** — `plans/STUB-window-frequency-certificate.md` | re-aimed: averaged certificates at five colours on the real plane, the integrality shape a six certificate must take (G24) and FS-104's route (c) — its shape derived in-ban, the LP post-ban (the advisor). At four colours: a window-frequency Farkas certificate of non-four-colourability kept small by the point group, aimed at ℚ(√167)'s survivors (row 80, G73); beside it the radius-≥ 2 cocycle route … | derived as the shape a six certificate must take, soft as to success (the fractional version caps at 4.36, G60); at four colours it would restate a value held — five at ℚ(√167) is held at [hand] by measure rigidity (row 123) |",
    96: "**FS-96 windows at the non-mixing places** — `plans/STUB-windows-five-nonmixing.md` | `PL_∃(23, 43)`'s negation at five, FS-59's question from the other side (the advisor); re-aimed (J39's R3): for existence the places are `{∞, 23, 43}` modulo SP; GAP-1 does not arise in the CP format; GAP-2 is PL(23, 43), FS-67's question in CP form … | speculative; given MR, exactly whether ℚ(√167)'s plane is five-colourable (row 125) |",
    64: "**FS-64 the adelic window colouring** — `plans/STUB-adelic-window-colouring.md` | every ceiling we own uses ONE place: build a cut-and-project colouring on the S-integers of F in ℝ² × ℝ² × ℚ₃²; can it beat 6 over ℚ(√167)? At six, a mixed CP six-colouring at a field with a non-6-thick place is \"six below HN\" (R1). Four-colour windows, characters and finite-place spectra are closed, five-colour windows reduced to nine places (rows 92, 96, 101, 110, 112–113; FS-96, FS-98); four-colour Kronecker windows: the `E`-form moot over T-C(A)'s class through MR (rows 116–117, 123) | **the only ceiling instrument that could decide six** — one of the two ways six can occur if HN = 7 (derived); G64 puts six in the gap between L(F) and χ(F²); speculative, low confidence (the conjecture predicts no) |",
    63: "**FS-63 the crystallography gate** — `plans/STUB-moire-coincidence.md` | re-aimed: the aperiodic-order gate for `Y` with `p`-adic factors, in the product-locality cluster (FS-67, FS-59, FS-96, FS-64) — not `χ_CP(ℝ²)`'s home (the advisor); a prior-art session in the vocabulary of coincidence site lattices, Moiré superlattices and aperiodic order (G62): does it already hold the rotation screen, the index arithmetic, or a colouring theory for planar modules? … | none directly; free classification theorems or the negative, and the paper's second-discipline vocabulary (FS-20) |",
    49: "**FS-49 one gadget for six** — `plans/STUB-distance-two-gadget.md` | route D, rung D's finite-graph form, needing no MR (given FS-103's F1, such a graph exists iff `χ_CP(ℝ²) ≥ 6`, the advisor): one five-colour virtual edge at distance 2 in a real F ⊇ K, on `[ExooIsmailescu2019]`'s host (G26, G55); the arena's sweep found none (G31) | the highest of any stub if it lands, in the genre that returned zero on the arena |",
    44: "**FS-44 the fifth colour** — `plans/STUB-fifth-colour-structure.md` | re-aimed: given MR, a five-colouring of `K(√7)²` exists iff `UD(ℝ²)` has a CP one (R1's walk, from T-J39-3), so its question is the shape of a CP five-colouring of the plane — FS-104's mirror; before it, the algebra of where the fifth colour may go over a 6-open field | a derived frame, the upper side of rung D; low as work until a statement exists |",
    69: "**FS-69 the all-levels certificate at 43** — `plans/STUB-certificate-at-43.md` | FS-59's necessary condition (five at every level of 43) and a window member; **post-ban** (the owner): a relaxation smaller than FS-66's, priced out at 43; five colours need `U < 369.8`, six `U < 308.17` | none directly; \"43 at depth\" in six at ℚ(√167) (row 125), and the last gap in M3's finite-place window count |",
    57: "**FS-57 the fractional wall** — `plans/STUB-fractional-wall.md` | route C: refuse six at the reachable window members by `α(U_Q) < Q²/6` — 47 (needs 368 against the certified 371) and `U₆₄` (needs 682 against Hoffman 768); **post-ban** (the owner) | none on `χ(ℝ²)`; it bears on S's product conjunct only if HN = 7 |",
    100: "**FS-100 one missing lemma for three fields** — `plans/STUB-measure-rigidity-three-fields.md` (minted by J47) | **MR proved (row 120); `χ(ℚ(√47)²) = 5` (row 121); wave 3: `χ(F²) = L(F)` for `L ≤ 5` over every real number field (row 123), the type-(B) rotation-invariant half (row 124), six at ℚ(√167) reduced (row 125)** — [hand]; prior-art gate negative (X24R); the in-ban round's results stand (rows 116–118); FS-97 absorbed. **Left**, none bearing on six: TR-ROT, closed on `E` and a GAP at NA₀ (row 126); C-4 (transience); MR at row 100's exception fields (no colouring consequence: they have `L = 2`); MR's complex-place case on an instance; the kernel port (FS-101); stage 4′ moot for ℚ(√47). MR's hardening is FS-105 | none |",
    65: "**FS-65 an exact independence number for the window planes** — `plans/STUB-exact-independence-solver.md` | `α(Γ_q)` exactly at the window members, where every off-the-shelf exact solver fails; at 23 the question is integers — best set 87, six needs 89 | none on `χ(ℝ²)`; `α < ⌈q²/6⌉` closes a wall member, never opens one |",
    17: "**FS-17 the first digit at 23** — `plans/STUB-first-digit-23.md` | is Γ₂₃ six- or seven-chromatic? Five is refused (FS-56), so `χ ∈ {6, 7, 8}` (eight in the kernel); six needs `α ≥ 89`, and the best set found is 87 | a six-colouring makes 23 the first exactly six-chromatic plane and `χ(ℚ(√167)²) ≤ 6` a theorem; a refusal of six puts ℚ(√167)'s local bound at 7 unless 43 is six-chromatic |",
    78: None,  # kept, with FRONTIER's since-row-123 clause added to its bearing (below)
    42: "**FS-42 5-tight quotients of 6-open planes** — `plans/STUB-tight-quotients.md` | a reading with its falsifier: the one constructive residue route to a five-colour forced pair row 66 leaves — a Cayley quotient of a 6-open field's plane that is five-colourable and 5-tight (G54, G48) | medium-low, a reading |",
    43: "**FS-43 the slack census** — `plans/STUB-arena-slack-census.md` | row 66's theorem on a graph against itself: a five-colour forced pair can sit only at vertices frozen in every five-colouring; on the ρ₆₃ arena the census is ≤ 132 interface vertices | medium as an instrument, two-sided |",
    39: "**FS-39 the bridge to the plane** — `plans/STUB-plane-bridge.md` | `χ(ℝ²) = sup` over real number fields of `χ(F²)`: in the kernel conditional on `RealAlgebraicDescent` (row 107), route C in the kernel (row 104); left, B2, the hypothesis itself (months). Partly superseded by FS-103's F1 (a candidate), which would attain `χ(ℝ²)` at a named field | none on finding a 6-forcer; every `χ(ℝ²)` sentence cites a kernel theorem with one named hypothesis |",
}

ORDER = [103, 104, 105, 62, 67, 59, 102, 80, 96, 64, 63, 49, 44, 69, 57, 100, 101, 65, 17, 55, 78, 42, 43, 45, 39, 75, 90, 98, 76]
POINTER = [95, 87, 92, 68, 47, 60, 46, 48, 72, 77, 88, 93, 94, 99, 41, 51, 52, 20, 2, 13, 12, 19, 37, 27, 23, 22, 30, 35, 8, 29, 9, 10, 5]


def frontier_order() -> list[int]:
    lines = Path("plans/FRONTIER-STUBS.md").read_text().split("\n")
    i = lines.index("## Ranked stubs")
    j = lines.index("## Closed, absorbed and demoted")
    out = []
    for line in lines[i:j]:
        m = re.match(r"^\| (\d+) \| .*?FS-(\d+)", line)
        if m:
            out.append((int(m.group(1)), int(m.group(2))))
    assert [r for r, _ in out] == list(range(1, len(out) + 1)), "FRONTIER-STUBS ranks are not 1..N"
    return [fs for _, fs in out]


def main() -> None:
    fo = frontier_order()
    assert fo[:29] == ORDER, (fo[:29], ORDER)
    assert fo[29:] == POINTER, (fo[29:], POINTER)
    rows = []
    for rank, fs in enumerate(ORDER, 1):
        if NEW.get(fs):
            rows.append(f"| {rank} | {NEW[fs]}")
        else:
            row = keep(fs, rank)
            if fs == 78:
                a = "| medium — where FS-49's gadget can be built at all |"
                assert row.endswith(a), row
                row = row[: -len(a)] + "| medium — where FS-49's gadget can be built at all; since row 123 it asks only where a five-colour compulsion can live |"
            rows.append(row)
    ptr = ", ".join(f"FS-{n}" for n in POINTER)
    rows.append(f"| 30–62 | {ptr} — in rank order; their rows are `plans/FRONTIER-STUBS.md`'s alone | … | … |")
    path = Path("CLAUDE.md")
    L = path.read_text().split("\n")
    i0 = L.index("| rank | stub | the question | bearing on χ ≥ 6 |")
    assert L[i0 + 1] == "|---|---|---|---|"
    i1 = next(i for i in range(i0, len(L)) if L[i].startswith("| 30–"))
    L[i0 + 2 : i1 + 1] = rows
    path.write_text("\n".join(L))
    # assert on the written file
    W = path.read_text().split("\n")
    j0 = W.index("| rank | stub | the question | bearing on χ ≥ 6 |")
    got = []
    for line in W[j0 + 2 :]:
        if not line.startswith("|"):
            break
        got.append(line)
    assert len(got) == 30, len(got)
    for rank, (line, fs) in enumerate(zip(got, ORDER), 1):
        assert line.startswith(f"| {rank} | "), line[:40]
        assert re.search(r"FS-(\d+)", line).group(1) == str(fs), (rank, line[:80])
    assert got[29].startswith("| 30–62 | " + ptr)
    print("table written:", len("\n".join(got).encode()), "bytes; CLAUDE.md", len(path.read_bytes()), "bytes")


if __name__ == "__main__":
    main()
