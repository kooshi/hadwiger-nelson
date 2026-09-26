#!/usr/bin/env python3
"""J42 stage 5: replace each FS67 entry's *Prior art:* field (up to *Kernel:*) with J40's verdict, quoted from plans/FS67-PA-close.md.
Every quoted J40 fragment is asserted present (verbatim) in J40's record before it is written; a missing one aborts (exit 1)."""
import re, sys, pathlib
root = pathlib.Path(__file__).resolve().parents[3]
pa = (root / "plans/FS67-PA-close.md").read_text(encoding="utf-8")
paN = " ".join(pa.split())
J = "J40, `plans/FS67-PA-close.md`"
def q(s):  # assert a J40 quotation is verbatim (whitespace-normalised) in its record
    if " ".join(s.split()) not in paN:
        print("NOT VERBATIM IN J40:", s[:80]); sys.exit(1)
    return s
if "--plant" in sys.argv:
    q("the construction `G = K_k × X` is decided")
F = {
"DA1": f"not gated by J40 (DA-1′ is not in its list, `plans/FS67-PA-close.md` Stage 1); the records' attributions stand: the stub's `C₅ × K₄` instance (FS-61's planner), and `[GreenwellLovasz1974]` Thm 1's hypothesis is gap-freedom (PA-P1). ",
"L1": f"{J} Stage 2: \"" + q("**not found as a printed sentence**; its content is the standard identification *frozen = fall colouring = isolated in `R_k(G)`* (zbl 1579.05061's review, verbatim above) carried to `K_k^G`") + "\". Stated at FS-89's close as part of PA-T6 (`plans/PA-tardif2023.md` §5.4). ",
"DA2": f"{J} Stage 2: \"" + q("**not found by these searches**; its `G = K_k` case is GL Thm 1's Case 2 (the products reader's PA-P2) and its `G = K_k^s` case is `[Larose2002]` (by review)") + "\" — and PA-T6 (FS-89's close) is its first statement here. For non-`k`-colourable `G` it is the exponential-graph criterion for multiplicativity (`[TardifWrochna2019]` §1.2). ",
"GL": f"the statement is `[GreenwellLovasz1974]` Cor. 1 — {J} Stage 2 on DA-3 (b): \"" + q("`[GreenwellLovasz1974]` Cor. 1 (read in full by the products reader") + "\"; the selection `γ` is Case 2's `γ′` of their proof (PA-P2). Nothing of it is ours but the route through FS67-DA2. ",
"CL": f"{J} Stage 2 (verbatim): \"" + q("FS67 holds for every connected graph in which every vertex lies in a `k`-clique (GL Cor. 1 on each clique, glued along overlaps as in Csernák's Lemma 3.5)") + "\" — its ingredients `[GreenwellLovasz1974]` Cor. 1 and Csernák 2023 (arXiv:2303.06406) Lemma 3.5, whose Thm 3.6 is the `A(n)`-type neighbour; not searched as a statement. ",
"DA3": f"{J} Stage 2: ⟸ \"" + q("**in print as an implication** — DSW 1985 §3, `(B_n) ⇒ (C_{n+1})` = Tardif's \"B(n) implies H(n)\"; **the construction `G = K_k × X` is undecided** until DSW is read") + "\"; (a)–(c) \"" + q("**in print**") + "\" (Weichsel 1962; `[GreenwellLovasz1974]` Cor. 1); ⟹ \"" + q("**not found by these searches** as a stated converse; a two-line consequence of GL Cor. 1 applied to `K_k × (X × H)`") + "\". `[DuffusSandsWoodrow1985]` not held (for Kooshi). ",
"DA4": f"{J} Stage 2, first clause: \"" + q("**not found by these searches as a printed sentence; in print by composition**: DSW's `B(n) ⇒ C(n+1)` (as reported) with `[Tardif2023]` Thm 1") + "\"; second clause: in print as DSW's implication (as DA-3's ⟸). **The owner's ruling** (2026-09-25): \"B(n) and A(n) are false for n ≥ 4\" is a composition of print — DSW 1985's `B(n) ⟹ H(n)` plus `[Tardif2023]` — not ours, and not a `CLOSED-QUESTIONS.md` entry; FS67-DA4 is its explicit `K_k × X` form. ",
"DC1": f"{J} Stage 3: \"" + q("**partly in print**: the vector statement is `[GodsilEtAl2020]` **Thm 4.16(1)**") + "\" … \"" + q("**the integral corollary is not stated** in GRRSV") + "\" (nor in its 8 Pak–Vilenchik-citing neighbours). The `χv` link is GRR 2017 Thm 4.9 / Cor. 4.10, in print. ",
"DC2": f"{J} Stage 3: \"" + q("**partly in print**: the case `G = K_k` is `[PakVilenchik2013]` Thm 3") + "\" (for every `r`-regular `H`, not only Cayley); \"" + q("**Arbitrary gap-free `G`: not found by these searches**") + "\" (40 zbMATH queries, two citation databases); J40's scope note: \"" + q("a reviewer may call it folklore; any claim should be for the statement (arbitrary gap-free, possibly infinite `G`) and cite PV Thm 3 and GRRSV Cor. 4.4 as the printed uses of the threshold") + "\". Its steps (M), (P) are M3-J21-MX's (filed; \"not found as stated\" there). ",
"DC2S": "not gated by J40 (not in its list); the `K_n` case of the mixing selection is Burr–Erdős–Lovász (`[Tardif2008]` Thm 3.2), as M3-J21-MX records. ",
"DC3": f"{J} Stage 4: \"" + q("a table of this project's own graphs; **nothing to gate**") + "\"; the spectra are G44's (Kloosterman form `[MMST1998]`). ",
"DB1R": f"not gated separately by J40; its Stage 4 treats Lemma W and DB-1's partial form (FS67-W, FS67-DB1Z): undecided until `[ElZaharSauer1985]` is read. ",
"W": f"{J} Stage 4: \"" + q("**undecided.** The paper that decides it is **`[ElZaharSauer1985]`**") + "\" (not held); the vertex-function step \"" + q("was not located in TW's §1–§3 by J27D's reading and was not re-searched here") + "\". Not run (J40's budget; declined at this close, inventory row 21): a search in the Hom-complex literature's words (`Hom(C_{2k+1}, K_3)`, Babson–Kozlov) and a walk of `[TardifWrochna2019]`'s citing works. The interleaved walk is `[TardifWrochna2019]` §1.2's. ",
"DB1Z": f"{J} Stage 4 (with FS67-W): \"" + q("**undecided.**") + "\"; the zero-class colouring is `[TardifWrochna2019]` §3's [external]; `[Tardif2006alg]` \"" + q("is the second paper that could decide DB-1's GAP") + "\" (not held). ",
"C5": "none sought (an instance of this project's own). ",
"T": f"{J} Stage 3: \"" + q("**in print, as a two-step corollary**") + "\" — `[Haemers2021]` p. 4 (verbatim in J40): \"" + q("in case G is regular we find that equality in the Hoffman bound implies that each vertex outside C has exactly αk/(n − α) = −λn neighbors in C") + "\"; the classical \"Hoffman colouring\" fact (Blokhuis–Brouwer–Haemers per G54); its abelian-Cayley case is FS38-D2-A (i), (iv). ",
"DB2": f"{J} Stage 3: \"" + q("**an instance, not a theorem to gate**") + "\" (Lemma T applied to named graphs of this project; the connectivity step is Nakayama). ",
"DD1": f"{J} Stage 3: \"" + q("**partly in print**: the vector statement is GRRSV Result 5 / Thm 4.16(3)") + "\"; \"" + q("**the integral step (`χ(H) > k` excludes the `H`-weight) is not stated** there") + "\". ",
"DD2R": "not gated by J40 (not in its list); the spectrum of a tensor product is classical. ",
"DD2N": "not gated by J40 (compositions of FS67-T, DC1, DC2, each gated above). ",
}
p = root / "plans/FS67-derivation.md"
t = p.read_text(encoding="utf-8")
done = 0
for k, v in F.items():
    m = re.search(r"^\*\*FS67-" + re.escape(k) + r" — ", t, re.M)
    assert m, k
    nxt = re.search(r"^(\*\*FS67-|## )", t[m.end():], re.M)
    end = m.end() + (nxt.start() if nxt else len(t) - m.end())
    block = t[m.start():end]
    a = block.index("*Prior art:*"); b = block.index("*Kernel:*")
    block = block[:a] + "*Prior art:* " + v + block[b:]
    t = t[:m.start()] + block + t[end:]
    done += 1
t = t.replace("every *Prior art:* field is **pending J40** (the close-time gate,\n`plans/FS67-PA-close.md`) until its verdicts are copied in at this close's last stage.",
              "every *Prior art:* field carries J40's verdict (the close-time gate,\n`plans/FS67-PA-close.md`), quoted verbatim with its stage, copied in at this close's last stage.")
p.write_text(t, encoding="utf-8")
print("fields replaced:", done, "| 'pending J40' left:", t.count("pending J40"))
