# FS-53 — the derivation file: the window for six colours

*Written 2026-09-23 by the FS-71 batch-6a implementer (`plans/FS71-theorem-audit.md`, row 69; G56–G58). Enumeration: read
in full — `data/fs53/window.md` (211 lines), `data/fs53/CLOSE.md` (86 lines), `data/fs53/README.md` (363 lines),
`data/fs53/g58/README.md` (65 lines), `plans/POROS-2026-09-15-fs53-planning.md` (438 lines); grepped and read at every
hit's neighbourhood — `plans/STUB-sixth-colour.md` (1,202 lines: §S4 "Derivations that fix the shape" and the G57 material
at lines 640–730 read closely, the rest by the pattern grep of `CLAUDE.md` §S.4), `data/fs53/PHASE-A0.md`, `PHASE-A.md`,
`PHASE-B.md`, `PHASE-K1K2.md` (grepped, no additional theorem-shaped content beyond what §§ below cite),
`plans/SESSION-HANDOFF-2026-09-15-fs53.md`, `plans/SESSION-HANDOFF-2026-09-15.md` (grepped and read at hits; confirms rather
than adds to the G56/G57 material). `Proofs/HadwigerNelson/CayleyCertificate.lean` (the kernel content — `colorable_finitePlane23_eight`,
already kernel, row 69's own line; no separate hand theorem hiding there). `LEDGER.md` row 69 read in full as the seed. Grades
are `CLAUDE.md` § Notation's. **G59 is out of scope for this file — see "Where the brief was wrong" in
`data/fs71/batch-6a.md`: its content (the `c = α/q^{3/2}` normalisation, the `√q/6` threshold, U₆₄'s Fourier-energy bound)
is not derivable from any FS-53 file and is dated 2026-09-18 in `CLAUDE.md`'s own text, after FS-53's close (2026-09-16)
and inside FS-54's territory (`plans/FS54-twenty-seven.md`, `plans/SESSION-HANDOFF-2026-09-16-fs54.md` both carry "the wall
is finite and fractional"); it belongs to whichever batch covers that material.***

## The theorems

**FS53-T1 — Hoffman-tightness forces `(k−1) ∣ (q+1)`. [hand; the advisor (Poros), 2026-09-15, adopted into the milestone's
plan]** For the finite Euclidean plane `UD(𝔽_q,2)`, `q ≡ 3 (mod 4)`, degree `d = q+1`: if the plane is Hoffman-tight at `k`
colours (`λ_min = −d/(k−1)` exactly), then `(k−1) ∣ (q+1)`. *Proof:* `λ_min` is an eigenvalue of the (integer) adjacency
matrix, hence an algebraic integer; `−d/(k−1)` is manifestly rational; a rational algebraic integer is an ordinary integer,
so `(k−1) ∣ d`. `plans/POROS-2026-09-15-fs53-planning.md` §3.5 ("A free sharpening of G54's classifier"). *Consequence,
checked at the window*: for `k=6` this needs `5 ∣ (q+1)`, which fails at `q ∈ {23, 27, 31, 43, 47, 67}` — six-slackness there
is therefore a divisibility theorem, not a numerical observation; it leaves only `q = 59, 79` (where `5 ∣ 60`, `5 ∣ 80`)
needing the explicit spectrum, already held (`λ_min = −14.9176 ≠ −12`, `−17.1019 ≠ −16`). Adopted into the subplan verbatim:
`plans/STUB-sixth-colour.md` §S4 D3 ("the advisor's sharpening of G54's classifier is correct and is used throughout … so
six-slackness there is a divisibility theorem"). *Proof verdict:* closes. *Rests on it:* G54's tight/slack classifier
restricted to `k=6` on the window (row 69); the window's own definition (G56); the P4 prediction of `plans/STUB-sixth-colour.md`
§0.3, upgraded from "high confidence" to a proof by this theorem. *Prior art:* ours — the fact "a rational eigenvalue of an
integer matrix is an integer" is textbook (algebraic-integer folklore), but its use here as a divisibility *obstruction to
Hoffman-tightness at a fixed colour count*, applied to exclude six window members outright, is not cited from a paper and is
not found under any query run. zbMATH not separately queried at this gate (an elementary, self-contained number fact; the
milestone's own record treats it as folklore-plus-application rather than as needing a literature check). *Kernel:* stub
(FS-41, `plans/STUB-forces-of-tight.md`) — "the project has no spectral infrastructure — no `λ_min`, no Hoffman bound, no
eigenvalue of an adjacency matrix — and building it is FS-41's whole milestone" (`plans/STUB-sixth-colour.md` §S4 D3); this
divisibility fact would be a one-line corollary of FS-41's Fourier-form Hoffman theory once built, not a separate development.

**FS53-T2 — G57: the window's clique split. [prior art (Krebs2022 Lemma 5.1, Vinh2008 Theorem 13) + derived: the transfer and the window-specific coincidence]** the window's clique-number split coincides with its field-exclusion split, and no candidate field holds a Moser spindle. (a) **[Krebs2022, prior art, re-verified here by direct search rather than cited]:**
`ω(UD(𝔽_q,2)) = 3` iff the characteristic is 3 or 3 is a square in `𝔽_q`, else `ω = 2`; verified at 21 planes spanning both
residue classes mod 4 (`q = 5,7,…,83`), 21 of 21 agreeing, so the rule holds uniformly in `q mod 4`, not only at
`q ≡ 3 (mod 4)`. (b) **[derived, the one-direction transfer]:** a real number field `F` has `√3 ∈ F` only if every usable
residue plane of `F` has `ω = 3` (usability requires `3` to be a square in `𝔽_q`, or the prime ramified with characteristic
`3`); so a usable plane with `ω = 2` (triangle-free) certifies `√3 ∉ F`. (c) **[derived, the window instance]:** the eight
window members split exactly four and four — `ω = 3` at `{23, 27, 47, 59}` (3 a square, or characteristic 3 at 27) and
triangle-free at `{31, 43, 67, 79}` (3 a non-square) — and this split coincides *exactly* with which radicand (`3` or `11`)
excludes the member for a field `⊇ K = ℚ(√3,√11)`: the four members excluded only by `√3` (`31,43,67,79`) are precisely the
triangle-free four, and the four excluded only by `√11` (`23,27,47,59`) are precisely the four with triangles. **So every
field this project has ever built (all contain `K`, hence both `√3` and `√11`) can reach NO window member** (G56's
exclusion, re-derived from the clique split rather than only from the direct Legendre-symbol computation), and since the
Moser spindle needs both `√3` (its rhombi) and `√11` (the twist `cos θ = 5/6`), **no field whose local bound could be 6
contains a Moser spindle** — every forcer this project holds is a spindle or a relative of one, so over a window field
there is nothing to build *from*. *Proof:* (a) `plans/STUB-sixth-colour.md` §"Q7" (lines 656–661, the 21-plane verification);
(b)–(c) lines 663–722 ("The split itself is prior art, and older than Krebs"; "The split is not a second fact — it IS the
exclusion"; the eight-row table of `(3/q)`, `(11/q)` at lines 700–709); confirmed independently in `plans/POROS-2026-09-15-fs53-planning.md`
§3.2 (the 27 exclusion line, found first there) and `plans/SESSION-HANDOFF-2026-09-15.md` items 2–3. *Proof verdict:* closes.
*Rests on it:* G56 (the field-level exclusion, row 69); G57 itself (the grokking this entry files); row 69's field-naming
table (the strategic redirection of any field-based hunt to `{23,27,47,59}` only); FS-53's own phase C.1 ("C.1's designer
must report that split explicitly per candidate"). *Prior art:* prior art `[Krebs2022]` Lemma 5.1 (the `ω` criterion itself
— re-verified, not re-derived, here); **prior art `[Vinh2008]` Theorem 13, older than Krebs and found by the advisor**: his
§3 already classifies the triangle-free members (`q = 12k±5`, i.e. `3` a non-square) as explicit Ramsey graphs disproving a
Chvátal conjecture and giving `R(3,k) ≥ Ω(k^{4/3})` — "neither the split nor an upper bound on `α` is ours" (`plans/STUB-sixth-colour.md`
line 668). **Ours**: the transfer from `ω` to field-usability exclusion, and the specific coincidence that the window's
clique split IS its Legendre-symbol exclusion split — Vinh wants `α` small for Ramsey purposes and never asks this question.
zbMATH not separately re-queried at this gate (both citations were found and verified by the milestone itself, `[Krebs2022]`
and `[Vinh2008]` already held in `BIBLIOGRAPHY.md`). *Kernel:* declined — the Legendre-symbol arithmetic is `decide`-able in
principle, but no stub currently plans a kernel form of this specific transfer argument; it becomes an instance of row 57's
field-to-ring gap (FS-47) once that closes, not before.

**FS53-T3 — G58: `τ` must fix a colour. [hand; the FS-53 phase (product owner / implementer), 2026-09-16]** For any
putative antipodally-symmetric colouring `c(−z) = τ(c(z))` of `UD(𝔽_q,2)` with `τ` an involution of the `k` colours: every
rotation fixes the origin, so `c(0) = τ(c(0))`, i.e. `τ` must fix at least one colour. **Consequence:** any candidate `τ`
that fixes no colour is refuted with no solver call at all; this accounts for **73 of the 226 rows refused across seven
equivariant sweeps (32%)**, including 17 of 43 at `q = 23` and 23 of 59 at `q = 47` — refusals that were never solver
evidence, and a filter the tool should apply before paying for a solver call. *Proof:* `data/fs53/g58/README.md`
§"Derived, not conjectured: τ must fix a colour" (lines 31–36). *Proof verdict:* closes. *Rests on it:* G58 itself (the
antipodal conjecture — a reading, existence-flavoured, NOT proved by this theorem, which is a one-sided necessary condition
only); the recommended fix to the equivariant-sweep tool (filter `τ`-fixed-point-free rows before any solver call); FS-55
(`plans/STUB-antipodal-colouring.md`, minted 2026-09-16 at FS-53's close, which carries this theorem verbatim in its own
description). *Prior art:* ours — `data/fs53/g58/README.md` §"Scope, honestly" records the prior-art gate run 2026-09-16
under two disciplines (graph theory: *colouring invariant under a graph automorphism*; algebraic combinatorics: *Cayley
graph colouring invariant under inversion*, *group-invariant colouring*, the *Burnside chromatic polynomial of
group-invariant graphs*) and found **nothing asserting or refuting the statement for any family**; two near neighbours
identified as NOT it — the *distinguishing* chromatic number (the opposite question) and the known failure of invariance
under the FULL automorphism group (which says nothing about one involution up to a colour permutation). *Kernel:* stub
(FS-55, `plans/STUB-antipodal-colouring.md`).

**FS53-T4 — 27 is the unique non-prime window member, and the reciprocity exclusion's eighth case. [derived; the FS-53
phase (product owner), 2026-09-16, first found by the advisor (Poros), 2026-09-15]** (a) A prime power `q = p^f` gives a
usable residue plane (`q ≡ 3 (mod 4)`, the condition under which `x²+y²=1` is a non-split conic with `q+1` points) **iff
`p ≡ 3 (mod 4)` and `f` is odd**: `p ≡ 1 (mod 4)` gives `p^f ≡ 1 (mod 4)` for every `f` (never usable); `p ≡ 3 (mod 4)` gives
`p^f ≡ p (mod 4)` for odd `f`, `≡ 1` for even `f`; `p = 2` gives `q ≡ 0` or `2 (mod 4)` (never usable). Among the odd prime
powers `≤ 97` (Weil's cutoff for six-colourability, `5|λ_min| ≥ q+1` failing from `q=98`), only **`27 = 3³`** satisfies this
— `25 = 5²` fails twice (`5 ≡ 1 (mod 4)`, and `f=2` even), `49 = 7²` fails once (`f=2` even, though `7 ≡ 3 (mod 4)` is fine);
the next candidates, `3⁵=243` and `7³=343`, exceed the cutoff. So 27 is the window's unique non-prime member, "now and for
good", and the tooling's prime-only assumption (`--p <PRIME>`) costs exactly this one member. (b) At `q=27`, since `3` is
itself ramified there (not a square/non-square question), G56's usual exclusion test does not typecheck; the correct
argument, completing the reciprocity exclusion's eighth case, is: `11 ≡ −1 (mod 3)`, and `−1` is a non-square in every
`𝔽_q` with `q ≡ 3 (mod 4)`, so `√11 ∉ 𝔽₂₇` and 27 is unusable for any field containing `√11`. *Proof:* (a) `data/fs53/window.md`
"Why 27 is the only non-prime member, and why 25 and 49 are not" (lines 161–189, with the table restating the congruence
argument); (b) `plans/POROS-2026-09-15-fs53-planning.md` §3.2 (lines 140–144, where the fact is first found, correcting the
subplan's §0.3 exclusion argument, which had typechecked only for prime `q`). *Proof verdict:* closes. *Rests on it:* G56's
window definition and its exclusion argument (row 69, now covering all eight members); the completeness of the window
table (eight members at FS-53's opening, narrowed to five by its close). *Prior art:* ours — the `p ≡ 3 (mod 4)`-and-`f`-odd
restatement of "usable" is elementary finite-field arithmetic and, per the searches run in this milestone's own record, not
cross-checked against a specific paper classifying usable prime POWERS this way (the held sources on finite Euclidean planes
— `[Moorhouse2010]`, `[Krebs2022]`, `[Vinh2005]`, `[Vinh2008]` — work at prime fields or leave the prime-power case implicit).
zbMATH not separately queried at this gate (an elementary congruence fact, judged not to need a literature check by the
milestone itself). *Kernel:* declined — no stub currently plans a kernel form of the prime-power usability criterion.

## Readings and measurements that were called theorems

- **`χ(UD(𝔽_q,2)) = ⌈q²/α(q)⌉` at every decided plane** ("integrality gap below 1"). [reading, registered as a hunch,
  status open at the time of the milestone's record — `plans/POROS-2026-09-15-fs53-planning.md` §3.5, "hunch:
  chi-equals-ceil-n-over-alpha"]. Verified at `q=3` (`α=3`) and `q=11` (`α=28`), consistent (not verified) at `q=7,19`
  where `α` is only bracketed. Explicitly framed as a *reading* with a stated falsifier (a decided plane with a verified
  colouring count above the ceiling), never promoted to a theorem in this milestone's own record — correctly not filed here.
- **The bias-corrected growth law for `α` (`α/Hoffman ≈ c·ln(d)/√d`)**, and its ω-split residual (Q7's registered
  prediction). [reading with a falsifier, `plans/STUB-sixth-colour.md` §S6]. **Scored at the close: LOST** (predicted
  α ≈ 96–97 at 23, found 87; predicted ≈166 at 31, found 146) — `data/fs53/CLOSE.md` "Predictions scored". Recorded as a
  demoted reading, not a theorem; its *shape* (asymmetric on the two ω-halves) is what FS53-T2 explains, but the specific
  numerical law itself failed.
- **The tightness calibration (`α/N` at the two exactly-known planes, 0.9938 at 7, 0.9597 at 11) and its non-linear
  extrapolation.** [measured]. `data/fs53/CLOSE.md` "The two calibration points" — explicitly notes "a linear reading in q
  was falsified by our own data", so no law is claimed; kept as a measurement guiding where compute is worth spending, not
  filed as a theorem.
- **The certificate's reach as a function of compute spent, not a fixed instrument property.** [method/measured]. Recorded
  throughout `data/fs53/window.md` and `README.md` (the 83 reach moving 0.8974 → 0.8836 from a longer solve on the same
  formulation); a discipline for reading a converged-vs-stopped certificate, not a theorem.
- **The equivariant sweep's undecided rows concentrate on the least-constrained symmetry classes**, and G58's evidence
  base (4 of 4 known-χ planes admit an antipodally symmetric optimal colouring, and no simpler form — identity or single
  transposition — survives at `q=19`). [measured]. The antipodal conjecture ITSELF (existence, at every plane) is a
  reading with its killing test (an optimal colouring with no antipodally-invariant form under any involution); FS53-T3
  above is only its derived necessary condition.

## Conjectures surfaced, not claimed

None found with a *gap* proof verdict — every theorem above closes on the evidence read. G58 (the antipodal conjecture
itself) is a standing reading, already tracked as such by `CLAUDE.md` and by FS-55's stub; it is not re-filed here as a
conjecture because it was never claimed as a theorem in FS-53's own record.

## Prior art re-attributed

- FS53-T2(a): `[Krebs2022]` Lemma 5.1 — already held and correctly attributed in `CLAUDE.md` G57; this audit confirms
  the attribution (re-verified by direct search here, not merely cited).
- FS53-T2(b)(c): **`[Vinh2008]` Theorem 13 is prior art for the triangle-free classification and its Ramsey use**, older
  than `[Krebs2022]` and found by the advisor (Poros) during FS-53's planning, already recorded in `CLAUDE.md` G56/G57 and
  `BIBLIOGRAPHY.md`; this audit confirms rather than newly finds the attribution.
- **The yearless key `GarciaMarcoKnauer` (cited in G58 with arXiv:2303.06262, no `BIBLIOGRAPHY.md` entry) is a miscitation, found at this
  gate**: arXiv:2303.06262 is `[Cervantes, Krebs, *Chromatic numbers of Cayley graphs of abelian groups: a matrix method*]`,
  already held as `[CervantesKrebs2023]`. The paper actually by I. García-Marco and K. Knauer on this topic is *Coloring
  minimal Cayley graphs*, **arXiv:2405.19543** (Math. Comb., 9 pp., v3 2024-12-06) — verified live (`arxiv.org/abs/2405.19543`).
  Added to `BIBLIOGRAPHY.md` § A as `[GarciaMarcoKnauer2024]`, **listing only** (not fetched, not read); the correct id
  and key are proposed for `CLAUDE.md` G58 in `data/fs71/batch-6a.md`'s "Proposed edits" section (the owner applies it).

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| FS53-T1 | **stub** (FS-41, `plans/STUB-forces-of-tight.md`) — a corollary of the Fourier-form Hoffman theory once built |
| FS53-T2 | declined — Legendre-symbol arithmetic; an instance of row 57's field-to-ring gap (FS-47) once it closes |
| FS53-T3 | **stub** (FS-55, `plans/STUB-antipodal-colouring.md`) |
| FS53-T4 | declined — no stub currently plans the prime-power usability criterion |
