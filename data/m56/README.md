# data/m56 — M56, the arithmetic of tightness (2026-09-06; `plans/M56-arithmetic-of-tightness.md`, results in §R)

The milestone's yardstick is Fischer's *additive colouring* restricted to a finite chunk: colour a point by a
group homomorphism of the chunk's difference lattice Λ (the ℤ-span of its unit edge vectors) into a group of
order k, nonzero on every edge vector. Every additive colouring is a proper colouring (`Proofs/HadwigerNelson/
Additive.lean`, `additiveColoring`), so the pairs every additive colouring identifies (F_add) CONTAIN the pairs
every colouring identifies (F_true), and a homomorphism separating a pair is a certificate that the pair is not
forced. Every record carries the stage's edge-list fingerprint, its exact coordinate frame, and a `claim_scope`.
Regenerate with `tools/additive.py` (`self-test` first; 27 planted controls).

**What a row licenses.** *A row reading `forced-additively` says every ADDITIVE colouring of this chunk gives the
pair one colour; it does NOT say every colouring does — the fabric's valuation-4 pairs are the standing
counterexample (forced-additively, separated by the solver). A row reading `separated-additively` or
`kempe-separated` comes with an explicit proper colouring in the same file, verified; it IS a certificate that
the pair is not forced. `vacuous` means no additive colouring exists and says nothing about χ.*

| artifact | stage | subcommand | instantiates | what a reader may conclude |
|---|---|---|---|---|
| `lattice-*.json` | any | `lattice` | Λ(X) (M1.1) | the lattice's rank and Hermite basis; the unit classes mod 2, 3, 4, 5, 7 |
| `homs-<stage>-k<k>.json` | any | `homs --k` | L2 (each listed colouring is proper, re-verified) | the complete additive colouring family (or a capped SAT sample: `exact: false`), with every colouring as a colour vector in the stage's vertex order — the certificates a sweep consumes |
| `forced-object-…-k4.json` | U (1,953 pts) | `forced --dial data/m53/rigidity-dial-it4.json` | L1 (depth ≥ 2 ⟹ forced-additively), L2 | the per-class table F_add vs the dial's F_true: depth-1 classes separated, depth-2 forced-additively but dial-free (non-additive separations), depth-3 forced |
| `kempe-object-…-k4.json` | U | `kempe --dial …` | M1.5 (each `kempe-separated` row carries a verified swapped colouring) | F_K: every depth-2 pair separated by a Kempe swap of an additive colouring; 187 kempe-forced pairs against the dial's 171 |
| `obstruct-<stage>-k<k>.json` | all | `obstruct --k` | L1's corollary (a unit vector in eΛ kills every hom into a group of exponent e — Fischer's 1/k obstruction, chunk form) | no additive colouring of that exponent; NEVER a χ claim. On the 1581 the 4Λ unit vector is its single cross edge (11, 802); on W it is the spindle chord (565, 1152) — L8 |
| `forced-EI-seed-unit-k5.json` | the seed's unit part (214 pts) | `forced --all` | L1, L2, L5 | over all 21,787 non-adjacent pairs exactly one is forced-additively: the forced pair (205, 206) |
| `forced-EI-seed-unit-k4.json` | the seed | `forced --classes 4,9,16,25` | L1 | the 11 distance-4 pairs forced-additively; cheats, d² = 9, 25 separated |
| `colourings-EI-seed-12graph-k5.json` | the seed as a {1,2}-graph | `tools/m56_dump_seed_colourings.py` | — | all 35 proper 5-colourings up to palette (complete: SAT blocking) |
| `additive-test-EI-seed-unit-k5.json`, `defect-EI-seed-unit-k5.json` | the seed | `additive-test`, `defect` | M1.3, M1.6 | 18 of the 35 are additive; the other 17 have additive defect 1 (12) or 2 (5) |
| `seed-G-additive-k5.json` | Exoo–Ismailescu's G (205 pts) | `tools/m56_seed_G.py` | M1.3 | all 18 of G's five-colourings are additive — G's colouring space is its additive family |
| `homs-heule510-k4.json`, `homs-heule510-k5.json`, `forced-heule510-k5.json`, `ask-heule510-k5.json` | Heule-510 | `homs`, `forced --all`, `tools/m56_ask_pairs.py` | L2; the jackpot protocol | no additive 4-colouring; 24 additive 5-colourings; 91 forced-additively pairs, all 91 refuted by the solver (no jackpot) |
| `homs-W-core-8over3-k5.json`, `forced-W-core-8over3-k5.json` | W (1,175 pts, K(√247)) | `homs`, `forced --all --sweep data/m53/witness-cheats-w5-rigidity.json` | L2 | 432 additive 5-colourings; 291 forced-additively pairs, every one recorded separated by the complete sweep |
| `colourings-sample-W-core-8over3-k5.json`, `defect-W-core-8over3-k5.json`, `additive-test-W-…`, `rr-defect-W-core-8over3-k5.json` | W | the sampler, `defect`, `tools/m56_rr_defect.py` | M1.6, D5 | 200 SAT-sampled five-colourings at additive defect 850–876 and residue-per-coset defect 816–880 (the random baseline ≈ 858); W − v four-colourings at RR defect 354–845 |
| `homs-degrey1581-k5.json`, `forced-degrey1581-k5.json` | de Grey's 1581 (`tools/degrey_cert.json`'s order = the M30 sweep's) | `homs --max 3000`, `forced --all --sweep build/m30-rigidity-1581-k5.json` | L2 | ≥ 2,981 additive 5-colourings (capped); the additively forced pairs against the complete M30 sweep |
| `obstruct-forcer791-field16-k4.json`, `forced-forcer791-field16-k4.json` | the 791-forcer (rebuilt through `construct.py`; `tools/m56_export_791.py`) | `obstruct`, `forced --classes 16,16/3` | L1 | no additive 4-colouring; its six forced pairs are `vacuous` for the theory |

The four L7 witness chunks (1/3 for the Moser twist; 1/4 for ρ₁₅, for (√5 + i√11)/4 in Heule's field, for ρ₂₄₇)
are planted stages of the self-test (`--planted l7-moser | l7-rho15 | l7-heule | l7-rho247`), not files.
