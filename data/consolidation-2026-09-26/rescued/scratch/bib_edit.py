import re, sys
p = '/home/kooshi/source/lean-dir/BIBLIOGRAPHY.md'
s = open(p, encoding='utf-8').read()

def rep(old, new, count=1):
    global s
    n = s.count(old)
    assert n == count, (n, old[:120])
    s = s.replace(old, new)

# ---- B1: [deGrey2018] copy column ----
rep("| rung B (the 1,581-vertex witness, kernel-certified, M06–M09); the anatomy G1–G10, G27, G31; the forced pairs of the 791-forcer | not held (arXiv) | read (earlier sessions) |",
    "| rung B (the 1,581-vertex witness, kernel-certified, M06–M09); the anatomy G1–G10, G27, G31; the forced pairs of the 791-forcer | `library/pdf/deGrey2018-chromatic-number-plane-at-least-5.pdf` (arXiv:1804.02385v3, 30 May 2018; saved 2026-09-25 from a scratch copy) | read (earlier sessions) |")

# ---- B3: [Polymath16wiki] copy column ----
rep("the 2026 capture's HTML at `library/notes/polymath16-algebraic-formulation-2018-snapshot-20260512.html` |",
    "the 2026 capture's HTML at `library/notes/polymath16-algebraic-formulation-2018-snapshot-20260512.html`; two of the asone.ai captures FS-85's input audit compared, one of 2021 and the one of 2022, at `library/notes/polymath16-algebraic-formulation-2021-snapshot.html` and `…-2022-snapshot.html` (saved 2026-09-25 from FS-85's scratch; both carry revision 10839, the revision read, and were not re-read) |")

# ---- EES 1990: DOI, abstract, the 1985 paper kept apart ----
rep("| **[EggletonErdosSkilton1990]** | R. B. Eggleton, P. Erdős, D. K. Skilton, *Colouring prime distance graphs*, Graphs Combin. 6 (1990) 17–32; zbMATH 0698.05033 |",
    "| **[EggletonErdosSkilton1990]** | R. B. Eggleton, P. Erdős, D. K. Skilton, *Colouring prime distance graphs*, Graphs Combin. 6 (1990) 17–32; doi 10.1007/BF01787476; zbMATH 0698.05033. **A different paper from `[EggletonErdosSkilton1985]`** (*Colouring the real line*, J. Combin. Theory Ser. B), which is held; the periodic and aperiodic `χ(D)`-colourings below are this 1990 paper's, known through its review |")
rep("aperiodic optimal colourings coexist with periodic ones there | not held | **reviewer's review read (zbMATH, K. Engel); paper not read** |",
    "aperiodic optimal colourings coexist with periodic ones there | not held (closed access; § R.4 item 15) | **reviewer's review read (zbMATH, K. Engel); abstract read on the publisher's page (`plans/M3-S1A-rank-one.md` §1.3, 2026-09-25); paper not read** |")

# ---- § R.4 request row for the 1990 paper ----
rep("(PA-P3). Nothing rests on it alone | not held; review only |\n",
    "(PA-P3). Nothing rests on it alone | not held; review only |\n"
    "| 15 | **[EggletonErdosSkilton1990]** — R. B. Eggleton, P. Erdős, D. K. Skilton, *Colouring prime distance graphs*, Graphs Combin. 6 (1990) 17–32 | doi 10.1007/BF01787476 · zbMATH 0698.05033 | Its Theorem 2 (periodic `χ(D)`-colourings of `G(ℤ, D)`) and its aperiodic `χ(D)`-colourings are cited across FS-73, FS-79 and M3 from the review alone; M3's rank-one question wants the construction (`plans/M3-close-inventory.md` row 13). Not the held 1985 paper, `[EggletonErdosSkilton1985]` | not held; review and abstract only |\n")

