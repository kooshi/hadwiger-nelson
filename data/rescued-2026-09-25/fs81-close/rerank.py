import re
from pathlib import Path
P = Path("/home/kooshi/source/lean-dir/plans/FRONTIER-STUBS.md")
t = P.read_text()
lines = t.split("\n")
rows = {}
first = last = None
for i, l in enumerate(lines):
    if re.match(r"^\| \d+ \|", l):
        raw = re.sub(r"^\| \d+ \|", "", l.rstrip())
        raw = raw[:-1] if raw.endswith("|") else raw + " "
        n = int(re.search(r"FS-(\d+)", raw).group(1))
        assert n not in rows, n
        parts = raw.split("|")
        rows[n] = parts if len(parts) == 5 else raw  # a list when well-formed, else the raw text
        first = i if first is None else first
        last = i
assert all(re.match(r"^\| \d+ \|", lines[j]) for j in range(first, last + 1))
del rows[81]
rows[30] = rows[30] + "| low: largely answered by M63 phases G–H2 (these three cells were missing from this row until FS-81's close; restored from `CLAUDE.md`'s mirror) | — | minted at M62 "
for n in (59, 75, 48, 64, 60, 20):
    assert isinstance(rows[n], list), n
def pre(n, idx, text): rows[n][idx] = " " + text + rows[n][idx].lstrip()
def app(n, idx, text): rows[n][idx] = rows[n][idx].rstrip() + text + " "
pre(59, 1, "**After FS-81 (§00 of the stub):** four also follows from the field-level theorem (row 82); the four-colour band is measured (row 84) and a matched-control ball is priced out, so the solver-free routes come first — the `Θ₄` cells of the seven survivors, the chain route on any that stays rigid, FS-80, FS-83.")
app(59, 4, "; §00 added at FS-81's close")
rows[75][1] = " **Re-aimed at FS-81's close: T4 for the whole family in the kernel.** T22's ⟹ direction (V2's forward lift), then FS81-T1–T5 — the pull-back lemma, L1 as an inverse limit over finite symmetric sets, C1(5) (T40's cells, a finite exact computation), L3 with the torsion character and L4′, and the five-layer statement parametric in `d`, whose instance at 167 subsumes the old target. Fallback per field: a kernel checker for FS-81's structural certificate on the 40 census fields (row 83). Cheap first derivation: T41's shape empties at K = 1 only at d ≡ 23 (mod 48) (FS81 §5 R2) "
rows[75][2] = " none on six; lifts row 82 from [hand] to the kernel — a class theorem over a family of fields, and a write-up's backbone if the Johnson papers leave it ours "
rows[75][3] = " T22's ⟹ unpriced (price from its first two leaves); C1(5) a finite computation; the rest short "
app(75, 4, "; re-aimed at FS-81's close")
pre(48, 1, "**Re-aimed at FS-81's close: extended to multiquadratic fields without √3.** Three colours are now decided for every multiquadratic field (row 82; residue degrees ≤ 2 leave no residual case); `χ(ℚ(√2,√7)²) ≥ 4`, and L ≥ 5 there by the verifier's reading (first usable planes 31, 47). The fields with √3:")
app(48, 4, "; re-aimed at FS-81's close")
app(64, 1, " The one-character case (one place, no window) is FS-83's question (the plan-phase advisor's, routed here at FS-81's close).")
pre(60, 1, "**Superseded for the lower halves by FS-75's re-aim** (the five-layer statement parametric in `d` covers every field; FS-81's structural certificates, row 83, are the per-field fallback); what remains here is the per-field witness format and the upper halves (FS-37/47). As minted:")
pre(20, 1, "**Row 82** (three colours over real quadratic fields, at the field level) answers at three colours questions posed in print (Benda–Perles, Moorhouse, `[Fischer1990]`'s request for a criterion) — a candidate paper once `[Johnson2000]` and `[Johnson2006]` are read, Kooshi's call.")
rows[82] = [" **FS-82 three colours at residue degree three** — `plans/STUB-three-colours-residue-degree-three.md` (minted at FS-81's close) ",
 " The one class of real number fields the three-colour theorem leaves open: non-bipartite, every prime above 3 of odd residue degree of degree ≥ 3, so no additive three-colouring exists (Hilbert 90). First instance ℚ(α, √7), α³ = α + 1, where L = 4 by the plane at 7: the conjecture predicts χ = 4, and a three-colouring (necessarily non-additive) would falsify it at L = 4. Route: a finite configuration with empty `Θ₃` (then χ = 4 exactly), or the field-level classification by layers ",
 " none on six; completes the three-colour classification of real number fields; a cheap, solver-free exposed test of the conjecture at L = 4 ",
 " an afternoon to a first configuration; a day to a structural certificate ",
 " minted at FS-81's close (FS81-T7's residual case) "]
