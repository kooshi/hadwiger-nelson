from pathlib import Path
import re
p = Path("CLAUDE.md"); t = p.read_text(encoding="utf-8")
def rep(old, new, count=1):
    global t
    n = t.count(old)
    assert n == count, (n, old[:80])
    t = t.replace(old, new)

# 1. Last updated
i = t.index("*Last updated: 2026-09-24 — **FS-81 closed**")
j = t.index("\n", i)
t = t[:i] + ("*Last updated: 2026-09-24 — **FS-85 closed** (rows 85–87; G75 minted; G54 rewritten, its middle case observed): **every "
 "four-colouring of de Grey's lattice is `8Λ`-periodic by derivation** from Parts's trees, at two independent derivations, with no solver "
 "refusal (row 85); **four-colour rigidity without triangles** exists in the abstract class and in the plane is exactly Soifer 55.1 (row "
 "86); the week's verdict **Paid (abstract)**. **No finite-witness search runs until 2026-10-01** (Kooshi; § Toolchain). Earlier closes: "
 "FS-81 (rows 82–84; G74), FS-79 (rows 80–81; G73), FS-73 (rows 78–79; G71), FS-71 (row 77), FS-70 (row 76; G68, G69), FS-66 (row 75; "
 "G66), FS-61 (row 74), FS-58 (rows 72–73); 2026-09-19 — G64 corrected; the rest in git.*") + t[j:]

# 2. item 3: tight forcing now has a second source
rep("the residue plane forces pairs only\n   where it is Hoffman-tight, and no 5-sealing plane is.",
    "the residue plane forces pairs only\n   where it is Hoffman-tight or pulls back from a tight quotient (row 87), and no 5-sealing plane does.")
rep("a residue plane forces pairs only where it is\nHoffman-tight, which at five colours no sealing plane is (G54;",
    "a residue plane forces pairs only where it is\nHoffman-tight or pulls back from a tight quotient (row 87), which at five colours no sealing plane does (G54;")

# 3. item 18: 8Λ derived
rep("**Over K the question is closed** (row 78): `F = P = 8Λ` — every four-colouring of de Grey's lattice is 8Λ-periodic, forced by one 2,044-point certificate;",
    "**Over K the question is closed** (rows 78, 85): `F = P = 8Λ` — every four-colouring of de Grey's lattice is 8Λ-periodic, first by one 2,044-point certificate, now by derivation from Parts's trees (item 23);")

# 4. item 19 compressed (facts in row 77 and G70)
i = t.index("19. **The derivations are counted, and the corpus graded itself down more often than up**")
j = t.index("\n20. **At three colours")
t = t[:i] + ("19. **The derivations are counted, and the corpus graded itself down more often than up** (row 77, FS-71): 254 theorems proved "
 "outside the kernel since M17, 184 by hand, filed one entry each in `plans/<home>-derivation.md` and indexed in `LEDGER.md` § B; one hand "
 "claim wrong (now a conjecture), under-grades four to one over-grade (G21), six results found in an uncited session record (G70).") + t[j:]

# 5. item 22 compressed (facts in row 81) and item 23 new
i = t.index("22. **ℚ(√167) at four colours** (row 81).")
j = t.index("\n\n**The prior-art position.**")
t = t[:i] + ("22. **ℚ(√167) at four colours** (row 81). `L21cc6506`, the lattice of `χ ≥ 4`, is four-colourable and loose (`F = P = 0`), so "
 "the chain route has no input there; seven minimal lattices of a finite part of the saturated chain survive every capped screen — "
 "survivors, not refusals. Five over ℚ(√167) is FS-59's question.\n"
 "23. **De Grey's lattice, derived; four-colour rigidity without triangles** (rows 85–87, G75, G54). Every four-colouring of "
 "`Cay(Λ, U)` is `8Λ`-periodic, local at one prime above 2 (Hubai's chirality), striped, 9,120 in all — by hand and exact computation "
 "from Parts's no-monochromatic-√3-triple trees, walked here as a certificate, at two independent derivations, with no solver refusal "
 "(row 85); the triangles enter as a linear identity that pins the spectrum (G75). It answers Mixon's 2018 question at its exact scope "
 "(`CLOSED-QUESTIONS.md` §2.5; the literal ring is FS-88). **Without triangles** rigidity is free in the abstract class — a "
 "triangle-free `G(ℤ, D)` with `F₄ = 4ℤ` — and in the plane it is exactly Soifer's Open Problem 55.1 (row 86); no triangle-free "
 "unit-distance lattice with `F₄ ≠ 0` is known (FS-86). No-gos, and a slack plane that forces: row 87. **The week's verdict** "
 "(`plans/FS85-rigidity-without-triangles.md` §R-close.2): **Paid (abstract)**, Part 1 alone **Draw (K)**; read with Kooshi's *\"A "
 "proven theorem about why its impossible is also valid. All novel knowledge is a success\"* — no-gos count. His remark that the ban may "
 "have been too strict, read against 37 logged would-have-searched lines (2 breaches): it paid where a search would have been the finder "
 "and cost only where one would have aimed.") + t[j:]

