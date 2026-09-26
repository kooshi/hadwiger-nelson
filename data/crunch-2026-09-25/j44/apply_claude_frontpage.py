#!/usr/bin/env python3
"""J44 stage 3: CLAUDE.md's current-state lines, the Paths-forward table and G79 (after the two closes' drafts are applied).

Every anchor must occur exactly once, or nothing is written.  --plant: an absent anchor; must exit 1 with CLAUDE.md untouched.
"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
p = ROOT / "CLAUDE.md"
t0 = p.read_text(encoding="utf-8")
t = t0
def rep(old, new):
    global t
    c = t.count(old)
    if c != 1:
        sys.exit(f"FAIL: anchor occurs {c} times: {old[:80]!r}; nothing written")
    t = t.replace(old, new, 1)

# 1. Last updated
rep("*Last updated: 2026-09-25 — **FS-67 closed** (rows 114–115; G21, G54, G61, G72 edited): the product question answered negatively from four colours up for gap-free factors, a sharp mixing pullback, three colours open; **Paid (theorem and no-go)** (`plans/FS67-tight-products.md` §R-close). **the 2026-09-25 crunch closed its three milestones**",
    "*Last updated: 2026-09-25 — **row 88's question and FS-67 closed** (rows 111–115; G79 minted; G21, G30, G44, G49, G54, G61, G72, G76 edited): **row 88's question** — four-colour rigidity over the type-(B) fields splits into invariant measures and transience, finite-place spectra are pullbacks and at ℚ(√47) none exists, transience stopped at two named steps; **Paid (theorem); row 88 not landed** (`plans/FS86-row88-rigidity.md` §R-close); **FS-67** — the product question answered negatively from four colours up for gap-free factors, a sharp mixing pullback, three colours open; **Paid (theorem and no-go)** (`plans/FS67-tight-products.md` §R-close). **Before them the 2026-09-25 crunch closed its three milestones**")
# 2. ledger range
rep("**Rows 1–110 live in `LEDGER.md`**", "**Rows 1–115 live in `LEDGER.md`**")
# 3. open milestones
rep("**Open milestones, in order.** **None is open.** **The 2026-09-25 crunch closed its three milestones**",
    "**Open milestones, in order.** **One is open: FS-84** (ℚ(√47): five colours; `plans/FS84-five-colours-47.md`) — S1, its derivation, and S1V, its blind verification, are done (`plans/FS84-S1-derivation.md`, `plans/FS84-S1V-verification.md`); its next stages run from 2026-10-01. **Row 88's question — CLOSED** (rows 111–113; `plans/FS86-row88-rigidity.md`, its §R-close first; `plans/R88-derivation.md`; FS-97, FS-98, FS-99 minted). **FS-67 — CLOSED as a milestone** (rows 114–115; `plans/FS67-tight-products.md` §R-close; `plans/FS67-derivation.md`; the stub re-aimed). **The 2026-09-25 crunch closed its three milestones**")
# 4. re-rank note
rep("**Ranked stubs** (re-ranked 2026-09-25 at the crunch's close (M1–M3), one rank per row: FS-91 and FS-82 closed, FS-83 answered; FS-92 to FS-96 minted; FS-39 moved below FS-68, FS-69 up one; FS-39, FS-45, FS-47, FS-48, FS-59, FS-64, FS-69, FS-75, FS-76, FS-87 re-aimed; G77, G78 forwarded. Its solver column",
    "**Ranked stubs** (re-ranked 2026-09-25 at row 88's and FS-67's closes, one rank per row: FS-98 (rank 7), FS-97 (12), FS-99 (31) minted; FS-67 closed as a milestone and re-aimed; FS-64, FS-84, FS-90 re-aimed; G76's split, G54's product sentence and G79 forwarded. At the crunch's M1–M3 close before it: FS-91 and FS-82 closed, FS-83 answered; FS-92 to FS-96 minted; G77, G78 forwarded. Its solver column")
# 5. row cells: FS-84, FS-90, FS-64 (+ its bearing, moved back from FS-92's row)
rep("the chain route on any that stays rigid, then D1's deep pass (SAT). **At FS-86's close:** a four-colouring falsifying the five-clause cannot be a measurable window colouring over finitely many places (row 92, one mind); at FS-89's, nor a character colouring (row 96) |",
    "the chain route on any that stays rigid, then D1's deep pass (SAT). **At FS-86's close:** a four-colouring falsifying the five-clause cannot be a measurable window colouring over finitely many places (row 92, one mind); at FS-89's, nor a character colouring (row 96); **at row 88's**, nor any colouring carrying an invariant measure whose spectrum reads finitely many places (row 113; FS-97). **Open:** S1 and S1V done, the next stages from 2026-10-01 |")
rep("`Λ₅₁₀`'s route 4 | none directly; each a finite witness",
    "`Λ₅₁₀`'s route 4. **At row 88's close:** the third is row 88's stage Y1, from 2026-10-01; a counterexample to isolation or defect growth is itself a non-pullback (row 111; FS-98) | none directly; each a finite witness")
bearing64 = " **the only ceiling instrument that could decide six** — G64 puts six exclusively in the gap between L(F) and χ(F²), where every existing instrument is silent; speculative, low confidence |"
rep("the shape a character falsifier would need |" + bearing64, "the shape a character falsifier would need |")
rep("reduces to nine places (row 110; FS-96) |\n",
    "reduces to nine places (row 110; FS-96); **at row 88's close** four-colour finite-place spectra over type (B) are pullbacks and none exists at ℚ(√47) (rows 112–113; FS-97, FS-98) |" + bearing64 + "\n")
if "--plant" in sys.argv:
    rep("zzq absent anchor zzq", "x")

# 6. re-rank the table
lines = t.split("\n")
h = [k for k, l in enumerate(lines) if l.startswith("| rank | stub | the question | bearing on χ ≥ 6 |")]
assert len(h) == 1
k = h[0] + 2
def shift(r):
    return r if r <= 6 else r + 1 if r <= 10 else r + 2 if r <= 28 else r + 3
new_rows = []
while lines[k].startswith("| "):
    l = lines[k]
    m = re.match(r"\| (\d+)(?:–(\d+))? \|", l)
    assert m, l[:30]
    a = int(m.group(1)); b = m.group(2)
    lab = f"{shift(a)}" + (f"–{shift(int(b))}" if b else "")
    new_rows.append("| " + lab + " |" + l[m.end():])
    k += 1
end = k
fs98 = "| 7 | **FS-98 transience over the type-(B) fields** — `plans/STUB-ultrametric-continuation.md` (minted at row 88's close) | isolation across an ultrametric front (T-B1) and defect growth (T-B2), both stopped at one named step by two minds (row 111); the expansive-subdynamics reading | none directly; row 88's other half — either FALSE is its \"no\" |"
fs97 = "| 12 | **FS-97 invariant four-colourings whose spectrum reads infinitely many places** — `plans/STUB-infinite-place-spectra.md` (minted at row 88's close) | row 88's measure half beyond Theorem C (row 112): spectra on the union over finite `S` of `T + A + Fin_S` and on no single one (R1), or reading infinitely many split places (R2); entropy and ×2×3; the ℚ(√47) form | none directly; the only measure route to `F(R)` over type (B) and to `χ(ℚ(√47)²)` |"
fs99 = "| 31 | FS-99 the ℚ⁴ control — `plans/STUB-rational-four-space-rigidity.md` (minted at row 88's close) | is every four-colouring of `G(ℚ⁴)` the Benda–Perles pullback? The triangle-full analogue of row 88; Zaks 1989 first | none; a control that separates dyadic tightness from triangles |"
out = []
for r in new_rows:
    out.append(r)
    if r.startswith("| 6 | **FS-76"): out.append(fs98)
    if r.startswith("| 11 | **FS-64"): out.append(fs97)
    if r.startswith("| 30 | FS-43"): out.append(fs99)
assert len(out) == len(new_rows) + 3, "an insertion anchor was not found"
labels = [re.match(r"\| ([\d–]+) \|", r).group(1) for r in out]
flat = []
for lab in labels:
    a, _, b = lab.partition("–"); flat += list(range(int(a), int(b or a) + 1))
assert flat == list(range(1, len(flat) + 1)), flat
lines[h[0] + 2:end] = out
t = "\n".join(lines)
# 7. grokkings: range, G79, G72's pointer
rep("G1–G78 are stable identifiers", "G1–G79 are stable identifiers")
g79 = (ROOT / "data/crunch-2026-09-25/j44/g79.txt").read_text(encoding="utf-8").rstrip("\n") + "\n"
rep("* **G51 — A competitor and an advisor beat one mind.", g79 + "* **G51 — A competitor and an advisor beat one mind.")
rep("2026-09-23; one instance (FS-73)]**", "2026-09-23; one instance (FS-73)]** *Its dual is G79.*")
p.write_text(t, encoding="utf-8")
print(f"PASS; net {len(t.encode()) - len(t0.encode()):+d} bytes; CLAUDE.md now {len(t.encode()):,} bytes; table {len(out)} rows, ranks 1–{flat[-1]}")
