# data/fs38 — the residue tower, measured (FS-38 phase T, 2026-09-13)

The plan is `plans/FS38-residue-tower.md`; the measurement record and the scoring of its predictions are
`plans/FS38-tower-records.md` § R-T. Everything here is produced by `tools/fs38_tower.py`, which is
**untrusted like everything in `tools/`** — nothing in this directory is a theorem. The certificates are the
Lean modules (`Proofs/HadwigerNelson/FanGap.lean`, `Instances/FanGap11.lean`, `TwoAdicTower.lean` and the
two 2-adic instance modules); these files are what those modules' data came from and what a reader
re-checks.

**Run `python3 tools/fs38_tower.py self-test` first**: 29 controls, each seen to fire, including the
perturbation that *cannot* fire (see the note at the end of this file).

## The two objects

* **The 2-adic tower.** `P_m = Cay(O/𝔓^m, S_m)` for `O = ℤ₂[ω][√3]`, `ω² = −1 − ω`, `π = 1 + √3`, `𝔓 = (π)`,
  `𝔓² = (2)`, `S_m = {z : z·z̄ = 1}` — the local plane of `K(i) = ℚ(√3,√11)(i)` at a prime above 2, where a
  *four*-colour question is open. `|P_m| = 4^m`, `|S_m| = 3·2^(m−1)`. A point is `(a, b, c, d)` for
  `(a + bω) + π(c + dω)` with `a, b ∈ ℤ/2^⌈m/2⌉` and `c, d ∈ ℤ/2^⌊m/2⌋`, indexed
  `idx = ((a·A + b)·B + c)·B + d` — the same order as Lean's `TwoAdicLevel m`.
* **The residue planes.** `UD(ℤ/p^m, 2) = Cay((ℤ/p^m)², {a² + b² = 1})` at `p = 11` and `p = 19`, where a
  *five*-colour question is settled and the fan gap is what the kernel consumes.

**Depth is the only unit used** (`plans/FS38-residue-tower.md` §S1): `depth(δ) = v_𝔓(δ) =
min(2·v₂(a,b), 1 + 2·v₂(c,d))`, which is `v₂(d²)` for a rational squared distance — M53's `v2` column, and
M56's "depth 3" is depth 6 here. `depth = m` is the zero of level `m`. Every record names its unit.

## What each file is, what it licenses, and how to regenerate it

