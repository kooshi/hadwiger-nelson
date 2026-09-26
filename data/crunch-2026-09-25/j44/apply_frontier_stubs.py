#!/usr/bin/env python3
"""J44 stage 4: plans/FRONTIER-STUBS.md for row 88's and FS-67's closes. Every anchor once, or nothing is written. --plant: absent anchor, exit 1."""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
p = ROOT / "plans/FRONTIER-STUBS.md"
t0 = p.read_text(encoding="utf-8"); t = t0
def rep(old, new):
    global t
    c = t.count(old)
    if c != 1:
        sys.exit(f"FAIL: anchor occurs {c} times: {old[:80]!r}; nothing written")
    t = t.replace(old, new, 1)
# 1. open milestones
rep("**No milestone is open.** **The 2026-09-25 crunch closed its three milestones**",
    "**One milestone is open: FS-84** (ℚ(√47): five colours, rank 3; `plans/FS84-five-colours-47.md`): S1, its derivation, and S1V, its blind "
    "verification, are done (`plans/FS84-S1-derivation.md`, `plans/FS84-S1V-verification.md`); its next stages run from 2026-10-01. **Row 88's "
    "question — CLOSED** (`LEDGER.md` rows 111–113; FS-97, FS-98, FS-99 minted; `plans/FS86-row88-rigidity.md` §R-close, `plans/R88-derivation.md`), "
    "**Paid (theorem); row 88 not landed**; **FS-67 — CLOSED as a milestone** (`LEDGER.md` rows 114–115; `plans/FS67-tight-products.md` §R-close, "
    "`plans/FS67-derivation.md`; the stub re-aimed, rank 10), **Paid (theorem and no-go)**. **Before them the 2026-09-25 crunch closed its three milestones**")
# 2. re-rank paragraph
rep("*Re-ranked 2026-09-25 at the crunch's close (M1–M3), one rank per row.",
    "*Re-ranked 2026-09-25 at row 88's and FS-67's closes (J44), one rank per row. **Closed as milestones:** row 88's question (`LEDGER.md` rows "
    "111–113; row 88 itself undecided) and FS-67 (rows 114–115; its stub re-aimed and kept, now rank 10). **Minted:** FS-98 (transience over the "
    "type-(B) fields, rank 7), FS-97 (spectra reading infinitely many places, 12), FS-99 (the ℚ⁴ control, 31). **Re-aimed:** FS-84 (row 113), FS-64 "
    "(rows 111–113; stage Y2 carried), FS-90 (its (c) is stage Y1), FS-67 (its close). Every rank from 7 on moved down one, from 11 down two, from 29 "
    "down three. The earlier re-rank's paragraph follows.*\n\n"
    "*Re-ranked 2026-09-25 at the crunch's close (M1–M3), one rank per row.")
# 3. cells
rep("`χ(ℚ(√47)²) = 5` answers Soifer 55.1 and Moorhouse's ℚ(√47) question. |",
    "`χ(ℚ(√47)²) = 5` answers Soifer 55.1 and Moorhouse's ℚ(√47) question. **At row 88's close:** no translation-invariant random four-colouring "
    "of its plane has spectrum on any `T + A + Fin_S`, `S` finite (row 113; the remainder is FS-97's). |")
rep("planned 2026-09-25 (`plans/FS84-five-colours-47.md`, J29; its stages run from 2026-10-01) |",
    "planned 2026-09-25 (`plans/FS84-five-colours-47.md`, J29); **open**: S1 and S1V done (`plans/FS84-S1-derivation.md`, "
    "`plans/FS84-S1V-verification.md`), the later stages from 2026-10-01 |")
rep("(d) `Λ₅₁₀`'s route 4 (composite quotients) and 29's certificate for (R4) |",
    "(d) `Λ₅₁₀`'s route 4 (composite quotients) and 29's certificate for (R4). **At row 88's close:** (c) is the row-88 plan's stage Y1, dated "
    "from 2026-10-01; a counterexample to isolation (T-B1) or to defect growth (T-B2) is itself a non-pullback (row 111), so no finite search for "
    "either is cheaper than row 88's \"no\" (FS-98). |")
