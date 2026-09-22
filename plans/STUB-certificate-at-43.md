# FS-69 — the all-levels certificate at 43: a smaller relaxation, not a bigger machine

*Minted 2026-09-21 at FS-66's close, from Phase 2D's pricing (`plans/FS66-phase2-certificate.md` §R‴.8). Written for a reader with
no conversation memory. Read beside: `LEDGER.md` row 75, G66, G56 (the window), G59; `plans/FS66-phase2-certificate.md` §F, §C, §R′,
§R″, §R‴; `data/fs66/b1/SOUNDNESS.md`; `plans/STUB-fractional-wall.md` (FS-57), `plans/STUB-exact-independence-solver.md` (FS-65).*

## 1. The question, in plain language

FS-66 built an instrument: one inequality that every independent set of every level of a residue tower obeys, its symmetry-reduced
second-level moment relaxation, an exact integer certificate of the relaxation's bound `U`, and a frozen checker. At 7, 11, 19 and 23
it certified that no level of the tower reads a lower chromatic number than level one — and, as a by-product, it bounded the
independence number of the level-one plane itself better than the level-3 relaxation built for that purpose (77 against 80.59 at 19,
97 against 105 at 23). The plane at 43 is `ℚ(√167)`'s other usable residue plane below the spectral refusals (which start at 59), and
one of the five planes where a finite Euclidean plane could still be exactly six-chromatic (G56).

> **Can the same certificate be had at 43?** Five colours there need `U < 1849/5 = 369.8`; six need `U < 308.17`. The best independent
> set known has 258 points and the certified ceiling is 365 (FS-53's level-3 certificate) — so five colours have ≈ 30 % of margin, the
> roomiest of any open member, and six are ≈ 16 % below the best set.

## 2. What is known, and why "run it" is the wrong ask

**[measured, extrapolated]** Phase 2D's cost model reproduces the sizes at 19 and 23 to a few per cent (`K ≈ p⁵/48` orbits; scalar
rows ≈ 4.97·K; nonzeros ≈ block rows × (n+1)/2). At 43, as the instrument stands: ≈ 3.06 M orbits, 43 blocks of size ≈ 927, ≈ 15.2 M
scalar rows, ≈ 1.7 × 10¹⁰ nonzeros, **≈ 1.2 TB of host memory at assembly, ≈ 310 GB of GPU memory** (graphics card A has 32), ≈ 520 s per
iteration, **≈ 84 days to converge**; one exact rounding attempt ≈ 22 h; the frozen checker 1–2 days at ≈ 200 GB. Splitting each
character block by its fixing reflection (926 → 463 + 463) divides the eigenwork by four and the matrix by two and still leaves ≈ 21
days and ≈ 100 GB; the checker is untouched by it. **Nothing on the list fits this machine, and a larger machine is the wrong repair.**

**What is wanted is one integer, not an optimum.** Five colours at 43 need `U < 369.8`; the relaxation's value is unknown but the
instrument's reach has been 0.1 %, 0.7 %, 2 % and 11 % above the best known set at 7, 11, 19, 23 — at 43 that would read somewhere
between 258 and ≈ 290, far below 369.8. So a *weaker* relaxation that certifies `U < 369.8` is the whole ask, and there are three ways
to get one smaller than FS-66's:

1. **Fewer localising rows.** The second-level relaxation's box rows (`φ_x(1 − φ_y)`-type products, four per pair orbit) are what
   make 15 M rows; a first-level (Shor-type) relaxation plus the fibre-share inequality alone may already certify 369.8 — price its
   value at 23 first (does it read below 105.8?) before building anything at 43.
2. **The reflection split** (above), a factor of four on the eigenwork.
3. **Coarser symmetry**: the certificate needs only the translation-Fourier blocks; the orbit reduction under the full `O(2, 43) ×
   swap` group is what makes the build tractable but the checker's rebuild expensive — measure which side dominates at 43.

**Prior art owed** at the opening: the sparse-moment and chordal-decomposition literature for semidefinite relaxations of
independence problems on symmetric graphs (Lasserre, Laurent, de Klerk–Pasechnik on `ϑ`-like hierarchies; `[GvozdenovicLaurent2008]`
and `[GLV2009]` are already in the bibliography as listings), searched in that discipline's words.

## 3. Deliverables, cheapest first

1. **Price the weaker relaxations at 23** (hours, CPU): the value each reads against 105.8, so the choice at 43 is made on a measurement.
2. **Build the chosen relaxation at 43 and take its float reading** — only if step 1 shows a formulation whose 43-size fits 32 GB of
   GPU or 100 GB of host; checkpointed in chunks, `--scs-setting verbose=1` for in-chunk visibility, never under a wall.
3. **Round and certify with the frozen checker** (`--m 5`; `--m 6` for the record): expect the checker to need a format that can
   skip the naive product-table rebuild at this size — a checker change is a new soundness page and a new freeze, to be decided
   before, not after.
4. **Record** what it licenses: no level of the tower at 43 five-colourable; `α(UD(𝔽₄₃,2)) ≤ ⌊U⌋` against 365; `χ_Bor(ℚ₄₃²) ≥ 6`;
   and, with 23, **the conjecture's prediction at `ℚ(√167)` robust to every level of every usable tower below the spectral refusals**.

## 4. Bearing on χ(ℝ²) ≥ 6, stated honestly

**None directly; idle compute and reading-room work.** It completes FS-66's statement for `ℚ(√167)` (23 alone leaves 43 as the
one tower the certificate does not cover), and it attacks FS-57's fractional wall and FS-65's exact numbers from a direction neither
stub considered — if this instrument beats the level-3 relaxation at 43 and 47 as it did at 19 and 23, the six-colour thresholds there
(`α < 308` and `α < 368`) come into a certifier's reach for the first time. A six refused at 43 or 47 removes a window member (G56).

## 5. Failure and jackpot clauses

*Failure, stated in advance:* every relaxation that fits the machine reads above 369.8, in which case the record is a typed null
with the values read, and 43 stays "priced, not run". *Jackpot:* `U < 308.17` at 43 — six colours refused at every level, the window
for six loses a member, and `L(ℚ(√4703)) ≥ 7`. *Registered expectation (owner, 2026-09-21):* a first-level relaxation with the
fibre-share inequality reads below 105.8 at 23 and below 369.8 at 43 (confidence medium — the 11 % gap at 23 says the second level is
doing real work there); six at 43 is out of reach of any relaxation in this family (confidence high).
