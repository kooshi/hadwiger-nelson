# FS-73 close inventory — everything the close must save

*Written by the product owner on 2026-09-23 (evening), at Kooshi's request ("I don't want to lose anything from before. There's a
lot to save."), while the last two agents were still running. It merges three sources: the mid-milestone handoff (§2 and §5 of
`plans/SESSION-HANDOFF-2026-09-23-fs73-mid.md`), the owner's running notes from after the compaction, and every record the phases
produced. It is the close planner's checklist, one line per item with its source address. **An item not ticked at the close
is either done or explicitly declined in the close commit; nothing is dropped silently.***

Grades are those of `CLAUDE.md` § Notation. "Owner-checked" means the product owner re-derived or re-ran it with independent means.

## Close status (the close planner's ticks; ✅ done, ⏳ waiting, ✗ declined with its reason)

- §1 results: ✅ rows 78 (four colours, the census, the table, rank 6, the kernel) and 79 (three colours, ℚ(√11), the `Θ`
  certificate, ℚ(√167)); ✅ R9 verified (the owner's message): the "≥ 4" branch kept, the other two deleted; ⏳ two number slots in row 79
  (`⟨R9#E⟩`, `⟨R9#V2⟩`) wait for the final records. One judgement: the inventory's R1–R18 went into **two** rows, not one per result — the house
  shape is one row per milestone or per theorem family (rows 72–73, 76, 77), and eighteen rows would bury the two results that
  matter.
- §2 theorems: ✅ `plans/FS73-derivation.md` T1–T38, `LEDGER.md` § B 38 lines, `tools/fs71_ledger_b_check.py --strict` PASS;
  ✅ §7 of the file: E's and V2's theorems as T39–T44 (final records `909cf054`, `7931a25e`, `0e7b95e7`); row 79's R9 slots
  filled from them (three independent routes; the half-page proof; no finite witness exhibited; E's prediction lost).
- §3 grokkings: ✅ **G71 minted** (three colours linear, four not). Candidates folded as instances rather than entries: the period
  cap and the Fourier read → G21; B's tight-prime reading → G54 (restated with Poros's N3); the covert channel → G51 and the
  protocol document; the leaf-pricing rule → § What compute actually helps (a rule about cost, not about the mathematics).
  Corrections applied: G69 (745 / 2,044 against the balls; "nearly four orders"; `F = 8Λ` complete rigidity; *rigid* qualified
  against *frozen* and `[PeledSpinka2023]`), G61(2), G68 (gap sufficient, not necessary; the Kempe-period criterion), G60 and G66
  (the `F_μ` and odometer sentences), G70 (exhaustive on de Grey's lattice), G51 (the second run; its Do line moved to the
  four-colour question), G55 (the `8/9` pair and its spindle into K(√7) — the owner's note), FS58-T4's kernel note (and FS-39's
  phase A). ⏳ the §G re-read, the §PA sweep and the forward propagation: next commit (plan §R and the stubs).
- §4 mechanics: ✅ gates re-run 2026-09-23 22:44 UTC under the heavy lock — build up to date (1,698 modules, 2 s); axioms **1034 clean**,
  10 axiom-free, 5 declared purchases, no record changed since the previous run; vacuity OK, `declarations=6795
  refutations-skipped=278 sites=275`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=253 unknown=2` — § The gate, § Trust
  ledger and `scripts/vacuity-baseline.txt`'s header updated (the header's stale 6723 and 240 corrected); architecture PASS;
  bibliography audit green after two fixes: the alias table now resolves a yearless key (`[GarciaMarcoKnauer]`, from FS-71's
  committed brief; `tools/bib_audit.py`, a planted fake key still fires), and FS-73's owed entries added (`[Chandgotia2017]`,
  `[ChandgotiaPakTassy2019]`, `[MooreNewman2000]`, Liu's 2008 survey, Gao–Jackson–Krohne–Seward). § Delegation unchanged. ⏳ the
  fact audit and the size check run last.

**The first close planner stopped here (2026-09-23, near its ~450k-token budget), at a clean boundary: §1–§4 done and committed
(`2cda3170`, `7c459f86`, `ebe1c597`). A successor continues with §3's three sweeps, then §5–§9, in this order:**
1. ✅ (second close planner: `plans/STUB-algebraic-explanation.md` minted as FS-74, `plans/STUB-three-colour-criterion-kernel.md` as FS-75, `data/fs73/table/CORRECTIONS.md` with **five** stale rows, not four — the four "REFUSING (C3-aper case)" verdicts, `Q11|D30` identified as `Ld65c8ee8` by its key, plus `Q11|3int|D50`'s spectral label — and a pointer paragraph in `TABLE.md`'s hand-written header; the rows are not regenerated, because each correction comes from outside the row pipeline) **Dangling addresses to create first** (committed text already points at them): `plans/STUB-algebraic-explanation.md` (Kooshi's
   milestone: the K half of `F = 8Λ` — leads B's tight-prime reading now in G54, `Λ = (1/9)O_E`, `O_E/8O_E` against row 67's
   tower, Baxter's height on hexagonal fabric, `[MooreNewman2000]`; the ℚ(√11) half is derived, T25), `plans/STUB-three-colour-
   criterion-kernel.md` (T22's ⟹ and a box-LP / relation-form certificate checker over ℚ with its soundness theorem; smallest
   instance T41's 36 vectors, then T39; FS-60's Θ route), `data/fs73/table/CORRECTIONS.md` (§5's four stale rows; `report`
   regenerates TABLE.md from rows, so the corrections live beside it and TABLE.md gains a pointer paragraph).
2. ✅ (second close planner: `plans/FS73-rigidity-dichotomy.md` §R-close.1–.4, with a close banner at the top and "[superseded: E#]" markers at the three misleading spots. The G62/G7 miss is sharper than the note: `v = (83 + i√167)/84` **is** G7's type-M rotation at `n = 42` — written into G62 in `CLAUDE.md`. G71 forwarded into FS-48, FS-72, FS-60, FS-46 and FS-67's bearings; FS-59 at its rewrite, §8. One correction to the note: FS-48's d = 23, 47 lattices are loose **as built** (`Λ₂₄` per subfield), not every lattice of those fields) **§3's sweeps** into a new §R close section of `plans/FS73-rigidity-dichotomy.md`. The first planner's notes for them:
   *paid* — G68 (gap finder first; the fixed-prime lemma), G21 (H1-found vs H1: the census design), G27 (the Galois point group
   gave `v`'s orbit its rank 4), R3/T10 (membership), G65, G51, FS58-T4 (R1 to the kernel); *missed* — G21 itself, twice (P2's
   `N ≤ 20` and P2b's `N ≤ 30` period caps were not read as the enumeration's measure); **G62/G7: `L21cc6506`'s unit vectors are
   five rotated copies of the rational pattern (`U = B5·U_R`), a five-layer twisted multilayer — G62's "name every bilayer by its
   rotation and decide layer by layer" predicted the product route E found, and nobody extracted it** (Coxeter's float tree stalled
   on the 1,764 lifts); G65 (the owner's "smallest refusing ball" walked into its hardness band). *§PA sweep* — the gate named
   Chandgotia's height functions for four-cycle-free targets and Moore–Newman's four-colour height, and did not extract "three
   colours have heights, four do not" into §C; the competitors found it themselves → now G71. *Conjecture sweep* — done in
   `plans/FS73-derivation.md` §8. *Forward propagation of G71*: add a provisional-bearings line to STUB-biquadratic-table (χ = 3
   against 4 decided by `Θ₃`), STUB-last-lattice (four colours: no `Θ`; L3's gap-free looseness; the Kempe-period criterion),
   STUB-quadratic-witnesses-kernel (the `Θ` certificate replaces LRATs: T26, T39), STUB-three-colour-classification, STUB-tight-
   product-colourings (plus §8's FS-67 note), and the FS-59 rewrite.
3. ✅ (second close planner: the plan's edits as errata E1–E13 in §R-close.7 — the body is not rewritten, only marked; B's four as E11; the FS-70 table cell corrected in place in `data/fs70/owner/cm-subfields-2026-09-22.md` (the defect is in that table, not in FS70-derivation T5's prose); the predictions scored once in §R-close.5, with P-T2's final score (lost at `L21cc6506`), P-C5 as outcome (b)'s plateau closed by `F = P`, P-K1 split, P-R2 unscored, and the P-C1 id collision recorded; the retraction tally in §R-close.6 — **the plan stage is planner 4 / Poros 2 (3 by the first convention), not Poros 4**, per §X) **§5** — the plan's edits (T10.2's wording; §0's looseness criterion and consequence 5 closed; §C's "depth 6 (8/3)", "K may be
   the instance under test", "rank 2 at K" superseded; P1d′ outcome "P = F certified"; P-R1 per Kempe component; P4's "one ρ₁₅
   word" = KR6; P1e's first step; P1f's W′ column; T9 assumes integrality) and B's four (in phase-P2.md "proposed plan edits"),
   FS70-derivation T5's prose (3 splits in ℚ(√5,i)), P4's "2L3-periodic" note, the prediction table (already scored in rows 78–79;
   write it once in §R, with V2's one retraction — a planted fault that could not fire — in the tally beside Poros 1, de Bruijn 1,
   Coxeter 0 and the plan stage's Poros 4 / planner 4).
4. ✅ (second close planner: owner errors, slips and kills in the plan's §R-close.8; the protocol document's rule 1 gains the scratch-until-hand-back, read-exactly-two-files and do-not-open rules, and its §3 is rewritten as the second run's outcomes (the asymmetric card logged, the successor-advisor rule) with the next use named — FS-76; `CLAUDE.md` § Building's kill rule gains its ninth instance; the table tool's docstring names its self-locking and session paths, in the previous commit) **§6** — owner errors 1–7 and the agents' slips into §R; `plans/PROTOCOL-competitor-and-advisor.md` (working files and the
   advisor's record in scratch until hand-back; the advisor reads exactly the two working files; competitors do not open each
   other's file before hand-back; this run's outcomes); `CLAUDE.md` § Building's kill rule gains its ninth instance (killing a
   `flock` wrapper orphaned a child holding the lock ~17 min — kill the process group, verify against the work); P2's quotient
   code takes the lock itself (a `flock` wrap deadlocks) and writes CNFs into B's scratch — note in the tool's docstring or §R.
5. ✅ (second close planner: §R-close.10 of the plan, every query with its count. **Found:** row 78's headline count is Hubai's (Polymath16, 9 May 2018: 9,120 colourings, 380 with a triangle fixed, all 8-periodic, on the ring) and `8/9` with its K(√7) spindle is Parts's (2021) — both in the threads we hold; the PO approved the correction and its framing; row 78, T6, T7, G49, G55, G69, the Frontier, the prior-art paragraph, `[Hubai2018]`, `[Polymath16threads]`, FS-74's first lead and the plan's §R-close.2 and owner error 8 rewritten; Parts's radius-`8/√27` vertices checked, not `v`'s orbit (`data/fs73/prior-art/parts_v.py`). **Not found:** `χ(ℚ(√167)²) ≥ 4` in print; the rank-1 ⟹ direction; decidability. New rows `[Ruhland2024]`, `[TanZhang2026]`; `[PeledSpinka2023]` abstract read; the Semantic Scholar cross-check done; Mohar–Salas declined) **§7** — the prior-art queries (zbMATH API, recorded in §R): `8/9` or `v` as a forced pair over K in Polymath16/Parts;
   `χ(ℚ(√167)²) ≥ 4` in print; the three-colour criterion for abelian Cayley graphs with arbitrary finite generating sets and its
   rank-1 case; decidability of 4-colourability of Cayley graphs of ℤ^r; the Semantic Scholar cross-check of `[AbrishamiEtAl2025]`;
   `[PeledSpinka2023]`'s notion (bibliography row). Mohar–Salas: declined (P4 did not use Kempe classes on tori).
6. ✅ (second close planner: FS-76 `plans/STUB-four-colour-inheritance.md` (C3-aper at four, certificates and decidability — **one stub, not two**: a two-sided certificate exists iff four-colourability is decidable, and the colourable side's certificate is C3-aper at four, so they are one question), FS-77 `plans/STUB-kr6.md`, FS-78 `plans/STUB-five-colour-rigidity-table.md` (minted, not optional: it is the screen that says where FS-49's gadget can be built); FS-74 and FS-75 in the first commit; the FS-73 stub bannered; FS-59 rewritten (§0: four proven, the question now five, C's design rule re-run at four colours heading the routes; `L21cc6506`'s `v` is also `[Fischer1990]` Example 4's vector); FS-60's and FS-67's notes in §3's commit; `plans/FRONTIER-STUBS.md` re-ranked (FS-74 rank 1 as the default next, FS-59 2, FS-75 3, FS-76 4, FS-78 5, FS-77 6; FS-73 and FS-71 to the closed list; no FS milestone open; each FS id once as a row, the M63 row's FS-33 mention aside); `CLAUDE.md` § Paths forward rewritten to match) **§8** — new stubs: C3-aper at `k ≥ 4` (`[AbrishamiEtAl2025]` 4.6; FS-72's lattice; T30's rank-1 lab), four-colour certificates
   and decidability (T29), KR6's four-colourability (T34), optionally the `k = 5` rigidity table (T15's pilot); banners on
   `plans/STUB-rigidity-dichotomy.md` (closed, rows 78–79); FS-59's stub rewritten (first question answered: `χ ≥ 4`; next is five,
   a four-colour question where no `Θ` exists; C's design rule heads R2); FS-60 and FS-67 notes; `plans/FRONTIER-STUBS.md`
   re-ranked with a closed row for FS-73; `CLAUDE.md` § Paths forward (the open-milestones paragraph still names FS-73 next; the
   ranked table's FS-73 row and FS-59's "nothing above three proven" are stale).
7. **§9** — `tools/claude_md_fact_audit.py --base a640efec` and `--dupes` (was 15 runs); `CLAUDE.md` is 240,166 bytes (budget
   275,000); the close commit; the owner pushes.

---

## 1. Results → `LEDGER.md` rows (row 78 onward) and the Frontier

| # | result | grade | source | owner check |
|---|---|---|---|---|
| ✅ R1 | **De Grey's lattice over K = ℚ(√3,√11), four colours: F = P = 8Λ.** Λ = (1/9)O_E, E = ℚ(√−3,√−11), O_E = ℤ[ζ₆, w], w = (1+√−11)/2. The pair (0, v) with v = −(4/9)(1+√−11) = −(8/9)w is forced by 2,044 points + {0, v} (trimmed LRAT, 383,771 additions, 56.5 MB gz, in git). v's orbit under ζ₆ and conjugation spans 8Λ. Separators on Λ/8Λ give P ⊆ 8Λ. **Every four-colouring of the lattice is 8Λ-periodic**: 380 pinned colourings in 12 orbits. 8/9 = −(v + v̄) and Harder's 8/3 are elements of F. Colourings at period 2^a·m are 2^min(a,3)-periodic; odd periods 15 and 21 have no colouring; P_32 = 8Λ | cert | `data/fs73/records/phase-P1.md`; `data/fs73/census/cert/t-16_8_8_0-R1.5/`; `tools/fs73_cert_check.py` (frozen); `verify-P1d.md` (independent: Glucose + drat-trim, live negative controls; Lingeling break-free) | owner ran the checker (CERTIFIED 16 s); a planted vertex move was refused |
| ✅ R2 | **G70 holds on all 12 classes:** the only √3-clean colourings are Theorem B's two residue colourings, which form one orbit | tools | phase-P1.md (A2) | — |
| ✅ R3 | **ℚ(√11)'s Λ₁₀ (36 unit vectors, denominators dividing 10), three colours: F = P = 3Λ.** FS-58's forcers u₁ (52 points, orbit rank 2) and u₂ (65 points, orbit rank 4, index 9 in 3Λ) are both needed. 48 colourings, one orbit under the order-16 point group, all affine. **Now also derived with no forcer and no solver:** Θ₃(Λ₁₀) is exactly 16 isolated points of order 3 (de Bruijn T1; Coxeter H-ii/H-iv, 651-node exact tree), so every colouring is affine, and the 16 functionals have common kernel 3Λ | verified (V) + hand + exact tools | `verify-P2-q11.md`; `phase-P2.md`; `plans/FS73-C3-deBruijn.md` §2 C1; `plans/FS73-C3-Coxeter.md` §3–§4 | owner checked T1's middle step |
| ✅ R4 | Λ₅₀ = (1/5)Λ₁₀ at three colours: F = P = 3Λ₅₀ (P_15 exact) | tools, replicated, not independently verified | phase-P2.md | — |
| ✅ R5 | **The fixed-prime gap lemma:** a conjugation-fixed prime whose residue target has a gapped k-colouring makes every lattice of that CM field loose at k. 25 of K(√7)(i)'s 28 quartic CM subfields are loose at 5 for free. **Scope (implementer F, P4):** it reaches only lattices inside a quartic CM subfield, not the rank-6 ones | hand | phase-P2.md; phase-P4.md | — |
| ✅ R6 | **The classification table:** 32 lattices (`data/fs73/table/TABLE.md`). At four colours only de Grey's lattice is rigid; every CM subfield of ℚ(√3,√5), ℚ(√3,√23), ℚ(√3,√47) and K's other subfields is loose by a gapped periodic colouring at N ∈ {2, 3, 5, 7}. **Stale rows to regenerate (§5)** | tools | `e42b3a32` | — |
| ✅ R7 | **ℚ(√167), the screen.** L3e1c94c6 is three-coloured with period 23 (a gapped residue colouring at (23, √167 − 11); completeness of U proved; `tools/fs73_q167_check.py`). 52 of FS-61's 57 lattices carry certified gapped periodic 3-colourings; 3 are 3-integral; FS-61's null at 167 is explained. **Design rule at 23:** 224 symmetry classes of residue sets, 98 colour (every colourable one with a gap), 126 refuse, the smallest refusing set a hexagon coset. At 43 the smallest refusing sets have 5 pairs. Denominator sweep M ≤ 420: 16 values pass both 23 and 43 | cert | `phase-P2b-q167.md`; `3807b9f5`, `72129faf`, `b2e67b18` | owner asked for and got the completeness proof of U |
| ✅ R8 | **ℚ(√167) survivor Ld14c588b is three-colourable:** ψ = (43/108)a + (1309/2160)b − (59/240)c − (301/1080)e, colouring ⌊3{ψ}⌋, period index 1,080 (cyclic). The P2b searches stopped at N ≤ 30 and circular N ≤ 120 | exact | `data/fs73/q167/coxeter-Ld14c588b-linear-3colouring.json`; Coxeter C-4 | **owner verified independently** (own enumeration of the 44 unit vectors, Fractions, a plant) |
| ✅ R9 | **VERIFIED (the owner, 2026-09-23: V2 `7931a25e`, the owner's re-run and five plants); row 79 carries `χ(ℚ(√167)²) ≥ 4`, two number slots `⟨R9#…⟩` wait for the final records.** ℚ(√167) survivor L21cc6506: Implementer E reports Θ empty by an exact structural route (U = {1, v, v̄, z, z̄} × the 12 rational unit vectors, with v = (83+i√167)/84 and z = (1+i)(15−i√167)/28; 4,768 Farkas-refuted cases), with a second route building. Independent verifier V2 is running. **If verified: χ(ℚ(√167)²) ≥ 4, FS-59's target.** Grade: hand (the criterion) + cert | — | `phase-P3b-q167-theta.md`; `verify-P3b-q167.md` (both in progress) | slot open |
| ✅ R10 | **The three-colour inheritance theorem, for every Cayley graph of a finitely generated torsion-free abelian group** (Coxeter H-i to H-iv; de Bruijn T0 to T2): **(H-i/T0)** 3-colourable ⟺ some θ has θ(s) mod 1 ∈ [1/3, 2/3] on every generator ⟺ a periodic 3-colouring exists; **(H-iii)** periodic 3-colourings are dense, so P = F (C3-inherit) and C3-aper both hold at three colours; **(H-iv)** F has finite index ⟺ every cell of Θ is a point; **(T1)** if Θ₃ consists of order-3 points, every colouring is affine. No arithmetic of the lattice enters. This answers `[AbrishamiEtAl2025]` Problem 4.6 at χ = 3 for abelian Cayley graphs | hand (two independent derivations; Poros read both) | `plans/FS73-C3-Coxeter.md` §3; `plans/FS73-C3-deBruijn.md` §2; `7ea82cc3`, `eaa68452` | **owner checked T1's middle step (Stiemke, tightness) and H-iii's deciding step (the choice of N kills Q's torsion)** |
| ✅ R11 | **The Θ-emptiness certificate** (a new certificate type): an exact tree certificate plus a Fraction-only checker that re-enumerates U from the key. ℚ(√47) shape: 2,997 nodes, empty ⟹ that lattice is not 3-colourable, with no LRAT file. E added an exact certificate for Ld65c8ee8 over d = 11 (20,843 nodes, 4.9 MB) | cert | `data/fs73/coxeter-c3/certtree.py`, `certcheck.py`, `cert_47.json`; E's `tools/fs73_theta_*.py` | owner ran certcheck; plants (a child dropped; relabelled to d = 335) refused |
| ✅ R12 | **P-D3 (row 67) refuted:** G ∪ (G + 8/3) forces 16/3, which has 2-adic depth 4 at both primes | derived | phase-P1.md (A) | — |
| ✅ R13 | **The rich lattices over ℚ(√3,√5) (twounits:14/30/42), generator graphs only:** F_known = 0; P_found of rank 8 and finite index (twounits:14: Λ/P_found ≅ (ℤ/10)² × (ℤ/20)² × (ℤ/5460)⁴); 4/3, 8/3, 4, 4/7 and 4/√3 lie in P_found, and 2, 2/3 and i√3 do not; no gap at 2Λ, 4Λ, 6Λ or 2Λ ∩ W₁₁ (for each of the four primes); N = 5 and 7 inadmissible (1/p ∈ Λ for every odd p dividing the denominator). **Rigid-found, forcing undecided.** Poros N1: the targets lying in 4Λ are partly in P_found by construction | tools | `data/fs73/census/README.md`, `tools/fs73_census_check.py` (frozen); `2c953c2a`, `aed56f8b` | owner ran the checker (19 s); a planted dropped ±pair was refused (NOT_COMPLETE) |
| ✅ R14 | **Rank 6:** L3 is loose (F = P = 0) **without a gap**, by one colouring with KPer = 0 (the first such lattice, so a gap is sufficient for looseness, not necessary). L2 and L6 are loose by gapped colourings at N = 5. KR6 (de Grey's lattice + the ζ₆-orbit of ρ₁₅, over K(√5), rank 6, 78 unit vectors): no periodic colouring at N ≤ 6; F ⊇ 8Λ_dG; **its four-colourability is open**; Heule-510 is not contained in it | tools + hand | `phase-P4.md`; `tools/fs73_rank6.py`; `426ab20f`, `cb86f3e9` | **owner re-checked L3's certificate with D's frozen checker primitives:** exact Per has Λ/Per ≅ (ℤ/2)², so the colouring is additive (V₄); KPer = 0; plants refused |
| ✅ R15 | **The fibre-collision sandwich** (the rank-6 mechanism): D_Q ⊆ V_Q, and V_Q/D_Q is the image of Q's cycle space. A target escapes iff e ∉ V_Q: membership, not the index. Poros's 81 = 3⁴ on L3 is the arithmetic of the unit vectors mod 2, independent of the colouring | hand, measured on L3 | phase-P4.md | — |
| ✅ R16 | **Chirality:** 13 of 16 colourings at N ≥ 4 are chiral and non-additive, all on loose lattices. So chirality is necessary for a four-colour counterexample of Coxeter's shape and far from sufficient. Coxeter's C-5 is achiral up to translation | tools | phase-P4.md | — |
| ✅ R17 | **The kernel layer:** `Proofs/HadwigerNelson/Kempe.lean`, zero sorry, standard three axioms: `forcedSubgroup`, `periodicForcedSubgroup`, `InheritanceQuestion` and its iff, `forces_iff_exists_finite`, `notMem_periodicForcedSubgroup_of_voltageEscape`, `voltageEscapeZ` | kernel | `phase-P5.md`; `cb0813d1`; architecture row `9c8a60a5` | owner: 37 statement headers identical (plant detected); axioms purchased section unchanged |
| ✅ R18 | **The four-colour answer** (Kooshi's question): a Θ-type certificate cannot exist at four colours. K₄'s square complex is ℝP² (its double cover is the cube), so the only winding is ℤ/2, and there is no height and no slope polytope. Graphs exist that are colourable with no linear 4-colouring (C-5). A two-sided certificate exists iff 4-colourability of Cayley graphs of ℤ^r is decidable, which is unknown | hand | Coxeter §6; de Bruijn §4 | owner checked the ℝP² identification |

✅ (except item 12 and the ⟨R9⟩ slots, which wait for R9's verdict) **The Frontier** (`CLAUDE.md` § Frontier, "Where the problem stands"): rewrite items 14 (quadratic fields; ℚ(√167)), 18 (where a forcer can live: F = 8Λ at K, the three-colour theorem), 12 (the conjecture's ℚ(√167) prediction) and 13 or 17 if they are touched. Add a new item for the three-colour theorem, and the "last updated" line. Update the prior-art position ("Ours:").

## 2. Theorems → `plans/FS73-derivation.md` and `LEDGER.md` § B (WORKFLOW 9, the theorem sweep)

Read every "Theorems this phase proved" heading, never the prose:

| source | heading | notes |
|---|---|---|
| `data/fs73/records/phase-P1.md` | line 23 (A), A2's entries around line 447, line 718 (D) | includes Poros's identity Λ = (1/9)O_E, span(v-orbit) = 8Λ, and the P-D3 refutation |
| `data/fs73/records/verify-P1d.md` | line 6 | |
| `data/fs73/records/phase-P2.md` | line 30 | the fixed-prime gap lemma |
| `data/fs73/records/verify-P2-q11.md` | line 12 | |
| `data/fs73/records/phase-P2b-q167.md` | line 32 | |
| `data/fs73/records/phase-P4.md` | line 136 | the fibre-collision sandwich |
| `data/fs73/records/phase-P5.md` | line 7 | the kernel theorems (grade kernel) |
| `plans/FS73-C3-deBruijn.md` | §5, line 235 | T0, T1, T2, L1–L4 |
| `plans/FS73-C3-Coxeter.md` | **no such heading.** Extract from §3 (Lemmas 1–3, H-i to H-iv), §4 (C-4, C-5, C-7) and §6 | tell Coxeter's file owner nothing; the close does the extraction |
| `data/fs73/records/phase-P3b-q167-theta.md`, `verify-P3b-q167.md` | when finished | E's structural lemma (60 = 5 × 12); the Θ_R dodecagon |
| `plans/FS73-rigidity-dichotomy.md` | §K and §M.2's hand theorems: R1 (compactness), R2, R3 (H1 ⟺ Kempe-rigid via residual finiteness), T10.x; F = ⋂ of Kempe period groups (all colourings), P = the same over periodic colourings | the modeling planner's close note |
| `plans/POROS-2026-09-23-fs73-plan.md`, `-cert.md`, `-competition.md` | the advisor's identities (8/9 = −(v+v̄); the choice-of-N step) | credit, not new rows |

**Kernel decisions, one per theorem.**
- **v's certificate: declined** (Kooshi, 2026-09-23: "an attempt at an algebraic explanation in a separate milestone rather than formalizing a big graph"). The certificate and its standalone checker stand.
- **The three-colour criterion (T0, ⟹ direction): stub.** It is the kernel route for R9 if R9 is verified, and the kind of certificate Kooshi prefers.
- Everything else: stub or declined, one line each.

## 3. Understanding → `CLAUDE.md` § Grokkings (G67's form: trigger, Do, killing test or what it forbids)

✅ **New entries, candidates:** (see the status block)
- **Three colours are linear, four are not.** K₃'s universal cover is a line, so every 3-colouring of an abelian Cayley graph has a height with a slope. Periodic colourings are dense, and 3-colourability is an exact polytope question. K₄'s square complex is ℝP², so four colours carry only a parity. *Do:* at three colours, decide by Θ (a certificate, no solver); at four, expect no slope. *Forbids:* a Θ-type two-sided certificate at four colours.
- **Implementer B's tight-prime reading**, now half-explained: full-rank F where the lattice is integral at a conjugation-fixed prime with a Hoffman-tight target (2 at K, 3 at ℚ(√11)). At ℚ(√11) the Θ derivation explains it. Poros N3: the prime is split at ℚ(√11), not conjugation-fixed, and the reading had lost its clause "no other prime's quotient has a gap". Killing test in B's record.
- **Method:** a periodic search measures its period cap. Ld14c588b's colouring has index 1,080, beyond N ≤ 30 and circular N ≤ 120; L3e1c94c6's has period 23, beyond N ≤ 20. That is two G21 instances in one milestone.
- **Method:** Fourier-transform a solver's colouring before searching for periods (implementer C; FS-61's 1.47M-point colouring had a Fourier peak of 0.74).
- **Method:** price leaves in minutes after a fine obligation pass (implementer K: priced at 1.5 days, took 40 minutes).
- **Method:** a competitor's working file is a covert channel if it lives in `plans/` (the owner's pre-launch catch; see §6).

✅ **Corrections to existing entries:**
- **G69:** Harder's smallest forcer is 745 points, not our 23,083-point ball; "three orders of magnitude" is nearer four. Add F = 8Λ at K (rigidity is now complete there, not just "Kempe-rigid at 8/3").
- **G61:** "(2) … quotient screens never kill … blind" — three-colourability is now exact by Θ, and the affine-colouring observation at ℚ(√11) is a theorem (T1).
- **G68:** L3 is loose without a gap, so a gap is sufficient, not necessary; add the Kempe-period criterion.
- **G60 and G66:** the F_μ invariant-measure sentence and the profinite-completion sentence (the modeling planner's close note).
- **G70:** confirmed on de Grey's 12 classes.
- **G51:** this competition's outcome: both sides reached the same frame independently; the retraction counts (Poros 1, de Bruijn 1, Coxeter 0); the advisor was stood down at about 480k, and its successor was cancelled because advising had ended.
- **G21:** the two period-cap instances above.
- **"Rigid"** must be qualified against *frozen* (`[AlonEtAl2021]`) and `[PeledSpinka2023]`.
- **FS58-T4's kernel note:** Mathlib has `Finset.rado_selection` and `nonempty_hom_of_forall_finite_subgraph_hom` (FS-39's phase A as well).

**WORKFLOW 9, the other sweeps:**
- the §G re-read of the plan (which extractions paid; which entry should have borne and did not);
- the §PA sweep (what the prior-art gate learned about the object: the SFT/hom-shift frame, Chandgotia's heights);
- the conjecture sweep (`grep -n -i "conjecture\|not claimed" plans/FS73-rigidity-dichotomy.md`: 4 hits);
- forward propagation of every new grokking to the open stubs' provisional-bearings lines.

## 4. `CLAUDE.md` mechanics

- **§ The gate counts:** axioms 1004 → 1034 clean; vacuity declarations 6728 → 6795, refutations 270 → 278, sites 262 → 275, generic 240 → 253. Re-run to confirm; the P4 and E tools add no Lean. `scripts/vacuity-baseline.txt`'s header is stale (it reads 6723).
- **§ Delegation:** unchanged. Staffing stays at three agents and Opus 5.5.
- **The fact audit** at the close: `tools/claude_md_fact_audit.py --base <the previous close> --dupes`. **The size budget:** 275,000 bytes.

## 5. Plan and record fixes

- **The plan** (`plans/FS73-rigidity-dichotomy.md`, one writer, done at the close):
  - T10.2's wording: the escape is decided by e ∉ V_Q with V_Q = D_Q + the cycle voltages (membership, not the index);
  - §0: a lattice is loose ⟺ finitely many periodic colourings' Kempe period groups intersect in 0 (a gap is one way, L3 the other); consequence 5 closed;
  - §C: "depth 6 (8/3)" against depth 3 per prime; "K may be the instance under test" and "rank 2 at K" superseded;
  - P1d′'s outcomes should include "P = F certified";
  - P-R1 restated per Kempe component (the least-ℓ rule is a convention; 301 of 2,304 colourings escape only non-locally);
  - P4's row: "de Grey's lattice with one ρ₁₅ word" is KR6;
  - P1e's first step: "the gap finder at every admissible period with an odd part, including composite period groups";
  - P1f: the W′ column is n/a for census asks;
  - T9's single-prime reading assumes integrality at the prime.
- **B's four plan edits:** the 2-unit verdict is not inherited from T5; rank-2 denominator lattices are marked; chainability is field-relative (1/2 ∉ ℤ[U] over K, so 8/3 is not chainable in K²); the command is `tools/fs73_table.py table FIELD`. Also T5's prose defect: the prime above 3 splits in ℚ(√5, i) over ℚ(√5).
- **`TABLE.md` / `rows.jsonl`, regenerate** (the owner, not an agent):
  - L3e1c94c6's "refusing" is superseded (C's wording is in its record);
  - `Q11|3int|D50` "Hoffman-refuses" is stale (slack ≤ −0.5617 at a 7-torsion character; the tool was fixed but the table never regenerated);
  - `Q11|D30`'s "C3-aper case" is Ld65c8ee8 over d = 11, which is certified not 3-colourable;
  - by T0, no three-colour row can be a genuine aperiodic case.
- **P4 row note:** L3's certificate colouring is recorded as "2L3-periodic"; its exact period group is coarser (index 4). Harmless; say so.
- **Predictions to score in the close:**

  | outcome | predictions |
  |---|---|
  | won | P-C1, P-C2, P-C6, P-T1, P-R1 (index-81 component), C's P-C1/P-C1b, P-F1, P-F2, P-F4 |
  | lost | P-S1, P-C4, P-T2 (re-score: superseded by C), P-C3(b); E's P3b prediction if R9 is verified (it predicted nonempty at 60%) |
  | decided | P-C5 (P = F) |
  | void | P-C3(a) (inadmissible periods at registration), P-F3 (unreachable at registration) |
  | won on the verdict, lost on the mechanism | P-T3 |
  | held | G70 |
  | killed | Poros's hunches "both drift to rigidity" and "no inheritance theorem" (the latter at three colours) |

## 6. Process, honesty and protocol

- **Owner errors** (the close's honesty section):
  1. I asked for the "smallest refusing ball", which walked the solver into G65's hardness band (5 UNKNOWNs, about 2 hours).
  2. A wrong paraphrase to the verifier ("2 separable by a period-2 colouring"; 2 ∈ 2Λ).
  3. P-C3(a) was registered on inadmissible periods.
  4. The first briefs omitted the `to: "main"` channel (Kooshi caught it).
  5. I retired the 500k rotation rule together with the Opus quirks (Kooshi restored it).
  6. **New:** the P4 brief claimed the rank-6 lattices were loose by the fixed-prime gap lemma. It doesn't reach them, and F caught it before any run.
  7. **New:** the first competition drafts put the working files and the advisor's record in `plans/`, a covert channel. I caught it before launch.
- **Agents' slips, recorded without blame:**
  - two reported commit hashes that didn't exist (A, V), so every hash is checked against `git log`;
  - Coxeter's `pkill -f` killed its own shell;
  - two runs went over 2 minutes without the lock;
  - a killed `flock` wrapper's child held the lock for about 17 minutes;
  - an orphaned kissat (pid 884222) was killed by the owner;
  - F's finished agent kept re-waking and re-sending its hand-back until stopped.
- **Owner kills this milestone:**
  - orphan kissat 884222;
  - A's down-ladder run (the forfeit recorded);
  - de Bruijn's redundant `q167.py 348` run (the forfeit: nothing; that lattice was already settled).
- **`plans/PROTOCOL-competitor-and-advisor.md`:**
  - working files and the advisor's record live in the agents' scratch directories until hand-back;
  - the advisor may read exactly the two working files;
  - each competitor is told not to open the other's `plans/` file until it has handed back;
  - also this run's outcomes: the same frame reached independently; the held items offered at 15:15; the route-specific card logged; the advisor's successor cancelled once advising ended.
- **Tool defects:**
  - P2's quotient code in `tools/fs73_table.py` takes the lock itself, so a `flock` wrap deadlocks;
  - it writes CNFs into B's scratch directory;
  - an orphaned solver outlived its driver;
  - killing a `flock` wrapper can orphan a child that holds the lock: kill the process group and verify against the command. This is the ninth instance for `CLAUDE.md`'s kill rule.

## 7. Prior art owed (WORKFLOW 3.2 items; `BIBLIOGRAPHY.md` the same day)

- Is a four-colour forced pair at 8/9 (less than a unit apart) or at v over K anywhere in Polymath16 or Parts?
- The Semantic Scholar cross-check (HTTP 429 at the gate).
- `[PeledSpinka2023]`, read enough to state the collision over "rigid".
- **New:** is the three-colour criterion (H-i/T0) known for abelian Cayley graphs with an arbitrary finite generating set? What about rank 1 ("G(ℤ, D) is 3-colourable ⟺ κ(D) ≥ 1/3", recalled by Poros and retracted)? Coxeter's gate found Chandgotia's heights (Lemma 1, not claimed) and judged H-iii at the standard generators folklore (not claimed). Candidates: Chandgotia–Pak–Tassy 2019 (Kirszbraun-type theorems), `[FourUnitVectors2025]` (reproduced in one line), Liu 2008's survey.
- **New:** is 4-colourability of Cayley graphs of ℤ^r decidable? `[Burr1984]` covers several vertex orbits, not Cayley graphs.
- **New, if R9 is verified:** is χ(ℚ(√167)²) ≥ 4 in print?
- Mohar–Salas 2009: P4 did not need it, so declined.

## 8. New stubs and stub updates (`plans/FRONTIER-STUBS.md`, re-ranked)

- **The algebraic explanation** (Kooshi's milestone). The ℚ(√11) half is derived (R3); the K half remains. Leads: B's tight-prime reading; Λ = (1/9)O_E; O_E/8O_E as the product of the level-3 quotients at the two primes above 2; row 67's tower; Baxter's height on hexagonal fabric (Coxeter §6).
- **Four-colour certificates and decidability** (Kooshi's question, R18).
- **C3-aper at k ≥ 4** (`[AbrishamiEtAl2025]` Problem 4.6; FS-72's rank-8 lattice). It is now open only from four colours up.
- **KR6's four-colourability** (R14): period groups W ⊇ 8Λ_dG avoiding U, or a ℤ² tiling over de Grey's 4,096-class colourings.
- **The three-colour criterion in the kernel** (T0 ⟹), the route for R9.
- **The Θ certificate as the instrument for FS-60** (the quadratic witnesses without LRAT files, 13 fields).
- **FS-59 (ℚ(√167)):** rewrite around R7–R9 and C's design rule. If R9 is verified, the stub's first question is answered and the next is five. If not, all 57 of FS-61's lattices are 3-colourable.
- **FS-67:** a note (the finite-U quotient is a subgraph of the product).
- **Possibly:** a k = 5 rigidity table for 6-open fields (P2's pilot at ℚ(√3,√−77)).

## 9. Commits at the close

- `data/fs73/briefs/`: **already committed with this inventory** (the owner's scratch directory lives in `/tmp`, which a reboot can erase). It holds the P3 competitor and advisor briefs as sent, the held items H-1/H-2, and the P3b, P4 and V2 briefs. The competition is over, so nothing in them is secret any longer.
- The regenerated table (§5).
- `plans/FS73-derivation.md`, `LEDGER.md`, `CLAUDE.md`, `plans/FRONTIER-STUBS.md`, the new stubs and the plan edits.
- **The push:** 10 local commits since `72129faf`, plus the close. Kooshi agreed (2026-09-23) to push at the close once R9's verdict is recorded.
