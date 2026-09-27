#!/usr/bin/env python3
"""FS105-X's application of FS105-C's §R-close 4.3 drafts to BIBLIOGRAPHY.md, as exact (old, new) pairs.

Every old text must occur exactly once in the file as it stood at FS105-X's stage 3 (`--check` applies to a copy and reports; `--apply`
writes BIBLIOGRAPHY.md). The quoted read-status texts are C's drafts verbatim; the additions that are not C's text are marked RULE
(the file's own § D rule 0b, or bib_audit's alias table) in the record.

    python3 data/fs105/fs105-x/bib_edits.py --check
    python3 data/fs105/fs105-x/bib_edits.py --apply
    python3 data/fs105/fs105-x/bib_edits.py --self-test   # a planted pair whose old text is absent must be refused
"""
from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
BIB = ROOT / "BIBLIOGRAPHY.md"

EL03_PATH = "library/pdf/EinsiedlerLindenstrauss2003-rigidity-zd-actions-tori-solenoids-era-9-99-110.pdf"
SAT_PATH = "library/pdf/Sataev1975-measures-invariant-polynomial-semigroups-circle-uspekhi-30-2-203-204.pdf"

# C's draft, verbatim (§R-close 4.3), split into the § A row's copy and read columns.
EL03_READ = ("**Held; read in full** (FS105-R, 2026-09-26; D read §1, §2 to Prop. 2.1, §3's opening, §6). An announcement: Thm 1.1 "
             "(= EL2021 Thm 1.2, verbatim but for \"Let µ be an α-ergodic measure\" and \"λ\" for \"m_X\") with only \"a sketch of how "
             "Theorem 1.1 is proved\" (§6, \"Outline of the proof of Theorem 1.1\", its last step \"not hard\"); §§3–4 prove Thm 4.1 "
             "(EL2021's Thm 5.1) in full; §5 proves Thm 5.1 \"essentially complete[ly]\", Prop. 5.3 \"We give no details here\"; its [5] "
             "(\"in preparation\") became EL2021. EL2021 p. 2's \"already proven in the announcement [7]\" overstates it (FS-105; row 120).")

EL22_READ = ("read: §§1, 2, 4 in full (X02D, X24R, FS105-R, FS105-D); §7's Lemma 7.4, Cor. 7.6 and the proof of Thm 4.1 from Cor. 7.6 "
             "in full (FS105-R); §3.1–3.3, §5 (Thm 5.1), §6 and §7 (Thm 7.1, Lemma 7.2, Prop. 7.5) at their statements; §§8–9 unread "
             "(not used by Thm 1.3's proof). Thm 1.2 is not proved in it: it is Thm 1.3 plus FS105-DED. Misprints (harmless): Thm 7.1's "
             "\"without cyclic factors\"; `κ > 0` where Lemma 7.2 gives `≥ 0`.")

SAT_VERDICT = ("**Held** (Kooshi's upload, 2026-09-26; Math-Net.ru `rm3995`, the Moscow Mathematical Society's session reports, item 3° "
               "on pp. 203–204), `" + SAT_PATH + "`. **Read in full by the owner** (a two-page abstract): Theorem 1 — for an integer "
               "polynomial `f` with `f(0) = 0` and `T_n z = z^{f(n)}`, every finite positive measure on `S¹` invariant under every `T_n` "
               "is a combination of Lebesgue measure and `δ₁`; proof by Weyl equidistribution (Hua Loo-Keng), unchecked. **Against "
               "`[EinsiedlerFish2010]` Thm 1.2** [the close's reading, one mind]: invariance under every `T_n` is invariance under the "
               "multiplicative semigroup the values generate, which has polynomial growth, so Sataev's is the case of a semigroup holding "
               "a polynomial's values, with a sharper conclusion (no ergodicity; the atom at 1); EF's covers every multiplicative "
               "semigroup of polynomial growth — `[Huang2017]` §1's \"independently discovered\" fits the case, not the generality.")

EL03_CITE = ("M. Einsiedler, E. Lindenstrauss, *Rigidity properties of ℤ^d-actions on tori and solenoids*, Electron. Res. Announc. Amer. "
             "Math. Soc. 9 (2003) 99–110, Zbl 1068.37002")

