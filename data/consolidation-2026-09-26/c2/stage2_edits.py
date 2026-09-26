#!/usr/bin/env python3
"""C2 stage 2: the fixes to BIBLIOGRAPHY.md, each an exact, uniqueness-checked edit (a miss aborts before writing)."""
import os, sys
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))
P = os.path.join(ROOT, "BIBLIOGRAPHY.md")
L = open(P, encoding="utf-8").read().split("\n")
TAG = "C2, 2026-09-26"

def line_of(key, nth=0):
    hits = [i for i, l in enumerate(L) if l.startswith("|") and f"**[{key}]**" in l.split("|")[1]]
    assert len(hits) > nth, f"no row {nth} for {key}: {hits}"
    return hits[nth]

def rep(key, old, new, nth=0):
    i = line_of(key, nth); c = L[i].count(old)
    assert c == 1, f"{key}: '{old[:60]}' occurs {c} times"
    L[i] = L[i].replace(old, new)

def cell_end_append(key, col, add, nth=0):
    i = line_of(key, nth); cols = L[i].strip().strip("|").split(" | ")
    cell = cols[col].rstrip(); assert L[i].count(cell) == 1, f"{key} col {col} not unique"
    L[i] = L[i].replace(cell, cell + add)

def lib_rep(old, new):
    hits = [i for i, l in enumerate(L) if old in l]; assert len(hits) == 1, f"'{old[:60]}' in {hits}"
    L[hits[0]] = L[hits[0]].replace(old, new)

# --- check 4: fields (zbMATH / arXiv APIs) ---
rep("EinsiedlerLindenstrauss2022", "Ergodic Theory Dynam. Systems (2022), arXiv:2101.11120",
    "Ergodic Theory Dynam. Systems 42(2) (2022) 691–736, doi 10.1017/etds.2021.74, Zbl 1489.37004, arXiv:2101.11120 (v1 2021-01-26). "
    "**Cited in prose as \"EL2021\"**, its arXiv year (alias in § A′); volume, pages, doi and Zbl from the zbMATH API (" + TAG + ")")
rep("LacaWarren2018", "arXiv:1801.07802 (journal not checked)",
    "J. Operator Theory 83(1) (2020) 73–93, Zbl 1449.46057, arXiv:1801.07802 (v1 2018-01-23; the key carries the arXiv year, the journal "
    "year is 2020 — alias in § A′; venue and Zbl from the zbMATH API, " + TAG + ")")
rep("LindenstraussWang2012", "(Duke Math. J. 161 (2012), Zbl 1258.37031; pages unchecked)",
    "(Duke Math. J. 161(7) (2012) 1305–1350, doi 10.1215/00127094-1593290, Zbl 1258.37031, arXiv:1101.0323 — not `[Wang2012]`'s "
    "1101.0321; pages and arXiv id from the zbMATH API, " + TAG + ")")
rep("BekkaFrancini2022", "(Groups Geom. Dyn. (2022), Zbl 1518.22005; arXiv:2002.07497)",
    "(Groups Geom. Dyn. 16(4) (2022) 1119–1164, doi 10.4171/GGD/678, Zbl 1518.22005; arXiv:2002.07497; volume and pages from the zbMATH API, " + TAG + ")")
rep("BaderVigdorovich2022", "Bader, Vigdorovich (initials not checked), arXiv:2208.07347 (stiffness of stationary measures on character spaces)",
    "U. Bader, I. Vigdorovich, *Charmenability and stiffness of arithmetic groups*, J. Eur. Math. Soc. (JEMS) 28(8) (2026) 3581–3621, "
    "doi 10.4171/jems/1535, arXiv:2208.07347 (v1 2022-08-15; the key carries the arXiv year, the journal year is 2026 — alias in § A′; "
    "no Zbl number yet). Authors, title and venue from the arXiv and zbMATH APIs (" + TAG + "); X24R's gloss: \"stiffness of stationary "
    "measures on character spaces\"")
rep("Lindenstrauss2004", "*Rigidity of multiparameter actions*, arXiv:math/0402165",
    "*Rigidity of multiparameter actions*, Israel J. Math. 149 (2005) 199–226, doi 10.1007/BF02772541, Zbl 1155.37301, arXiv:math/0402165 "
    "(the key carries the arXiv year, the journal year is 2005 — alias in § A′; venue from the zbMATH API, " + TAG + ")")