# 6. prior-art position
rep("the passage from additive to all three-colourings at the field level and the census's structural certificates (rows 82–83; as far as the gate reached, `[Johnson2000]` and `[Johnson2006]` unread); every kernel certificate.",
    "the passage from additive to all three-colourings at the field level and the census's structural certificates (rows 82–83; as far as the gate reached, `[Johnson2000]` and `[Johnson2006]` unread); `F = P = 8Λ` on de Grey's lattice by derivation and the audit of its input, the triangle-free abstract rigidity and its Soifer calibration, and the no-gos on `Λ` (rows 85–87); every kernel certificate.")
rep("the Moser ring's 9,120 four-colourings, all 8-periodic (Hubai, Polymath16, 2018);",
    "the Moser ring's 9,120 four-colourings, all 8-periodic (Hubai, Polymath16, 2018); the no-monochromatic-√3-triple trees (`[Parts2020hv]`); stripes from no monochromatic √3-triangle and the abandoned route to period 16 (Gibbs, Polymath16, 2018); the renormalisation (Tao, the wiki's Cor. 9); `K_k × Y` uniquely colourable (`[KlotzSander2017]` Thm 4.2, after Greenwell–Lovász);")

# 7. ledger pointer
rep("**Rows 1–84 live in `LEDGER.md`**", "**Rows 1–87 live in `LEDGER.md`**")

# 8. open milestones
i = t.index("**Open milestones, in order.** **None is open.**")
j = t.index("\n", i)
t = t[:i] + ("**Open milestones, in order.** **None is open.** **FS-85 — can four-colour rigidity exist without triangles? — CLOSED "
 "2026-09-24** (rows 85–87, G75; `plans/FS85-rigidity-without-triangles.md`, its §R-close first; `plans/FS85-derivation.md`; the stub "
 "carries the banner): de Grey's `8Λ` derived, FS-74 closed by it; the triangle-free abstract yes and its Soifer calibration; FS-86, FS-87, "
 "FS-88 minted; FS-59, FS-67, FS-76, FS-80 re-aimed. **Next: Kooshi's choice**, in the finite-witness-free week to 2026-10-01 (§ "
 "Toolchain). Earlier closes, their records and banners: `plans/FRONTIER-STUBS.md`'s closed list. **M63** stands at phases H2–H3 closed "
 "(rows 64–65); **M62** stays paused behind it.") + t[j:]

# 9. ranked stubs intro
i = t.index("**Ranked stubs** (re-ranked 2026-09-24 at FS-81's close")
j = t.index("\n", i)
t = t[:i] + ("**Ranked stubs** (re-ranked 2026-09-24 at FS-85's close, one rank per row: FS-74 closed by row 85; FS-86, FS-87, FS-88 "
 "minted at ranks 2, 8, 15; FS-67 re-aimed to its four-colour form and moved to 9; FS-59, FS-76, FS-80 re-aimed; G75 forwarded into "
 "FS-59, FS-67, FS-76, FS-80, FS-86, FS-88. A solver column there marks the stubs the finite-witness-free week can run; "
 "`plans/FRONTIER-STUBS.md` is authoritative):") + t[j:]

