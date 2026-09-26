#!/usr/bin/env python3
"""J44 stage 5: BIBLIOGRAPHY.md for row 88's close (plans/FS86-row88-rigidity.md §R-close 4.4) and FS-67's (plans/FS67-tight-products.md
§R-close R.8d, from plans/FS67-PA-close.md Stage 5). Every anchor once, or nothing is written.  --plant: an absent key; exit 1."""
import sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[3]
p = ROOT / "BIBLIOGRAPHY.md"
t0 = p.read_text(encoding="utf-8"); L = t0.split("\n")

def row_of(key, ncols=None):
    hits = [k for k, l in enumerate(L) if l.startswith(f"| **[{key}]**")]
    if len(hits) != 1:
        sys.exit(f"FAIL: [{key}] row found {len(hits)} times; nothing written")
    return hits[0]
def sub(key, old, new):
    k = row_of(key)
    if L[k].count(old) != 1:
        sys.exit(f"FAIL: [{key}]: {old[:50]!r} occurs {L[k].count(old)} times; nothing written")
    L[k] = L[k].replace(old, new, 1)
def add_role(key, add):          # 5-column § A row: role is the third-from-last cell
    k = row_of(key); body = L[k]
    assert body.endswith(" |")
    head, copy, read = body[:-2].rsplit(" | ", 2)
    L[k] = f"{head}{add} | {copy} | {read} |"
def add_last(key, add):          # append to the last cell (read column in § A, verdict in § C)
    k = row_of(key); assert L[k].endswith(" |"); L[k] = L[k][:-2] + add + " |"
def insert_after(pred, rows, what):
    ks = [k for k, l in enumerate(L) if pred(l)]
    if len(ks) != 1:
        sys.exit(f"FAIL: insertion point {what} found {len(ks)} times; nothing written")
    L[ks[0] + 1:ks[0] + 1] = rows

if "--plant" in sys.argv:
    row_of("NoSuchKey2099")

# ---- corrections and updates (row 88) ----
sub("BachocEtAl2014", "Nothing certified rests on it: FS-56 uses it", "**Thm 2.2, the Hoffman bound for edge-null sets, is an input of C14.2 (c), R88-TC-count and R88-TC-Yp (row 112).** Nothing kernel-certified rests on it: FS-56 uses it")
sub("BachocEtAl2014", "| not held | **abstract only (2026-09-16)** |", "| `library/pdf/arXiv-1301.1054-bachoc-decorte-oliveira-vallentin-spectral-bounds-operator.pdf` | read: abstract (2026-09-16); §§2.3–2.4, §3.2 (FS-58 sweep); Def. 2.1, Thm 2.2 with proof, Thm 2.3's statement (2026-09-25, J35) |")
k = [i for i, l in enumerate(L) if l.startswith("| `pdf/arXiv-1301.1054-bachoc-decorte-oliveira-vallentin-spectral-bounds-operator.pdf` |")]
assert len(k) == 1; L[k[0]] = L[k[0]][:-2] + "; Def. 2.1, Thm 2.2 with proof, Thm 2.3's statement (2026-09-25, J35) |"
sub("BardestaniMallahiKarai2017", "Nothing of ours rests on it; it is the prior art", "**C14.2 (c) (FS-86) is their §3.2 in window form** (J35), so row 113's correction of row 110's prior art rests on it; it is the prior art")
sub("BardestaniMallahiKarai2017", "§§3–4 (oscillatory integrals, isotropic case) not read** (2026-09-20, FS-66 planner) |", "the rest of §§3–4 (oscillatory integrals, isotropic case) not read** (2026-09-20, FS-66 planner); **§3.2 (Thm 3.7, Lemmas 3.8–3.11) read in full** (2026-09-25, J35) |")
add_role("Johnson2000surprises", "; could pose row 113's fractional question on rational planes (J35; for Kooshi — row 88's close proposed it as `[Johnson2000frac]`, this row's work)")
# ---- updates (FS-67) ----
add_role("GodsilEtAl2020", "; **FS67-DC1 and FS67-DD1 (row 115) are the integral corollaries of its Thm 4.16 (1), (3)**, not stated there")
add_last("GodsilEtAl2020", "; Results 1–5 and §1.2 (J27D), Thm 4.16 (1) (J27V), §4.3 Thm 4.16, §4.4 with Thm 4.17's proof, §5's first page (J40), all 2026-09-25")
add_role("GodsilRobersonRooney2017", "; Cor. 4.10's `χv = 1 + r/|λ_min|` for 1-walk-regular graphs is FS67-DC1's link (row 115)")
add_last("GodsilRobersonRooney2017", "; Cor. 4.10 (2026-09-25, J27D)")
add_role("TardifWrochna2019", "; FS67-W (the interleaved walk) and FS67-DB1Z rest on §3 (its median homomorphism used, not re-derived; row 114)")
add_last("TardifWrochna2019", "; §3 in full (2026-09-25, J27D)")
add_role("Tardif2023", "; **FS67-DA4 (row 114) rests on Thm 1**, and DD-2's open regularity question on §2's `Ω_w(K_m)`")
add_role("Tardif2008", "; row 114's attribution of Duffus–Sands–Woodrow's `B(n) ⟹ H(n)` and FS67-CL's scope (§4.2, Thm 3.2)")
add_last("Tardif2008", "; §4.2 re-read and Thm 3.2 (2026-09-25, J27V, J40)")
add_role("GreenwellLovasz1974", "; FS67-GL, FS67-DA3 and FS67-CL (row 114) rest on Thm 1 and Cor. 1")
add_role("PakVilenchik2013", "; its Thm 3 is FS67-DC2's case `G = K_k` (row 115)")
add_role("ElZaharSauer1985", "; it decides FS67-W's and DB-1's attribution (FS-67's gate, `plans/FS67-PA-close.md` Stage 5)")
add_role("DuffusSandsWoodrow1985", "; **its `B(n) ⟹ H(n)`** (as `[Tardif2008]` §4.2 and `[GodsilEtAl2020]` §1.3 report it) **with `[Tardif2023]` makes `B(n)` and `A(n)` false for every `n ≥ 4` — a composition of print, not ours** (row 114; owner's ruling); whether its proof builds `K_n × X` is undecided until it is read; 69 OpenAlex and 71 Semantic Scholar citing works walked (J40)")
add_last("Haemers2021", " **FS-67 (J40, 2026-09-25): p. 4's equality passage is Lemma T (FS67-T, row 115)** — Hoffman-tight at `k` ⟹ every `k`-colouring gap-free.")
add_last("AbiadEtAl2025", " **§4 Thm 4.1 read (J40, 2026-09-25):** a non-trivially Hoffman-colourable connected 2-walk-regular graph is not uniquely vector colourable — the uniqueness clause of `[GodsilEtAl2020]` Thm 4.16 (2); FS67-DC1 uses item (1), no conflict.")

