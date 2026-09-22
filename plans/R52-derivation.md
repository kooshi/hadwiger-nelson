# R52 — the derivation file: the 2026-09-06 finite-plane bound analysis (ledger row 52)

*Filed 2026-09-22 by FS-71 batch 3c. Row 52 predates the M-numbered milestone series: it is a same-day exchange between
Kooshi and a web session (`reference/Chat-analysis/analysis.txt`, credited there as "your web-Claude session"), checked and
re-measured the same day by de Bruijn (`reference/Chat-analysis/VERIFICATION.md`). No `plans/M<nn>` file exists for it; the
two reference files are its whole written record, and M58 (`plans/M58-field-sieve.md`, filed separately as
`plans/M58-derivation.md`) reopens and generalizes its content three days later. Prefix `R52` per
`plans/FS71-theorem-audit.md` §M.2 (a ledger-row event, not a milestone).*

## The theorems

**R52-T1 — The finite-plane bound, odd residue degree. [hand; the web session, re-derived and checked here by de Bruijn]**
Let `F ⊂ ℝ` be a number field, `p ≡ 3 (mod 4)` a rational prime, and `𝔭` a prime of `F` above `p` with residue field
`𝔽_{p^f}` for odd `f` (so `−1` is a non-square there). Then every finite unit-distance graph in `F²` maps
homomorphically to `UD(𝔽_{p^f}, 2) = Cay(𝔽_{p^f}², \{(a,b) : a² + b² = 1\})`, hence `χ(F²) ≤ χ(UD(𝔽_{p^f}, 2))`. *Proof:*
`reference/Chat-analysis/analysis.txt` lines 7–9 (the theorem and its proof, `f = 1` stated, `f` odd noted as identical);
`reference/Chat-analysis/VERIFICATION.md` §1 (the same argument re-run by hand: `𝔭` unramified and inert in `F(i)` since
`p ≡ 3 (mod 4)`, so the residue field of the unique prime above it in `F(i)` is `𝔽_{p^f}(√−1) ≅ 𝔽_{p^{2f}}`; conjugation
reduces to Frobenius; a unit vector `z` has `zz̄ = 1` hence valuation 0 at that prime; translating one vertex to `0` makes
every vertex a sum of unit vectors, hence integral; reducing sends adjacent vertices to a norm-one residue difference,
i.e. a point of the circle). *Proof verdict:* closes. *Rests on it:* R52-T2, R52-T3, R52-T4; M58-T1, M58-T2 (which
generalize and correct it — see below); row 53; the whole field-sieve programme (FS-7, FS-11, FS-14, FS-15). *Prior art:*
partly: the reduction-to-a-finite-plane mechanism for a degree-one prime is `[Moorhouse2010]` §8.2/§10.3, `[Manturov2012]`
Thms 17–19, `[Madore2015]` Cor. 3.4 (all held and read, all predating this session — row 52's own text names them once
the sieve was checked against the literature at M58's prior-art gate); **the odd-residue-degree generalization beyond
degree one is not in any of the three** (each states the degree-one case only) and is this session's addition, confirmed
independently at M58 (M58-T1). zbMATH: `ab:"finite Euclidean graph" & ab:"chromatic number" & ab:"number field"` (0
hits), `ti:"unit distance" & ab:"finite field" & ab:"reduction"` (0 hits). *Kernel:* declined at this date — superseded
three days later by `Proofs/HadwigerNelson/UnitQuadrance.lean`'s `unitQuadrance.map` and `UDCert.drawing_adj` (M58-T1's
kernel form, certificate-level rather than field-level; see M58-derivation.md).

**R52-T2 — χ(UD(𝔽₁₁, 2)) = 5. [tools; the web session's DSATUR solver, cross-checked here by an independent
pysat/cadical run]** `UD(𝔽₁₁, 2)` (121 vertices, degree 12) is not 4-colourable and is 5-colourable.
*Proof:* `reference/Chat-analysis/analysis.txt` line 11 (three encodings — DSATUR, two relabellings — agree; the
5-colouring checked against the raw circle definition, 0 monochromatic pairs); `reference/Chat-analysis/VERIFICATION.md`
§2 (re-measured independently: `k = 4` UNSAT 0.0 s, `k = 5` SAT verified 0.1 s, `data/fplane/chi-p11.json`; controls
`χ(UD(𝔽₃,2)) = 3`, `χ(UD(𝔽₇,2)) = 4` — Vinh's computer value — `χ(UD(𝔽₁₃,2)) = 5` at the non-usable `p ≡ 1 (mod 4)`
control). *Proof verdict:* closes. *Rests on it:* R52-T3; M58-T1's re-derivation (`chromaticNumber_finitePlane11`,
kernel, no solver, via Heule-510's certified refusal of four plus the pullback five-colouring — the value's later
kernel-certified form). *Prior art:* `[Vinh2006]` (arXiv:math/0510092, cited as "Vinh2005" in the session's own
bibliography) brackets `χ(UD(𝔽_q,2))` at `[√q/2, (q+1)/2]` for prime `q` but computes the exact value only at `q = 7`; the
exact value at `q = 11` was, per both files' own literature check, not found in Vinh's paper or elsewhere ("looks
unrecorded" — `analysis.txt` line 11; `VERIFICATION.md` §4 calls this "the web session's reading, not confirmed by a
search of the literature", i.e. a claim, not a checked zero). zbMATH: `ab:"Kloosterman sum" & ab:"chromatic number"` (0
hits) — see M58-T1 for the systematic spectral check. *Kernel:* declined at this date — superseded by
`chromaticNumber_finitePlane11` (M58, kernel, no solver dependency).