# 10. table
lines = t.split("\n")
h = next(k for k,l in enumerate(lines) if l.startswith("| rank | stub | the question | bearing on χ ≥ 6 |"))
k0 = h + 2
k1 = k0
while lines[k1].startswith("| "):
    k1 += 1
rows = lines[k0:k1]
def fs(r):
    m = re.search(r"FS-(\d+)", r.split(" | ")[1]); return int(m.group(1))
single = {fs(r): r for r in rows if re.match(r"\| \d+ \|", r)}
groups = [r for r in rows if re.match(r"\| \d+–\d+ \|", r)]
assert len(single) == 28 and len(groups) == 7, (len(single), len(groups))
single.pop(74)
single[86] = ("| 0 | **FS-86 four-colour rigidity over ℚ(√59) and ℚ(√83)** — `plans/STUB-dyadic-rigidity-triangle-free.md` | triangle-free, "
 "four-chromatic, and their only four-colour target the inert dyadic `K₄`, Hoffman-tight (H5, H6's type B): does a rich lattice there carry "
 "`P₄` or `F₄ ≠ 0`? H5's falsifier is an exact Smith-form derivation on the dyadic tower (solver-free); then tightness up the tower read "
 "with row 87, and what pins the spectrum without triangles (G75's killing test) | none directly (χ = L = 4); **a yes answers Soifer 55.1** "
 "(row 86) and is priced so; Coxeter's R2.6 predicts no |")
single[87] = ("| 0 | **FS-87 de Grey's lattice in the kernel** — `plans/STUB-de-grey-chain-kernel.md` | row 85's chain in Lean: the stripe "
 "lemma (V2-T5) first, dB9's V1, a checker for Parts's nine trees (with V8's placement, (S″) kernel), then the theorem as a conditional "
 "one with (S″) named; dB2 as a small instance | none; row 85 to the kernel's word, which a write-up of Mixon's question needs |")
single[88] = ("| 0 | FS-88 Mixon's follow-up — `plans/STUB-literal-ring-mixon.md` | the literal ring `ℤ[ζ₆, ω₃]`, which row 85 does not "
 "reach (V2-T8): are its four-colourings periodic, and finitely many? Hubai's comments first, then a derivation | none; the literal form "
 "of a question posed in print (`CLOSED-QUESTIONS.md` §2.5) |")
def add(fsn, old, new):
    r = single[fsn]; assert r.count(old) == 1, (fsn, old); single[fsn] = r.replace(old, new)
add(59, "| **the conjecture's widest gap**", "**Re-aimed at FS-85's close:** the field is triangle-free, so the chain route's input is Soifer-strength (row 86) and R2.6 predicts no rigidity | **the conjecture's widest gap**")
add(80, "and the index topological bounds |", "and the index topological bounds; on de Grey's lattice radius 1 cannot lift `120Λ` to `8Λ` (row 87), so price radius ≥ 2 |")
add(76, "local instances FS-72 and KR6 |", "local instances FS-72 and KR6; `P = F` now holds on de Grey's lattice by derivation (row 85) |")
add(67, "| `G` Hoffman-tight at three colours", "| **re-aimed at FS-85's close to its four-colour form**, answered yes once (R3a, row 85: the tight dyadic quotient times the mod-5 torus), bearing on FS-86; as minted: `G` Hoffman-tight at three colours")
order = [59,86,83,84,75,80,76,87,67,64,82,48,78,77,88,72,55,45,39,63,60,47,46,68,43,49,65,57,69,62]
assert sorted(order) == sorted(single)
new_rows = []
for r_, f in enumerate(order, 1):
    c = single[f].split(" | "); c[0] = f"| {r_}"; new_rows.append(" | ".join(c))
shift = {"29–33":"31–35","34–36":"36–38","37–40":"39–42","41–42":"43–44","43–45":"45–47","46–47":"48–49","48–50":"50–52"}
for g in groups:
    c = g.split(" | "); c[0] = "| " + shift[c[0][2:]]; new_rows.append(" | ".join(c))
lines[k0:k1] = new_rows
t = "\n".join(lines)
p.write_text(t, encoding="utf-8")
print(len(t.encode()))
