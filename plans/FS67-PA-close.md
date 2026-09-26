# FS-67 — the close-time prior-art gate (crunch job J40)

*De Bruijn (Opus 5.5), 2026-09-25, FS-67's prior-art reader. Brief: `data/crunch-2026-09-25/briefs/J40-FS67-prior-art-gate.md` with
`STANDING-RULES.md`. Gate: WORKFLOW 3.2's eight questions, run on the theorems J27D filed (`plans/FS67-J27D-derivation.md`, "Theorems this
phase proved"). Touches only this file, `data/fs67/j40/` and `~/source/library/pdf/`. Every negative measures its query's words (G21); nothing
here is called "new" — a statement not located is "not found by these searches". Bibliography rows and `CLOSED-QUESTIONS.md` entries below are
proposals for the front-page lane.*

## Theorems this phase proved

None. This is a reading job: its products are attributions and negatives, graded by what was read (per section, below). One small fact is
checked here by hand where a verdict needed it; it is listed in the stage that uses it with its grade.

## Stage 1 — SAVED (quotation check)

`data/fs67/j40/quotes.sh` (fixed-string `grep -F` of each quoted fragment of the brief against its source; output `quotes.out`): **7 of 7
found** — J27D's "uniquely colorable graph" and "expander" (Stage 5's prior-art debt line), "Lemma W", "is a component invariant" (theorem
row 13), DC-2's row "at `τ_k = 1/(k−1)`, `G` any `k`-gap-free graph", DA-4's row, and J27's §PA quotation of `[Tardif2008]` §4.2 "In [17] it is
proved that A(n) implies B(n) and B(n) implies H(n)." **One condensation logged:** the brief's `"uniquely colorable" × "expander"` occurs
verbatim nowhere; J27D writes it as `"uniquely colourable graph × expander"` (Stage 3, British spelling) and as separate quoted terms
(Stage 5). The condensation is faithful — same words, same scope — and the plant (`PLANT=1`, J27D's Stage-3 spelling in straight quotes, which
does not occur) exits 1, `quotes-plant.out` — the check fires. The brief's unquoted summaries of DA-3/DA-4, DC-2, Lemma W and DB-1 were
compared by eye with J27D's theorem rows 5, 6, 10, 13, 14: faithful at scope (DC-2's "with no other condition on `G`" matches J27D's "`G` any
`k`-gap-free graph", connectivity unused).

