import re
ROOT="/home/kooshi/source/lean-dir/"
plan=open(ROOT+"plans/FS100-three-field-lemma.md",encoding="utf-8").read().splitlines()
L=open(ROOT+"LEDGER.md",encoding="utf-8").read()
def rep(old,new):
    global L
    n=L.count(old); assert n==1,(n,old[:90]); L=L.replace(old,new)
def pipes(l): return len(re.findall(r"(?<!\\)\|",l))
# rows 123-125 from the plan (lines 1766, 1768, 1770; 1-based)
rows=[plan[i-1] for i in (1766,1768,1770)]
assert rows[0].startswith("| 123 |") and rows[1].startswith("| 124 |") and rows[2].startswith("| 125 |")
# owner's launch note 3: one sentence in row 123 (FS100-COR's scope), and X28D's address
old123="a complex place enters only through its compact real form, the circle inside the norm-one hyperbola."
assert rows[0].count(old123)==1
rows[0]=rows[0].replace(old123, old123+" The complex-place case is inhabited and not reducible to totally real fields by monotonicity: ℚ(√23, ∛2) has `L = 5` while its totally real subfields have `L ≤ 4` (X28D-CP2), so the complex-place step is load-bearing there.")
olda="`tools/x25b_t1_check.py` |"
assert rows[0].count(olda)==1
rows[0]=rows[0].replace(olda,"`tools/x25b_t1_check.py`; `plans/FS100-X28D-derivation.md` §2.3, §3.3; `tools/x28d_check.py` |")
for r in rows: assert pipes(r)==5, (r[:10],pipes(r))
anchor122=[l for l in L.splitlines() if l.startswith("| 122 |")]
assert len(anchor122)==1
rep(anchor122[0]+"\n", anchor122[0]+"\n"+"\n".join(rows)+"\n")
# corrections, row 117
rep("[hand + tools exact, one mind (J51), re-derived by J51V (not blind) and J53 (Legendre symbols); K0 hand, one mind (J51V) + a one-step check (J53); both on R88-TCA's class form, one mind outside ℚ(√47)]",
    "[hand + tools exact; two derivations (J51; X25B, blind), re-derived by J51V (not blind) and J53 (Legendre symbols); K0 two (J51V; X21V, blind); both on R88-TCA's class form, now two derivations over totally real fields (J28D; X25B)]")
rep("**Not claimed:** MR anywhere; the class among fields of higher degree.", "**Not claimed:** — (MR is row 120; the class in every degree is row 123).")
# row 113
rep("the class form — every real field whose stable places all have all-levels ratio `< 1/4` — J28D's;",
    "the class form — every real field whose stable places all have all-levels ratio `< 1/4` — J28D's; a second derivation over totally real fields by X25B (blind to the proofs), and with a complex place the step by restriction to the compact real form (FS100-CX, row 123);")
# row 120 (the Johnson clause kept between the two replaced spans)
rep("**EL2021 §2 (\"Actions on adelic solenoids\") unread and may hold PE-2's inverse-limit step — no novelty claimed for PE-2 until it is read**;",
    "EL2021 §2 and §4.1–4.3 read (X24R): set-up for `ℤ^d` only, holding neither PE-2 nor EF_F⁺ (its Lemma 4.2 is a factor lift for a fixed `ℤ^d`); EF_F⁺ not in print (EF 2010's eleven citers in two databases, circle and tori only; Sataev 1975 is the circle theorem, unheld);")
rep("transposed; prior-art gate on MR pending, X24R. |",
    "transposed; MR not found under its discipline's names — its nearest, `[LacaWarren2018]`'s \"generalized Furstenberg conjecture\" (extremal traces of `C*(J ⋊ O*)`), is the finitely generated case and open. |")
# row 121
rep("(none is exhibited). At their grades: `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335) (K0), `χ(ℚ(√167)²) ≥ 5`, and row 88",
    "(none is exhibited). Also `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335), `χ(ℚ(√167)²) ≥ 5` (row 123), and row 88")
rep("The consequences: K0 one mind + a check (row 117), R88-TCA's class form one mind outside ℚ(√47); not kernel",
    "The consequences: row 123's grade; not kernel")