rep("the mixed window — several places, non-linear readings — is the remaining question. |",
    "the mixed window — several places, non-linear readings — is the remaining question. **At row 88's close:** at four colours over the type-(B) "
    "fields every invariant random colouring with spectrum on `T + A + Fin_S` is a pullback, and over ℚ(√47) none exists (rows 112–113); the "
    "four-colour remainder is FS-97 and FS-98; stage Y2, `χ_f(ℚ(√59)²)` by an exact LP a derivation shapes, is carried here (post-ban, Kooshi's "
    "call). |")
rep("re-aimed at the M1 and M3 closes |", "re-aimed at the M1, M3 and row-88 closes |")
# 4. FS-67's row, in the full form of its close's draft (R.8c/R.8e)
old67 = [l for l in t.split("\n") if l.startswith("| 9 | **FS-67 3-colourings of tight products**")]
assert len(old67) == 1
new67 = ("| 9 | **FS-67 colourings of gap-free products** — `plans/STUB-tight-product-colourings.md` (closed as a milestone 2026-09-25, the stub "
  "re-aimed) | **Closed as a milestone** (`LEDGER.md` rows 114–115; `plans/FS67-tight-products.md` §R-close, `plans/FS67-derivation.md`). `G` "
  "gap-free (a fall colouring) at `k`, `H` connected, `χ(H) > k`: must every `k`-colouring of `G × H` come from `G`? Exactly when every "
  "`k`-colouring of `G` is gap-free and `χ(E_k(G)) ≤ k` (FS67-DA1, DA2); **no from four colours up** for some uniquely colourable `G = K_k × X` "
  "(a composition of print: Duffus–Sands–Woodrow's `B(k) ⟹ H(k)` with `[Tardif2023]`; not a `CLOSED-QUESTIONS.md` entry); yes for `K_k^s` "
  "(Greenwell–Lovász) and every `G` whose vertices lie in `k`-cliques; yes against every mixing `H` (`λ* < 1/(k−1)`, sharp at `K_k`), and for "
  "1-walk-regular Hoffman-tight `G` against `χv(H) > k` (conditional on `[GodsilEtAl2020]`); so FS-58's \"rigid tensored with the plane at 11\" "
  "is a theorem, and at 7 still measured. For maps into the Moser spindle yes in print (`[TardifWrochna2019]` Thm 2, M3's close). **Left:** "
  "three colours (3-colour the non-zero-winding part of `E_3(G)`; `[ElZaharSauer1985]` and `[Tardif2006alg]` first), a Hoffman-tight "
  "counterexample at `k ≥ 4` (a regular Hedetniemi factor with `μ_min ≥ −d/(k−1)`), Zhang's IS-imprimitive exception. | none; mechanism — "
  "G61 (3)'s 11 half now a theorem, its 7 half measured; the model of \"when must a colouring of a product of local targets be local at one "
  "place\" (G48, FS-64, FS-66, FS-92) | the readings first (Duffus–Sands–Woodrow 1985, El-Zahar–Sauer 1985, Tardif 2006: none held); the "
  "three-colour step open | minted 2026-09-20 at FS-61's close; closed as a milestone 2026-09-25 (crunch, J27–J42), re-aimed | none for the "
  "derivation; PB-1 at `C₇` and `K₃ × C₅` post-ban (an exact finder on a set the derivation fixes) |")
rep(old67[0], new67)
if "--plant" in sys.argv:
    rep("zzq absent zzq", "x")
# 5. re-rank the table, inserting the three new stubs
lines = t.split("\n")
h = [k for k, l in enumerate(lines) if l.startswith("| rank | stub | the question | bearing on χ ≥ 6 | cost | status |")]
assert len(h) == 1
k = h[0] + 2
def shift(r): return r if r <= 6 else r + 1 if r <= 10 else r + 2 if r <= 28 else r + 3
rows = []
while lines[k].startswith("| "):
    m = re.match(r"\| (\d+) \|", lines[k]); assert m, lines[k][:30]
    rows.append(f"| {shift(int(m.group(1)))} |" + lines[k][m.end():]); k += 1