rows[83] = [" **FS-83 the layer method at four and five colours** — `plans/STUB-layer-method-five-colours.md` (minted at FS-81's close) ",
 " Can one character of `ℤ[U_F]` put every unit vector in `[1/k, 1 − 1/k]`? A point is a whole-plane k-colouring, local at no prime when its archimedean part is nonzero: at k = 5 over ℚ(√167) it falsifies the conjecture, at k = 4 over ℚ(√47) its five-clause. From four colours up emptiness proves only that no character colouring exists, never χ > k (G71, G73). Route: `Θ_k(U₅)` at the new band by T40's exact cells, then gluing by the field's relations (the plan-phase advisor's question; FS-64's simplest case) ",
 " speculative; the only solver-free instrument aimed at the conjecture's falsifier where it is exposed ",
 " a day for the rational layer at two bands; the gluing unpriced ",
 " minted at FS-81's close "]
rows[84] = [" **FS-84 ℚ(√47): five colours** — `plans/STUB-five-colours-47.md` (minted at FS-81's close; FS-59's sibling) ",
 " 4 ≤ χ ≤ 5 and L = 5 at every level: the conjecture predicts exactly five, its cheapest exposed five-clause, and a refusal pins the value. 25 survivors of 127 lattices, 10 minimal, none called rigid (row 84); a matched ball is priced out (×1,284, [reading]). Next: P3b's exact `Θ₄` cells on the 10 minimal survivors, the chain route on any that stays rigid, then D1's deep pass (residue re-asks, quotients) ",
 " none directly (ℚ(√47) is 5-sealed); a five would pin the first real quadratic value at five ",
 " hours for the `Θ₄` finder; a day for the cells; the chain unpriced ",
 " minted at FS-81's close (stage D1's deep pass carried, the owner's ruling) "]
solver = {59:"SAT for quotients, residue asks, balls; none for `Θ₄` cells and the chain's derivation", 83:"none", 84:"SAT for the deep pass; none for `Θ₄` cells and the chain's derivation",
 74:"none", 75:"none", 80:"none (LP)", 76:"none (derivation)", 64:"none", 82:"none", 48:"none at three colours; SAT for four-colour refusals",
 78:"SAT", 77:"SAT", 72:"SAT", 55:"SAT (a finder)", 45:"none (kernel; the refusal's LRAT held)", 39:"none (kernel)", 63:"none (reading)",
 60:"none (kernel)", 47:"none (kernel)", 46:"none (kernel)", 67:"optional", 68:"none (SDP)", 43:"SAT", 49:"SAT", 65:"SAT or MIP",
 57:"none (SDP)", 69:"none (SDP)", 62:"none", 41:"none (kernel)", 42:"SAT", 44:"optional", 51:"none (kernel)", 52:"none (kernel)",
 20:"none", 17:"SAT", 2:"SAT", 13:"SAT", 12:"optional", 19:"none", 37:"none (kernel)", 27:"none", 23:"none", 30:"SAT", 35:"SAT",
 22:"SAT", 8:"none", 29:"none", 9:"none", 10:"none", 5:"none"}
order = [59,83,84,74,75,80,76,64,82,48, 78,77,72,55,45,39,63,60,47,46, 67,68,43,49,65,57,69,62,41,42, 44,51,52,20,17,2,13,12,19,37, 27,23,30,35,22,8,29,9,10,5]
assert sorted(order) == sorted(rows), set(order) ^ set(rows)
assert set(order) == set(solver)
new = []
for r, n in enumerate(order, 1):
    c = rows[n]
    body = "|".join(c) if isinstance(c, list) else c
    new.append(f"| {r} |" + body + f"| {solver[n]} |")
# header
hi = first - 2
assert lines[hi].startswith("| rank | stub |"), lines[hi]
lines[hi] = "| rank | stub | the question | bearing on χ ≥ 6 | cost | status | solver (the close planner's reading; check at the opening) |"
lines[hi+1] = "|---|---|---|---|---|---|---|"
lines[first:last+1] = new
P.write_text("\n".join(lines))
print("rows", len(new))
