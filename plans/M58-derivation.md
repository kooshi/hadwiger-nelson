# M58 — the derivation file: the field sieve (ledger row 53)

*Filed 2026-09-22 by FS-71 batch 3c. Read: `plans/M58-field-sieve.md` §S1–S3 (the derivations), §R0–R7 (the results). M58
opened three days after row 52's web-session analysis (`plans/R52-derivation.md`) and both generalizes it (odd residue
degree beyond the multiquadratic case, the exact 2-adic wall criterion) and corrects it (the stub's D3′ had the wall
criterion wrong; `[Vinh2006]`'s bound is shown to be missing a factor of 2).*

## The theorems

**M58-T1 — The Kloosterman spectral identity, and the Weil–Hoffman refusal of five from 59 up. [derived; the M58
opening session, from the finite-Euclidean-graph spectrum (Medrano–Myers–Stark–Terras) plus Weil's bound and Hoffman's
ratio bound]** For
`p ≡ 3 (mod 4)`, `UD(𝔽_p, 2)`'s adjacency eigenvalues are `λ(c) = −K(1, c/4)` for each nonzero norm class `c ∈ 𝔽_p^×`
(`K(u,v) = Σ_{t ∈ 𝔽_p^×} e((ut + v/t)/p)` the classical Kloosterman sum), checked numerically to residual `≤ 5.7·10⁻¹⁴`
against the full 2-D DFT at every `p ≡ 3 (mod 4)` below 600. Weil's `|K(u,v)| ≤ 2√p` and Hoffman's
`χ(G) ≥ 1 + λ_max/(−λ_min)` then give `χ(UD(𝔽_p, 2)) ≥ 1 + (p+1)/(2√p)`, hence **`χ > 5` for every `p ≥ 62`** (so every
usable `p ≥ 67` refuses five colours with no computation beyond Weil), with the exact spectrum extending the refusal
down to `p = 59` (Hoffman `5.022`, margin `0.022` against a float error `≤ 10⁻¹²`). *Proof:* `plans/M58-field-sieve.md`
§S2 (the identity, the Weil/Hoffman derivation, the table at 3–479), §R1. *Proof verdict:* closes. *A further consequence,
verified here, not separately tabulated in M58's or M61's own tables*: the identical argument gives `χ > 6` (i.e.
`χ ≥ 7`) whenever `p + 1 > 10√p`, first true (among primes `≡ 3 mod 4`) at **`p = 103`**
(`1 + 104/(2√103) = 6.124 > 6`; the previous candidate `p = 83` gives only `5.611` by Weil alone, reaching `≥ 6` there
only via the *exact* spectrum, `5.743`) — this is `CLAUDE.md` G44's "χ > 6 from p = 103" clause; it is a direct corollary
of this entry's formula and was confirmed by hand here, since no file in this batch computes it explicitly (M58's table
jumps `83 → 107`, M61 never revisits the threshold). *Rests on it:* row 53; M58-T2 (which needs "every usable `p ≥ 67`
refuses five" for `F ⊇ K`); M61-T2 (the odd-degree generalization of the same formula); G44; row 68's exact certificate
at 83 (a different, tighter instrument for the same target). *Prior art:* the spectral identity is second-hand from
`[MMST1998]` (Medrano–Myers–Stark–Terras 1996/98, cited via `[Vinh2006]`, both held); Weil's bound and Hoffman's ratio
bound are textbook. **A finding against prior art**: `[Vinh2006]` (arXiv:math/0510092) restates the spectral bound
without a factor of 2 (his bracket reads `[√p/2, (p+1)/2]`), which does not match this entry's kernel-checked exact
value at `p = 19` (`λ_min = −7.610` there, not the value his restated formula would give) — recorded in the entry and
row 53's own ledger text; not yet propagated to `BIBLIOGRAPHY.md`'s `[Vinh2006]` row (owed). zbMATH:
`ab:"Kloosterman sum" & ab:"chromatic number"` (0 hits). *Kernel:* declined — the spectral identity and the Weil/Hoffman
consequence are a float computation with a stated error bound, not formalized; the kernel instead certifies specific
values directly (`chromaticNumber_finitePlane11 = 5`, no spectrum needed).

**M58-T2 — The field profile for F ⊇ K: 6-open ⟺ wall broken ∧ 11 inert. [derived, from row 52's bound (R52-T1) plus
elementary quadratic reciprocity, generalized here from the multiquadratic case]** For a number field `F ⊇ K = ℚ(√3,√11)`,
the usable primes (those `p ≡ 3 (mod 4)` at which every radicand of `F` is a square mod `p`) are a subset of
`{p ≡ 11 (mod 12)} ∩ {p mod 11 ∈ {2, 6, 7, 8, 10}}` — **the only usable prime below 67 for any field containing K is
11** — so with M58-T1, `F ⊇ K` is 6-open (no usable prime seals it at 5) exactly when the 2-adic wall is broken
(Theorem B fails to four-colour it) and 11 is inert (some radicand a non-residue mod 11). *Proof:* `plans/M58-field-sieve.md`
§S1 (the reciprocity computation: 3 is a residue mod `p ≡ 3 (mod 4)` iff `p ≡ 11 (mod 12)`; `(11/p) = −(p/11)` for
`p ≡ 3 (mod 4)` both `≡ 3 mod 4`, so 11 is a residue iff `p` is a non-residue mod 11), §R2 (the field-profile statement
in full, the 19-field map `data/fplane/map.md`). *Proof verdict:* closes. *Rests on it:* row 53's headline
("over K, 6-open ⟺ wall broken ∧ 11 inert"); G43; M61-T5 (the tightness mechanism, which explains *why* the forcer's
field lands 6-open by this exact criterion); every field-table row in `data/fplane/map.md`. *Prior art:* the
reduction mechanism is `[Moorhouse2010]`/`[Manturov2012]`/`[Madore2015]` (as R52-T1); the specific reciprocity
computation for `F ⊇ K` and the "6-open ⟺" biconditional are not stated in any of the three (they stop at the
degree-one-prime reduction and do not specialize to a field's own radicand structure). zbMATH:
`ab:"local bound" & ab:"chromatic number" & ab:"number field"` (0 hits). *Kernel:* stub-worthy at the field level
(FS-47's "prime inversion in its general form... every number field, every prime" territory) — the ring-level
functoriality (`unitQuadrance.map`) is kernel; the reciprocity computation over `ℤ` is elementary number theory Lean
already holds (`ZMod.legendreSym`-adjacent) but was not formalized here.

**M58-T3 — The exact 2-adic wall criterion over K, correcting the stub. [hand; the M58 opening session]** For `F = K(√d)`,
`d` odd squarefree, the 2-adic wall (Theorem B's colourability criterion) breaks iff one of the four square classes
`{d, 3d, 11d, 33d}` is `≡ 7 (mod 8)` — equivalently **`d ≡ 5` or `7 (mod 8)`** (the `d ≡ 5` case works through
`3d ≡ 15 ≡ 7 (mod 8)`), correcting the pre-milestone stub's D3′, which had listed only `d ≡ 7 (mod 8)`. The smallest new
member is `d = 13` (`13 ≡ 5 mod 8`, `(13/11) = (2/11) = −1`, non-residue mod 11, hence 6-open by M58-T2). *Proof:*
`plans/M58-field-sieve.md` §S1, third paragraph (the four-class computation; ℚ₂'s square classes are `⟨−1, 2, 5⟩` with
`−1` the class `7 mod 8`, so an even class can never give `−1`). *Proof verdict:* closes. *Rests on it:* the candidate
radical list `{7, 13, 29, 61, 79, 85, 95, 101, 109, 127, 149, 151, 167, 173, 197, …}` (G37's list, confirmed here to be
M58's home, not M53's — batch 3a's flag); M58-T2. *Prior art:* the wall criterion's *general* form (odd square class
`≡ 7 mod 8`) is G35's, credited to this project throughout; the *four-class enumeration specific to K(√d)* is this
entry's own arithmetic, not separately searched (it is a two-line consequence of G35 applied to K's own square-class
group, `{1, 3, 11, 33}`). *Kernel:* declined — the general wall criterion is G35's kernel target (unresolved, per
`CLAUDE.md`'s own gate on G35); this specific four-class instance was never separately priced.

## Readings and measurements that were called theorems

- **"The stub's 'the Hoffman bracket may settle them for free' was right, and stronger than it guessed"** (§S2) — a
  retrospective comment on a registered prediction (P-something in the stub), not itself a theorem; the theorem is
  M58-T1.
- **The shadow sieve applied to de Grey's 1581 and its gen-1 closure at 131 and 479** (§S2, the four-row table) — a
  direct instance of Hoffman's bound on `Cay(𝔽_p², D)` for the specific direction sets `D` those two objects realize;
  not a general theorem (the general fact — Hoffman applies to any symmetric connection set via its DFT eigenvalues —
  is textbook and not separately claimed here). The numbers (e.g. "≥ 5 only" at 131 on the 1581's 55-direction shadow)
  are measurements, left undecided at the milestone's close (§R3 addendum) and finally not needed once M58-T2 made the
  field-level statement unconditional.
- **P4's re-registration ("for F ⊇ K the only sealing prime is 11")** — this is M58-T2 itself, already filed; the §R5
  table entry is the *scoring* of the registered prediction, not a separate claim.

## Conjectures surfaced, not claimed

- **D5 — the field-level statement, stated but explicitly priced and deferred** (§S3, §R4): "every finite
  unit-distance graph in the field is presentable as a `Valid` tower certificate with `11 ∤ denom` after translation"
  — needs the integrality of unit vectors at the primes above 11 plus the 2-power index of `ℤ[√3,√5,√11]` in `O_F`.
  Not proved here or anywhere in this batch's files; the same gap recurs at M59 (§R6, "the field-level statement stays
  a hand argument"), M60 (§R2, "NOT claimed: the field-level statement"), M61 (§R6, "the field-level statement... stays
  a hand argument"), and row 57's own "not proved" clause — one gap, named once here, cross-referenced everywhere else
  in this batch rather than re-filed. Consumer: FS-47 ("prime inversion in its general form... every number field,
  every prime").

## Prior art re-attributed

None promoted to a bibliography row this batch (the `[Vinh2006]` factor-of-2 finding was already recorded in row 53's
own text before this audit; propagating it into `BIBLIOGRAPHY.md`'s `[Vinh2006]` row is noted as owed, not done here to
avoid an unreviewed bibliography edit outside this audit's per-theorem procedure).

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M58-T1 | declined — a float derivation with a stated error bound; specific values are kernel-certified directly, not via the spectrum |
| M58-T2 | stub (FS-47) — the reciprocity computation over a general field is elementary number theory not yet formalized |
| M58-T3 | declined — folded into G35's still-open kernel target |
