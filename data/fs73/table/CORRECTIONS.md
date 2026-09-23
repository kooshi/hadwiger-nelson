# Corrections to `TABLE.md` — five stale rows (FS-73's close, 2026-09-23)

`TABLE.md` is rendered by `python3 tools/fs73_table.py report` from `rows.jsonl`, and the rows below were computed before later
phases settled them. **The rows are not regenerated:** each correction comes from a theorem or certificate outside the table's
pipeline (a residue colouring, a linear form, a `Θ₃` certificate), which `report` cannot see, and re-running the row pipeline on
the spectral row costs solver runs for no new fact. So the corrections live here, each with its source; `rows.jsonl` and the
rendered table are left exactly as computed, and the table's header points here.

**The general correction (T22, `plans/FS73-derivation.md`):** at three colours a Cayley graph of a finitely generated torsion-free
abelian group is 3-colourable **iff** it has a periodic 3-colouring. So no three-colour row can be a genuine C3-aper case: every
row whose verdict reads "REFUSING at every N ≤ 12 searched (C3-aper case)" is either not 3-colourable at all or has a periodic
colouring at a period the search did not reach. The table's "periods" column is a statement about the periods searched (G21), and
all four such rows below turned out to be one or the other.

| row | stale entry | correction | source |
|---|---|---|---|
| `Q167\|fs61:L3e1c94c6` | verdict "REFUSING at every N ≤ 12 searched (C3-aper case)"; P_found "vacuous" | **3-colourable with period 23**: a gapped residue colouring at `(23, √167 − 11)`, its 36 unit vectors reaching half the residue circle; completeness of `U` proved. The refusals at N ≤ 12 (and P2's at N ≤ 20) stand — the least period is 23 | T17; `data/fs73/records/phase-P2b-q167.md`; `tools/fs73_q167_check.py` |
| `Q167\|fs61:Ld14c588b` | the same verdict | **3-colourable**, by the linear form `ψ = (43/108)a + (1309/2160)b − (59/240)c − (301/1080)e`, colouring `⌊3{ψ}⌋`, period index 1,080 (cyclic) — past P2b's `N ≤ 30` and circular `N ≤ 120`; `Θ₃`'s cell is full-dimensional (maximal slack 133/115872) | T27, T43; `data/fs73/q167/coxeter-Ld14c588b-linear-3colouring.json`; verified independently by the owner |
| `Q167\|fs61:L21cc6506` | the same verdict ("C3-aper case") | **not 3-colourable**: `Θ₃ = ∅` by three independent exact certificates, so `χ(ℚ(√167)²) ≥ 4` (`LEDGER.md` row 79). "C3-aper case" is void (there is no colouring); P_found = Λ holds, and so does F = Λ | T39–T42, T44; `data/fs73/records/phase-P3b-q167-theta.md`, `verify-P3b-q167.md` |
| `Q11\|D30` | the same verdict ("C3-aper case") | This row is **`Ld65c8ee8` over d = 11** (key `30\|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2`, 108 unit vectors; FS-61's `11:REF/108`). **Not 3-colourable**: `Θ₃ = ∅` by an exact certificate (20,843 nodes, 4.9 MB, accepted by the unmodified `certcheck.py`), FS-61's refusal re-derived through the criterion | T43; `data/fs73/q167/theta-controls/Ld65c8ee8-d11-theta-tree.json.gz`; phase-P3b-q167-theta.md §4 |
| `Q11\|3int\|D50` | spectral (c): "−0.4488 vs −0.5000: Hoffman-refuses" | **slack.** −0.4488 is BFGS's local minimum, stored before the column was made to take the least of BFGS and the exact quotient minima; the same row stores the N = 3 quotient minimum −50 = −d/2 (exactly −1/(k−1)), and a torsion scan reaches −56.17 (m/d ≤ −0.5617) at a 7-torsion character. A "Hoffman-refuses" on a lattice with a verified period-3 colouring is impossible | phase-P2.md "Defects" item 2; `tools/fs73_table.py` (the comment above the quotient-minimum step); Poros's hunch `table-spectral-column-stale` (`plans/POROS-2026-09-23-fs73-competition.md`) |

**Also recorded, not a stale row:** the rank-6 lattice L3's certificate colouring is labelled "2L3-periodic" in phase P4's record; its
exact period group is coarser (`Λ/Per ≅ (ℤ/2)²`, index 4, so the colouring is additive into `V₄`), as the owner's re-check found.
Harmless: every claim made from it (KPer = 0, F = P = 0) holds for the coarser group.

If `report` is ever re-run, keep the pointer paragraph at the top of `TABLE.md`: the rendered header is hand-written, not generated.
