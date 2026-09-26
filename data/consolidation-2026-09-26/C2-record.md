*Record of job **C2** (clean citations), 2026-09-26 documentation consolidation. de Bruijn, Opus 5.5. Brief:
`data/consolidation-2026-09-26/briefs/C2-citations.md` with `STANDING-RULES.md`. Touch list: `BIBLIOGRAPHY.md`, this record,
`data/consolidation-2026-09-26/`.*

## Stage 1 — SAVED (the audit)

**Instruments** (all under `data/consolidation-2026-09-26/c2/`, none edits a tool):
- `tools/bib_audit.py` (unchanged) — walks `*.md` only.
- `lean_key_scan.py` — imports `bib_audit`'s own regexes, defined-key and alias sets, and applies them to `Proofs/**/*.lean`, so a key
  resolves there exactly when it resolves in the audit.
- `held_at.py` — every backticked file address in `BIBLIOGRAPHY.md`, resolved against `~/source/`, `~/source/library/` and the repository
  root; md5 prefixes written beside a path are checked. Plus a reverse check: every file under `~/source/library/` whose basename appears
  nowhere in `BIBLIOGRAPHY.md`.
- `rows.py` (print a row column by column), `said_read.py` (what a record says it read), `zb.py` (zbMATH Open API), `arxiv.xml` (arXiv API
  reply for eight ids).

### Check 1 — every key resolves