**R52-T3 — Corollaries: exact values and a sealing list. [hand + tools; the web session, checked here]** Combining
R52-T1 and R52-T2 with the kernel-certified 5-chromaticity of Heule-510 (M06–M09) and of the T20 witness `W`
(K(√247)'s 5-forcer): **χ(ℚ(√3,√5,√11)²) = 5 exactly** (Heule-510 below via `[Fischer1990]`-style additive four-colour
impossibility plus a K(√5,√11)-plane certificate, `UD(𝔽₁₁,2)`'s 5-colouring pulled back above); **χ(K(√247)²) = 5**
likewise via `W`; **χ(K(√5)²) ≤ 5** and **χ(K(√5,√247)²) ≤ 5** (no matching lower-bound witness checked at this date).
*Proof:* `reference/Chat-analysis/VERIFICATION.md` §3, first two bullets (Heule-510 reduces into `UD(𝔽₁₁,2)` with all
2,504 edges landing on the circle, verified; `W` likewise with all 5,773 edges); `analysis.txt` line 13, corollary (1).
*Proof verdict:* closes for the two exact values (Heule-510 and `W`'s lower bounds are M06–M09's and M53's own
kernel/hand results, cited not re-derived); unsure for the two `≤ 5` claims stated with no matching lower bound in either
file (the claim is only ever the upper half). *Rests on it:* row 52's ledger text ("Sealed at 5: K(√5) = Heule's field,
K(√23), K(√247), K(√5, √247)"); M58-T2's generalization (the field-profile theorem, which subsumes this list and adds
K(√23)). *Prior art:* ours (the corollary combines R52-T1/T2 with M06–M09's and M53's independently-attributed results;
no held key or zbMATH query bears on the combination itself). *Kernel:* declined — no consumer beyond the exact values,
which M58 re-derives with no solver dependency.

**R52-T4 — No 6-chromatic unit-distance graph has all coordinates in a field with a degree-one prime above 11. [derived
from R52-T1, R52-T2]** For any number field `F` with a degree-one prime above 11 (K, K(√5), K(√247), K(√5,√247),
Heule's `ℚ(√3,√5,√11)` all qualify, per the sieve computed the same session), `χ(F²) ≤ χ(UD(𝔽₁₁,2)) = 5 < 6`. *Proof:*
`reference/Chat-analysis/analysis.txt` line 13, corollary (2); `VERIFICATION.md` §3, second bullet (the field list named
explicitly: K, K(√5), K(√247), K(√5,√247), Heule's field — "every object the descent (M49–M53), the copy-lock family
(M52), the T20 witness and the F₂₄₇ thickening (M54–M57) live in a field where 6 is impossible"). *Proof verdict:*
closes (immediate from R52-T1 + R52-T2 + `5 < 6`). *Rests on it:* the whole "sealed at 5" vocabulary (G43); row 53's
sharper form ("F ⊇ K is 6-open ⟺ the 2-adic wall is broken ∧ 11 is inert in F", M58-T2), which supersedes this entry by
naming the *exact* condition rather than one sufficient family. *Prior art:* ours (a one-line corollary; not separately
searched). *Kernel:* declined — subsumed by M58's `five_le_chromaticNumber_finitePlane131`-style instances and by the
general field-profile theorem, neither of which needed this entry's weaker form.

## Readings and measurements that were called theorems

- **"χ(UD(𝔽₁₁,2)) = 5 looks unrecorded [in the literature]"** (`analysis.txt` line 11) — a literature-search claim, not
  a theorem; `VERIFICATION.md` §4 itself demotes it to "the web session's reading, not confirmed by a search of the
  literature". Superseded at M58's own prior-art gate (batch 3c's own read of row 53's ledger text: `[Vinh2006]`
  restates the spectral bound "without a factor 2, which our kernel value at 19 contradicts" — a *different*, sharper
  finding about Vinh's paper, filed under M58-T1).
- **"De Grey's field has no usable prime below 131"** — a measurement (the sieve run on his coordinate list), not a
  theorem; restated and generalized by M58-T2's field-profile theorem, which explains *why* (√7 makes 11 inert) rather
  than only reporting the computed fact.
- **The Haugland 7-adic falsifier** (`analysis.txt` corollary (3): "7 is totally ramified in ℚ(ζ₇)... compute his
  field, factor 7") — a registered check, explicitly "not done" (`VERIFICATION.md` §3, last bullet). This is FS-8's
  territory (`CLAUDE.md` § Paths forward, "FS-8 Haugland 7-adic check"), unresolved here and not filed as a theorem.

## Conjectures surfaced, not claimed

None beyond R52-T3's two `≤ 5`-only claims, noted above as *unsure* rather than *closes* (no matching lower bound in
either file; not pursued further here since M58's field-profile theorem generalizes past the point of needing them).

## Prior art re-attributed

None new. `[Moorhouse2010]`, `[Manturov2012]`, `[Madore2015]` and `[Vinh2006]` were already correctly credited in
`VERIFICATION.md` §4 and in row 52's own ledger text at the time of writing; this audit found no correction to make.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| R52-T1 | declined — superseded by M58's certificate-level `unitQuadrance.map`/`UDCert.drawing_adj` |
| R52-T2 | declined — superseded by M58's `chromaticNumber_finitePlane11` (no solver) |
| R52-T3 | declined — the exact-value half is M58's; the `≤ 5`-only half has no consumer |
| R52-T4 | declined — subsumed by M58-T2's exact field-profile theorem |
