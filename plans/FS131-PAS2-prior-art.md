# FS131-PAS2 — the prior-art searches owed by C7 and C14

*Job FS131-PAS2 (brief `data/fs131/briefs/FS131-PAS2-prior-art.md`, on `main` at `24d9c671d`), Ephodos, 2026-10-17. Worktree
`.claude/worktrees/kcs1`, branch `fs131-pas2`, cut from `main` at `ac47c67b0`. A prior-art gate (`.claude/agents/ephodos.md` § The
opening job, §PA) run on two statements already derived; no derivation of its own. Query scripts and logs: `data/fs131/pas2/`
(`zb.py` and `ax.py` are FS131-PAS1's scripts with the log renamed; every query and every returned record is appended to
`data/fs131/pas2/queries.jsonl`). Papers fetched go to `~/source/library/`; none is committed here.*

## Theorems this phase proved

None. This job searches and reads; it proves nothing.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

`data/fs131/pas2/quote_check.py` reads every block quotation of the brief and checks it, character for character, against the
source file it names (a source written `path § section` is checked against the whole file at `path`). Run against `main` (the brief
was committed there after this worktree was cut):

```
OK   data/fs131/REQUEST-2026-10-13.md 'W2: (2026-10-13, answering the choice between the two publishable form'
OK   plans/FS131-close-inventory.md '1073. **The next work, ruled (logged 2026-10-16 23:55 UTC; every landi'
OK   plans/POROS-2026-10-13-number-field-findings.md '**Rank 7 — C7. Rational four-space.** *The theorem:* for `d > 0` with '
OK   CLOSED-QUESTIONS.md '- **Which distances can a four-colouring of `ℚ⁴` forbid beside 1?** `['
OK   plans/POROS-2026-10-13-number-field-findings.md '**Rank 9 — C14.** *The theorem:* the fractional chromatic number of th'
OK   CLOSED-QUESTIONS.md '### 1.6 The fractional chromatic number of the plane over `ℚ(√3, √11)`'
mismatches: 0
```

Control: a copy of the brief with one word of the closed-questions C7 entry changed (`p, q` odd → `p, q` even) prints `MISS` for
that quotation and exits 1; the copy was deleted after the run. All six quotations are verbatim.

The statements behind the quotations, read against their own sources:
1. **C7** against `data/consolidation-2026-09-27/lv/record.md` LV-T3 (the first mind, "[derived, one mind; a second reader owed]")
   and `data/consolidation-2026-09-27/lx/record.md` stage 1 (the blind second mind, LX-T1 to LX-T6) — agrees. The asking lane's form
   ("for `d > 0` with `d² ∈ ℚ`") carries LX's scope repair: as LV first worded it, the corollary was false for `d² ∉ ℚ`
   (`d = 2^{1/4}`: no pair is at that distance, so a colouring exists, yet `d²` is not `p/q`). The grade "[derived, two minds, one
   blind]" is LV with LX's blind derivation; neither is kernel-checked and there is no ledger row.
2. **C14** against `plans/FS56-field-blowup.md` (Theorem, Corollary, B1–B4) — agrees. Its lower bound is `[MatolcsiEtAl2025]`
   Theorem 1's proof read with the field kept (B1–B2: every congruence between subsets of `F²` is an isometry of `F²`), its witness
   their `G27` (re-verified here by `tools/fs56_gf_check.py`), its upper bound Theorem B.
3. **The brief's author list for C7** names Chow "from my memory, unchecked". Checked: `[Chow1993]` is held and read in full
   (`BIBLIOGRAPHY.md`); it classifies distance sets forbidden by **two**-colourings of `ℚ³` and `Aₙ` by the two-index `v₂(d²)`, so it is
   the two-colour analogue of C7, not a four-colour result. Its author is searched below with the others.

### 1.2 The two statements in the field's own words, and the query terms each suggests

**C7 — distances forbidden by four-colourings of rational four-space.** *Euclidean distance graphs (the discipline that posed it):*
for a set `D ⊂ (0, ∞)` write `G(ℚ⁴, D)` for the graph on `ℚ⁴` joining points at a distance in `D`. Benda–Perles (1976, printed
2000) and Chilakamarri (1988) proved `χ(G(ℚ⁴, 1)) = 4`; `[Johnson1990]` Thm 3 gave a four-colouring forbidding every distance in
`K = {√(p/q) : p, q odd positive}`; `[Zaks1999]` proved every proper four-colouring of `G(ℚ⁴, 1)` monochromatic on pairs at `√2`
and at 2 and bichromatic at odd integers. `[Johnson2006]` p. 212 asks: *for which `d > 0` is `χ(G(ℚ⁴, {1, d})) = 4`?* C7's answer:
for `d` realized in `ℚ⁴`, exactly `d ∈ K` — i.e. exactly when the 2-adic valuation of `d²` (Chow's *two-index*) is 0; for every
other realized `d`, `χ(G(ℚ⁴, {1, d})) ≥ 5`. Behind it a uniqueness statement: every proper four-colouring of `G(ℚ⁴, 1)` is, on
each connected component, Johnson's colouring up to a permutation of the colours (forced equal iff `v₂(|x − y|²) ≥ 1`, forced
different iff `= 0`). In the literature's derived vocabulary: it gives the **second Babai number** a lower bound, `B₂(ℚ⁴) ≥ 5`
(`[Johnson2006]` p. 215's definition, from Abrams–Johnson 2001), and it says Johnson's set `K` is the largest set of distances any
proper four-colouring of `ℚ⁴` forbids.
*Quaternion arithmetic (the second discipline):* `ℚ⁴` is the rational quaternions with `|x|² = N(x)`; the component of 0 in
`G(ℚ⁴, 1)` is the subring the norm-one quaternions generate, the Hurwitz order with odd denominators inverted (`R = H ⊗ ℤ₍₂₎`); its
maximal ideal `P = (1 + i)R` has residue field `𝔽₄`; C7 says every proper four-colouring of the Cayley graph `Cay(R, {N = 1})` is the
reduction `R → R/P ≅ 𝔽₄` up to a permutation of `𝔽₄` — a statement about colourings of a Cayley graph of an order in the
quaternion algebra ramified at 2 and ∞.
Query terms: "rational space" / "rational four-space" / "four-dimensional rational space" / `Q^4` with "chromatic" or "coloring";
"forbidden distance(s)" / "forbid" / "forbids" with "rational"; "two forbidden distances"; "distance graph" with "rational points";
"Babai number(s)"; "4-coloring" / "four-coloring" with `Q^4`; "odd distances" / "odd integral distances"; "two-index"; "quaternion"
/ "Hurwitz" / "unit quaternions" with "distance graph" / "chromatic" / "Cayley graph" / "coloring"; "uniquely colorable" with
"rational". The question's own words: "4-coloring of Q^4 which forbids both distances 1 and d". Authors: Zaks, Johnson, Benda,
Perles, Chow, Chilakamarri, Abrams, Lee, Mann, Cibulka, Raigorodskii (and coauthors Ponomarenko, Shitova), Jungreis–Reid–Witte.

**C14 — the fractional chromatic number of the plane over `ℚ(√3, √11)`.** *Fractional graph colouring and geometric graph theory
(the discipline that posed it):* write `G(F², 1)` for the unit-distance graph on `F²`, `F = ℚ(√3, √11)`. `[CranstonRabern2015]`
showed `χ_f(G(F², 1)) ≥ 76/21` and asked its value. C14: `χ_f(G(F², 1)) = 4`; equivalently the finite unit-distance graphs with
coordinates in `F` have independence ratios (Hall ratios' reciprocals) at least `1/4` with infimum `1/4`, and fractional chromatic
numbers below 4 with supremum 4. The upper bound is `χ(G(F², 1)) = 4` (`[Fischer1994]`); the lower is `[MatolcsiEtAl2025]`'s
geometric fractional chromatic number `χ_gf(G27) = 4` blown up along a Følner sequence of the (solvable) group generated by the
congruences of `G27`, which preserves `F²`. Nearby objects in the same words: the **Moser lattice** and the **Moser ring** (inside
`F²`, rank 4 against `F²`'s 8), where `[Ducz2026]` gives geometric four-colourings. *Harmonic analysis of distance-avoiding sets
(the second discipline):* the independence density `α₁` of the unit-distance graph on a dense additive subgroup of the plane (a
`ℚ`-vector space or a lattice); "1-avoiding sets" in a subgroup; the finitary Hall ratio `ρ = 1/α₁`; `m₁`. Query terms:
"fractional chromatic number" with "Q(√3,√11)" / "number field" / "algebraic" / "rational points" / "Moser lattice" / "Moser ring";
"geometric fractional chromatic number"; "independence ratio" with "unit distance" / "lattice"; "Hall ratio" with "plane"; "1-avoiding"
/ "avoiding unit distances" with "lattice" / "rational" / "field"; the question's own words "fractional chromatic number of
Q(√3,√11)". Authors: Cranston, Rabern, Matolcsi, Ruzsa, Varga, Zsámboki, Dúcz, Ambrus (and Csiszárik, Oliveira Filho, Bellitto,
Pêcher, Sédillot, Parts). Citation graphs: works citing `[CranstonRabern2015]`, `[MatolcsiEtAl2025]`, `[Ducz2026]`, `[DuczVarga2026]`.