rep("LindWard1988", "(Ergodic Theory Dynam. Systems 8 (1988))",
    "(Ergodic Theory Dynam. Systems 8(3) (1988) 411–419, doi 10.1017/S0143385700004545, Zbl 0634.22005)")
rep("LindWard1988", "(J. reine angew. Math. 489 (1997))",
    "(J. reine angew. Math. 489 (1997) 99–132, Zbl 0879.58037; both from the zbMATH API, " + TAG + ")")
rep("JohnsonA1992", "A. Johnson (1992; initials unchecked — **not**",
    "A. S. A. Johnson (1992; Isr. J. Math. 77(1–2) 211–240, doi 10.1007/BF02808018 — Aimee S. A. Johnson per zbMATH 0790.28012, " + TAG + "; **not**")
rep("Croft1967", "(the paper itself unheld)", "(the paper itself unheld; Eureka is not in zbMATH — `au:Croft & py:1967` returns only Math. Gaz. 51, " + TAG + ")")

# --- check 3: read status ---
rep("BekkaFrancini2022", "**Thm 1.1 and Remark 1.2 (iii)–(iv) read** (X03D, 2026-09-26)",
    "**Read: abstract, §1 (pp. 1–5: Theorem 1.1, its proof sketch, Remark 1.2 (i)–(v)); the rest unread** (X03D, 2026-09-26, "
    "`plans/FS100-X03D-derivation.md`, which quotes Remark 1.2 (iii) and (iv) verbatim)")
lib_rep("| `[BekkaFrancini2022]` | read: Thm 1.1, Remark 1.2 (iii)–(iv) (X03D); §1 pp. 1–6 and Thm 5.8's statement (X24R, 2026-09-26) |",
        "| `[BekkaFrancini2022]` | read: abstract, §1 (pp. 1–5: Thm 1.1, its proof sketch, Remark 1.2 (i)–(v)) (X03D); §1 pp. 1–6 and Thm 5.8's statement (X24R, 2026-09-26); the rest unread |")
rep("LacaWarren2018", "**Read: abstract; pp. 7–9, 13–14** (X24R",
    "**Read: abstract; pp. 7–9 (Prop. 3.5–3.8) and pp. 13–14 (Cor. 4.10, Thm 4.11)** (X24R")
lib_rep("| `[LacaWarren2018]` | read: abstract; pp. 7–9, 13–14 (X24R, 2026-09-26) |",
        "| `[LacaWarren2018]` | read: abstract; pp. 7–9 (Prop. 3.5–3.8), pp. 13–14 (Cor. 4.10, Thm 4.11) (X24R, 2026-09-26) |")

# --- check 2: addresses ---
rep("AxenovichEtAl2014", "A browser save to `library/pdf/axenovich-2014-chromatic-number-subsets-euclidean-plane-preprint.pdf` is the route ",
    "The KIT preprint is held (the copy column; fetched by the FS-58 sweep). ")
rep("CostaSilvaFilho2026", "| not held |",
    "| held, `pdf/arXiv-2607.19995-costa-silva-filho-coordinate-fields-EI17-EI19.pdf` (on disk since 2026-09-19; no record names its fetch) |")
for key, fn in (("GLV2009", "arXiv-0712.3079-gvozdenovic-laurent-vallentin-block-diagonal-hierarchies.pdf"),
                ("GMS2012", "arXiv-1005.4959-gijswijt-mittelmann-schrijver-quadruple-code-bounds.pdf"),
                ("LPS2017", "arXiv-1602.02531-litjens-polak-schrijver-nonbinary-quadruples.pdf"),
                ("dLMOV2021", "arXiv-1812.06045-delaat-machado-oliveira-vallentin-k-point-equiangular.pdf"),
                ("BGSV2012", "arXiv-1007.2905-bachoc-gijswijt-schrijver-vallentin-invariant-sdp.pdf")):
    rep(key, "| `~/source/library/pdf/`", f"| `~/source/library/pdf/{fn}`")

