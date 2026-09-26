"""J24 stage 5: BIBLIOGRAPHY.md — the closes' proposals (J23p §C.3 and §C.2, M1 4.8, M2 4f with J17's §3.4 updates, M3 R4.Bib superseded
by J23cpa Stage 6, J26 §4.4's Ambrus merge, J29 §3.1 verdict 4). Read statuses are the reading records' own, never upgraded.
Run: python3 data/crunch-2026-09-25/j24/bib_apply.py [--dry] [--plant]"""
import sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
DRY = '--dry' in sys.argv or '--plant' in sys.argv
F = ROOT / 'BIBLIOGRAPHY.md'; T = F.read_text(); T0 = T
errors = []
def rep(old, new, tag):
    global T
    n = T.count(old)
    if n != 1: errors.append(f'{tag}: anchor occurs {n}: {old[:70]!r}'); return
    T = T.replace(old, new)
def line_with(prefix):
    ls = [l for l in T.split('\n') if l.startswith(prefix)]
    if len(ls) != 1: errors.append(f'line {prefix[:50]}: {len(ls)}'); return None
    return ls[0]
def append_cell(prefix, col, text, tag):
    l = line_with(prefix)
    if l is None: return
    c = l.split(' | ')
    last = col == len(c) - 1
    v = c[col][:-2].rstrip() if last else c[col]
    c[col] = v.rstrip() + text + (' |' if last else '')
    rep(l, ' | '.join(c), tag)