# ---- new § A rows ----
A = [
"| **[BergelsonMoragues2021]** | V. Bergelson, A. Ferré Moragues, *An ergodic correspondence principle, invariant means and applications*, Israel J. Math. (2021) 921–962, doi 10.1007/s11856-021-2233-y, Zbl 1501.37009; arXiv:2003.03029 | Thm 2.3 + Prop. 2.7 are R88-CL, the clopen correspondence (row 111 (v)) | `library/pdf/BergelsonMoragues2021-ergodic-correspondence-invariant-means.pdf` | read: §1, §2 to Prop. 2.7 (2026-09-25, J35) |",
"| **[ChenDai2017]** | Z. Chen, X. Dai, *Chaotic dynamics of minimal center of attraction of discrete amenable group actions*, J. Math. Anal. Appl. 456 (2017) 1397–1414, Zbl 1385.37038; arXiv:1707.07786 | Lemma 1.2: the measure centre by positive upper density of return times, in Følner-relative form — row 111's \"transient\" | `library/pdf/ChenDai2017-minimal-center-attraction-amenable.pdf` | read: §1, §2.3 (2026-09-25, J35) |",
"| **[LevitzMott1972]** | K. B. Levitz, J. L. Mott, *Rings with finite norm property*, Canad. J. Math. 24 (1972) 557–565, doi 10.4153/CJM-1972-049-1, Zbl 0222.13006 | Thm 2.3 (`A = ℤ`): every subring of a number field has every non-zero ideal of finite index — R88-J28V-7, row 88's V2 without Lemma R (rows 88, 111) | `library/pdf/LevitzMott1972-rings-finite-norm-property.pdf` | read: §2 in full (2026-09-25, J35) |",
"| **[SallyTaibleson1966]** | P. J. Sally Jr., M. H. Taibleson, *Special functions on locally compact fields*, Acta Math. 116 (1966) 279–309, doi 10.1007/BF02392818 | Lemma 8(i): the vanishing step behind `[BardestaniMallahiKarai2017]` Lemma 3.11 and so C14.2 (c); whether it covers residue characteristic 2 decides how much of row 113's `q = 2` case is in print | not held (Kooshi's fetch, row 88's close) | cited-by only |",
"| **[Csernak2023]** | T. Csernák, *Trivial coloring of Cartesian product of graphs* (the body is about direct products), arXiv:2303.06406v2 (22 Oct 2024) | Def. 2.2's *tight* colouring is FS-67's gap-free (fall) colouring — a clash with G54's Hoffman-tight; Lemma 3.5's argument with Greenwell–Lovász's Cor. 1 gives FS67-CL (row 114); Thm 3.6 (weakly-cliqued `G` × tight `H`, `χ = k`) is an `A(n)`-type statement | `library/pdf/Csernak2023-trivial-coloring-products.pdf` | read: abstract, §1–§3; §6 by grep; §4–§5 not read (2026-09-25, J40) |",
]
insert_after(lambda l: l.startswith("| **[Johnson2011rational]**"), A, "after [Johnson2011rational]")
# ---- new § C rows ----
C = [
"| **[WangZhou2016]** Wang, Zhou, the measure centre for amenable actions (Acta Sci. Nat. Univ. Sunyatseni 55(3) (2016) 52–54, Zbl 1363.28019) | **Summary only** (row 88's gate, J35): defines the measure centre for amenable actions, the notion row 111's transience is |",
"| **[ChewLawn1970]** K. L. Chew, S. Lawn, *Residually finite rings* (Canad. J. Math. 22 (1970) 92–101, Zbl 0215.08901) | **Listing only** (J35): its Thm 2.3 is `[LevitzMott1972]`'s Prop. 2.2 |",
"| **[BoyleLind1997]** M. Boyle, D. Lind, *Expansive subdynamics* (Trans. AMS 349 (1997) 55–102, Zbl 0863.54034; free online) | **zbMATH summary only** (J35): the vocabulary of FS-98's reading (T-B1's ultrametric obstruction as the archimedean/non-archimedean split); not a transferable theorem |",
"| **[EinsiedlerLindMiles2001]** M. Einsiedler, D. Lind, R. Miles, *Expansive subdynamics for algebraic actions* (Ergodic Theory Dynam. Systems 21 (2001) 1695–1729, Zbl 1003.37003; arXiv:math/0104261) | **Review only** (J35): expansiveness decided by amoebas at archimedean and non-archimedean places — FS-98's reading; not held (free online) |",
"| **[Zaks1989]** J. Zaks, *On four-colourings of the rational four-space* (Aequationes Math. 37 (1989) 259–266, doi 10.1007/BF01836448, Zbl 0705.05033) | **Reviewer's text only** (J28, J35): in every four-colouring of `G(ℚ⁴)` every colour class is everywhere dense — FS-99's control and its first reading; not held (Kooshi's fetch; GDZ refused a scripted fetch) |",
"| **[Bergelson1985]** V. Bergelson, *Sets of recurrence of `ℤ^m`-actions and properties of sets of differences in `ℤ^m`* (J. London Math. Soc. (2) 31 (1985) 295–304, Zbl 0579.10029) | **Listing only** (J35): the intersectivity lemma, R88-B2-2's method; an optional fetch |",
"| **[AsgarliYip2022]** / **[Yip2026]** S. Asgarli, C. H. Yip (Zbl 1496.05068); C. H. Yip (Zbl 1584.05083) — maximum cliques in Cayley graphs over finite fields with multiplicative connection sets | **Listings only** (J28 §PA.2): the finite analogue of R88-TC-count's equality case (subspaces) |",
"| **[ExooIsmailescu2016]** G. Exoo, D. Ismailescu, *Small order triangle-free 4-chromatic unit distance graphs* (Zbl 1362.05039) | **Listing only** (J28): bears on stage Y1's realisation question (FS-90 (c)); not held |",
"| **[Yu2022]** Yu, *Times two, three, five orbits on `𝕋²`* (Zbl 1495.37039) | **Listing only** (J28): closed-set ×p×q rigidity on a torus, row 95's neighbour |",
"| **[Rudolph1990]** / **[JohnsonA1992]** / **[Host1995]** D. Rudolph (1990); A. Johnson (1992; initials unchecked — **not** `[Johnson1992]`, P. D. Johnson Jr.'s two-colouring paper); B. Host (1995) — measure rigidity for ×p×q at positive entropy | **Listings only** (J28 §PA.4): what FS-97's (R2) would cite |",
"| **[GodsilEtAl2019]** C. Godsil, D. E. Roberson, B. Rooney, R. Šámal, A. Varvitsiotis, *Graph homomorphisms via vector colorings* (European J. Combin. 79 (2019), doi 10.1016/j.ejc.2019.04.001; arXiv:1610.10002) | **Negative for FS-67** (abstract read, full text grepped for products, J40, 2026-09-25): homomorphisms and cores, no product statement. Held: `library/pdf/arXiv-1610.10002-godsil-et-al-graph-homomorphisms-vector-colorings.pdf` |",
"| **[Tardif2006alg]** C. Tardif, *On the algorithmic aspects of Hedetniemi's conjecture* (Topics in Discrete Mathematics, Algorithms Combin. 26, Springer 2006, Zbl 1114.05040) | **Listing only** (J40): an algorithm from a 3-colouring of a product to one of a factor — DB-1's second decider (FS-67's stub); not held |",
"| **[Tardif2022frac]** C. Tardif, *Counterexamples to Hedetniemi's conjecture with large fractional chromatic numbers* (Graphs Combin. 38 (2022) Paper 171, doi 10.1007/s00373-022-02576-x) | **Listing only** (J40): DD-2's first reading (a regular Hedetniemi factor); not held |",
"| **[LaroseTardif2000]** B. Larose, C. Tardif, *Hedetniemi's conjecture and the retracts of a product of graphs* (Combinatorica 20 (2000) 531–544, doi 10.1007/s004930070006) | **Listing only** (J40's citation walk of Duffus–Sands–Woodrow); not held |",
"| **[SauerZhu1992]** N. W. Sauer, X. Zhu, *An approach to Hedetniemi's conjecture* (J. Graph Theory 16 (1992) 423–436, doi 10.1002/jgt.3190160504) | **Listing only** (J40): the FS-67 brief's \"Sauer 1992\" is this paper; not held |",
"| **[Sauer2001]** N. Sauer, *Hedetniemi's conjecture — a survey* (Discrete Math. 229 (2001) 261–292, doi 10.1016/S0012-365X(00)00213-2; Elsevier open archive, blocked to scripts) | **Listing only** (J40): a pre-2019 survey, cannot state `B(n)`'s failure; for Kooshi (a browser save) |",
"| **[Zhu1998survey]** X. Zhu, *A survey on Hedetniemi's conjecture* (Taiwanese J. Math. 2(1) (1998) 1–24, doi 10.11650/twjm/1500406890; free at Project Euclid, which returns HTML to a script) | **Listing only** (J40); FS-67's close proposed it as `[Zhu1998]`, which is the distance-graph paper's key; for Kooshi (a browser save) |",
"| **[DuffusSauer2005]** D. Duffus, N. W. Sauer, *Chromatic numbers and products* (Discrete Math. 300 (2005) 91–99; Elsevier open archive) | **Listing only; review withheld** (J40's author listing of Duffus) |",
"| Dunbar, Hedetniemi, Hedetniemi, Jacobs, Knisely, Laskar, Rall, *Fall colorings of graphs* (2000, Zbl 0962.05020) | **Title and review** (J40): the literature's name, *fall colouring* (idomatic partition), for FS-67's gap-free colouring |",
"| Belavadi, Cameron, Hildred (2025, Zbl 1579.05061) | **Review only** (J40): states verbatim that a *frozen* colouring (isolated in the recolouring graph `R_k(G)`) is a *fall* colouring — FS67-L1's identification |",
"| S. Špacapan, *On 3-colorings of direct products of graphs* (Discuss. Math. Graph Theory 39 (2019) 391–413, doi 10.7151/dmgt.2085) | **Abstract and reference list only** (J40, via the Wayback Machine): its subject is the 3-independence number `α₃(G × H)`, not colourings pulled back from a factor — a negative for FS-67's result 1 and Lemma W |",
"| M. Valencia-Pabon (2010); S. Klavžar, G. Mekiš (2011) — idomatic partitions of direct products of complete graphs | **Titles only; reviews withheld** (J40) |",
]
insert_after(lambda l: l.startswith("| **[MacVicar2023]**"), C, "after [MacVicar2023]")
# ---- § B held files ----
Bh = [
"| `pdf/BergelsonMoragues2021-ergodic-correspondence-invariant-means.pdf` | `[BergelsonMoragues2021]` | read: §1, §2 to Prop. 2.7 (2026-09-25, J35) |",
"| `pdf/ChenDai2017-minimal-center-attraction-amenable.pdf` | `[ChenDai2017]` | read: §1, §2.3 (2026-09-25, J35) |",
"| `pdf/LevitzMott1972-rings-finite-norm-property.pdf` | `[LevitzMott1972]` | read: §2 in full (2026-09-25, J35) |",
"| `pdf/Csernak2023-trivial-coloring-products.pdf` | `[Csernak2023]` | read: abstract, §1–§3; §6 by grep (2026-09-25, J40) |",
"| `pdf/arXiv-1610.10002-godsil-et-al-graph-homomorphisms-vector-colorings.pdf` | `[GodsilEtAl2019]` | abstract; full text grepped for products (2026-09-25, J40) |",
]
insert_after(lambda l: l.startswith("| `pdf/BrakensiekDavies2024-"), Bh, "after BrakensiekDavies2024's held file")
t = "\n".join(L)
p.write_text(t, encoding="utf-8")
print(f"PASS; net {len(t.encode()) - len(t0.encode()):+d} bytes; {len(A)} § A rows, {len(C)} § C rows, {len(Bh)} § B rows")
