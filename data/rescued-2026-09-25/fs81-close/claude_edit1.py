import re
from pathlib import Path
P = Path("/home/kooshi/source/lean-dir/CLAUDE.md")
t = P.read_text()
def fx(old):
    parts = [re.escape(p) for p in old.split()]
    return re.compile(r"\s+".join(parts))
def rep(old, new, flexible=True):
    global t
    pat = fx(old) if flexible else re.compile(re.escape(old))
    ms = list(pat.finditer(t))
    assert len(ms) == 1, (len(ms), old[:80])
    m = ms[0]
    t = t[:m.start()] + new + t[m.end():]
def ins_before(anchor, new):
    global t
    ms = list(fx(anchor).finditer(t)); assert len(ms) == 1, (len(ms), anchor[:80])
    t = t[:ms[0].start()] + new + t[ms[0].start():]
def ins_after(anchor, new):
    global t
    ms = list(fx(anchor).finditer(t)); assert len(ms) == 1, (len(ms), anchor[:80])
    t = t[:ms[0].end()] + new + t[ms[0].end():]

# 1. Last updated block
i = t.index("*Last updated: 2026-09-24 — **FS-79 closed**")
j = t.index("### Where the problem stands", i)
t = t[:i] + ("*Last updated: 2026-09-24 — **FS-81 closed** (rows 82–84; G74 minted; G61 rewritten with a demotion record): **three colours are "
 "decided over every real quadratic field** — `χ(F²) ≥ 4` whenever `1/3 ∈ ℤ[U_F]` and `F²` is not bipartite, [hand, two independent "
 "derivations], nothing claimed new while `[Johnson2000]` and `[Johnson2006]` are unread; **the census completed**, 40 of 40, by structural "
 "certificates; four colours calibrated on de Grey's lattice and ℚ(√47) screened — **five not landed**. **No SAT solver runs until "
 "2026-10-01** (Kooshi). Before that: 2026-09-24 — FS-79 closed (rows 80–81; G73): four colours, cell by cell — four no-gos, each for its "
 "named format, rank-1 density false, `L21cc6506` loose at four colours. 2026-09-23 — FS-73 closed (rows 78–79; G71): `F = P = 8Λ` at four "
 "colours on de Grey's lattice, the inheritance question a theorem at three colours, χ(ℚ(√167)²) ≥ 4. 2026-09-22 — FS-71 closed (row 77), "
 "the theorem audit; FS-70 closed (row 76; G68, G69), five over ℚ(√3,√5) not landed. 2026-09-21 — FS-66 closed (row 75; G66). "
 "2026-09-20 — FS-61 closed (row 74). 2026-09-19 — G64 corrected; 2026-09-17 — FS-58 closed (rows 72–73).*\n\n") + t[j:]

# 2. target paragraph
rep("L ≤ 5 for multiquadratic F ⊇ K (G55). Its remaining *testable* range is L ≤ 5 outside those classes (FS-61, FS-46, FS-48), then",
    "L ≤ 5 for multiquadratic F ⊇ K (G55); since FS-81 also L ≤ 4 for every real quadratic field (row 82). Its remaining *testable* range is L ≤ 5 outside those classes (FS-61, FS-46, FS-48, FS-82), then")
rep("ℚ(√47) the cheapest; four at the census's 25 open fields (T4, G61; FS-81 aims at both); and at least six at **ℚ(√167)**, proven 4 (row 79), the widest gap, at discriminant 668.",
    "ℚ(√47) the cheapest (FS-81 priced a refusal there and did not land it, row 84; FS-84); four at ℚ(α,√7), α³ = α + 1, outside the proved range (FS-82); and at least six at **ℚ(√167)**, proven 4 (rows 79, 82), the widest gap, at discriminant 668. Four at the census's 25 open fields, and at every squarefree d ≡ 11 (mod 12), is met (rows 82–83).")