PAIRS: list[tuple[str, str, str]] = [
    # R.6: Sataev's debt closes; Lind–Ward's state (C's text); the new row for EL2021's cited machinery.
    ("r6-sataev",
     "| `[Sataev1975]` | row 120: `[EinsiedlerFish2010]`'s Thm 1.2 first, per `[Huang2017]` — the circle theorem | not held, unread; not in "
     "zbMATH; one Math-Net.ru fetch and one Russian web search failed (X24R) |",
     "| `[Sataev1975]` | row 120: `[EinsiedlerFish2010]`'s Thm 1.2 first, per `[Huang2017]` — the circle theorem | **closed** (FS-105): held "
     "and read (§ C) |"),
    ("r6-lindward",
     "| `[LindWard1988]`, `[ChothiEverestWard1997]` | FS100-EFG's entropy formula (row 120), cited from memory in X01D | not held, unread |",
     "| `[LindWard1988]`, `[ChothiEverestWard1997]` | FS100-EFG's entropy formula (row 120), cited from memory in X01D | Not held, unread "
     "— carried a second milestone (FS-105, W §5.3); its load-bearing consequence, positive Haar entropy on the pieces, is derived (X02D "
     "§3.3; FS105-H, `≥ log 2`). |\n"
     "| `[EinsiedlerLindenstrauss2010]`, `[EinsiedlerLindenstrauss2019]`, `[EinsiedlerKatok2005]` (EL2021's `[10]`, `[11]`, `[5]`) | row "
     "120's (a9): EL2021 Thm 1.3's leafwise-measure machinery | not held, unread; the fetch declined for now (FS-105); `[11]` Prop. 6.4 "
     "first, on which EL2021 Prop. 3.5's equality rests (FS105-R); the first two on arXiv |"),
    # § A: EL2022's read column (C's text, with the copy provenance the old column held kept after it); EL2003 moves in from § C.
    ("a-el22-read",
     "| read: §1, pp. 1–3 (2026-09-25, J23p; FS-89 had the abstract); re-read at §1 by J51, 2026-09-26, from a re-fetched copy "
     "(byte-identical, md5 `1a32060a…`, removed from the repository at `0c61c274`); §1 re-read in full by X02D and pp. 1–3 by X02V "
     "(2026-09-26); §2 (pp. 5–9) and §4.1–§4.3 (pp. 14–17) read (X24R, 2026-09-26): §2 is set-up only, PE-2 and EF_F⁺ not in it; Lemma "
     "4.2 a lift for fixed `ℤ^d` (row 120); §§3, 5–9 unread. The advisor's third copy (`data/crunch-2026-09-26-x2x3/poros/"
     "el2021-2101.11120.pdf`, the same md5) removed at X10F's stage 4 |",
     "| " + EL22_READ + " §2 is set-up only, PE-2 and EF_F⁺ not in it; Lemma 4.2 a lift for fixed `ℤ^d` (row 120). §1 first read "
     "2026-09-25 (J23p; FS-89 had the abstract); a re-fetched copy (J51; byte-identical, md5 `1a32060a…`) removed from the repository "
     "at `0c61c274`; the advisor's third copy (`data/crunch-2026-09-26-x2x3/poros/el2021-2101.11120.pdf`, the same md5) removed at "
     "X10F's stage 4 |\n"
     "| **[EinsiedlerLindenstrauss2003]** | " + EL03_CITE + " | row 120's grade (FS-105): the announcement EL2021 p. 2 cites for its "
     "Thm 1.2's proof, which it gives only in outline | `" + EL03_PATH + "`, md5 `430849cf7d710c42002d768fcaf73266`, 12 pp. | "
     + EL03_READ + " |"),
    # § A: the three re-reads (W §5.3).
    ("a-ambrus",
     "Thm 1, Lemma 1 and the §4 Remark re-read 2026-09-26 (FS103-F) — the Remark's expected `α₁(ℝ²) ≠ m₁(ℝ²)` bears on row 129 |",
     "Thm 1, Lemma 1 and the §4 Remark re-read 2026-09-26 (FS103-F) — the Remark's expected `α₁(ℝ²) ≠ m₁(ℝ²)` bears on row 129; "
     "Theorem 1, p. 19's computed `0.24699…` and §4's Remark re-read 2026-09-26 (FS105-W) |"),
    ("a-duczvarga",
     "§§1–2.2 and §3's definitions re-read 2026-09-26 (FS103-F; FS103-B) — its Conjecture 1 (§2.1), whose first clause row 129 answers "
     "given MR |",
     "§§1–2.2 and §3's definitions re-read 2026-09-26 (FS103-F; FS103-B) — its Conjecture 1 (§2.1), whose first clause row 129 answers "
     "given MR; Lemma 1 and the blow-up paragraph re-read 2026-09-26 (FS105-W) |"),
    ("a-matolcsi",
     "§§1–3 and Conjecture 1 re-read 2026-09-26 (FS103-G; FS103-F; FS103-B) |",
     "§§1–3 and Conjecture 1 re-read 2026-09-26 (FS103-G; FS103-F; FS103-B); §2 re-read 2026-09-26 (FS105-W) |"),
    # § A′: the plan's arXiv-year key (bib_audit's alias table; C: "the plan's [BekkaFrancini2020] is this held paper").
    ("a-prime-bekka",
     "| `[BaderVigdorovich2026]` | **`[BaderVigdorovich2022]`** | one paper (arXiv:2208.07347, 2022; JEMS 28(8), 2026), listed so a "
     "journal-year citation resolves |",
     "| `[BaderVigdorovich2026]` | **`[BaderVigdorovich2022]`** | one paper (arXiv:2208.07347, 2022; JEMS 28(8), 2026), listed so a "
     "journal-year citation resolves |\n"
     "| `[BekkaFrancini2020]` | **`[BekkaFrancini2022]`** | one paper (arXiv:2002.07497, 2020; Groups Geom. Dyn. 16(4), 2022; Zbl "
     "1518.22005): FS-105's plan and FS105-R cited it under its arXiv year (FS105-C §R-close 4.3: \"the plan's `[BekkaFrancini2020]` is "
     "this held paper\") |"),
    # § B: EL2022's line; the two new library files.
    ("b-el22",
     "| `pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` | `[EinsiedlerLindenstrauss2022]` | read: "
     "§1 (J23p, J51; in full by X02D, 2026-09-26); §2 and §4.1–§4.3 (X24R, 2026-09-26); §§3, 5–9 unread |",
     "| `pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` | `[EinsiedlerLindenstrauss2022]` | "
     + EL22_READ + " |"),
    ("b-new-files",
     "| `pdf/HuangLiShiXu2023-strongly-independent-matrices-rigidity-times-a-invariant-measures-n-torus.pdf` | `[HuangLiShiXu2023]` | "
     "read: §1 (X01D, 2026-09-26) |",
     "| `pdf/HuangLiShiXu2023-strongly-independent-matrices-rigidity-times-a-invariant-measures-n-torus.pdf` | `[HuangLiShiXu2023]` | "
     "read: §1 (X01D, 2026-09-26) |\n"
     "| `" + EL03_PATH.removeprefix("library/") + "` | `[EinsiedlerLindenstrauss2003]` | read in full (FS105-R, 2026-09-26; D read §1, "
     "§2 to Prop. 2.1, §3's opening, §6); an announcement, its §6 an outline |\n"
     "| `" + SAT_PATH.removeprefix("library/") + "` | `[Sataev1975]` (§ C) | read in full by the owner (a two-page abstract; Kooshi's "
     "upload, 2026-09-26) |"),
    # § C: EL2003 leaves for § A; Sataev held and read; Jungić's identifiers; the two sphere titles.
    ("c-el03-out",
     "| **[EinsiedlerLindenstrauss2003]** M. Einsiedler, E. Lindenstrauss, *Rigidity properties of ℤ^d-actions on tori and solenoids* "
     "(Electron. Res. Announc. Amer. Math. Soc. 9 (2003) 99–110, Zbl 1068.37002) | **Author's summary only** (J51; the AMS PDF returned a "
     "bot-check page twice): `[EinsiedlerLindenstrauss2022]` (EL2021) says its Thm 1.1 is EL2021's Thm 1.2. Not held |\n",
     ""),
    ("c-sataev",
     "| **Not held, unread**: `[EinsiedlerFish2010]`'s Thm 1.2 first, per `[Huang2017]`; not in zbMATH (author listing checked); one "
     "Math-Net.ru fetch and one Russian web search failed; by Huang's description a circle theorem (X24R, 2026-09-26) |",
     "| " + SAT_VERDICT + " |"),
    ("c-jungic",
     "Jungić, *Still spinning*, Math. Mag. 96(2) (2023) |",
     "Jungić, *Still spinning*, Math. Mag. 96(2) (2023), doi 10.1080/0025570X.2023.2176684, Zbl 1535.05104 |"),
    ("c-sphere",
     "| arXiv:1810.00960 *On the density of sets … avoiding distance 1*; arXiv:2207.13892 (random `ε`-distance graphs on spheres) |",
     "| arXiv:2605.28709 D. Czifra, Á. Dúcz, M. Matolcsi, D. Varga, P. Zsámboki, *Improved bounds for the double cap conjecture*; "
     "arXiv:2607.05083 Á. Dúcz, *On the maximal measure of a spherical set avoiding solutions to x + y + z = 0* | **Titles only, not "
     "read** (FS105-W §4.3, the poser's zbMATH listing, 2026-09-26): sphere problems by their titles |\n"
     "| arXiv:1810.00960 *On the density of sets … avoiding distance 1*; arXiv:2207.13892 (random `ε`-distance graphs on spheres) |"),
    # § C: the three EL2021 references the new R.6 row names (keys must resolve; bib_audit).
    ("c-el21-refs",
     "| **[Huang2017]** H. Huang, *Fourier coefficients of ×p-invariant measures*,",
     "| **[EinsiedlerLindenstrauss2010]** M. Einsiedler, E. Lindenstrauss, *Diagonal actions on locally homogeneous spaces*, Clay Math. "
     "Proc. 10 (2010) — EL2021's `[10]` | **Not held, unread** (FS-105; § R.6): EL2021 Thm 1.3's leafwise-measure machinery (row 120's "
     "(a9)); on arXiv |\n"
     "| **[EinsiedlerLindenstrauss2019]** M. Einsiedler, E. Lindenstrauss, *Joinings of higher rank torus actions on homogeneous spaces*, "
     "Publ. Math. IHÉS 129 (2019) — EL2021's `[11]` | **Not held, unread** (FS-105; § R.6): its Prop. 6.4, on which EL2021 Prop. 3.5's "
     "equality rests (FS105-R), is the first to read; on arXiv |\n"
     "| **[EinsiedlerKatok2005]** M. Einsiedler, A. Katok, *Rigidity of measures — the high entropy case and non-commuting foliations*, "
     "Israel J. Math. 148 (2005) 169–238 — EL2021's `[5]` | **Not held, unread** (FS-105; § R.6): EL2021 Thm 1.3's machinery (row 120's "
     "(a9)) |\n"
     "| **[Huang2017]** H. Huang, *Fourier coefficients of ×p-invariant measures*,"),
]


