ROOT="/home/kooshi/source/lean-dir/"
B=open(ROOT+"BIBLIOGRAPHY.md",encoding="utf-8").read()
def rep(old,new):
    global B
    n=B.count(old); assert n==1,(n,old[:90]); B=B.replace(old,new)
LW="library/pdf/LacaWarren2018-phase-transitions-c-star-algebras-number-fields-generalized-furstenberg.pdf"
BF="library/pdf/BekkaFrancini2022-characters-algebraic-groups-number-fields.pdf"
H1="library/pdf/Huang2017-fourier-coefficients-times-p-invariant-measures.pdf"
H2="library/pdf/HuangLiShiXu2023-strongly-independent-matrices-rigidity-times-a-invariant-measures-n-torus.pdf"
# § A: EL2022 read column
rep("**§2 (\"Actions on adelic solenoids\") unread — a prior-art debt on PE-2** (row 120); §§3–9 unread.",
    "§2 (pp. 5–9) and §4.1–§4.3 (pp. 14–17) read (X24R, 2026-09-26): §2 is set-up only, PE-2 and EF_F⁺ not in it; Lemma 4.2 a lift for fixed `ℤ^d` (row 120); §§3, 5–9 unread.")
# § A: EF 2010, one line (X24R's citers)
rep("| **read in full** (the advisor; X01D; X01V §§1–4; X12B) |",
    "| **read in full** (the advisor; X01D; X01V §§1–4; X12B). Its citers (X24R, 2026-09-26): OpenAlex splits the ETDS and arXiv records (5 + 3), Semantic Scholar merges them (11); none is `S`-adic or number-field; Semantic-Scholar-only arXiv citers arXiv:2608.24503 (Zhao 2026), arXiv:2303.01089 (Badea–Grivaux), arXiv:1909.06866 (Gilat, Discrete Anal. 2019); also arXiv:1411.2776 (JFA 2015, *On C\\*-algebras of irreversible algebraic dynamical systems*), arXiv:1804.01369 (Badea–Grivaux, CMH 2020), arXiv:1006.4491 (optimal transport) — abstracts read (X24R) |")
# § B library table
rep("| `pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` | `[EinsiedlerLindenstrauss2022]` | read: §1 (J23p, J51; in full by X02D, 2026-09-26); §§2–9 unread |",
    "| `pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` | `[EinsiedlerLindenstrauss2022]` | read: §1 (J23p, J51; in full by X02D, 2026-09-26); §2 and §4.1–§4.3 (X24R, 2026-09-26); §§3, 5–9 unread |")
ef="| `pdf/EinsiedlerFish2010-rigidity-measures-multiplicative-semigroup-polynomial-growth.pdf` | `[EinsiedlerFish2010]` | read in full (2026-09-26, the ×2×3 crunch) |"
rep(ef, ef+"\n"
 "| `pdf/LacaWarren2018-phase-transitions-c-star-algebras-number-fields-generalized-furstenberg.pdf` | `[LacaWarren2018]` | read: abstract; pp. 7–9, 13–14 (X24R, 2026-09-26) |\n"
 "| `pdf/BekkaFrancini2022-characters-algebraic-groups-number-fields.pdf` | `[BekkaFrancini2022]` | read: Thm 1.1, Remark 1.2 (iii)–(iv) (X03D); §1 pp. 1–6 and Thm 5.8's statement (X24R, 2026-09-26) |\n"
 "| `pdf/Huang2017-fourier-coefficients-times-p-invariant-measures.pdf` | `[Huang2017]` | read: §1, Remark 5.4, references (X01D, 2026-09-26) |\n"
 "| `pdf/HuangLiShiXu2023-strongly-independent-matrices-rigidity-times-a-invariant-measures-n-torus.pdf` | `[HuangLiShiXu2023]` | read: §1 (X01D, 2026-09-26) |")
# § C rows
rep("so its character rigidity does not apply (row 122). Held in the repository at `data/fs100/x03d/bekka-francini-2002.07497.pdf`, to move to the library |",
    f"so its character rigidity does not apply (row 122). **§1 pp. 1–6 and Thm 5.8's statement read** (X24R, 2026-09-26): the torus case excluded by hypothesis. `{BF}` |")
rep("circle only — row 120's prior-art search. Held in the repository at `data/fs100/x01d/` |", f"circle only — row 120's prior-art search. `{H1}` |")
rep("tori, not `S`-adic — row 120's prior-art search. Held in the repository at `data/fs100/x01d/` |", f"tori, not `S`-adic — row 120's prior-art search. `{H2}` |")
sat_old="| **Not held, unread**: `[EinsiedlerFish2010]`'s Thm 1.2 first, per `[Huang2017]` |"
rep(sat_old, "| **Not held, unread**: `[EinsiedlerFish2010]`'s Thm 1.2 first, per `[Huang2017]`; not in zbMATH (author listing checked); one Math-Net.ru fetch and one Russian web search failed; by Huang's description a circle theorem (X24R, 2026-09-26) |\n"
 f"| **[LacaWarren2018]** M. Laca, J. M. Warren, *Phase transitions on C\\*-algebras arising from number fields and the generalized Furstenberg conjecture*, arXiv:1801.07802 (journal not checked) | **Read: abstract; pp. 7–9, 13–14** (X24R, 2026-09-26): names MR's character form (extremal traces of `C*(J ⋊ O*)` ↔ ergodic invariant measure plus isotropy character, via Neshveyev) and the finitely generated case as the open \"generalized Furstenberg conjecture\" (row 120). `{LW}` |\n"
 "| **[BauJohnsonNoble2021]** S. Bau, P. D. Johnson Jr., M. Noble, *On single-distance graphs on the rational points in Euclidean spaces*, Canad. Math. Bull. 64 (2021) 13–24, doi 10.4153/S0008439520000181, Zbl 1461.05078 | **Not held; abstract only** (X24R, 2026-09-26): `χ(ℚⁿ, d)`; checked for a quadratic-field value, none |\n"
 "| **[Soifer2025open]** A. Soifer, *New results and new open problems and conjectures related to the chromatic number of the plane problem*, Geombinatorics (2025), Zbl 1569.05108; and *New open problems and conjectures in the new mathematical coloring book* (2024), Zbl 1559.05062 | **Not held; zbMATH review (2025), title only (2024)** (X24R, 2026-09-26): checked for Open Problem 55.1's status |\n"
 "| **[BaderVigdorovich2022]** U. Bader, I. Vigdorovich, arXiv:2208.07347 (stiffness of stationary measures on character spaces) | **Not held; abstract only** (X24R, 2026-09-26, `plans/FS100-X24R-prior-art.md` §3, its discipline table): a character-rigidity search hit for MR's character form |\n"
 "| **[Croft1967]** H. T. Croft, *Incidence incidents*, Eureka 30 (1967) 22–26 — the citation checked against `[AmbrusEtAl2023]`'s reference [Cr67] (the paper itself unheld) | **Not held, unread.** The tortoise construction, `m₁(ℝ²) ≥ 0.22936` (at `x = 0.96553`, per `[AmbrusEtAl2023]` §1, read): row 125's density no-go (`m₁ > 1/5`) |")
open(ROOT+"BIBLIOGRAPHY.md","w",encoding="utf-8").write(B); print("ok")