# 3. item 10
rep("L ≤ 3, for every field containing √3 with L ≤ 4, and, given the measured 8/3 forcer,",
    "L ≤ 3, for every field containing √3 with L ≤ 4, **for every real quadratic field with L ≤ 4** (row 82, [hand, two independent derivations]; G74), and, given the measured 8/3 forcer,")
rep("against a proven 4 ≤ χ ≤ 5, as at ℚ(√143), ℚ(√311), ℚ(√335) (row 74) — open (FS-81's last phase).",
    "against a proven 4 ≤ χ ≤ 5, as at ℚ(√143), ℚ(√311), ℚ(√335) (row 74) — open: FS-81 priced it without landing it (row 84; FS-84).")

# 4. item 14
i = t.index("14. **Real quadratic fields need four colours, and a census says where we can show it**")
j = t.index("15. **Six may be a value no field attains", i)
t = t[:i] + ("14. **Real quadratic fields: three colours are decided, and four is a theorem of the family** (G61, G74, G65; rows 72–74, 79, 82–84).\n"
 "   **`χ(F²) ≥ 4` for every `F ⊆ ℝ` with `1/3 ∈ ℤ[U_F]` and `F²` not bipartite** [hand, two independent derivations; row 82] — so every\n"
 "   squarefree d ≡ 11 (mod 12) needs four (T4), χ = L for every real quadratic field with L ≤ 4, the three-colourings at d ≡ 3, 7 (mod 12)\n"
 "   are exactly the additive ones, and χ(ℚ(√2,√7)²) ≥ 4 with no √3 in the field; `[Fischer1990]` Thm 10(ii) held the relation and proved\n"
 "   the additive case, and **nothing is claimed new while `[Johnson2000]` and `[Johnson2006]` are unread**. **The census is complete:**\n"
 "   all 40 squarefree d ≡ 11 (mod 12) below 500 — the only real quadratic fields that *can* need four — carry a certified finite witness,\n"
 "   the last 25 by one five-layer configuration and a structural certificate, independent of that argument (row 83); χ(ℚ(√11)²) ≥ 4 is\n"
 "   kernel (row 72). Every witness uses a direction with 3 in a denominator, as the kernel's **3-adic barrier** requires. **ℚ(√47) at four\n"
 "   colours** (row 84): calibrated first — de Grey's lattice with one extra edge refuses four at R = 1.4 by certificate, and refusals stay\n"
 "   undecided at `d_ball` 8.3–14.7 — then 102 of 127 lattices four-colour and 25 survive capped screens; a matched refusal is priced out\n"
 "   (≥ 1,284 times the control's points, [reading]); **five not landed** (FS-84), and the bracket `4 ≤ χ(ℚ(√47)²) ≤ 5` cannot close from above\n"
 "   by residues at any depth (§1.7, row 75). A three-colour question over any real field is now a question about 1/3 (G74); `Θ₃`-emptiness\n"
 "   trees remain the finite witness (row 79).\n") + t[j:]

# 5. prior-art position: ours
rep("`L21cc6506`'s looseness at four colours (rows 80–81); every kernel certificate.",
    "`L21cc6506`'s looseness at four colours (rows 80–81); the passage from additive to all three-colourings at the field level — `χ(F²) ≥ 4` whenever `1/3 ∈ ℤ[U_F]` and the plane is not bipartite — and the census's structural certificates (rows 82–83; as far as the gate reached, `[Johnson2000]` and `[Johnson2006]` unread); every kernel certificate.")
rep("the unit argument and the 1/k obstruction (Fischer);",
    "the unit argument and the 1/k obstruction, with the type-M relation at N ≡ −1 (mod 24) that row 82 uses (Fischer, 1990, additive colourings only);")

# 6. ledger pointer
rep("**Rows 1–81 live in `LEDGER.md`**", "**Rows 1–84 live in `LEDGER.md`**")

# 7. G-range
rep("never deleted**: the entry keeps, in one or two sentences, what it wrongly claimed and what killed it. G1–G73 are stable",
    "never deleted**: the entry keeps, in one or two sentences, what it wrongly claimed and what killed it. G1–G74 are stable")
P.write_text(t)
print("ok", len(t.encode()))