# ---------- § A: new rows, after [Zhu1998]
A = [
 "| **[Manners2015]** | F. Manners, *A solution to the pyjama problem*, Invent. Math. (2015), doi 10.1007/s00222-014-0571-7, Zbl 1332.52009, arXiv:1305.1514 | **Lemma 5.3 is band rigidity (`LEDGER.md` row 98) for `ℤ[i][1/P₅, 1/P₁₃]`**: the band condition is his *pyjama* condition; §5.5 asserts the one-prime failure (row 102 proves it in band form); `[MalikiosisMatolcsiRuzsa2013]`'s rational obstructions are our torsion band characters (FS-91's close gate, `plans/FS91-PA-close.md` §1.3; FS-93) | `library/pdf/Manners2015-solution-pyjama-problem.pdf` | **read: §1–§5 in full; §6.4–6.5 in part**; §6.1–6.3, §7, App. A not read (2026-09-25, J23p) |",
 "| **[Wang2012]** | Z. Wang, *Rigidity of commutative non-hyperbolic actions by toral automorphisms*, Ergodic Theory Dynam. Systems 32 (2012) 1752–1782, doi 10.1017/S0143385711000484, Zbl 1278.37007, arXiv:1101.0321 | the torus form of row 98 with an isometric direction (Thms 1.8, 1.10); Prop. 4.3 with Lemma 4.2 is FS89-PA-B2's architecture | `library/pdf/Wang2012-rigidity-commutative-non-hyperbolic-toral.pdf` | read: abstract, §1, §2.3, §4.1, the start of §4.2 (2026-09-25, J23p) |",
 "| **[EinsiedlerLindenstrauss2022]** | M. Einsiedler, E. Lindenstrauss, *Rigidity properties for commuting automorphisms on tori and solenoids*, Ergodic Theory Dynam. Systems (2022), arXiv:2101.11120 | p. 3: the solenoid form of Wang's classification \"does not seem to have been written\"; Manners's lemma is its special case (row 98's prior art) | `library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` | read: §1, pp. 1–3 (2026-09-25, J23p; FS-89 had the abstract) |",
 "| **[KravitzLeng2025]** | N. Kravitz, J. Leng, *Quantitative pyjama*, arXiv:2510.17744 (2025) | effective Manners: torsion orders `≤ exp exp exp(ε^{−C})` — an effective `N_k` on the half ring, where row 98's `N_k` is non-effective (FS-93) | `library/pdf/KravitzLeng2025-quantitative-pyjama.pdf` | read: abstract, §1 pp. 1–3 (2026-09-25, J23p) |",
 "| **[MalikiosisMatolcsiRuzsa2013]** | R. D. Malikiosis, M. Matolcsi, I. Z. Ruzsa, *A note on the pyjama problem*, European J. Combin. (2013), Zbl 1292.52016, arXiv:1211.6138 | no periodic (rational) covering for `ε < 1/3`: torsion band characters as obstructions (row 98's prior art) | not held | abstract |",
 "| **[BarajasSerra2008]** | J. Barajas, O. Serra, *The lonely runner with seven runners*, Electron. J. Combin. 15 (2008), Zbl 1206.11030, arXiv:0710.4495 | **defines the regular chromatic number**, which is `χ_char` of a circulant or distance graph (rows 100–101; G77) | `library/pdf/BarajasSerra2008-lonely-runner-seven-runners.pdf` | read: abstract, §1 (2026-09-25, J23p) |",
 "| **[BarajasSerra2009]** | J. Barajas, O. Serra, *On the chromatic number of circulant graphs*, Discrete Math. (2009), Zbl 1213.05064 (DOI not looked up) | regular colourings of circulants (rows 100–101's vocabulary) | not held (§ R.4) | not read (zbMATH withholds the text) |",
 "| **[Muchnik2005]** | R. Muchnik, *Semigroup actions on `T^n`*, Geom. Dedicata 110 (2005), doi 10.1007/s10711-004-4321-7, Zbl 1071.37008 | an isometric-direction generalisation of Berend (per `[Manners2015]`); **decides whether row 98 is in print** (FS-93) | not held (§ R.4) | not read |",
 "| **[BosioVivaldi2000]** | D. Bosio, F. Vivaldi, *Round-off errors and p-adic numbers*, Nonlinearity 13 (2000), doi 10.1088/0951-7715/13/1/315, Zbl 1009.65077 | the coding of discretized rotations beside row 102's nine-rotation model (FS-94) | not held (§ R.4) | author summary only (J23p) |",
 "| **[Vivaldi2006]** | F. Vivaldi, *The arithmetic of discretized rotations*, in *p-adic Mathematical Physics*, AIP Conf. Proc. 826 (2006), doi 10.1063/1.2193120, Zbl 1152.37329 | a survey of row 102's neighbourhood (FS-94) | not held (§ R.4) | author summary only (J23p) |",
 "| **[AdlerKitchensTresser2001]** | R. Adler, B. Kitchens, C. Tresser, *Dynamics of non-ergodic piecewise affine maps of the torus*, Ergodic Theory Dynam. Systems 21 (2001), doi 10.1017/S0143385701001468, Zbl 1055.37048 | substitution and odometer codings beside row 102's S-adic subshift (FS-94) | not held (§ R.4) | author summary only (J23p) |",
 "| **[AkiyamaPetho2013]** | S. Akiyama, A. Pethő, *Discretized rotation has infinitely many periodic orbits*, Nonlinearity (2013), arXiv:1206.3868 | row 102's neighbourhood (periodic orbits of discretized rotations; FS-94) | not held (arXiv, not downloaded) | author summary only (J23p) |",
 "| **[GrytczukKozikMicek2013]** | J. Grytczuk, J. Kozik, P. Micek, *New approach to nonrepetitive sequences*, Random Struct. Algorithms 42(2) (2013) 214–225, doi 10.1002/rsa.20411, Zbl 1349.68131, arXiv:1103.3809 (checked against zbMATH 2026-09-25, `data/crunch-2026-09-25/j24/zbmath-grytczuk-kozik-micek.json`) | the entropy-compression method of FS91-J13-T6 (J13's route to `MS₄({5})` false, row 102), cited there from memory | not held | not read |",
 "| **[Shimura1964]** | G. Shimura, *Arithmetic of unitary groups*, Ann. of Math. (2) 79 (1964) 369–409, doi 10.2307/1970551, Zbl 0144.29504 (checked against zbMATH 2026-09-25) | possible prior art for Lemma C/C′ (the completed unit-vector ring, row 100; FS-47); undecided at FS-91's close gate | not held (§ R.4; JSTOR) | not read |",
 "| **[Snyder2000]** | N. Snyder, *An alternate proof of Mason's theorem*, Elem. Math. 55, no. 3 (2000) 93–94, Zbl 1031.11012 | the proof of Mason–Stothers that J17's Lemma NP reproduces (row 107; `plans/M2-derivation.md`) | not held | the zbMATH record read (`data/m2/j23b/zbmath-snyder.json`, 2026-09-25, J23b); the paper not read |",
 "| **[Zhu2021]** | X. Zhu, *Relatively small counterexamples to Hedetniemi's conjecture*, J. Combin. Theory Ser. B 146 (2021) 141–150, doi 10.1016/j.jctb.2020.09.005, arXiv:2004.09028, Zbl 1457.05095 | M3's J21-NG2: the ratio-only counterexample at 125 colours (`F[K₄₁]`, `F` Exoo's 83-vertex circulant; row 109) | `library/pdf/arXiv-2004.09028-zhu-relatively-small-counterexamples-hedetniemi.pdf` (fetched 2026-09-25, J23c) | read: §3 Theorem 3's statement and construction, §4's remarks on `p` (Exoo's 83-vertex graph, `α = 27`, personal communication); the proof not read |",
 "| **[AlonDinurFriedgutSudakov2004]** | N. Alon, I. Dinur, E. Friedgut, B. Sudakov, *Graph products, Fourier analysis and spectral techniques*, GAFA 14(5) (2004) 913–940, doi 10.1007/s00039-004-0478-3, Zbl 1056.05104 | maximum and near-maximum independent sets of weak (= categorical) powers `H^n` under Hoffman tightness are dictatorships, with stability; the printed form of the cylinder lemma J21-NG1 refutes above the near-maximum range (row 109) | `library/pdf/AlonDinurFriedgutSudakov2004-graph-products-fourier-spectral.pdf` (authors' preprint, 21 Oct 2003) | read: abstract, §1, §4.1, §4.2, §5, §5.1 to Kneser, §6; §2–§4 statements only (2026-09-25, J23cpa) |",
 "| **[TardifWrochna2019]** | C. Tardif, M. Wrochna, *Hedetniemi's conjecture and strongly multiplicative graphs*, SIAM J. Discrete Math. 33(4) (2019), Zbl 1427.05090, arXiv:1808.04778 | multiplicative and strongly multiplicative **targets** — odd cycles, square-free graphs, graphs with every edge in at most one square (**the Moser spindle among them**), cubes of girth-`> 12` graphs; Thm 2 answers FS-67 for maps into the Moser spindle | `library/pdf/TardifWrochna2019-hedetniemi-strongly-multiplicative.pdf` (arXiv v1) | read: abstract, §1, §2.1–2.2; the theorem statements of §3–§6 and App. A–B (2026-09-25, J23cpa) |",
 "| **[PakVilenchik2013]** | I. Pak, D. Vilenchik, *Constructing uniquely realizable graphs*, Discrete Comput. Geom. 50(4) (2013) 1051–1071, doi 10.1007/s00454-013-9545-6, Zbl 1280.05092 | Thm 3: `λ(H) < r/(k−1)` ⟹ `K_k ⊗ H` uniquely `k`-colourable and uniquely vector `k`-colourable — the printed home of the mixing selection's threshold, first factor `K_k` only (row 109) | `library/pdf/PakVilenchik2013-constructing-uniquely-realizable-graphs.pdf` (authors' copy via the Wayback Machine) | read: abstract, §1.2, Thms 1–3 statements, §8 (2026-09-25, J23cpa) |",
 "| **[BrakensiekDavies2024]** | J. Brakensiek, S. Davies, *Robust factorizations and colorings of tensor graphs*, SIAM J. Discrete Math. 38(1) (2024) 883–916, doi 10.1137/23M1552474, Zbl 1533.05210, arXiv:2207.08913 | 3-colouring graphs ε-near `K₃ × G`, polynomial when `G` is an edge expander (Thm 1.2), NP-hard in general — a neighbour of the mixing selection (row 109) | `library/pdf/BrakensiekDavies2024-robust-factorizations-colorings-tensor-graphs.pdf` (arXiv v2) | read: abstract, §1–§1.1, §1.3.3, §5's \"Extending past `K3`\" (2026-09-25, J23cpa) |",
 "| **[Spacapan2011]** | S. Špacapan, *The k-independence number of direct products of graphs and Hedetniemi's conjecture*, European J. Combin. 32(8) (2011) 1377–1383, doi 10.1016/j.ejc.2011.07.002, Zbl 1284.05204 | the one unread listing that could hold a density form of the mixing selection's finite case (row 109's prior art is undecided only here) | not held (§ R.4; not on arXiv; review withheld) | not read |",
 "| **[KechrisSoleckiTodorcevic1999]** | A. S. Kechris, S. Solecki, S. Todorčević, *Borel chromatic numbers*, Adv. Math. 141 (1999) 1–44, doi 10.1006/aima.1998.1771 | §6 (E), (F), for completeness of the Borel-product row of row 109 (per `[KechrisMarks2020]`) | not held (§ R.4, low) | not read |",
 "| **[KrivelevichSudakov2006]** | M. Krivelevich, B. Sudakov, *Pseudo-random graphs* (2006) | the expander mixing lemma's attribution for the mixing selection's part (C) (row 109) | not held (openly available; not fetched) | not read |",
 "| **[Johnson1996fcn]** | P. D. Johnson Jr., *About two definitions of the fractional chromatic number*, Zbl 0856.05036 | the LP and set-colouring definitions agree when finite; open problems on infinite graphs — owed before FS-84's S1 relies on its invariant-measure lemma (`plans/FS84-five-colours-47.md` §3.1) | not held | not read — zbMATH listing only (J29) |",
 "| **[Johnson2000surprises]** | P. D. Johnson Jr., *Infinite graphs and the fractional chromatic number: some recent surprises*, Zbl 0945.05021 | an infinite graph's `χ_f` against its finite subgraphs' — the step FS-84's S1 takes by amenability; owed before S1 relies on it (J29) | not held | not read — zbMATH listing only (J29) |",
 "| **[JohnsonRodger2005]** | P. D. Johnson Jr., C. A. Rodger, *Coloring the vertices of a graph with measurable sets in a probability space*, Zbl 1059.05050 | measurable (set-valued) colourings — owed before FS-84's S1 (J29) | not held | not read — zbMATH listing only (J29) |",
 "| **[Johnson2011rational]** | P. D. Johnson Jr., *Euclidean distance graphs on the rational points*, Zbl 1243.05082 | a survey of `χ(ℚⁿ, {d})`, beside `[Johnson2006]` | not held | not read — zbMATH listing only (J29) |",
]
anchor = line_with('| **[Zhu1998]**')
if '--plant' in sys.argv: anchor = 'PLANTED'
if anchor: rep(anchor, anchor + '\n' + '\n'.join(A), '§ A insert')
# ---------- § A: updates
append_cell('| **[Madore2015]**', 4, " ¶5.4 re-read 2026-09-25 (J17): the step from `ℚ^{r−alg}` to number fields is not written (one line); 'decidability' stands for completeness; footnote 5 cites Soifer's Problem 11.1 and Benda–Perles. **Prop. 3.2 read** (p. 6 of the held PDF, 2026-09-25, M2's close): route C's valuation lemma (`RouteC.unitQuadrance_colorable_of_valuationSubring`, row 104) is its `d = 2` case, and its proof's first paragraph is J04-H1.", 'Madore')
append_cell('| **[Soifer2024]**', 2, " Ch. 11's Open Problem 11.1, verbatim: *\"Find a countable subset C of the set of real numbers R such that the chromatic number χ(C²) is equal to the chromatic number χ(E²) of the plane. The set of all algebraic numbers would work, but it would not advance our search for the chromatic number of the plane.\"* — its comment asserted, not proved (J17, `plans/M2-S1D-bridge.md`; the bridge is `[Madore2015]` ¶5.4's, row 107).", 'Soifer')
append_cell('| **[BendaPerles2000]**', 2, " `[Fischer1990]`'s introduction credits them with noting that finite algebraic extensions suffice for `χ(ℝ²)` (the bridge, row 107); zbMATH's review is withheld (\"contents unavailable due to conflicting licenses\") (J17).", 'BendaPerles')
append_cell('| **[Parts2020hv]**', 2, " §3's stripe lemma is kernel-checked (M2, `Proofs/HadwigerNelson/Stripe.lean`, `striped_of_proper_nt0`; row 106).", 'Parts2020hv')
append_cell('| **[Polymath16]**', 2, " The fourth thread holds Mixon's MCNP ≥ 6 criterion (5 May 2018): a five-colour forced `{1,2}`-vertex at an irrational angle proves `χ_µ(ℝ²) ≥ 6` (M3 plan §PA.1 row 4; FS-49).", 'Polymath16')
append_cell('| **[GodsilEtAl2020]**', 4, "; §1.1–§1.3, §2.3 (Thm 2.12 with proof), §4.1 Cor. 4.4 to Lemma 4.5 read (2026-09-25, J23cpa); the two held copies are byte-identical", 'GodsilEtAl2020')
append_cell('| **[Tardif2008]**', 4, "; §3 and §6.1 read in full (2026-09-25, J23cpa); Thm 3.2 [14] is the citation for Burr–Erdős–Lovász's `χ(G × K_n) = min(χ(G), n)` (row 109)", 'Tardif2008')
append_cell('| **[Johnson2000]**', 2, " **Gates `CLOSED-QUESTIONS.md` §2.6** (Fischer's question, answered at `L ≤ 4` over every real number field, row 99): unread, it is the paper that could hold the answer.", 'Johnson2000')
append_cell('| **[Johnson2006]**', 2, " **Gates `CLOSED-QUESTIONS.md` §2.6** with `[Johnson2000]`.", 'Johnson2006')
# ---------- J26 §4.4: one row for the Ambrus paper
old188 = line_with('| **[AmbrusEtAl2024]** / **[Ambrus2023]**')
old259 = line_with('| **[AmbrusEtAl2023]** |')
if old188 and old259:
    new259 = ("| **[AmbrusEtAl2023]** / **[AmbrusEtAl2024]** / **[Ambrus2023]** | G. Ambrus, A. Csiszárik, M. Matolcsi, D. Varga, P. Zsámboki, *The density of planar sets avoiding unit distances*, arXiv:2207.14179 (v3, 28 Jul 2023); Math. Program. **207** (2024), no. 1–2, 303–327, DOI 10.1007/s10107-023-02012-9 (first online 6 Oct 2023; checked against Crossref 2026-09-25). arXiv v3's comment reads 'Final version, to appear in Mathematical Programming'; the published text is paywalled here, and its one supplementary file is byte-identical to the authors' notebook PDF | FS-50 §PA. **Theorem 1: `m₁(ℝ²) ≤ 0.2470`**, by the full inclusion–exclusion of a point set `X` (Lemma 1: the atoms `a_X(ε) ≥ 0`, zero on non-independent atoms, summing to 1, with `Σ_{ε∋i} = f(0)` and `Σ_{ε∋i,j} = f(x_i − x_j)`), a 23-point set `X₂₃`, and the Fourier side of §5 — Corollary 1 reads the fractional-chromatic bound as the same LP. The finite-plane form (`fplane_lp.atoms_feasible`) adds nothing beyond Lemma 3.2 (2) at 11, 23 or 83 on 10–19-point sets. Croft 1967's 0.22936 > 1/5 restated — the density route can never certify measurable χ ≥ 6 (G43). It introduced the **geometric** fractional chromatic number (Definition 2). Its §9 remarks that \"X23 is a subset of the ring R2 spanned by the vertices of the Moser spindle (see [PM22]) … a surprising observation considering that our search was not restricted to this ring\" — a claim about their own `X₂₃` and the ring `R₂`, not the lattice. With `[Bellitto2021]`'s earlier bounds it is the fractional/density state of the art the `χ_f(K²)` bracket sits inside; row 92's real places rest on Theorem 1. Certificate and checker: `data/pa-ambrus2023/` (authors' page https://static.renyi.hu/ai-shared/daniel/unit-distances/, via bit.ly/unit-distances; no licence stated); **re-checked by J26**, `plans/PA-ambrus2023-audit.md` | `pdf/arXiv-2207.14179-ambrus-csiszarik-matolcsi-varga-zsamboki-density-planar-sets.pdf` | **read — §1–§9 in full, with the proofs of Lemmas 1–2, Corollaries 1–2 and Proposition 1; Tables 1–2 not line by line** (J26, 2026-09-25); the authors' verification notebook read in full |")
    rep(old259, new259, 'Ambrus merged row')
    rep(old188 + '\n', '', 'Ambrus row 188 deleted')