def apply(text: str, pairs) -> tuple[str, list[str]]:
    misses = []
    for name, old, new in pairs:
        n = text.count(old)
        if n != 1:
            misses.append(f"{name}: old text occurs {n} times")
            continue
        text = text.replace(old, new)
    return text, misses


def main() -> int:
    mode = sys.argv[1] if len(sys.argv) > 1 else "--check"
    src = BIB.read_text(encoding="utf-8")
    if mode == "--self-test":
        _, misses = apply(src, PAIRS + [("plant", "this text is not in BIBLIOGRAPHY.md", "x")])
        ok = any(m.startswith("plant") for m in misses)
        print("SELF-TEST", "PASS: the planted pair was refused" if ok else "FAIL: the plant was not refused")
        return 0 if ok else 1
    new, misses = apply(src, PAIRS)
    print(f"BIBLIOGRAPHY.md {len(src.encode())} -> {len(new.encode())} bytes ({len(new.encode()) - len(src.encode()):+d}); "
          f"{len(PAIRS)} pairs, {len(misses)} misses")
    for m in misses:
        print("MISS:", m)
    if misses:
        print("FAIL")
        return 1
    if mode == "--apply":
        BIB.write_text(new, encoding="utf-8")
        print("written: BIBLIOGRAPHY.md")
    print("PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