end = k
fs98 = ("| 7 | **FS-98 transience over the type-(B) fields** — `plans/STUB-ultrametric-continuation.md` (minted at row 88's close) | Isolation across "
  "an ultrametric front (T-B1) and defect growth (T-B2), both stopped at one named step by two minds (row 111): unique continuation from a region "
  "that is no archimedean half-space, and propagation to positive density; the expansive-subdynamics reading (Boyle–Lind, Einsiedler–Lind–Miles) "
  "with its killing test | none directly; row 88's other half — a FALSE for either is a non-pullback, row 88's \"no\" | unpriced (a derivation) | "
  "minted 2026-09-25 at row 88's close | none until 2026-10-01; after it a finite shadow measures balls, never the plane |")
fs97 = ("| 12 | **FS-97 invariant four-colourings whose spectrum reads infinitely many places** — `plans/STUB-infinite-place-spectra.md` (minted at "
  "row 88's close) | Row 88's measure half beyond Theorem C (row 112): spectra on the union over finite `S` of `T + A + Fin_S` and on no single one "
  "(R1: no Haar measure on the full product), or reading infinitely many split places (R2: entropy, ×2×3 rigidity); the ℚ(√47) form (row 113) | "
  "none directly; the only measure route to `F(R)` over type (B) and to `χ(ℚ(√47)²)` | unpriced (a derivation) | minted 2026-09-25 at row 88's "
  "close | none |")
fs99 = ("| 31 | **FS-99 the ℚ⁴ control** — `plans/STUB-rational-four-space-rigidity.md` (minted at row 88's close) | Is every four-colouring of "
  "`G(ℚ⁴)` the Benda–Perles pullback (Hurwitz order at its prime above 2)? The triangle-full analogue of row 88; Zaks 1989 (every colour class "
  "dense, by review) first | none; a control that separates dyadic tightness from triangles | a browser fetch, then a derivation | minted "
  "2026-09-25 at row 88's close | none for the derivation |")
out = []
for r in rows:
    out.append(r)
    if r.startswith("| 6 | **FS-76"): out.append(fs98)
    if r.startswith("| 11 | **FS-64"): out.append(fs97)
    if r.startswith("| 30 | **FS-43"): out.append(fs99)
assert len(out) == len(rows) + 3, "an insertion anchor was not found"
nums = [int(re.match(r"\| (\d+) \|", r).group(1)) for r in out]
assert nums == list(range(1, len(nums) + 1)), nums
lines[h[0] + 2:end] = out
t = "\n".join(lines)
# 6. the closed list
rep("## Closed, absorbed and demoted\n",
    "## Closed, absorbed and demoted\n"
    "* **Row 88's question — is `(0, 4)` forced over ℚ(√59), ℚ(√83), ℚ(√131)?** — FS-86's continuation, no stub of its own. **Closed 2026-09-25** "
    "(record `plans/FS86-row88-rigidity.md`, §R-close first; `plans/R88-derivation.md`; close inventory `plans/FS86-row88-close-inventory.md`; "
    "`LEDGER.md` rows 111–113; G76): the split into invariant measures and transience (row 111), Theorem C (row 112), its ℚ(√47) form (row 113); "
    "**Paid (theorem); row 88 not landed**. Successors FS-97, FS-98, FS-99.\n"
    "* **FS-67 colourings of gap-free products** — `plans/STUB-tight-product-colourings.md`. **Closed as a milestone 2026-09-25**, the stub "
    "re-aimed and kept at rank 10 (record `plans/FS67-tight-products.md`, §R-close first; `plans/FS67-derivation.md`; close inventory "
    "`plans/FS67-close-inventory.md`; `LEDGER.md` rows 114–115; G54): the product criterion and its no from four colours up (row 114), the sharp "
    "mixing pullback (row 115); **Paid (theorem and no-go)**.\n")
p.write_text(t, encoding="utf-8")
print(f"PASS; net {len(t.encode()) - len(t0.encode()):+d} bytes; table ranks 1–{nums[-1]}")