# ---- B2: the three FS-85 § C rows ----
rep("A citing work of Klotz–Sander; nothing on triangle-free unique colourability |",
    "A citing work of Klotz–Sander; nothing on triangle-free unique colourability. **Held:** `library/pdf/JanssenMacKeigan2020-orthogonal-colourings-cayley-graphs.pdf` (saved 2026-09-25 from FS-85's scratch) |")
rep("Subject (strong cliques, CIS circulants) outside the question |",
    "Subject (strong cliques, CIS circulants) outside the question. **Held:** `library/pdf/Hujdurovic2020-strong-cliques-vertex-transitive-graphs.pdf` (saved 2026-09-25 from FS-85's scratch) |")
rep("(the edge-minimal uniquely n-colourable circulant, which has cliques). Nothing triangle-free |",
    "(the edge-minimal uniquely n-colourable circulant, which has cliques). Nothing triangle-free. **Held:** `library/pdf/ErskineGriggsSiran2022-clique-partitioned-graphs.pdf` (saved 2026-09-25 from FS-85's scratch) |")

# ---- new § A rows, after the last row ([Speyer2018]) ----
m = re.search(r"^\| \*\*\[Speyer2018\]\*\* .*\n", s, re.M)
assert m and s.count("| **[Speyer2018]** ") == 1
new_rows = [
"| **[EggletonErdosSkilton1985]** | R. B. Eggleton, P. Erdős, D. K. Skilton, *Colouring the real line*, J. Combin. Theory Ser. B 39 (1985) 86–100, doi 10.1016/0095-8956(85)90039-5; zbMATH 0549.05029 (errata ibid. 41 (1986) 139, not held). **A different paper from `[EggletonErdosSkilton1990]`** (*Colouring prime distance graphs*), which is not held | M3's rank-one question (FS-76 in rank one; `plans/M3-S1B-rank-one.md` §2.1, read for it): `G(ℝ, D)` and `G(ℤ, D)` for finite distance sets `D` (§6) and prime distances (§7); its colourings are explicit periodic formulas, and the periodic-versus-aperiodic statements cited under the 1990 key are not in it | `library/pdf/EggletonErdosSkilton1985-colouring-the-real-line.pdf` (a scan with an OCR layer; Kooshi's fetch, 2026-09-25) | **read: §§1–2, §6, §8 in full; §7 to Thm 16 (Thm 17's statement truncated in the OCR); §§3–5 at theorem statements (Thms 1–8)** (`plans/M3-S1B-rank-one.md` §2.1, 2026-09-25) |",
"| **[GoelPatilVerma2022]** | K. Goel, D. P. Patil, J. Verma, *Nullstellensätze and applications*, arXiv:1809.02818 (v2, 23 Feb 2022) | FS-39's bridge by the Artin–Lang route (M2, `plans/M2-S1D-bridge.md` §1.1 Q11, §2.1 route AL): Thm 3.11 (the Artin–Lang homomorphism theorem, proof referred to `[Lang1953]`), Cor. 3.12, and the definition of a real domain | `library/pdf/GoelPatilVerma2022-nullstellensatze-and-applications.pdf` (saved 2026-09-25 from a scratch copy) | **read: Thm 3.11, Cor. 3.12 and the definition of a real domain** (2026-09-25; the passage in `data/m2/j17/excerpts/goel-patil-verma-thm3.11.txt`); the rest not read |",
"| **[Lang1953]** | S. Lang, *The theory of real places*, Ann. of Math. (2) 57 (1953) 378–391, doi 10.2307/1969865; zbMATH 0052.03301 | the proof `[GoelPatilVerma2022]` Thm 3.11 refers to (the Artin–Lang route to FS-39's bridge, `plans/M2-S1D-bridge.md` §2.1) | not held | not read; cited through `[GoelPatilVerma2022]` |",
"| **[BCR1998]** | J. Bochnak, M. Coste, M.-F. Roy, *Real algebraic geometry*, Ergebnisse der Mathematik und ihrer Grenzgebiete (3) 36, Springer, Berlin (1998), transl. from the French; zbMATH 0912.14023 | §4.1, \"The Artin-Lang Homomorphism Theorem and the Real Nullstellensatz\" (p. 85 ff.), cited for the Artin–Lang step of FS-39's bridge (`plans/M2-S1D-bridge.md` §1.1 Q11) | not held; its table of contents at `data/m2/j17/bcr-toc.txt` (a Deutsche Nationalbibliothek scan) | **table of contents only**; the theorem number 4.1.2 is unverified |",
"| **[Marker2002]** | D. Marker, *Model theory: an introduction*, Graduate Texts in Mathematics 217, Springer, New York (2002), doi 10.1007/b98860; zbMATH 1003.03034 | §3.3 (real closed fields), cited through `[Zapletal2022]` for Tarski's quantifier elimination on FS-39's bridge by the Tarski route (`plans/M2-S1D-bridge.md` §2.1) | not held | not read |",
"| **[Poizat2000]** | B. Poizat, *A course in model theory: an introduction to contemporary mathematical logic*, transl. M. Klein, Universitext, Springer, New York (2000); zbMATH 0951.03002 | Thm 6.41 (Tarski), cited through `[Madore2015]` ¶5.4 for the Tarski route to FS-39's bridge (`plans/M2-S1D-bridge.md` §2.1) | not held | not read |",
"| **[Zapletal2022]** | J. Zapletal, *Coloring the distance graphs*, arXiv:2201.00275 (v1, 2 Jan 2022); with its superseded companion *Coloring the distance graphs in three dimensions*, arXiv:2103.02757 (v2, 18 Mar 2021) | Fact 4.2 (quantifier elimination for real closed fields) and Cor. 4.3 (a real closed subfield of `ℝ` is an elementary submodel), the citation for Tarski on FS-39's bridge by the Tarski route (`plans/M2-S1D-bridge.md` §2.1; the passage in `data/m2/j17/excerpts/zapletal2022-fact4.2.txt`); both papers are rational-distance graphs in choiceless set theory (§ B's verdicts) | `library/pdf/arXiv-2201.00275.pdf`, `library/pdf/arXiv-2103.02757.pdf` | **scanned — negative for prior art** (2026-09-08, FS-18; § B); **§4's Fact 4.2 and Cor. 4.3 read** (2026-09-25, M2) |",
"| **[WangKosheleva1998]** | W. Wang, O. Kosheleva, *Chromatic-number-type theorems are logically non-trivial*, Geombinatorics 8(1) (1998) 169–174; zbMATH 0915.03011 | found by M2's zbMATH gate on FS-39's bridge (`plans/M2-S1D-bridge.md` §1.3, query Q10); adjacent: by the review, the class of second-order statements `∀S P(S)` over Tarski's language (so the plane's colouring statements) is algorithmically undecidable | not held | reviewer's review read (zbMATH, V. Kreinovich; 2026-09-25) |",
"| **[CohenMahboubi2012]** | C. Cohen, A. Mahboubi, *Formal proofs in real algebraic geometry: from ordered fields to quantifier elimination*, Log. Methods Comput. Sci. 8(1) (2012), paper 2, 40 pp., doi 10.2168/LMCS-8(1:2)2012; arXiv:1201.3731; zbMATH 1241.68096 | the reference for pricing a kernel quantifier elimination for real closed fields (a Coq development), on FS-39's bridge (`plans/M2-S1D-bridge.md` §3.2, §3.4) | not held | not read |",
"| **[KechrisMarks2020]** | A. S. Kechris, A. S. Marks, *Descriptive graph combinatorics*, preliminary version, 9 October 2020 (a survey; no zbMATH document record, checked 2026-09-25) | M3's second question (FS-64 at five colours; `plans/M3-exotic-colourings.md` §PA, `plans/M3-S1D-windows-five.md` §1.1): the measurable chromatic number `χ_µ` of the plane, whose exact value the survey states unknown (Example 5.1), and Problem 4.23 (whether `χ_B(G × H) = min{χ_B(G), χ_B(H)}` for analytic graphs) | `library/pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf` | **read: §3 p. 16 (the `Φ`-chromatic numbers), §4.6, §4.7, §5.1 Example 5.1 (pp. 45–46)** (2026-09-25; M3's reframe and `plans/M3-S1D-windows-five.md` §1.1). The unit-distance passage is Example 5.1 in §5.1, **not §4.7** (§4.7 is \"Extensions\"), as M3's plan §PA.1 row 3 had it |",
"| **[Zhu1998]** | X. Zhu, *Pattern periodic coloring of distance graphs*, J. Combin. Theory Ser. B 73(2) (1998) 195–206, doi 10.1006/jctb.1998.1831; zbMATH 0904.05028 | M3's prior-art gate for FS-76 in rank one (`plans/M3-exotic-colourings.md` §PA.1 row 3, §PA.3): the distance-graph literature on periods of colourings | not held | review read only (2026-09-25) |",
]
s = s[:m.end()] + "\n".join(new_rows) + "\n" + s[m.end():]