b461 = line_with('| `pdf/arXiv-2207.14179-ambrus')
if b461:
    c = b461.split(' | '); c[2] = "read — §1–§9 in full, with the proofs of Lemmas 1–2, Corollaries 1–2 and Proposition 1; Tables 1–2 not line by line (J26, 2026-09-25); the authors' notebook read in full |"
    rep(b461, ' | '.join(c), 'Ambrus § B')
# ---------- § B: the held files
Bl = [
 "| `pdf/Manners2015-solution-pyjama-problem.pdf` | `[Manners2015]` | read: §1–§5 in full; §6.4–6.5 in part (2026-09-25, J23p) |",
 "| `pdf/Wang2012-rigidity-commutative-non-hyperbolic-toral.pdf` | `[Wang2012]` | read: abstract, §1, §2.3, §4.1, the start of §4.2 (2026-09-25, J23p) |",
 "| `pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` | `[EinsiedlerLindenstrauss2022]` | read: §1, pp. 1–3 (2026-09-25, J23p) |",
 "| `pdf/KravitzLeng2025-quantitative-pyjama.pdf` | `[KravitzLeng2025]` | read: abstract, §1 pp. 1–3 (2026-09-25, J23p) |",
 "| `pdf/BarajasSerra2008-lonely-runner-seven-runners.pdf` | `[BarajasSerra2008]` | read: abstract, §1 (2026-09-25, J23p) |",
 "| `pdf/arXiv-2004.09028-zhu-relatively-small-counterexamples-hedetniemi.pdf` | `[Zhu2021]` | read: §3 Theorem 3's statement and construction, §4's remarks (2026-09-25, J23c) |",
 "| `pdf/AlonDinurFriedgutSudakov2004-graph-products-fourier-spectral.pdf` | `[AlonDinurFriedgutSudakov2004]` | read: abstract, §1, §4.1, §4.2, §5, §5.1 to Kneser, §6; §2–§4 statements only (2026-09-25, J23cpa) |",
 "| `pdf/TardifWrochna2019-hedetniemi-strongly-multiplicative.pdf` | `[TardifWrochna2019]` | read: abstract, §1, §2.1–2.2; theorem statements of §3–§6, App. A–B (2026-09-25, J23cpa) |",
 "| `pdf/PakVilenchik2013-constructing-uniquely-realizable-graphs.pdf` | `[PakVilenchik2013]` | read: abstract, §1.2, Thms 1–3 statements, §8 (2026-09-25, J23cpa) |",
 "| `pdf/arXiv-1801.08243-godsil-roberson-rooney-samal-varvitsiotis-vector-coloring-categorical-product.pdf` | `[GodsilEtAl2020]` | byte-identical to `pdf/arXiv-1801.08243.pdf` (J23cpa, 2026-09-25); read status on that line |",
 "| `pdf/BrakensiekDavies2024-robust-factorizations-colorings-tensor-graphs.pdf` | `[BrakensiekDavies2024]` | read: abstract, §1–§1.1, §1.3.3, §5's \"Extending past `K3`\" (2026-09-25, J23cpa) |",
]
lastB = line_with('| `pdf/EggletonErdosSkilton1985-colouring-the-real-line.pdf`')
if lastB: rep(lastB, lastB + '\n' + '\n'.join(Bl), '§ B insert')
for p in ('| `pdf/arXiv-1801.08243.pdf`', ):
    l = line_with(p)
    if l:
        c = l.split(' | '); c[-1] = c[-1][:-2].rstrip() + "; §1.1–§1.3, §2.3, §4.1 Cor. 4.4 to Lemma 4.5 read (2026-09-25, J23cpa) |"; rep(l, ' | '.join(c), 'GRRSV § B')