| scope | result |
|---|---|
| `python3 tools/bib_audit.py` (every `*.md`: `CLAUDE.md`, `LEDGER.md`, `CLOSED-QUESTIONS.md`, `plans/`, `data/`) | **exit 0**: 398 keyed rows, 12 retired/alternate keys; 228 arXiv ids and 380 bracketed keys cited; 0 unresolved |
| `python3 tools/bib_audit.py --self-test` | exit 0, 3 controls fired |
| `lean_key_scan.py .lean` (1,746 Lean files) | 7 citation keys, all resolve (`[AbrishamiEtAl2025]`, `[BrewsterEtAl2020]`, `[Fischer1990]`, `[Fischer1990b]`, `[Madore2015]`, `[Moorhouse2010]`, `[Parts2020a]`); 3 arXiv ids, all resolve. Exit 1 only on five yearless matches that are tactic lemma lists, not citations: `simp [MonoPair]`, `rw [NormBranch]`, `simp [PairsAt]`, `simp [PairsAtRatio]`, `simp [ValidOn]` (the audit's `NOT_KEYS` is for `*.md`; nothing to fix) |

**Unkeyed citations** (resolve by no key because they carry none; owed to C3a, not fixable here): `LEDGER.md` rows 92 (line 130) and 125
(line 163) cite "Croft's `m₁ ≥ 0.22936`" / "`≥ 0.2293`" without `[Croft1967]`; row 120 cites "Sataev 1975" and "Johnson's nonlacunary theorem
(1992, review only)" without `[Sataev1975]` / `[JohnsonA1992]`.

### Check 2 — every "held at" address exists

`held_at.py`: 501 addresses, 493 found, **0 md5 mismatches**. The 8 misses:

| line | key | address | verdict |
|---|---|---|---|
| 104, 195, 224 (1st), 233, 236, 657 | `[Moorhouse2010]`, `[Aggarwal2025]`, `[AxenovichEtAl2014]`, `[CoveringDesigns]`, `[Johnson2002]`, (§ C) | web URLs | not file addresses; fine |
| 224 (2nd) | `[AxenovichEtAl2014]` | `library/pdf/axenovich-…-plane-preprint.pdf` | **stale acquisition sentence**: the description still says "a browser save to `…-preprint.pdf` is the route"; the copy column (and § B) correctly give `pdf/axenovich-2014-chromatic-number-subsets-euclidean-plane.pdf` (the KIT preprint, FS-58). Fix |
| 337 | `[EinsiedlerLindenstrauss2022]` | `data/crunch-2026-09-26-x2x3/poros/el2021-2101.11120.pdf` | a history note ("removed at X10F's stage 4", commit `bc7a03df`), not an address; correct |

**The crunch's moves**, each file present in `~/source/library/pdf/` with the md5 its move record gives, and each § A/§ C and § B row pointing
at it:

| key | library file | md5 (prefix) | moved by | § A/§ C row | § B row |
|---|---|---|---|---|---|
| `[EinsiedlerFish2010]` | `EinsiedlerFish2010-rigidity-measures-multiplicative-semigroup-polynomial-growth.pdf` | `fdb1e267` | X10F stage 4 (`bc7a03df`) | ✓ | ✓ |
| `[EinsiedlerLindenstrauss2022]` | `EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf` | `1a32060a` (= row) | held since J23p; J51's repository copy `data/fs100/j51/el2021.pdf` removed by J53 (`0c61c274`), the advisor's by X10F | ✓ | ✓ |
| `[LacaWarren2018]` | `LacaWarren2018-phase-transitions-…-generalized-furstenberg.pdf` | `d444eed9` | X30F stage 4 (`3b1952a6`) | ✓ | ✓ |
| `[BekkaFrancini2022]` | `BekkaFrancini2022-characters-algebraic-groups-number-fields.pdf` | `f2be9857` | X30F | ✓ | ✓ |
| `[Huang2017]` | `Huang2017-fourier-coefficients-times-p-invariant-measures.pdf` | `5e9d353a` | X30F | ✓ | ✓ |
| `[HuangLiShiXu2023]` | `HuangLiShiXu2023-strongly-independent-…-n-torus.pdf` | `869fa1e8` | X30F | ✓ | ✓ |

**Old paths elsewhere in the repository** (`git grep`; outside my touch list): every hit is a historical record — a brief, a report, a job
record or a close inventory stating where the file was at the time — except the milestone plan, whose lines are instructions now done:
`plans/FS100-three-field-lemma.md` lines 1874, 1884, 1892 still say "**to move to `~/source/library/pdf/`**" for Laca–Warren, Bekka–Francini and
the two Huang papers (moved at X30F stage 4, `3b1952a6`), and `plans/FS100-X03D-derivation.md` line 80 "(to move to `~/source/library/`)". Owed.

**Reverse check** (library files no row names): six PDFs and one supplementary folder.

| file | row that holds it | what is wrong |
|---|---|---|
| `pdf/arXiv-0712.3079-gvozdenovic-laurent-vallentin-block-diagonal-hierarchies.pdf` | `[GLV2009]` | copy column gives the directory only; no § B row |
| `pdf/arXiv-1005.4959-gijswijt-mittelmann-schrijver-quadruple-code-bounds.pdf` | `[GMS2012]` | same |
| `pdf/arXiv-1007.2905-bachoc-gijswijt-schrijver-vallentin-invariant-sdp.pdf` | `[BGSV2012]` | same |
| `pdf/arXiv-1602.02531-litjens-polak-schrijver-nonbinary-quadruples.pdf` | `[LPS2017]` | same |
| `pdf/arXiv-1812.06045-delaat-machado-oliveira-vallentin-k-point-equiangular.pdf` | `[dLMOV2021]` | same |
| `pdf/arXiv-2607.19995-costa-silva-filho-coordinate-fields-EI17-EI19.pdf` (mtime 2026-09-19) | `[CostaSilvaFilho2026]` | the row says **"not held"** — wrong; no § B row |
| `supplementary/mrvz-2311.10069-fcn4/` (10 files, 2026-09-16) | `[MatolcsiEtAl2025]` | no § B row; used as data by `tools/fs56_mrvz_import.py` → `data/fs56/g27/cert-g27-mrvz.json` (`data/fs56/README.md`) |

### Check 3 — read status per section against the records

| key | row says | the records say | verdict |
|---|---|---|---|
| `[EinsiedlerFish2010]` | read in full (the advisor; X01D; X01V §§1–4; X12B) | X01D "**in full**, §§1–4 and references"; X01V "§§1–4 in full"; X12B "read in full (all 8 pp., §§1–4 and references)" | agrees |
| `[EinsiedlerLindenstrauss2022]` | §1 pp. 1–3 (J23p); §1 re-read (J51); §1 in full (X02D), pp. 1–3 (X02V); §2 (pp. 5–9), §4.1–§4.3 (pp. 14–17) (X24R); §§3, 5–9 unread | X02D §1.2 "§1 (pp. 1–5): read in full … §§2–9: not read (grepped only…)"; X02V "§1, pp. 1–3, including the definitions"; X24R Stage 3 "§1, §2 (pp. 5–9), §4.1–§4.3 (pp. 14–17) read; §§3, 5–9 unread" | agrees; § B agrees |
| `[LacaWarren2018]` | abstract; pp. 7–9, 13–14 (X24R) | X24R: "abstract, pp. 7–9 (Prop. 3.5–3.8) and pp. 13–14 (Cor. 4.10, Thm 4.11)" | agrees (add the item numbers) |
| `[Huang2017]` | §1, Remark 5.4, references (X01D) | X01D: "§1 (pp. 1–3), Remark 5.4 and the reference list" | agrees |
| `[HuangLiShiXu2023]` | §1 (X01D) | X01D: "§1 (pp. 1–4: …)" | agrees |
| `[BekkaFrancini2022]` | "Thm 1.1 and Remark 1.2 (iii)–(iv) read (X03D)"; § B the same | X03D line 61–62: "**Read: abstract, §1 (pp. 1–5: Theorem 1.1, its proof sketch, Remark 1.2 (i)–(v)); the rest unread.**" (quotes (iii) and (iv) verbatim) | **understated — fix § C and § B** to X03D's words |
| `[Lindenstrauss2004]` | pp. 1–6 (X02D), a WebFetch copy, not in the library | X02D §4.4 as the row | agrees |
| `[Croft1967]` | not held, unread; via `[AmbrusEtAl2023]` §1 and ref. [Cr67] | X30F stage 4 | agrees; add: not in zbMATH (`au:Croft & py:1967` returns only Math. Gaz. 51) |
| `[Sataev1975]` | not held, unread, not in zbMATH | X24R | agrees |
| `[LindSchmidt1999]` | reviews only (2026-09-25), not held | X27D, X27V, X31C: "reviews only, unread" | agrees; rests-on line missing (check 6) |
| `[BaderVigdorovich2022]` | "Bader, Vigdorovich (initials not checked) … (stiffness of stationary measures on character spaces)", abstract only | X24R "(c) abstract only" | read status agrees; **authors and title now checked** (arXiv API; zbMATH): Uri Bader, Itamar Vigdorovich, *Charmenability and stiffness of arithmetic groups*, J. Eur. Math. Soc. (JEMS) 28, No. 8, 3581–3621 (2026), doi 10.4171/jems/1535; no Zbl number yet — fix |
| `[JohnsonA1992]` (row 120's "Johnson's nonlacunary theorem") | "A. Johnson (1992; initials unchecked)" | zbMATH `an:0790.28012`: Aimee S. A. Johnson, Isr. J. Math. 77 (1992) 211–240 | fix the initials |

### Check 4 — journal-year trap; arXiv ids and Zbl numbers

| key | missing or wrong field (source: zbMATH API, arXiv API, 2026-09-26) | alias need |
|---|---|---|
| `[EinsiedlerLindenstrauss2022]` | no Zbl, no volume: **ETDS 42, No. 2, 691–736 (2022), doi 10.1017/etds.2021.74, Zbl 1489.37004** | cited in prose as **EL2021** (arXiv v1 2021-01-26); G50's instance. Add `[EinsiedlerLindenstrauss2021]` to § A′ and "EL2021" to the row |
| `[LacaWarren2018]` | "journal not checked": **J. Oper. Theory 83, No. 1, 73–93 (2020), Zbl 1449.46057** | journal year 2020 ≠ key year 2018 (arXiv); add `[LacaWarren2020]` to § A′ |
| `[Lindenstrauss2004]` | arXiv only: **Isr. J. Math. 149 (2005) 199–226, doi 10.1007/BF02772541, Zbl 1155.37301** | journal year 2005; add `[Lindenstrauss2005]` to § A′ |
| `[LindenstraussWang2012]` | "pages unchecked": **Duke Math. J. 161, No. 7, 1305–1350 (2012), doi 10.1215/00127094-1593290, arXiv:1101.0323** | — |
| `[BekkaFrancini2022]` | volume/pages: **Groups Geom. Dyn. 16, No. 4, 1119–1164 (2022), doi 10.4171/GGD/678** | — |
| `[BaderVigdorovich2022]` | as check 3 (JEMS 2026) | journal year 2026 ≠ key year 2022 (arXiv); add `[BaderVigdorovich2026]` to § A′ |
| `[LindWard1988]` | **ETDS 8, No. 3, 411–419 (1988), doi 10.1017/S0143385700004545, Zbl 0634.22005** | — |
| `[ChothiEverestWard1997]` | **J. Reine Angew. Math. 489, 99–132 (1997), Zbl 0879.58037** | — |
| `[Croft1967]` | Eureka 30 is not in zbMATH | — |
| `[EinsiedlerFish2010]`, `[Huang2017]`, `[HuangLiShiXu2023]`, `[Manners2015]`, `[Wang2012]`, `[EinsiedlerLindMiles2001]`, `[EinsiedlerLindenstrauss2003]`, `[LindSchmidt1999]` | arXiv id and Zbl present (Wang2012 is arXiv:1101.0321, Lindenstrauss–Wang 1101.0323 — distinct) | — |

### Check 5 — prior-art debts left open by the crunch

`BIBLIOGRAPHY.md` keeps outstanding papers in § R (R.1–R.5). No block lists the crunch's debts. To add as **§ R.6**, one block: Johnson
2000/2006 (R.2 items 2–3; "Kooshi, acquiring"); Sataev 1975; `[LindSchmidt1999]` and Einsiedler–Lind–Miles (NA₀'s home discipline:
homoclinic / asymptotic-in-density points of algebraic actions of infinitely generated abelian groups — X27D §2.6, X27V §2.3, X31C);
Lind–Ward 1988 and Chothi–Everest–Ward 1997 (cited from memory for FS100-EFG's entropy formula, X01D §2.1).

### Check 6 — "rests on it" lines

| key | rests on it (source) | row names it? |
|---|---|---|
| `[EinsiedlerFish2010]` | FS100-EFP = **EF_F⁺** (Lemmas 3.1–3.2), hence FS100-MR, row 120; §4 (the Nazarov phenomenon) cited for FS100-ED2, row 122 | row 120 only — add EF_F⁺, FS100-MR, row 122 |
| `[EinsiedlerLindenstrauss2022]` | Thm 1.2 → FS100-PE2 (**PE-2**) → FS100-MR, row 120; rows 98, 118 | ✓ (names PE-2 and rows 98, 118, 120) |
| `[LacaWarren2018]` | row 120's prior-art sentence (MR not found under its discipline's names) | ✓ |
| `[BekkaFrancini2022]` | row 122's prior-art sentence (does not apply) | ✓ |
| `[Croft1967]` | row 125's density no-go (`m₁ > 1/5`); row 92's "anything at five colours" clause | row 125 only — add row 92 |
| `[JohnsonA1992]` | FS100-PE2's prior art ("PE-2's shape is Johnson's nonlacunary theorem … transposed"), row 120 | no — add |
| `[LindWard1988]`/`[ChothiEverestWard1997]` | FS100-EFG, row 120 | ✓ |
| `[LindSchmidt1999]` | row 126's prior art; NA₀ (X27D's proposed line, `plans/FS100-X27D-derivation.md` line 287, never written — X31C) | no — add X27D's line verbatim |
| `[EinsiedlerLindMiles2001]` | NA₀'s home discipline (X27V, X31C: "unsearched") | no — add |
| `[Fischer1990]` | row 123's prior art: "the question is `[Fischer1990]` §1's" | ✓ (row 123 present) |
| `[Fischer1994]` | rows 57, 89, 100 (no crunch row cites it) | ✓ row 57; rows 89, 100 not named — add |
| `[Moorhouse2010]` | §7.1 → FS54-T2 (odd degree ⟹ 2-colourable; `CLAUDE.md` G56); row 121 cites `[Moorhouse2010slides]`, not this key | §7.1 named, FS54-T2 not — add |
| `[Johnson2000]`, `[Johnson2006]` | rows 121, 123: "unread, so 'not found', never 'first'" | no — add |
| `[ExooIsmailescu2019]`, `[Soifer2024]` | row 121's **Answers** (smallest-subfield question in part; Open Problem 55.1's existence half) | no — add |
| `[BergelsonMoragues2021]` | row 124: the clopen correspondence for `R ⋊ U` "needs its citation checked at that generality" | row 111 only — add row 124 |
| `[Chandgotia2017]` | row 119's prior art (ingredient of the winding form) | row 79 only — add row 119 |

**Would have searched here (stage 1):** none (zbMATH and arXiv API lookups of known papers' fields, not searches for witnesses).
