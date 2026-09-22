# M60 — the derivation file: the five-colour residue obstruction at 11 (ledger row 55)

*Filed 2026-09-22 by FS-71 batch 3c. Read: `plans/M60-five-colour-residue-obstruction.md` §S1–S3 (the derivations),
§R0–R8 (the results). Most of row 55's content is already kernel — `Forces.image`, the distance law, the `5/3` answer
— per the brief's own seed; what survives outside the kernel is the *structural* justification behind the deciding
algorithm (D2) and one honest generalization (the hex-shell corollary, stated in the plan for every `p ≥ 5`, kernelized
only at `p = 11`).*

## The theorems

**M60-T1 — The compulsion sets of a Cayley plane are unions of norm classes. [hand; the M60 opening session]** For
`p ≡ 3 (mod 4)`, the orthogonal group `O(2, 𝔽_p)` (order `2(p+1)`) acts on `UD(𝔽_p, 2)` by automorphisms; its rotation
subgroup (the norm-one group of `𝔽_{p²}`, cyclic of order `p+1`) acts **freely and transitively** on each nonzero-norm
circle `{quad = c}` (no isotropic vectors, since `−1` is a non-square), so every such circle is one rotation orbit.
Hence `F_p(k) ∖ \{0\}` and `S_p(k)` (respectively the differences every `k`-colouring of the plane identifies, resp.
never coincides on) are **unions of the `p − 1` norm classes `N_c := \{d : quad\, d = c\}`, `c ∈ 𝔽_p^×`** — so deciding
each of the two sets reduces from `p² − 1` individual differences to `p − 1` classes, one representative check each.
*Proof:* `plans/M60-five-colour-residue-obstruction.md` §S2, "Structure" paragraph. *Proof verdict:* closes. *Rests on it:* the algorithm behind `tools/fpcompel.py sets` (deciding a class by one representative rather than exhaustively);
the measured table at 3, 7, 11, 19 (§S2's table) that reports `F_p(χ) = \{0\}`, `S_p(χ) = N₁` at all four primes — a
measurement whose *feasibility as a finite check* depends on this reduction. *Prior art:* the orbit-transitivity fact
is elementary (a Cayley graph on `𝔽_p²` with connection set a union of norm-one-group orbits, acted on by the
stabilizer of the origin) and is not separately attributed; the *use* of it to reduce a compulsion-set decision
problem is this entry's own. Not separately searched (a one-paragraph consequence of standard finite-field geometry).
*Kernel:* declined — the general orbit-transitivity statement for arbitrary `p` is not formalized; every kernel
instance (`finitePlane11_forces_iff` etc.) instead decides the specific table directly by `decide`, without invoking
the reduction.

**M60-T2 — The hex-shell corollary, for every sealing prime `p ≥ 5` at once. [hand, derived from row 48's kernel
theorem plus the transfer law and one elementary congruence; the M60 opening session]** Over any field with a usable
prime `p ≥ 5` whose residue plane is 5-colourable and pairwise free at five colours (`F_p(5) = \{0\}`, `S_p(5) = N₁`):
**no finite unit-distance graph separates a `√3`-pair or a distance-2 pair at five colours, and none forces either pair
equal** — each of the two hex-shell gadgets `six_le_chromaticNumber_plane_of_forced_pairs` (row 48, kernel) needs is
impossible *separately* over such a field, because `3 ≢ 0, 1` and `4 ≢ 0, 1` modulo every prime `p ≥ 5`. *Proof:*
`plans/M60-five-colour-residue-obstruction.md` §S3, "The hex-shell corollary" blockquote (the general statement, for
"every sealing prime at once"); the `p = 11` instance is kernel (`not_separated_sqrt3_11`, `not_separated_two_11`).
*Proof verdict:* closes for the general statement as elementary number theory (`3, 4 ∉ \{0, 1\} \bmod p` for any prime
`p ≥ 5` is immediate), *given* the hypothesis that the plane is pairwise free at five colours — which is itself
verified (not merely assumed) only at `p = 3, 7, 11, 19` in this batch's files (M60-T4/the reading below), so the
corollary's reach beyond those four primes rests on an unverified hypothesis for any *other* usable `p ≥ 5`. *Rests on it:* row 55's ledger text (the `√3`/distance-2 conclusions at 11); G26 (the design target: "a five-colour virtual edge
at distance 2 needs a 6-open field" — this entry is *why* a sealed field can never supply one); M61-T5 (the tightness
mechanism generalizes this corollary's mechanism from "gadget escapes a sealing prime" to "every forced pair's spindle
escapes the prime that sealed it"). *Prior art:* ours — row 48's kernel theorem and the transfer law are both this
project's; the congruence observation is elementary. Not separately searched. *Kernel:* declined at the general-`p`
level (the `p = 11` instance is kernel; a general theorem quantified over every prime `p ≥ 5` at which the plane is
pairwise free was never separately stated in Lean, only instantiated).

**M60-T3 — The arity-3 census of `UD(𝔽₁₁, 2)` at five colours. [tools; the M60 opening session]** Of the 31,602
admissible triple-pattern questions through the origin at five colours on `UD(𝔽₁₁, 2)`, **every one is realized on a
verified colouring** (31,598 on the certified table's 2,904 translates and rotations, plus 170 solver-sampled
colourings for the remainder, with only 4 resolved purely by solver models) — hence `arityFloor(UD(𝔽₁₁,2), 5) ∈ \{4, 5\}`,
matching the bracket M48 measured on de Grey's witness. *Proof:* `plans/M60-five-colour-residue-obstruction.md` §R1,
final sentence; §R3, "arity 3 of the plane at 11" row. *Proof verdict:* closes — this is a complete census over a
named finite domain (31,602 questions), not a sample, so it quantifies over exactly what was checked (M.1's rule for
`[tools]` grade). *Rests on it:* row 55's arity-floor bracket; G31's finite-plane analogue (arity-2 emptiness at every
sealed field, extended here one arity level for the sealing plane itself). *Prior art:* ours; a direct computation, not
separately searched. *Kernel:* declined — priced as a 31,602-question census, not attempted; the arity-2 case at the
same prime is kernel (`three_le_arityFloor_finitePlane11`).

## Readings and measurements that were called theorems

- **The uniform reading — "at every finite Euclidean plane whose exact chromatic number is known, at that number of
  colours, the plane has NO arity-2 compulsion beyond its edges"** (§S2, explicitly minted there "as G47's candidate").
  Measured at exactly four primes (3, 7, 19, 11 — `k = 3, 4, 5, 5` respectively), with the caveat the milestone itself
  states: "the single table's never-coincident norms 3, 4, 5 were the table, not the plane" (P5's refutation at `p = 7`
  — the first pass over-read one table's coincidental gaps as a plane fact, corrected by a per-class SAT check; G21
  in the plan's own words). This reading was later subsumed and superseded by row 66's kernel theorem (the fan-gap
  mechanism, FS-38), which proves the *general* fact for every 5-sealed field, not merely reports it at four measured
  primes — `CLAUDE.md` G47 itself notes it is "subsumed by row 66". Not filed in § B (it is exactly the "measurement
  called a theorem" case M.1 warns about: a general claim checked on a four-prime sample).
- **P7's "≥ 60 of the 86 undecided M55 asks settled by residue"** (§R4) — a registered prediction, refuted by the
  actual count (35 settled, 51 residue-allowed); the *reason* the prediction's uniform-1/11 assumption failed is left
  open (§R4: "the reason is open (T44)") and is not itself a theorem.

## Conjectures surfaced, not claimed

- **The field-level statement recurs a third time** (§R2: "NOT claimed: the field-level statement (that every
  unit-distance graph in Heule's field is such a certificate)") — the same gap as M58-derivation.md's, not re-filed.
- **T44 ("why 59% of the theorem-admitted candidates sit at residue norm 1")** — an open question named in the plan's
  own §R4, never resolved in this batch's files; not a theorem, no known consumer beyond curiosity. Not stub-worthy on
  its own (no milestone currently depends on the answer).

## Prior art re-attributed

None. This file's theorems are all self-contained combinations of kernel results already held; no external source
bears on them beyond what row 55's own text already names.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M60-T1 | declined — used only to justify the tool's algorithm; every kernel instance decides the specific table directly |
| M60-T2 | declined at the general-`p` level; the `p = 11` instance is kernel |
| M60-T3 | declined — priced as a 31,602-question census |