# ---------- § C: listing rows
C_anchor = line_with('| **[Payan1992]**')
Crows = [
 "| **[LangbergVilenchik]** M. Langberg, D. Vilenchik, *Edge distribution in generalized graph products* (arXiv:1211.1467) | **Negative for the mixing selection** (abstract read, 2026-09-25, J23cpa, `plans/M3-PA-mixing.md` Stage 5) |",
]
if C_anchor: rep(C_anchor, C_anchor + '\n' + '\n'.join(Crows), '§ C insert')
# ---------- § R.4: the paywalled fetches
r4 = line_with('| 15 | **[EggletonErdosSkilton1990]**')
R4 = [
 "| 16 | **[Muchnik2005]** — R. Muchnik, *Semigroup actions on `T^n`*, Geom. Dedicata 110 (2005) | doi 10.1007/s10711-004-4321-7 · zbMATH 1071.37008 | Decides whether band rigidity at every band (`LEDGER.md` row 98) is in print (FS-93) | not held (J23p's fetch list, `plans/FS91-PA-close.md` §C.2) |",
 "| 17 | **[Shimura1964]** — G. Shimura, *Arithmetic of unitary groups*, Ann. of Math. (2) 79 (1964) 369–409 | doi 10.2307/1970551 · zbMATH 0144.29504 (JSTOR) | Possible prior art for Lemma C/C′ (row 100; FS-47) | not held |",
 "| 18 | **[BarajasSerra2009]** — J. Barajas, O. Serra, *On the chromatic number of circulant graphs*, Discrete Math. (2009) | zbMATH 1213.05064 (DOI not looked up) | Regular colourings of circulants, `χ_char`'s vocabulary (rows 100–101) | not held |",
 "| 19 | **[Spacapan2011]** — S. Špacapan, *The k-independence number of direct products of graphs and Hedetniemi's conjecture*, European J. Combin. 32(8) (2011) 1377–1383 | doi 10.1016/j.ejc.2011.07.002 · zbMATH 1284.05204 | The one listing that could hold the mixing selection's finite case (row 109); Kooshi asked | not held |",
 "| 20 | The discretized-rotation group: **[BosioVivaldi2000]** (Nonlinearity 13, doi 10.1088/0951-7715/13/1/315), **[Vivaldi2006]** (AIP Conf. Proc. 826, doi 10.1063/1.2193120), **[AdlerKitchensTresser2001]** (ETDS 21, doi 10.1017/S0143385701001468); and, low, **[KechrisSoleckiTodorcevic1999]** (Adv. Math. 141, doi 10.1006/aima.1998.1771) | see each § A row | Row 102's neighbourhood (FS-94); the Borel-product row of row 109 | not held |",
]
if r4: rep(r4, r4 + '\n' + '\n'.join(R4), '§ R.4 insert')
# ---------- rule 0e: the partial reads
rep("`[Polymath16threads]` (searched in full, key passages read).", "`[Polymath16threads]` (searched in full, key passages read); and, from the 2026-09-25 crunch's closes, `[Manners2015]`, `[Wang2012]`, `[EinsiedlerLindenstrauss2022]`, `[KravitzLeng2025]`, `[BarajasSerra2008]`, `[Zhu2021]`, `[AlonDinurFriedgutSudakov2004]`, `[TardifWrochna2019]`, `[PakVilenchik2013]`, `[BrakensiekDavies2024]`, `[GodsilEtAl2020]`, `[Tardif2008]`.", 'rule 0e')
if errors:
    print('ERRORS:'); [print(' ', x) for x in errors]; sys.exit(1)
print(f'BIBLIOGRAPHY.md {len(T0.encode())} -> {len(T.encode())} bytes; § A +{len(A)}, § B +{len(Bl)}, § R.4 +{len(R4)}')
if not DRY: F.write_text(T)