| file | what it is | what a reader may conclude | trust word | regenerate |
|---|---|---|---|---|
| `tower-p2-k4-m<M>.json`, M = 1..7 | level `M` of the 2-adic tower at **four** colours: the graph's size, circle, depth histogram and fibre count; the independent ring validation; the orbit decomposition; the fan-gap verdict with its planted control; **every** nonzero difference asked individually for forcedness and for separation, aggregated by depth; the verified models' per-depth examples and aggregate hash | a `free` difference is **not forced**: the record's per-depth example colouring is proper on every edge and gives the pair different colours (re-checkable with no solver). A `refused` difference is **one solver's UNSAT**, re-asked on a second engine (glucose4) and a second encoding (`P_m` plus the edge `(0, δ)`, plain colourability) — still not a theorem. `E` in `sep_string` is separation **by properness**, a theorem; `S` is a refusal | **free: verified colouring. refused: refused (solver, untrusted)** | `python3 tools/fs38_tower.py forced --m <M>` |
| `gap-p11-k5.json` | `UD(𝔽₁₁,2)` at five colours: the certified table read back **from the kernel literal** (`Instances/FinitePlane11.lean`) and checked against `data/fplane/chi-p11.json`; every (vertex, colour) pair the table leaves absent from a closed neighbourhood; a fresh SAT ask for a gap; two controls | the census is an exact enumeration over the committed table — the three gapped vertices `(2,4)`, `(7,8)`, `(9,6)` are what `finitePlane11_fanGap` decides by twelve lookups, and `Slack (finitePlane 11) 5` follows by translation. The fresh ask carries a colouring verified here | verified colouring (the census is exact arithmetic) | `python3 tools/fs38_tower.py gap --p 11` |
| `gap-p19-k5.json` | the same at `UD(𝔽₁₉,2)` for the kernel's own periodic colouring `circ19Table ∘ projAlong (1,1)` | the 38 = 2·19 gapped pairs, all with gap colour 1, on exactly the two projection classes {4, 10} — what `finitePlane19_fanGap` decides by ten lookups (FS-38 §S8 decision 10 keeps only the forces half at 19). **Not** in the brief's file list; added because K2 needs the census and burying it in the double-gap file would hide it | verified colouring | `python3 tools/fs38_tower.py gap --p 19` |
| `doublegap-p11-k5.json` | one colour absent from `N[(0,0)] ∪ N[(1,0)]` at 11: a fresh SAT ask, **and the committed literal `finitePlane11DoubleGapTable` re-verified**, with a flipped entry as the planted red; the two shared neighbours; controls | a found (or committed) table with `colour_absent_on_closed_neighbourhood: true` is `DoubleSlack`'s witness at the base edge, hence at every edge by translation and `rotHom` — the hypothesis of `separated_iff_adj_of_doubleSlack` | verified colouring | `python3 tools/fs38_tower.py doublegap --p 11` |
| `doublegap-p19-k5.json` | the same ask at 19, with the kernel colouring's single-gap census beside it | the shared gap exists at 19 too; the kernel half is not taken (decision 10) | verified colouring | `python3 tools/fs38_tower.py doublegap --p 19` |
| `p4-tables.json` | level four's cover: the five committed tables (`Instances/TwoAdicFour.lean`) re-verified proper with their period groups, the intersection of those groups, and the smallest cover this tool could find in a pool | `covers_every_nonzero_difference: true` is exactly the hypothesis of `Forces.eq_of_forall_exists_not_periodic`, so the **list** (no single table) is what makes level four pairwise free. The minimum is a **search result** — an upper bound on the minimum, never a proof of minimality | verified colourings; the "no aperiodic table" fact is the solver's | `python3 tools/fs38_tower.py tables` |
| `recolour-p11-level2.json` | the level-2 repaint at 11: the certified table pulled back to `UD(ℤ/121,2)`, one lift of a gapped residue repainted to its gap colour, verified on every edge; the negative control repaints the same lift to each **present** colour | the repainted colouring is proper on every edge and separates the lifted vertex from all 120 of its fibre-mates — so no colouring of level two is pulled back from level one, and level two at 11 is **not 1-continuous** (FS-38 stub P2's instance). The kernel form is `pullbackRepaint` | exact arithmetic, no solver | `python3 tools/fs38_tower.py recolour` |
| `lrat/p5-plus-edge-edges.json`, `lrat/p5-plus-edge.lrat`, `lrat/manifest.json` | the formula for "`P₅` plus the edge `(0, δ)` at depth 4 is not 4-colourable" and cadical's LRAT proof, with every checksum | cadical exited 20 on the formula with the edge and 10 without it, and the proof's last line is the empty clause. **Nothing more**: there is no LRAT or DRAT checker on this machine (CLAUDE.md row 64's precedent), so the proof is **generated, not checked**. Consuming it in Lean is phase K3's | **generated, not checked** | `python3 tools/fs38_tower.py lrat` |
| `ckpt/` | resume files while a level is in flight; empty between runs | — | — | see `ckpt/README` |

## Three things a reader should know before quoting a number

1. **The graph is derived from a law, so a refusal is the suspect verdict** (CLAUDE.md § "A measured half and
   a derived half fail in opposite directions"): an invented edge would make the graph denser, make refusals
   arrive faster, and look like success. The guard is an **independent construction**: the genuine ring
   `R = (ℤ/16)[ω,π]/(π² − 2π − 2)`, built from its relations, in which the ideal `(π^m)` is computed as an
   explicit set of 65,536 ring multiples. Every level's record carries the comparison, and its `scope` field
   says what it does *not* test — the presentation itself (`π` Eisenstein over `ℤ₂[ω]`) is FS-38 §S3's
   `[hand 1]`. FS-38 §S3's own discriminating control, coincidence with the planning session's pilot graphs,
   is unrunnable: that code died with the session's scratchpad.
2. **The count `|S_m| = 3·2^(m−1)` is not a control.** §S3's perturbations fire only read as *halving* the
   coefficient of `N(B)` (`2 → 1`), which reproduces its numbers exactly. Read as *deleting* the term they
   cannot fire at all — the count stays `3·2^(m−1)` at every level 1..7 — and neither can a sign flip in `N`
   or in `Tr`. Four of six perturbations tried leave the count untouched. The self-test keeps the
   deleted-term row precisely so nobody reaches for the plant that cannot go red.
3. **The orbit fields.** Multiplication by any `s ∈ S_m` (a unit, `N(s) = 1`) and conjugation are graph
   automorphisms fixing 0 — checked as *set* equalities `s·S_m = S_m` and `conj(S_m) = S_m`, not merely
   closure — so forcedness and separation are constant on orbits. Where every difference was asked
   individually that is a free cross-check (a disagreement inside an orbit halts the run); at level 8 it is
   how every difference is *decided* from one ask per orbit. `orbits.sizes_total` counts all `4^m` vertices,
   the zero orbit's singleton included, so the nonzero total is `sizes_total − 1`.

## Not recorded here

* **Level 8** (65,536 vertices, degree 384, 12.6 M edges) — see `plans/FS38-tower-records.md` § R-T for
  whether it was run and at what cost; memory was measured at level 7 first, as the phase's brief required.
* **The CNF** for the level-5 LRAT: regenerable in a second from the committed edge list through
  `tools/coloring.py`'s `write_cnf`, and its SHA-256 is in the manifest. Only the edge list and the proof are
  committed.
* **Any kernel claim.** No file here is checked by Lean. The fan gap at 11 and 19, the level-4 cover and the
  level-5 refusal become theorems only in the modules that consume them.
* **The 2-adic law at the field level.** Nothing here draws a `K`-certificate into `P_m`; that is FS-38
  §S3's `[hand 2]`, row 57's open gap.