rep("**Prior art:** the value's own gate not yet run (the posers' zbMATH listings, the Polymath16 threads) — owed before any novelty or publication claim; prior-art gate pending, X24R. |",
    "**Prior art:** not found in print (X24R, 2026-09-26: zbMATH listings of twelve posers and fifteen abstract queries, arXiv with a positive control, the Polymath16 threads held and live to 2026-09-24, `[Soifer2024]` chs. 11 and 55; the only triangle-free five-chromatic unit-distance graph in print is in ℝ³, de Grey 2026, Zbl 1581.05080); `[Johnson2000]`, `[Johnson2006]` unread, so novelty is \"not found\", never \"first\". |")
# § B lines: X29C's 19, address in the table's convention
bl=[]
start=[i for i,l in enumerate(plan) if l.startswith("| FS100-Q0 | row 123 |")]
assert len(start)==1
i=start[0]
while plan[i].startswith("| FS100-"):
    l=plan[i]; cells=[c.strip() for c in l.strip().strip("|").split("|")]
    assert len(cells)==6, (l[:40],len(cells))
    cid,row,st,gr,addr,ker=cells
    assert addr==cid, (addr,cid)
    bl.append(f"| {cid} | {row} | {st} | {gr} | `plans/FS100-derivation.md` {cid} | {ker} |")
    i+=1
assert len(bl)==19, len(bl)
# X28D's seven (launch note 3): short forms from the table's statements, grades as stated, one mind
x28={
 "FS100-X28D-P":("odd local degree preserves *ramified* in `F_v(i)/F_v` at a dyadic place (closes FS54-T2's parity step)","hand, one mind"),
 "FS100-X28D-S":("`L(E) ≥ L(F)` for every finite extension `E ⊇ F` of real number fields","hand, one mind"),
 "FS100-X28D-CP1":("CP-1 TRUE: a real number field with `L ≥ 3` has even degree; with a non-real embedding and `L ≥ 5`, even degree `≥ 4`","hand, one mind"),
 "FS100-X28D-CP2":("CP-2 FALSE: `F = ℚ(√23, ∛2)`, signature `(2, 2)`, `L(F) = 5`; its totally real subfields `ℚ`, `ℚ(√23)` have `L = 2, 4`","hand + tools exact, one mind"),
 "FS100-X28D-CP3":("CP-3 FALSE: `L` rises `4 → 5` in `ℚ(√23) ⊂ ℚ(√23, ∛2)`; `χ` rises `3 → 4` unconditionally in `ℚ(√3) ⊂ ℚ(√3, 2cos(2π/7))`","hand + tools exact (the `χ` half rests on row 99 and G56's `U₈`), one mind"),
 "FS100-X28D-ODD":("an odd-degree extension preserves `L = 2` and `χ = 2` (FS54-T2 relative to any base)","hand, one mind"),
 "FS100-X28D-CUBE":("cube roots are impotent exactly where `μ₃` is absent: `L(F(∛m)) = L(F)` whenever some place attaining `L(F)` has `ζ₃ ∉ F_v`; then `χ(F(∛m)²) = χ(F²)` when `L(F) ≤ 4`","hand, one mind"),
}
for cid,(st,gr) in x28.items():
    bl.append(f"| {cid} | row 123 | {st} | {gr} | `plans/FS100-derivation.md` {cid} | undecided (the owner's) |")
for l in bl: assert pipes(l)==7,(l[:30],pipes(l))
flh=[l for l in L.splitlines() if l.startswith("| FS100-FLH |")]
assert len(flh)==1
rep(flh[0]+"\n", flh[0]+"\n"+"\n".join(bl)+"\n")
# claim list (X29C 4.5)
rep("(row 119; as far as the gate reached; its ingredients are in print);",
    "(row 119; as far as the gate reached; its ingredients are in print); the entropy split of measure rigidity for the unit-vector group and its Einsiedler–Fish transfer, and `χ(ℚ(√47)²) = 5` (rows 120–122); the class theorem and SP-Cor in every degree, so the local–global conjecture's main clause through five over every real number field, `χ(ℚ(√3,√5)²) = 5`, the type-(B) fields' rotation-invariant half and the reduction of six at ℚ(√167) to `χ_CP(ℝ²) ≥ 6` (rows 123–125) — as far as the gate reached (X24R: not found in print), `[Johnson2000]` and `[Johnson2006]` unread;")
open(ROOT+"LEDGER.md","w",encoding="utf-8").write(L)
print("ok", len(bl))