**The statements gated, verbatim from J27D's "Theorems this phase proved" table** (each stage quotes its own at full scope):
- row 5 "DA-3: `K_k × X` connected, uniquely `k`-colourable, gap-free; FS67 fails ⟺ a Hedetniemi partner of `X`"
- row 6 "DA-4: FS67 fails for a finite connected uniquely `k`-colourable `G` at every `k ≥ 4`; FS67 on that class ⟹ `H(k)`"
- row 8 "DC-1: 1-walk-regular, `χv(G) = k`, `H` connected, `χv(H) > k` ⟹ pullback"
- row 10 "DC-2 at `τ_k = 1/(k−1)`, `G` any `k`-gap-free graph, connectivity of `G` unused"
- row 11 "DC-3: which `Γ_p` (`p ≤ 103`) meet DC-1's / DC-2's hypothesis at `k = 3, 4, 5`"
- row 13 "Lemma W: `D_C(f) = D_C(g) = 3w_C(f,g)` on every arc of `K_3^G`; `D_C` is a component invariant"
- row 14 "DB-1 partial: components of `E_3(G)` with `D_C ≡ 0` for some odd `C` are 3-colourable"
- row 15 "Lemma T: Hoffman-tight at `k` ⟹ every proper `k`-colouring gap-free"
- row 16 "DB-2: `UD(𝔽₉,2)` and every tight level of `UD(ℤ₃[i]/3^j, 2)` are connected and 3-gap-free"
- row 17 "DD-1: equal `χv`, Result 5's hypothesis, `χ(H) > k`, `H` connected ⟹ pullback"
- rows 2–3 (L1, DA-2′'s characterisation) are gated with DA-3 in Stage 2, since DA-3 rests on them.

## Stage 2 — SAVED (result 1: DA-3, DA-4, with L1 and DA-2′ beneath them)

**Recognition (the query words).** The object is the *unique colourability of categorical (direct, tensor, weak) products*
(Duffus–Sands–Woodrow's `B(n)`); a "gap-free colouring" is, in two disciplines' words, a **fall colouring** / partition into independent
dominating sets (*idomatic partition*; Dunbar et al. 2000, zbl 0962.05020) and a **frozen colouring** (reconfiguration: an isolated vertex of
the recolouring graph `R_k(G)`) — a reviewer's text states the identification verbatim: "A k-colouring of a graph G is called frozen if it
is an isolated vertex in R_k(G) (in the literature, frozen colourings have also been called fall colouring, and the term indominable graph
has been used for a graph admitting a frozen colouring)" (zbl 1579.05061, review of Belavadi–Cameron–Hildred 2025). In the product
literature the same notion is **Csernák's "tight" colouring**, and a `k`-gap-free graph is his "tight graph" (below). J27D's L1 (a gap-free
proper colouring is an isolated looped vertex of `K_k^G`) is therefore *"frozen in `R_k(G)` ⟺ isolated in the exponential graph"*: a
recolouring of one vertex is an arc of `K_k^G` (checked by hand here: if `b ∉ c(N[v])`, `c` and `c[v↦b]` are adjacent in `K_k^G`), and L1 is
the converse.

**Queries** (zbMATH Open API via `data/fs67/j40/zb.py`, outputs `zb-r1a.out`; OpenAlex and Semantic Scholar citation walks via
`oa_cites.py`, `s2_cites.py`, outputs `oa-dsw.out`, `s2-dsw.out`, `oa-gl.out`; arXiv API `arx.sh`, `arxiv-{1,2}.out`; all 2026-09-25;
J27's twelve and J23cpa's thirty zbMATH queries not repeated):

| query | hits | on point |
|---|---|---|
| `ab:"uniquely" & ab:"colorable" & ab:"product"` | 4 | Zhu 1999 (uniquely `H`-colourable), Klavžar–Yeh 2002; none on `B(n)` |
| `ab:"uniquely" & ab:"colourable" & ab:"product"` | 1 | `[Larose2002]` (already a bibliography row) |
| `ab:"uniquely" & ab:"Hedetniemi"` | 9 | none (uniquely colourable planar/large-girth graphs, proceedings volumes) |
| `ab:"Greenwell" & ab:"Lovász"` (and `Lovasz`) | 12 | **Csernák 2023** (arXiv:2303.06406) and **Csernák 2024** (*On proper colorings of functions*); Larose 2002; Kun–Larose 2009 |
| `ab:"fall coloring" & ab:"product"`; `ab:"fall colouring"`; `ab:"idomatic" & ab:"product"` | 1; 2; 3 | the vocabulary (above); Valencia-Pabon 2010 and Klavžar–Mekiš 2011, *idomatic partitions of direct products of complete graphs* (titles; reviews withheld) |
| `ab:"frozen" & ab:"coloring" & ab:"product"`; `ab:"exponential graph" & ab:"coloring"` | 1 (a STOC volume); 0 | — |
| author listings (item 8): `au:"Duffus, Dwight"` (65), `au:"Woodrow, Robert E."` (46) | 111 | scanned by title: after 1985 the only product-colouring titles are Duffus–Sauer 1996 (lattices) and 2005 (*Chromatic numbers and products*, review withheld) |
| arXiv: `au:Tardif AND cat:math.CO` (15); `abs:"uniquely colourable"` (19); three phrase queries (0–4) | — | none on `B(n)` (the arXiv API's phrase matching is loose: its hits are off-topic, so these negatives are weak) |
| citing works of DSW 1985: OpenAlex 69, Semantic Scholar 71 (18 titles only in S2) | 87 distinct | every neighbourhood title checked against the held set: GRRSV 2020 (held, read below), `[Tardif2008]` (held), Zhu 1998 survey (Project Euclid, blocked by script — for Kooshi), Sauer 2001 survey (ScienceDirect OA, blocked — for Kooshi), Larose–Tardif 2000, Sauer–Zhu 1992, Duffus–Sauer 2005 (not held) |
| citing works of `[GreenwellLovasz1974]` (OpenAlex 85) and of `[Tardif2023]` (OpenAlex 3: `[Zhu2025]`'s journal version, two off-topic) | 88 | Špacapan 2019 (DMGT, below), Csernák 2023, GRRSV, Brakensiek–Davies 2024 (read by J23cpa) |

**Papers opened, and what was read.**
- `[GodsilEtAl2020]` (held, arXiv:1801.08243): **§1.3 re-read in full, §4.4 read in full (Thm 4.17 with proof)**. §1.3, verbatim: "Duffus,
  Sands, and Woodrow considered the following three parameterized statements: • (An ) : For all uniquely n-colorable graphs G and H, each
  n-coloring of G × H is induced by G or H. • (Bn ) : For all uniquely n-colorable graphs G and connected graphs H with χ(H) > n, the graph
  G × H is uniquely n-colorable. • (Cn ) : For all graphs G and H with χ(G) = χ(H) = n, we have χ(G × H) = n. … Surprisingly, Duffus,
  Sands, and Woodrow showed that (An ) ⇒ (Bn ) ⇒ (Cn+1 ) for all n. Unfortunately, they were not able to prove (An ) or (Bn ) in general,
  but only under additional restrictions, such as one of the factors being a complete graph." §4.4: "A key ingredient in the proof of
  (An ) ⇒ (Bn ) is the result of Greenwell and Lovász [8]" and "the relevant relationship between n and n + 1 for proving (Bn ) ⇒ (Cn+1 )
  is that n + 1 is the smallest value achievable by χ that is greater than n."
- `[Tardif2008]` (held): §4.2 re-read — `H(n)` is defined at l. 53 as "If G × H is n-colorable, then G or H is n-colorable", so its "B(n)
  implies H(n)" and GRRSV's "(Bn) ⇒ (Cn+1)" are the same implication (J27's reading, confirmed).
- **Csernák 2023** (arXiv:2303.06406v2, 22 Oct 2024; fetched → `~/source/library/pdf/Csernak2023-trivial-coloring-products.pdf`): abstract,
  §1–§3 in full (Defs 2.1–2.2, 3.1, Obs. 3.2, Lemma 3.5 and Theorem 3.6 with proofs, Thm 3.7), §6 (problems) by grep; §4–§5 not read. Verbatim:
  "Definition 2.2. … We say that φ is tight if, for every vertex v ∈ V (G) and every color c ≠ φ(v), there is a neighbor u of v such that
  φ(u) = c. … G is tight if all of its χ(G)-colorings are tight." — **exactly J27D's gap-free, and `k`-gap-free (which forces `χ(G) = k`)**;
  "Greenwell and Lovász has also shown, that if H is tight with χ(H) = k for some k ≥ 3, then Kk × H is trivially colorable (see [2, Theorem
  1])"; "Theorem 3.6. If G is a weakly-cliqued, connected graph, H is a tight graph with χ(G) = χ(H) = k ≥ 3 , then all k-colorings Φ of
  G × H are trivial." (weakly-cliqued: every vertex in a `k`-clique; "trivial": induced by a colouring of one factor). This is an `A(n)`-type
  statement (equal chromatic numbers, a gap-free factor), not FS-67's `B`-type (`χ(H) > k`); its Lemma 3.5 first-type argument, with GL
  Cor. 1 in place of GL Thm 1, gives FS67(G, k) for every connected weakly-cliqued `G` — a class J27D does not name.
- **Špacapan 2019** (*On 3-colorings of direct products of graphs*, DMGT 39 (2019) 391–413, doi 10.7151/dmgt.2085): its journal page
  (fetched through the Wayback Machine; the host's TLS chain is incomplete) — **abstract and reference list only**; its subject is the
  3-independence number `α₃(G × H)`, not colourings pulled back from a factor. Recorded as an abstract-level negative for result 1 and
  Lemma W; the paper itself is not read.

**Verdict — result 1, at exact scope.**

| statement | verdict | where |
|---|---|---|
| DA-3's transfer, ⟸ ("a Hedetniemi partner `H` of `X` gives a non-pulled-back `k`-colouring of `(K_k × X) × H`"), and DA-4's second clause ("FS67 on the uniquely `k`-colourable class ⟹ `H(k)`") | **in print as an implication** — DSW 1985 §3, `(B_n) ⇒ (C_{n+1})` = Tardif's "B(n) implies H(n)"; **the construction `G = K_k × X` is undecided** until DSW is read | reported verbatim by `[GodsilEtAl2020]` §1.3 and `[Tardif2008]` §4.2; GRRSV §4.4 names GL as the key ingredient of `(A_n) ⇒ (B_n)` only. That DSW's proof of `B ⇒ C` uses `K_n × X` (as J27D's does) is likely — GL Cor. 1 is the only uniquely colourable graph built from an arbitrary `X` in either source — but it is **not read**: DSW is not held |
| DA-3 (a)–(c): `K_k × X` connected, uniquely `k`-colourable, gap-free | **in print** | (a) Weichsel 1962 (classical; not re-read); (b) `[GreenwellLovasz1974]` Cor. 1 (read in full by the products reader, `plans/PA-products-GL1974-LT2002.md` §0 item 1); (c) immediate from (b) |
| DA-3 ⟹ (a non-pulled-back colouring of `(K_k × X) × H` gives `χ(X × H) ≤ k`) | **not found by these searches** as a stated converse; a two-line consequence of GL Cor. 1 applied to `K_k × (X × H)` | — |
| DA-4, first clause: "FS67 fails for a finite connected uniquely `k`-colourable `G` at every `k ≥ 4`", i.e. **`B(k)` is false for every `k ≥ 4`** | **not found by these searches as a printed sentence; in print by composition**: DSW's `B(n) ⇒ C(n+1)` (as reported) with `[Tardif2023]` Thm 1 (`C(n+1)` false for `n ≥ 4`; earlier `[Shitov2019]` for large `n`) | no citing work of `[Tardif2023]` (3 in OpenAlex) or of DSW (87 across both databases) found by title to state `B(n)`'s failure; `[Zhu2025]` (held; grep "uniquely", "Duffus": one citation line, no statement) does not mention `A(n)`/`B(n)`. So the statement is a corollary any reader of DSW and Tardif 2023 can draw; nobody found here draws it. Undecided at: Sauer 2001 and Zhu 1998 (surveys, pre-2019, cannot state it) — none can decide it; **`[Zhu2025]`'s §3 is the natural place and does not** |
| L1 (gap-free ⟹ isolated looped vertex of `K_k^G`) | **not found as a printed sentence**; its content is the standard identification *frozen = fall colouring = isolated in `R_k(G)`* (zbl 1579.05061's review, verbatim above) carried to `K_k^G` | — |
| DA-2′'s characterisation "FS67(G, k) ⟺ every proper `k`-colouring gap-free ∧ `χ(E_k(G)) ≤ k`" | **not found by these searches**; its `G = K_k` case is GL Thm 1's Case 2 (the products reader's PA-P2) and its `G = K_k^s` case is `[Larose2002]` (by review) | — |

**What this stage taught us about our own object (for the close's §PA sweep).** (1) The project's "gap" / "gap-free" (G13's fan gap, G54,
G68) has three printed names — **fall colouring**, **frozen colouring**, **tight colouring** (Csernák) — and the literature's "tight" collides
with G54's "Hoffman-tight": any write-up must say "gap-free (fall) colouring" and never "tight" unqualified. (2) FS67 holds for every
connected graph in which every vertex lies in a `k`-clique (GL Cor. 1 on each clique, glued along overlaps as in Csernák's Lemma 3.5) —
the Burr–Erdős–Lovász class; a derivation-grade observation for the close, not checked here beyond reading the two proofs it combines.
