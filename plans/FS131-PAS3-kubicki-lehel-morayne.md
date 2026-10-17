# FS131-PAS3 — Kubicki, Lehel and Morayne 2002, read in full against rational four-space at four colours

*Job FS131-PAS3 (brief `data/fs131/briefs/FS131-PAS3-kubicki-lehel-morayne.md`, written 2026-10-17 00:55 UTC). Ephodos, the prior-art
gate (§PA) on one paper and one result. Worktree `.claude/worktrees/filing2`, branch `fs131-pas3`, cut from `main` at `1253d345c`.
The paper: G. Kubicki, J. Lehel, M. Morayne, *Patch colorings and rigid colorings of the rational n-space*, J. Combin. Theory Ser. B
84 (2002) 45–53, doi 10.1006/jctb.2001.2062, Zbl 1024.05030 — held as
`~/source/library/pdf/KubickiLehelMorayne2002-patch-rigid-colorings-rational-n-space-jctb-84-45-53.pdf` (nine pages, a text layer;
received 17 December 1999, published online 27 August 2001). Cited below as KLM.*

## Theorems this phase proved

Written at stage 3 (none before it).

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, checked against their sources

- The three block quotations (inventory items 1075, 1080, 1082) are verbatim in `plans/FS131-close-inventory.md`, on `main` and in
  this worktree: `data/fs131/pas3/quote_check.py` (whitespace collapsed, each block a substring of the source) prints `quotations: 3
  verbatim: 3`, exit 0; with one character planted in each (`--plant`) it prints `verbatim: 0`, exit 1 — the control fires.
- The two inline quotations of the paper's abstract are in its text layer (`pdftotext`, p. 45): *"We show that every 2-coloring of
  Q 2 or Q 3, and every 4-coloring of Q 4 is rigid."* (the brief's *"every 2-coloring of Q 2 or Q 3, and every 4-coloring of Q 4 is
  rigid"*, verbatim, exponents flattened by the text layer) and *"rigid colorings which uniquely extend from any open subset of Q n"*
  (the brief's *"uniquely extend[s] from any open subset of Q n"*, with the brief's bracketed inflection). **No mismatch.**
- The probe's phrases (item 1075, `plans/FS131-PAS2-prior-art.md` § 2.1) are all words of the printed abstract: *"Q^4 is rigid"*,
  *"every 4-coloring of"*, *"uniquely extend"*, *"points at distance one get distinct colors"* (the abstract reads *"any two points at
  distance one get distinct colors"*). The probe's misses (*"dense"*, *"component"*, *"unique"*, *"forbid"*) are absent from the abstract
  too: the probe read the abstract correctly. What it could not read is what "rigid" means; § 2.1 answers it.

### 1.2 C7, A3 and the two drafted forms, in my words

- **C7** (`CLOSED-QUESTIONS.md` § 3, *"Which distances can a four-colouring of `ℚ⁴` forbid beside 1?"*). Johnson asks (`[Johnson2006]`
  p. 212, again `[Johnson2010]` p. 169) for which `d > 0` some proper four-colouring of the unit-distance graph on `ℚ⁴` also gives
  different colours to every pair at distance `d`. The entry's answer, verbatim: *"for `d` realised in `ℚ⁴` (`d² ∈ ℚ`; for `d² ∉ ℚ` no
  pair is at distance `d` and a colouring exists trivially — LX's scope repair), exactly the `d` with `d² = p/q`, `p, q` odd — and then
  every proper four-colouring forbids `d`."* Under it sits the compulsion law (LV-T3 = LX-T5): with `w(z) = v₂(|z|²)`, a pair `x ≠ y`
  is forced equal in every proper four-colouring when `w(x − y) ≥ 1`, forced different when `w(x − y) = 0`, and free (some colouring
  joins it, some splits it) when `w(x − y) < 0`. Its parts, as the brief names them: the compulsion law (three clauses), A3, and
  the answer to Johnson's question.
- **A3** (`.claude/worktrees/il5/plans/FS131-KFS1-four-space-plan.md` § 1.2, read only): *"Every proper four-colouring is, on each
  component `x₀ + R`, the residue map `R → R/P ≅ 𝔽₄` followed by a bijection to the colours, where `R = {w ≥ 0} = H ⊗ ℤ₍₂₎` (`H` the
  Hurwitz order) and `P = {w ≥ 1} = (1 + i)R`."* In my words: each component of `G(ℚ⁴, 1)` has one proper four-colouring up to
  renaming the colours — it is **uniquely four-colourable** — and that colouring is reduction modulo the prime of the quaternion order
  above 2. KFS1's § 2.1 builds it from Zaks's Lemma 1 (forced equal at `√2`), the component of the origin (`⟨S⟩ = R`), and the unit
  tetrahedron `T = {0, 1, h, h′}` meeting the four residue classes once each.
- **Form (A)** (`plans/FS131-PAS2-prior-art.md` § 2.4 item 1, to be used *"if Kubicki–Lehel–Morayne 2002 does not prove the residue
  structure"*): the answer is not found in print; Johnson poses it again in 2011 with this answer as his guess; the similarity step is
  `[BauJohnsonNoble2021]` Thm 3.3.
- **Form (B)** (the same item, *"if it does"*): the answer is in print in part — every four-colouring of `ℚ⁴` is rigid, from which the
  answer follows with Benda–Perles's components and `[Johnson1990]` Thm 3; neither posing by Johnson cites the paper; ours is the
  residue form and the derivation of the forbidden distances.
- **Draft 2** (the same § 2.4, item 2): Johnson–Voloshin 2007's question on the period group of a four-colouring of `ℚ⁴`, answered by
  `[Zaks1999]` Lemma 1 with the component structure; held because its attribution might move with this paper.

What form (B) presumes, stated so it can be checked: that KLM's "rigid" carries A3, i.e. that a four-colouring of `ℚ⁴` is fixed by
data that every colouring shares up to a renaming (a unit tetrahedron, say). Stage 2 reads what "rigid" means.
