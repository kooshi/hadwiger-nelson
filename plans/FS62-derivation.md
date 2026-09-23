# FS-62 — the derivation file: G64's theorems (six is not a value) and G59's derived clauses of 2026-09-18

*Written 2026-09-23 by the FS-71 batch-6c implementer (`plans/FS71-theorem-audit.md`; G64's row: "target, batch 6"; G59's
row: "target, batch 6", moved here from FS-53 by batch 6a's own finding — G59 dates to 2026-09-18, two days after FS-53's
close, and its home is this conversation, not a milestone). **There is no milestone file for either**: G63/G64's
derivations live only in `data/fs62/` and `CLAUDE.md` itself (the brief's own words), so this file, not a
`plans/FS62-*.md` narrative, is the home. Enumeration: `plans/STUB-six-is-not-a-value.md` read in full (251 lines — the
primary source: its demotion banner, §1's S/W split with proof, §2a's G59 derivation, §3–§5); `data/fs62/README.md` read
in full (89 lines, `fq_chi.py`'s dim-2/dim-3 rebuild); `data/fs62/q19/README.md` read in full (280 lines); `data/fs62/q19/HANDOFF.md`
read in full (112 lines); `data/fs62/q19/fixedk/README.md` read in full (230 lines) — all FS-65 working material behind
the G59 measurements, grepped for additional theorem-shaped content beyond the four clauses the brief names (found: the
fixed-cardinality "`f(k) ≤ N` always" monotonicity fact, which belongs to FS-65's own eventual audit, not this one — FS-65
has not closed, is not in the FS-71 reader list, and its material here is read only as G59's supporting evidence, per the
brief's explicit scope). `CLAUDE.md` G59 and G64 (loaded, disk-authoritative) read in full. `tools/fq_chi.py` read for its
docstring only, per the brief (not run). Grades are `CLAUDE.md` § Notation's.*

## The theorems

**FS62-T1 — S implies W. [derived]** Let **S** be "no subfield `F ⊆ ℝ` has `χ(F²) = 6`" and **W** be "`χ(ℝ²) ∈ {5, 7}`".
Then **S ⟹ W**. *Proof:* trivially, since ℝ is a subfield of itself; restricted to number fields, via FS-39's bridge — if
`χ(ℝ²) = 6`, de Bruijn–Erdős gives a finite 6-chromatic unit-distance graph, its coordinates generate a number field `F`,
and `6 ≤ χ(F²) ≤ χ(ℝ²) = 6` gives a number field with `χ(F²) = 6`, contradicting S. *Proof:*
`plans/STUB-six-is-not-a-value.md` §1. *Proof verdict:* closes. **Demotion record, filed here because it is this
theorem's own history:** as minted 2026-09-17, this stub's headline claimed the full equivalence **S ⟺ W**, read in the
project as "Hadwiger–Nelson reduced from three values to two". **Corrected 2026-09-19: only S ⟹ W holds.** Both lines of
the original argument in fact established the same implication; nothing motivates the converse (`χ` is monotone up the
tower of fields, but its steps are irregular — one quadratic extension takes ℚ from 2 colours to `ℚ(√11)`'s 4), and if the
plane needs seven a strictly smaller field may perfectly well need exactly six. The withdrawal cost two days of compute
at `q = 19` (`data/fs62/q19/`, run under the banner that a set of 78 there would bear on `χ(ℝ²)`) whose **results are
sound and whose stated bearing on `χ(ℝ²)` is withdrawn** — they bear only on the wall (FS62-T3 below), never on W. *Rests on it:* FS-57 and FS-65's re-ranking (`plans/FRONTIER-STUBS.md`, both restated as bearing on the wall, not on χ(ℝ²));
FS62-T2 (the corrected exact form). *Prior art:* checked, none found — `plans/STUB-six-is-not-a-value.md` §5 records the
prior-art gate for the whole stub as never run before this audit; this audit's own queries (below, FS62-T4/T5's entries)
found nothing bearing on S or W specifically. *Kernel:* stub (FS-62's D1 in `plans/STUB-six-is-not-a-value.md` §3: "the
exact equivalence in the kernel — `χ(ℝ²) ≠ 6` ⟺ every six-chromatic number field has a seven-chromatic finite extension;
and S ⟹ W for number fields", priced at "hours, on top of FS-39", not built).

**FS62-T2 — The exact biconditional form of W. [derived]** `χ(ℝ²) ≠ 6` **⟺** every real number field `F` with `χ(F²) = 6`
has a finite real extension `F′` with `χ(F′²) = 7`. *Proof:* (⟸) if `χ(ℝ²) = 6`, the bridge gives a number field `F` with
`χ(F²) = 6`, and every real `F′ ⊇ F` has `6 ≤ χ(F′²) ≤ χ(ℝ²) = 6`, so no such `F′` reaches 7 — contradicting the
hypothesis, so `χ(ℝ²) ≠ 6`. (⟹) If `χ(ℝ²) ≠ 6` and some field has `χ(F²) = 6`, then (since `χ(ℝ²) ≥ χ(F²) = 6` and
`χ(ℝ²) ≠ 6`) `χ(ℝ²) = 7` (the classical interval is `{5,6,7}`), the bridge gives a number field `E` with `χ(E²) = 7`, and
the compositum `F′ = FE ⊆ ℝ` is a finite extension of `F` with `6 ≤ χ(F′²) ≤ 7`; since `F′ ⊇ E`, `χ(F′²) ≥ χ(E²) = 7`, so
`χ(F′²) = 7`. *Proof:* `plans/STUB-six-is-not-a-value.md` §1 (full proof given); adopted verbatim as a corollary
in `plans/STUB-plane-bridge.md` §5. *Proof verdict:* closes. *Rests on it:* the stub's own reading of what the wall (b)
and the gap theorem (c) can and cannot buy (§2); FS-39's phase C ("a rewrite of the prose sentences to cite it"). *Prior art:* ours — a restatement of Hadwiger–Nelson at its top rung, not a reduction of it ("six is never where the climb
stops", per the stub's own honest framing); not separately searched (the statement is a direct corollary of the bridge
and elementary set manipulation). *Kernel:* stub (FS-39 phase C / FS-62 D1, `plans/STUB-plane-bridge.md` §4 phase C — "the
corollary `chromaticNumber_plane_eq_iSup_numberField` and a rewrite of the prose sentences to cite it", an hour once the
bridge itself is built).

**FS62-T3 — S factors through the local bound and the window's finite classification (this is G64's own stated conclusion; the entry supplies its proof). [derived]** Combining `χ(F²) ≤ L(F)` (row 52, `M53-T1`, "Theorem A") with the classification of which
finite planes can possibly be exactly six-chromatic (rows 68–70; FS53-T1/T2, FS54-T5 — the window is `q ∈ {23, 27, 31,
43, 47}` and `U₆₄`, six named graphs, none decided at the time of writing): if `χ(F²) = 6` then `L(F) ≥ χ(F²) = 6`
(unconditional, from Theorem A alone); and `L(F) = 6` is possible **only** by one of the six named window graphs being
itself exactly six-chromatic, since every other prime power `q` (or inert-2 target) is already settled either way by the
certified spectra and certificates FS-53/FS-54/FS-57 hold. *Proof:* `plans/STUB-six-is-not-a-value.md` §2(a)–(c)
(the "S factors" argument) and §1's "the split, stated once" table. *Proof verdict:* closes for the unconditional half
(`χ(F²)=6 ⟹ L(F)≥6`, an immediate corollary of Theorem A); the *further* narrowing to "one of six named graphs" rests on
the finite classification already filed elsewhere (FS53-T1–T4, FS54-T2–T5) and is not conditional on "the wall holding"
— it is a structural fact about which finite planes remain undecided, true regardless of how they are eventually
decided. **What remains open and is NOT part of this theorem:** part (c), the field-internal gap theorem
`χ(F²) ≥ 6 ⟹ χ(F²) ≥ 7`, which would need a six-colour forced pair inside a hypothetically six-chromatic field's own
fabric — explicitly named in the stub as this repository's own open structural question ("is a pigeonhole necessary?")
asked at six instead of five, and explicitly **not** claimed. *Rests on it:* the stub's §1 "split" table (the three-row
classification by local bound); FS-57 and FS-65 (both aimed at deciding two of the six named graphs, 47 and `U₆₄`).
*Prior art:* ours — the synthesis of Theorem A with the window classification; both pieces are separately attributed
elsewhere (Theorem A partly `[Moorhouse2010]`/`[Madore2015]`, filed as `M53-T1`; the window classification is this
project's own, FS-53/FS-54). *Kernel:* declined — a synthesis of two already-stubbed/kernel-partial results, no
independent target.

**FS62-T4 — Three mechanism theorems constrain the colour count of every structured colouring this project builds, and 6 is excluded by all three. [derived]** Every *structured* colouring this project has ever produced constrains its colour
count to a specific number-theoretic form: **(i)** a residue colouring (Theorem A) colours by the size of a residue
field, hence a **prime power**; **(ii)** a coset colouring of the triangular lattice by a rotation-stable sublattice
colours by the index of an ideal of the Eisenstein integers, hence a **Loeschian number** (`a² + ab + b²`); **(iii)** the
same construction on the square lattice colours by the index of an ideal of the Gaussian integers, hence a **sum of two
squares**. **6 is the smallest positive integer that is none of the three**, for three independent number-theoretic
reasons: it is not a prime power (2·3); in the Eisenstein integers, 2 is inert and 3 ramifies, so no ideal has index 6;
in the Gaussian integers, 2 ramifies and 3 (≡ 3 mod 4) is inert, so likewise no ideal has index 6. *Proof:*
`CLAUDE.md` G64 (the mechanism paragraph, dated 2026-09-18 in the grokking's own text; no separate plan file found —
searched `data/fs62/`, `plans/STUB-six-is-not-a-value.md` for "Loeschian", "sum of two squares", "prime power": no hits
outside `CLAUDE.md` itself). *Proof verdict:* closes for each of the three named mechanisms as a mathematical fact
(classical algebraic number theory: ideal norms in `ℤ[i]` are exactly the sums of two squares by unique factorisation and
the splitting of rational primes; ideal norms in the Eisenstein integers are exactly the Loeschian numbers by the
analogous factorisation; a residue field's size is a prime power by definition) — the specific claim that a *coset*
colouring's colour count is always such a norm is this project's own recognition (row 34, G62), not independently
re-derived here beyond citing the classical fact. *Rests on it:* the norm reading (below, explicitly **not** a theorem);
row 34's "2, 5, 6 are not `a² + ab + b²`" observation, of which this is the completed three-mechanism form. *Prior art:*
the norm characterisations themselves are textbook algebraic number theory (Fermat's two-square theorem and its
Eisenstein analogue), not attributed to any paper this project holds; zbMATH `ab:"sum of two squares" & ab:"ideal norm" &
ab:"colouring"` (0 hits), `ti:"Loeschian" & ab:"norm"` (0 hits) — the *application* to colouring counts of unit-distance
constructions was not found in print. *Kernel:* declined — no consumer named; the mechanism is used only to support the
(explicitly non-theorem) norm reading below.

**FS62-T5 — The independence-number normalisation and the six-colour threshold. [derived]** Write
`c(q) = α(UD(𝔽_q,2)) / q^{3/2}`. Since these graphs are vertex-transitive, `χ_f = q²/α = √q/c`, and `χ ≥ ⌈χ_f⌉`, so a plane
needs six colours only if `c(q) ≲ √q/6` — **a threshold that grows with `q`**, against an observed maximum near a
constant (0.756 to 0.918 across `q = 7, 11, 19` at the time of writing). The threshold crosses the observed maximum
(0.92) at `q ≈ 30.5`. *Proof:* immediate from `χ_f = q²/α` (a standard fact about vertex-transitive graphs — the
fractional chromatic number equals the vertex count over the independence number) and the substitution
`α = c·q^{3/2}`: `χ_f = q²/(c q^{3/2}) = q^{1/2}/c`. Setting `χ_f = 6` gives the threshold `c = √q/6`. *Proof:*
`plans/STUB-six-is-not-a-value.md` §2a (2026-09-18, "out of a conversation with Kooshi that started on the complex plane
and the quaternions" — the derivation itself is elementary algebra once the normalisation is chosen; the choice of
normalisation is the substance). *Proof verdict:* closes. *Rests on it:* FS62-T6 below; the stub's reading "six is not
special; the family is discrete and the function climbs" (a reading, not filed); FS-57's re-scoped pricing table (which
member is closest to its own threshold). *Prior art:* the fact `χ_f = n/α` for vertex-transitive graphs is textbook
fractional-graph-colouring folklore, already attributed as such in `FS54-T5`'s entry (batch 6b); the `q^{3/2}`
normalisation and its threshold reading are this project's own; zbMATH `ti:"value set" & ab:"chromatic number" & ab:"field"`
(0 hits), `ab:"chromatic gap" & ab:"graph family"` (0 hits). *Kernel:* declined — a reading instrument, not itself a
kernel target (the underlying `χ_f = n/α` fact and the wall certificates it explains are FS54-T5's kernel-adjacent
territory, already handled there).

**FS62-T6 — No uniform bound `c(q) ≤ C` with `C < 0.799` can close the window member at `q = 23`. [derived]** Since
`c(19) ≥ 0.918` is an established **lower** bound on the true value (from a verified independent set of 76 found at
`q = 19`, `data/fs62/q19/README.md`), any statement of the form "`c(q) ≤ C` for every (odd) `q` in this family" with
`C < 0.799` is false, because it would in particular assert `c(19) ≤ C < 0.799`, contradicting the measured
`c(19) ≥ 0.918`. Since excluding six at `q = 23` by such a uniform bound needs `C < 0.799` (23's own threshold, from
`FS62-T5` with `q = 23`: `√23/6 ≈ 0.799`, refined to the exact fractional form `529/6/23^{3/2} = 0.799` in the source),
**no uniform bound of this shape can close 23**. *Proof:* the argument above is a one-line existence counterexample once
`c(19) ≥ 0.918` is on record; `plans/STUB-six-is-not-a-value.md` §2a item 2 states the conclusion ("No uniform bound can
close 23: it needs `c < 0.799` while 19 itself reaches 0.918") without spelling out the one-line contradiction, which is
supplied here. *Proof verdict:* closes. *Rests on it:* the stub's D5 deliverable ("the uniform independence bound
`α(UD(𝔽_q,2)) ≤ 0.93·q^{3/2}` for odd `q ≥ 23`... closes 31, 43 and 47 in one theorem, cutting the wall from six members
to two" — this theorem shows the *same* route cannot also reach 23, so the wall's remaining hard cases after any such
uniform theorem are 23, 27 and `U₆₄`, not just 27 and `U₆₄`); FS-57's re-ranking (§2a item 4: D5 itself is priced as "a
long shot", needing 19% beyond the instrument's best single-member result). *Prior art:* ours — elementary, not searched
separately (the content is a numeric contradiction from data already in `CLAUDE.md`/`data/fs62/`). *Kernel:* declined —
an exclusion argument about a *hypothetical* future theorem (D5), not itself a target; nothing to build.

## Readings and measurements that were called theorems

* **The norm reading** ("every chromatic number this project has ever pinned for a plane over a coefficient structure is
  2, 3, 4, 5 or 7 — exactly the integers ≤ 7 that are `a² + b²` or `a² + ab + b²`, and 6 is the smallest that is
  neither"). **Explicitly [reading], not a theorem**, per `CLAUDE.md` G64's own text: "no mechanism at the finite
  planes... this is half numerology and is labelled so", and its own self-correction ("the mechanism half... WEAKENS the
  reading rather than supporting it... five has no mechanism either, and five occurs: the pattern already fails at the
  value immediately below the one it is being used to explain"). FS62-T4 above is the mechanism half; the reading itself
  (that the *pattern* explains or predicts anything about χ(ℝ²)) is carried as a reading with its own killing tests (a
  six-colouring at 17, at `U₆₄`, or at any window member) and is never promoted here.
* **"Six is not special; the family is discrete and the function climbs"** (`plans/STUB-six-is-not-a-value.md` §2a item
  1). A reading about *why* the wall's five-member window sits where it does, explicitly flagged as "a far weaker and
  more contingent reason" than the norm reading — not a theorem, and the stub notes its own sharpening of the "six is
  skipped is not evidence for seven" trap.
* **`fq_chi.py`'s dimension-2/dimension-3 rebuild** (`data/fs62/README.md`). An independent re-measurement: χ = 3, 4, 3,
  5, 5 at `q = 3, 7, 9, 11, 19` (matching `[Moorhouse2010]` Table 6.1 and the kernel at 11), clique numbers 3, 2, 3, 3, 2
  (matching `[Krebs2022]` Thm 5.2), and two new decided values (`q = 5, 13`, both χ = 3, χ = 5 — **not claimed as new**:
  "almost certainly his [Moorhouse's] table's too and are not claimed — prior art unchecked, owed to FS-62's gate", which
  this audit does not discharge, since it was never separately searched here either). The dimension-3 probe is explicitly
  a **null result about the probe's own design**, not evidence for or against the reading ("every three-dimensional case
  the budget decides is either 3... or at least 7... there is no case near six for an answer to land on"). A
  measurement, not a theorem.
* **The fixed-cardinality moment-equation fact `f(k) ≤ N` always** (`data/fs62/q19/fixedk/README.md`: "adding constraints
  cannot raise a maximum"). A trivial LP-monotonicity fact used inside FS-65's own instrument; **not filed here** — it
  belongs to FS-65's eventual audit when that milestone closes (FS-65 is not a closed milestone, is not in the FS-71
  reader list, and its q=19 material is read in this batch only as G59's supporting evidence, per the brief's scope).
* **"The wall is finite"** (G59's own phrase, restating χ(U_Q) ≠ 6 settled everywhere except the six named `Q`) and
  **the U₆₄ Fourier-energy bound** (a 683-set must carry ≥ 50.2% of its energy on the least eigenspace). **Both already
  filed**: the fractional wall `W_f` with no rounding and its CRT-product closure is `FS54-T5` (batch 6b); the Fourier-
  energy bound at `U₆₄` is `FS54-T11` (batch 6b). Confirmed by re-reading both entries against `CLAUDE.md` G59's text: the
  statements match exactly. Not refiled here — the brief's seed line named them as "G59's derived clauses... file them as
  FS62-Tn", but they were proved and filed at FS-54's own close (2026-09-16), two days before this section of G59 was
  written (2026-09-18); G59 restates them, it does not re-derive them. Recorded as a "where the brief was wrong" item in
  the batch report.

## Conjectures surfaced, not claimed

* **The gap theorem** `χ(F²) ≥ 6 ⟹ χ(F²) ≥ 7` (FS62-T3's part (c)) — open; "nobody has a 6-colour forced pair over any
  field, and G31 says every compulsion sweep this project has run returned zero at the top rung" (the stub's own
  expectation, high confidence it resists).
* **D5, the uniform independence bound** `α(UD(𝔽_q,2)) ≤ 0.93·q^{3/2}` — a long shot, priced but not attempted; FS62-T6
  shows it cannot, in its stated form, also close 23.

## Prior art re-attributed

None — every query run for this file's theorems (recorded above) returned nothing bearing on S, W, the wall's threshold
form, or the three-mechanism argument; nothing here required a change to `BIBLIOGRAPHY.md`.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| FS62-T1 | **stub** — FS-62 D1 (`plans/STUB-six-is-not-a-value.md` §3), priced "hours, on top of FS-39" |
| FS62-T2 | **stub** — FS-39 phase C, "an hour once the bridge itself is built" |
| FS62-T3, T4, T5, T6 | declined — syntheses and readings-instruments, no independent kernel target |
