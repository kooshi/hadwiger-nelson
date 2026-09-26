# C3b — claims in the ranked stubs and the stub files: record

*Job C3b of the 2026-09-26 documentation consolidation (brief `data/consolidation-2026-09-26/briefs/C3b-claims-stubs.md`, standing rules
beside it, and the owner's three added notes from C1's report). de Bruijn, Opus 5.5. HEAD at launch: `c4a716b4`. `CLAUDE.md` at launch:
298,945 bytes.*

## Stage 1 — SAVED

The owner's notes 1–2 and the brief's item 4 (the small, named lines).

| file | location | old text (quoted) | new text | justified by |
|---|---|---|---|---|
| `LEDGER.md` | row 123, address cell (end) | "…`plans/FS100-X28D-derivation.md` §2.3, §3.3; `tools/x28d_check.py` \|" | "…`tools/x28d_check.py`; `plans/FS100-X26B-derivation.md` §2–§3; `tools/x26b_spectra.py`, `tools/x26b_uq_colour.py` \|" | owner note 1; row 123's own grade names X26B-L1 (§2.2) and X26B-L3 (§3.2); C1 index 2.1 |
| `BIBLIOGRAPHY.md` | `[Lindenstrauss2004]` (§ C), held-at clause | "A WebFetch copy, not in the library" | "**Held: its text only, not its PDF** — arXiv v1 as plain text, `lean-dir-rescue/consolidation-2026-09-26/papers/scratch/lin04.txt` (a fetched copy dated 2026-09-26, rescued from `/tmp` by C1); not in the library" | owner note 2; C1 manifest line 2164 (the provenance is not named there, so I name no job) |
| `BIBLIOGRAPHY.md` | `[AmbrusEtAl2023]` (§ A), copy column | "`pdf/arXiv-2207.14179-…-density-planar-sets.pdf`" | the same, then "; outside the library, rescued from `/tmp` by C1 (2026-09-26), under `lean-dir-rescue/consolidation-2026-09-26/papers/scratch/`: the arXiv source of v1–v3 (as downloaded, `src-v1`–`src-v3`, gzip; unzipped, `src-v1.tar`–`src-v3.tar`; extracted, `x-v1/`–`x-v3/`) and the supplementary notebook as text (`esm.txt`, `ver.txt`, byte-identical)" | owner note 2; `file` on each item; `cmp esm.txt ver.txt` |
| `plans/FS100-derivation.md` | FS100-PE2, *Prior art* | "PE-2's shape is Johnson's nonlacunary theorem (1992, review only) transposed; **EL2021 §2 (\"Actions on adelic solenoids\") is unread and may already contain the inverse-limit step — no novelty claimed until it is read** (X02D §4.4)." | "PE-2's shape is Johnson's nonlacunary theorem (1992, `[JohnsonA1992]`, review only) transposed; EL2021 §2 …, which X02D §4.4 held open (\"no novelty claimed until it is read\"), was read in full by X24R (`plans/FS100-X24R-prior-art.md` §3.1): *\"It is set-up for **finitely generated** acting groups (`ℤ^d`) and holds no statement about invariant measures, zero entropy, infinitely generated groups or limits over growing modules\"*; its Lemma 4.2 … is *\"a **factor** step for one fixed `ℤ^d`, not an inverse limit over `ℤ[Γ]`-submodules\"*; *\"So PE-2's step is not in EL2021, and neither is EF_F⁺.\"* The rest of the search: row 120's prior-art cell." | brief item 4; C2 report "owed (C3b/plans)"; X24R §3.1 quoted verbatim |
| `plans/FS100-three-field-lemma.md` | §R-close 4.3, `[LacaWarren2018]` (l. 1874) | "…**to move to `~/source/library/pdf/`** — abstract; pp. 7–9, 13–14 read (X24R)." | unchanged, then "*[Annotation, C3b, 2026-09-26: the move is done — X30F (commit `3b1952a6`) copied it to `~/source/library/pdf/LacaWarren2018-…-generalized-furstenberg.pdf` and removed the repository copy.]*" | brief item 4; `git show 3b1952a6` (X30F's record, "File moves") |
| same | §R-close 4.3, `[BekkaFrancini2022]` (l. 1884) | "**PDF `data/fs100/x03d/bekka-francini-2002.07497.pdf` to move to the library**." | unchanged, then "*[Annotation, C3b, 2026-09-26: done — X30F (commit `3b1952a6`); now `~/source/library/pdf/BekkaFrancini2022-characters-algebraic-groups-number-fields.pdf`, the repository copy removed.]*" | same |
| same | §R-close 4.3, `[Huang2017]`, `[HuangLiShiXu2023]` (l. 1892) | "…**to move to the library** (inventory 42)." | unchanged, then "*[Annotation, C3b, 2026-09-26: done — X30F (commit `3b1952a6`); now `~/source/library/pdf/Huang2017-…pdf` and `~/source/library/pdf/HuangLiShiXu2023-…pdf`, the repository copies removed.]*" | same |

**Left, on purpose (the brief names lines 1874, 1884, 1892 only):** the same plan's l. 1403 (`[EinsiedlerFish2010]`'s PDF at
`data/crunch-2026-09-26-x2x3/poros/`, "to move to `~/source/library/pdf/`" — the library holds `EinsiedlerFish2010-…pdf`, but X30F's move
list does not name it) and l. 1417 (Bekka–Francini "PDF at `data/fs100/x03d/`, to move to the library", the same fact as l. 1884). Owed
to the owner as found items.

Gates after stage 1: `fs71_ledger_b_check.py --strict` PASS (exit 0; 784 rows, 0 placeholders); `bib_audit.py` exit 0; `check_architecture.py`
PASS (exit 0). `CLAUDE.md` untouched.
