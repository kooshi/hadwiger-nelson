import re
from pathlib import Path
exec(open("/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs81-close/helpers.py").read())
t = P.read_text()
# Open milestones paragraph
i = t.index("**Open milestones, in order.** **None is open.**")
j = t.index("\n", i)
t = t[:i] + ("**Open milestones, in order.** **None is open.** **FS-81 — four colours over real quadratic fields — CLOSED 2026-09-24** (rows 82–84, G74; "
 "`plans/STUB-quadratic-four-colour-classification.md` carries the banner; `plans/FS81-quadratic-four-colours.md`, its §R-close first; "
 "`plans/FS81-derivation.md` T1–T25): three colours decided at the field level for every real quadratic field, the census completed, "
 "ℚ(√47) screened at four colours and five not landed; FS-82, FS-83, FS-84 minted; FS-48, FS-59, FS-64, FS-75 re-aimed. **Next: Kooshi's "
 "choice, in a week with no SAT solver (2026-09-24 to 2026-10-01)**, advised by a fresh Poros on the algebra-only direction "
 "(`plans/POROS-2026-09-24-algebra-week.md`); the table's top is the default only if nothing is chosen. **Earlier closes**, each with its "
 "record and its stub's banner: FS-79 (rows 80–81, G73; `plans/FS79-invariant-question.md`, `plans/FS79-derivation.md` T1–T43), FS-73 "
 "(rows 78–79, G71; `plans/FS73-rigidity-dichotomy.md`, `plans/FS73-derivation.md` T1–T45; five stubs minted, FS-74 to FS-78), FS-71 "
 "(row 77; `plans/FS71-theorem-audit.md`: seventeen Sonnet 5 reading batches over M17–M36, M37–M52, M53–M61, M62–M64, FS-24–FS-38 and "
 "FS-50–FS-66, 254 theorems in 53 files `plans/<milestone>-derivation.md`), FS-70 (row 76, G68, G69; FS-72 and FS-73 minted from it), "
 "FS-66 (row 75, G66; `plans/FS66-residue-tower-drop.md`, `plans/FS66-phase2-certificate.md`, `plans/FS66-tower-conjecture.md`; its GPU "
 "solve at 23 may still be converging for a tighter `U`; `data/fs66/ckpt/b1-p23/README.md` has the commands that re-round from a later "
 "checkpoint), FS-61 (row 74), FS-58 (rows 72–73); earlier ones in `plans/FRONTIER-STUBS.md` and git. **M63** stands at phases H2–H3 "
 "closed (rows 64–65); **M62** stays paused behind it.") + t[j:]
# Ranked stubs intro
i = t.index("**Ranked stubs** (re-ranked 2026-09-24 after FS-79's close:")
j = t.index("`plans/FRONTIER-STUBS.md` is authoritative):", i) + len("`plans/FRONTIER-STUBS.md` is authoritative):")
t = t[:i] + ("**Ranked stubs** (re-ranked 2026-09-24 at FS-81's close, one rank per row: FS-81 closed; FS-59 stays at rank 1 with its solver-free "
 "routes first; FS-83, FS-84, FS-82 minted at ranks 2, 3, 9; FS-75 re-aimed to T4 for the family (rank 5), FS-48 to multiquadratic fields "
 "without √3 (rank 10); FS-64 routed to FS-83, FS-60 superseded for its lower halves by FS-75; G74 forwarded into FS-48, FS-59, FS-64, "
 "FS-75, FS-82, FS-83, FS-84. A solver column there marks the stubs a SAT-free week can run; `plans/FRONTIER-STUBS.md` is authoritative):") + t[j:]
# table
lines = t.split("\n")
h = next(k for k,l in enumerate(lines) if l == "| rank | stub | the question | bearing on χ ≥ 6 |")
a = h + 2
b = a
while b < len(lines) and lines[b].startswith("|"): b += 1
rows = lines[a:b]
rank = {59:1,83:2,84:3,74:4,75:5,80:6,76:7,64:8,82:9,48:10,78:11,77:12,72:13,55:14,45:15,39:16,63:17,60:18,47:19,46:20,67:21,68:22,43:23,49:24,65:25,57:26,69:27,62:28,41:29,42:30,44:31,51:32,52:33,20:34,17:35,2:36,13:37,12:38,19:39,37:40,27:41,23:42,30:43,35:44,22:45,8:46,29:47,9:48,10:49,5:50}
out = []
for r in rows:
    m = re.match(r"^\| ([0-9–]+) \|(.*)$", r); assert m, r[:60]
    body = m.group(2)
    fss = [int(x) for x in re.findall(r"FS-(\d+)", body.split("|")[0])]
    first = fss[0]
    if first == 81: continue
    if "–" in m.group(1):
        nums = [n for n in fss if n in rank]
        # group row: the FS numbers named in its stub cell
        label = f"{min(rank[n] for n in nums)}–{max(rank[n] for n in nums)}"
        key = min(rank[n] for n in nums)
    else:
        label = str(rank[first]); key = rank[first]
    out.append((key, f"| {label} |{body}"))