# --- check 6: rests on it ---
rep("EinsiedlerFish2010", "row 120 (FS100-EFP: Lemmas 3.1–3.2 transferred — the zero-entropy half of MR)",
    "row 120 (FS100-EFP = **EF_F⁺**: Lemmas 3.1–3.2 transferred — the zero-entropy half of MR; with PE-2, from `[EinsiedlerLindenstrauss2022]` "
    "Thm 1.2, it gives FS100-MR); row 122 (FS100-ED2: \"ED-2 shows averaging over `U_N` is strictly stronger than rigidity (the Nazarov "
    "phenomenon, `[EinsiedlerFish2010]` §4)\")")
cell_end_append("Croft1967", 1, "; row 92's \"anything at five colours (the count fails at the real place: Croft's `m₁ ≥ 0.22936 > 1/5`)\"")
cell_end_append("JohnsonA1992", 1, ". **Rests on it:** FS100-PE2's prior art, \"PE-2's shape is Johnson's nonlacunary theorem (1992, review only) "
                "transposed\" (row 120)")
rep("LindSchmidt1999", "Not load-bearing; not held",
    "Not load-bearing; not held. **Rests on it** (X27D's proposed line, `plans/FS100-X27D-derivation.md` Stage 4, written here by C2): "
    "\"the home discipline of X27D's NA₀ (homoclinic / asymptotic points of algebraic actions); not read by X27D\" — row 126's prior art. "
    "A debt (§ R.6)")
rep("EinsiedlerLindMiles2001", "FS-98's reading; not held (free online)",
    "FS-98's reading; not held (free online). Named with `[LindSchmidt1999]` as NA₀'s home discipline (X27V, X31C: \"Einsiedler–Lind–Miles "
    "unsearched\") — a debt (§ R.6)")
cell_end_append("Fischer1994", 2, " **Rests on it (as a control):** rows 89 and 100 use its ℤ/4 colouring as a positive control by formula (one dyadic prime, level 3).")
cell_end_append("Moorhouse2010", 2, " **§7.1 is FS54-T2's prior art** (odd degree ⟹ 2-colourable; rows 70, 77; `CLAUDE.md` G56).")
cell_end_append("Johnson2000", 2, " **Rows 121 and 123 rest on its being unread** — row 121: `[Johnson2000]`, `[Johnson2006]` unread, so novelty is \"not found\", never \"first\".")
cell_end_append("Johnson2006", 2, " **Rows 121 and 123 rest on its being unread** (with `[Johnson2000]`: novelty \"not found\", never \"first\").")
cell_end_append("ExooIsmailescu2019", 2, ". **Row 121 answers its smallest-subfield question in part** (ℚ(√47) is the first real quadratic field needing five)")
cell_end_append("Soifer2024", 2, " **Row 121 answers the existence half of Open Problem 55.1, non-constructively** (55.1 asks to construct; 55.2 open); chs. 11 and 55 are in row 121's prior-art search.")
cell_end_append("BergelsonMoragues2021", 2, "; row 124: the clopen correspondence for the non-abelian `R ⋊ U` \"needs its citation checked at that generality\"")
cell_end_append("Chandgotia2017", 1, " **Row 119** (FS-75): its heights are one ingredient of the winding form, \"not found stated\".")
for key, n in (("Johnson2006", 2), ("Johnson2000", 3)):
    hits = [j for j, l in enumerate(L) if l.startswith(f"| {n} | **[{key}]**")]; assert len(hits) == 1 and hits[0] < 88, key
    i = hits[0]   # the § R.2 row
    assert L[i].rstrip().endswith("| not requested |"), key
    L[i] = L[i].rstrip()[: -len("| not requested |")] + "| **Kooshi, acquiring** (2026-09-26; § R.6) |"

# --- check 4: aliases (§ A′) ---
ai = [i for i, l in enumerate(L) if l.startswith("| `[Tardif2022]` | **`[Tardif2023]`**")]; assert len(ai) == 1
L[ai[0] + 1: ai[0] + 1] = [
 "| `[EinsiedlerLindenstrauss2021]` (and the prose \"EL2021\") | **`[EinsiedlerLindenstrauss2022]`** | one paper (arXiv:2101.11120, v1 2021; ETDS 42(2), 2022; Zbl 1489.37004): the crunch's records cite it as EL2021, and it went unfound under its journal-year key once (G50) |",
 "| `[LacaWarren2020]` | **`[LacaWarren2018]`** | one paper (arXiv:1801.07802, 2018; J. Operator Theory 83(1), 2020; Zbl 1449.46057), listed so a journal-year citation resolves |",
 "| `[Lindenstrauss2005]` | **`[Lindenstrauss2004]`** | one paper (arXiv:math/0402165, 2004; Israel J. Math. 149, 2005; Zbl 1155.37301), listed so a journal-year citation resolves |",
 "| `[BaderVigdorovich2026]` | **`[BaderVigdorovich2022]`** | one paper (arXiv:2208.07347, 2022; JEMS 28(8), 2026), listed so a journal-year citation resolves |"]