# ---- § B: new file rows, after the HaynesMunday row (the last file row) ----
anchor = "| `pdf/HaynesMunday2013-arXiv-1303.1661.pdf` | `[HaynesMunday2013]` | §1–§2 read (2026-09-25); §3–§4 unread |\n"
assert s.count(anchor) == 1
brows = [
"| `pdf/deGrey2018-chromatic-number-plane-at-least-5.pdf` | `[deGrey2018]` | read (earlier sessions; this copy is arXiv v3, saved 2026-09-25) |",
"| `pdf/JanssenMacKeigan2020-orthogonal-colourings-cayley-graphs.pdf` | `[JanssenMacKeigan2020]` (§ C) | passage read (FS-85) |",
"| `pdf/Hujdurovic2020-strong-cliques-vertex-transitive-graphs.pdf` | `[Hujdurovic2020]` (§ C) | reference list only (FS-85) |",
"| `pdf/ErskineGriggsSiran2022-clique-partitioned-graphs.pdf` | `[ErskineGriggsSiran2022]` (§ C) | closing paragraph read (FS-85) |",
"| `notes/polymath16-algebraic-formulation-2021-snapshot.html`, `notes/polymath16-algebraic-formulation-2022-snapshot.html` | `[Polymath16wiki]` (asone.ai captures; revision 10839, the revision read) | compared at FS-85's input audit; not re-read |",
"| `pdf/GoelPatilVerma2022-nullstellensatze-and-applications.pdf` | `[GoelPatilVerma2022]` | read: Thm 3.11, Cor. 3.12, the definition of a real domain (2026-09-25, M2) |",
"| `pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf` | `[KechrisMarks2020]` | read: §3 p. 16, §4.6, §4.7, §5.1 Example 5.1 (2026-09-25, M3) |",
"| `pdf/EggletonErdosSkilton1985-colouring-the-real-line.pdf` | `[EggletonErdosSkilton1985]` | read: §§1–2, 6, 8 in full; §7 to Thm 16; §§3–5 at theorem statements (2026-09-25, M3) |",
]
s = s.replace(anchor, anchor + "\n".join(brows) + "\n")

# ---- § B: Zapletal file rows gain the key ----
rep("| `pdf/arXiv-2103.02757.pdf` | — (Zapletal; below) | scanned — negative |",
    "| `pdf/arXiv-2103.02757.pdf` | `[Zapletal2022]` (the superseded companion; verdict below) | scanned — negative |")
rep("| `pdf/arXiv-2201.00275.pdf` | — (Zapletal; below) | scanned — negative |",
    "| `pdf/arXiv-2201.00275.pdf` | `[Zapletal2022]` (verdict below) | scanned — negative; Fact 4.2 and Cor. 4.3 read (2026-09-25, M2) |")

open(p, 'w', encoding='utf-8').write(s)
print("ok")