def edit(fs, old, new):
    for k,(key,row) in enumerate(out):
        if re.match(rf"^\| {rank[fs]}( |–)", row) and f"FS-{fs} " in row[:160]:
            assert old in row, (fs, old[:40]); out[k] = (key, row.replace(old, new, 1)); return
    raise SystemExit(f"row {fs} not found")
edit(59, "| Four is proven (row 79);", "| **After FS-81:** four is also row 82's, and the four-colour band is measured with a matched ball priced out (row 84), so the solver-free routes come first — the `Θ₄` cells of the seven survivors, the chain route on any that stays rigid, FS-80, FS-83. Four is proven (row 79);")
edit(75, "| `χ(ℚ(√167)²) ≥ 4` in the kernel:", "| **re-aimed at FS-81's close: T4 for the whole family in the kernel** — T22's ⟹, then FS81-T1–T5 (the pull-back lemma, L1 as an inverse limit, C1(5), L3 with the torsion character, the five-layer statement parametric in `d`); fallback, a kernel checker for FS-81's structural certificates on the census (row 83); the old target is an instance. As minted, `χ(ℚ(√167)²) ≥ 4` in the kernel:")
edit(48, "| χ = 3 iff d ≡ 1 (mod 3);", "| **re-aimed at FS-81's close: multiquadratic fields without √3** — three colours decided there (row 82), `χ(ℚ(√2,√7)²) ≥ 4`, L ≥ 5 by the verifier's reading. With √3: χ = 3 iff d ≡ 1 (mod 3);")
edit(60, "| χ ≥ 4 for the 13 certified fields", "| **superseded for the lower halves by FS-75's re-aim** (row 82 is parametric; row 83's structural certificates are the per-field fallback). As minted: χ ≥ 4 for the 13 certified fields")
edit(64, "First ask: can it beat 6 over ℚ(√167)? |", "First ask: can it beat 6 over ℚ(√167)? Its one-place, windowless case — one character colouring the whole field — is FS-83 |")
edit(20, "FS-20 the paper (**re-scoped 2026-09-22:", "FS-20 the paper (**row 82 a candidate paper once the Johnson papers are read, Kooshi's call; re-scoped 2026-09-22:")
new = [
 (2, "| 2 | **FS-83 the layer method at four and five colours** — `plans/STUB-layer-method-five-colours.md` (minted at FS-81's close) | can one character of `ℤ[U_F]` put every unit vector in `[1/k, 1 − 1/k]`? A point colours the whole plane, local at no prime when its archimedean part is nonzero: at `k = 5` over ℚ(√167) it falsifies the conjecture, at `k = 4` over ℚ(√47) its five-clause; from four colours up emptiness proves only that no character colouring exists (G71, G73). The plan-phase advisor's question; solver-free | speculative; the only solver-free instrument aimed at the conjecture's falsifier where it is exposed |"),
 (3, "| 3 | **FS-84 ℚ(√47): five colours** — `plans/STUB-five-colours-47.md` (FS-59's sibling) | L = 5 at every level and `4 ≤ χ ≤ 5`: the conjecture's cheapest exposed five-clause. 25 survivors of 127 lattices, 10 minimal, none called rigid; a matched ball priced out (row 84). Next: P3b's exact `Θ₄` cells on the 10 (solver-free), the chain route on any that stays rigid, then D1's deep pass (SAT) | none directly (5-sealed); a five pins the first real quadratic value at five and would answer Soifer's Open Problem 55.1, a triangle-free five-chromatic unit-distance graph (`CLOSED-QUESTIONS.md` §3) |"),
 (9, "| 9 | **FS-82 three colours at residue degree three** — `plans/STUB-three-colours-residue-degree-three.md` | the one class of real number fields row 82 leaves open (FS81-T7): every prime above 3 of odd residue degree has degree ≥ 3, so no additive three-colouring exists; first ℚ(α, √7), α³ = α + 1, where L = 4 by the plane at 7 — the conjecture predicts four, and a (necessarily non-additive) three-colouring falsifies it; solver-free | none on six; completes the three-colour classification of real number fields; a cheap exposed test at L = 4 |"),
]
out += new
out.sort(key=lambda x: x[0])
lines[a:b] = [r for _, r in out]
t = "\n".join(lines)
P.write_text(t)
print("ok", len(t.encode()), len(out))