# --- check 2: § B rows for held files no row named ---
bi = [i for i, l in enumerate(L) if l.startswith("| `pdf/arXiv-1610.10002-godsil-et-al-graph-homomorphisms-vector-colorings.pdf`")]; assert len(bi) == 1
L[bi[0] + 1: bi[0] + 1] = [
 "| `pdf/arXiv-0712.3079-gvozdenovic-laurent-vallentin-block-diagonal-hierarchies.pdf` | `[GLV2009]` | read in full (the D4 agent, 2026-09-16) |",
 "| `pdf/arXiv-1005.4959-gijswijt-mittelmann-schrijver-quadruple-code-bounds.pdf` | `[GMS2012]` | §1–2 and Table 1 read |",
 "| `pdf/arXiv-1602.02531-litjens-polak-schrijver-nonbinary-quadruples.pdf` | `[LPS2017]` | §1, §1.1 read |",
 "| `pdf/arXiv-1812.06045-delaat-machado-oliveira-vallentin-k-point-equiangular.pdf` | `[dLMOV2021]` | §1, §2, §3.1 read |",
 "| `pdf/arXiv-1007.2905-bachoc-gijswijt-schrijver-vallentin-invariant-sdp.pdf` | `[BGSV2012]` | contents only |",
 "| `pdf/arXiv-2607.19995-costa-silva-filho-coordinate-fields-EI17-EI19.pdf` | `[CostaSilvaFilho2026]` | abstract (2026-09-09); the file on disk since 2026-09-19, not read |",
 "| `supplementary/mrvz-2311.10069-fcn4/` (10 files, with `SHA256SUMS`) | `[MatolcsiEtAl2025]` | the paper's supplementary data (`https://bit.ly/fcn-4`); used as data, not read as text: `tools/fs56_mrvz_import.py` imports `G_27_*.txt` and `witness.txt` into `data/fs56/g27/cert-g27-mrvz.json` (sha256 recorded there; `data/fs56/README.md`) |"]

# --- check 5: § R.6, the crunch's open prior-art debts ---
ri = [i for i, l in enumerate(L) if l.startswith("## A. Load-bearing")]; assert len(ri) == 1
L[ri[0]: ri[0]] = [
 "### R.6 Prior-art debts left open by the 2026-09-25/26 crunch",
 "",
 "*Collected by the documentation consolidation (" + TAG + "); each row's entry in § A or § C carries its detail.*",
 "",
 "| work | what rests on it | state |",
 "|---|---|---|",
 "| `[Johnson2000]`, `[Johnson2006]` (§ R.2 items 3, 2) | rows 121 and 123 say \"not found\", never \"first\", while both are unread | **Kooshi, acquiring** |",
 "| `[Sataev1975]` | row 120: `[EinsiedlerFish2010]`'s Thm 1.2 first, per `[Huang2017]` — the circle theorem | not held, unread; not in zbMATH; one Math-Net.ru fetch and one Russian web search failed (X24R) |",
 "| `[LindSchmidt1999]` and `[EinsiedlerLindMiles2001]` | NA₀'s home discipline — homoclinic / asymptotic-in-density points of algebraic actions of infinitely generated abelian groups (X27D, X27V, X31C; row 126) | Lind–Schmidt: reviews only, not held; Einsiedler–Lind–Miles: review only, unsearched for NA₀ |",
 "| `[LindWard1988]`, `[ChothiEverestWard1997]` | FS100-EFG's entropy formula (row 120), cited from memory in X01D | not held, unread |",
 ""]

open(P, "w", encoding="utf-8").write("\n".join(L))
print("stage 2 edits applied")
