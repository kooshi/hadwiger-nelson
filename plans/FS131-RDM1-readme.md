# FS131-RDM1 — the README rewritten for a reader coming to it blind

*Job record of Ephodos (the deriver lane, here as the page's writer), brief `data/fs131/briefs/FS131-RDM1-readme.md` (on `main`
at `d6c07a22c`; written 2026-10-16 18:56 UTC by Keryx). Worktree `/home/kooshi/source/lean-dir/.claude/worktrees/rdm1`, branch
`fs131-rdm1`, cut from `main` at `80629caf3`; `main` has moved two commits since (the brief, its generator script and one
inventory line — no Lean file and no source this page reads changed: `git diff --stat 80629caf3 main`).*

## Theorems this phase proved

None. This is a writing job: it derives nothing and re-grades nothing. Every result on the page is copied at the grade its
sources give it, and a grade a source states wrongly is reported as a finding, not repaired here.

## Stage 1 — SAVED: the readback

### 1.1 The quotations in the brief, checked against their sources

Checked by script (exact substring match of each quoted line against its named source):

| quotation | source | result |
|---|---|---|
| W21, "(2026-10-16) I'd also like a complete rewrite of the readme. …" | `data/fs131/REQUEST-2026-10-16.md` | verbatim |
| "**W21, read by Keryx (2026-10-16), labelled as mine.** …" | `data/fs131/REQUEST-2026-10-16.md` | verbatim |
| W2, "(2026-10-13, answering the choice between the two publishable forms) I choose the second form. …" | `data/fs131/REQUEST-2026-10-13.md` l. 4 | verbatim |

No mismatch.

### 1.2 What the page must do, in my words

The front page is read first by a mathematician who knows nothing of this project and decides within a minute whether it is
worth more of their time. So it must tell them, in this order:

1. **What the problem is**, in one paragraph, with the current state of knowledge and whose it is (χ(ℝ²) ∈ {6, 7} is other
   people's work: de Grey for five, `[OAIMath2026]` for six).
2. **What this project proved that is its own**, as a table at the top: one short formula per row, a status per row, nothing
   wider than a phone. Status is one of two kinds and says which: *checked by Lean's kernel* — on Lean's three standard axioms
   alone, or also on named outside theorems (Weil's bound, Einsiedler–Lindenstrauss Thm 1.3, `[OAIMath2026]`'s
   no-five-colouring theorem) — or *proved by hand, not yet formalized*, with the ledger's grade. Only `main` counts: the four
   modules in flight (the `p`-adic bound, the lattice three-colour criterion, the density form of the collapse, the five-colour
   fields by class) are not held.
3. **Under the table, one short section per row**: what it says in words, why anyone would care (which published question it
   answers), what it rests on, and what it does not claim.
4. **Other people's results that the library also checks**, credited exactly as `LEDGER.md` credits them, as context and never as
   ours; where the value is prior art and the kernel proof is ours, that sentence exactly.
5. **The rest** — what the library assumes, how to check it, the layout, how it was made, the licence — kept, rewritten for the
   same reader, shorter. Detail the front page no longer carries (every Lean name, every axiom list, the full results table)
   moves to one reference file at the root, linked. Nothing lost.

Wording rules: every symbol defined at or before its first use; no row numbers, milestone ids or coined terms as nouns (an
address in parentheses or a link is fine); `BIBLIOGRAPHY.md` § E's words for the literature's objects; novelty as "prior art: not
found in print", never "first", "new" or "not new"; where a search was not run, say so. The repository is public: nothing private,
no path outside it, no other project.

### 1.3 The results I intend to put in the table, with their sources

Order: this project's results first, by what a reader would look for (the asking lane's ranking,
`plans/POROS-2026-10-13-number-field-findings.md` § 3.2–3.3, plus the plane's results named apart in its § 3.6). "Status" is as
the sources state it before Stage 2's prints; Stage 2 re-prints every axiom list.

**This project's, kernel-checked on `main`:**

| # | result | source | status, as the sources state it | attribution, as the sources state it |
|---|---|---|---|---|
| 1 | `χ(ℚ(√47)²) = 5`; also `= 5` at ℚ(√143), ℚ(√311), ℚ(√335), ℚ(√3,√5); `χ(ℚ(√167)²) ≥ 5` | `LEDGER.md` rows 121, 123; `CLAUDE.md` § Where the problem stands | [kernel] since FS131-LGT1, on Weil's bound and `[EinsiedlerLindenstrauss2022]` Thm 1.3; `χ ≤ 5` alone on the standard three | lower half: prior art not found in print (row 121's gate); upper half prior art (the plane at 11, row 52); answers `[Moorhouse2010slides]`'s "What about χ(ℚ(√47)²)?", the existence half of `[Soifer2024]` Open Problem 55.1; posed again as open by `[Davies2026]` p. 5; no graph exhibited |
| 2 | `χ(F²) = L(F)` whenever `L(F) ≤ 5`, every real number field; with no hypothesis `min(χ(F²), 5) = min(L(F), 5)` | row 123; `CLAUDE.md` § Where the problem stands | [kernel] (FS131-LGT1, FS131-IL5), on Weil's bound and EL Thm 1.3 | conjecture `χ(F²) = L(F)` this project's (G48); question `[Fischer1990]` § 1 and `[Johnson2000]` Problem 4.4; the upper half prior art (`[Moorhouse2010]`, `[Manturov2012]`, `[Madore2015]`, row 52); the lower half and MR: not found in print |
| 3 | three colours: a non-bipartite `F²` is three-colourable exactly when some prime of `F` has residue field `𝔽₃`; `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`; `χ(F²) = L(F)` whenever `L(F) ≤ 4` | row 99 | [kernel] since FS131-LJ1, on Weil's bound | question `[Fischer1990]` § 1 / `[Johnson2000]` Problem 4.4; answer at this range not found in print; the two-colour classification and the three-colour one over fields with √3 are GPT Astra's (row 99, G55; `LEDGER.md` § B) |
| 4 | four colours: `χ(F²) ≥ 4` for every `F ⊆ ℝ` with `1/3 ∈ ℤ[U_F]` and `F²` not bipartite; so `χ(ℚ(√m)²) ≥ 4` for `m ≡ 11 (mod 12)`, the table for `ℚ(√m)`, and `χ(ℚ(√11)²) = 4` | rows 73, 82; `CLAUDE.md` § Where the problem stands | [kernel] since FS131-LJ1 (and row 73 since FS131-LU1), the standard three | lower bound four: prior art not found in print; `[Johnson2006]` p. 214 asks whether any `m` needs four; values 2, 3 and every upper bound `[Fischer1990]` Thms 8, 9, 10(i); the relation and `1/3 ∈ C₀` are `[Fischer1990]` Thm 10(ii), additive colourings only |
| 5 | the collapse: `χ(F²) = χ(ℝ²)` at every real number field uniformly `c`-thick, `c < 1/5`; at ℚ(√635087) and ℚ(√3,√5,√7,√11) with no hypothesis; `6 ≤ χ(ℚ(√635087)²) ≤ 7` | row 128 | [kernel] since FS131-ICO2: general form on EL; the two fields also on Weil's bound; the corollary also on `[OAIMath2026]`'s five-colour theorem | field equality: prior art not found in print; the plane equality `χ(ℝ²) = χ_m⁰(ℝ²)` is `[OAIMath2026]`'s; `[Davies2026]` Thm 1.1 is the analogue for `d ≥ 4` and suspects the plane needs "a more complicated extension" |
| 6 | the density equality: `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, `χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, `f(n)/n → m₁(ℝ²)` | row 129 | [kernel] since FS133-LD1, the standard three (through `[OAIMath2026]`'s rigidity step, ported) | for the plane: prior art not found in print; `[Davies2026]` Thm 1.1 proves it for `d ≥ 4`; answers `[DuczVarga2026]` Conj. 1 first clause, `[MatolcsiEtAl2025]` § 2, `[Johnson1996fcn]` Questions 1, 3, `[Johnson2000surprises]` Problems 3, 4 |
| 7 | six against seven as stability: `7 ≤ χ(ℝ²) ⟺ sup_{ε>0} µ₆(ε) < 1` | row 131 | [kernel] (FS132-L1); the row says "on … the declared outside theorem `Outside.OAI158.proper_to_borel_weak` alone", `CLAUDE.md` and `LEAN.md` say that theorem is ported since FS131-LP1 — **Stage 2 decides** | not found in print as an equivalence; the conditional is `[SokolovVoronov2025]` § 9 |
| 8 | the disc criterion: `7 ≤ χ(ℝ²)` exactly when some open disc has no weak measurable six-colouring | row 161 | [kernel] (FS124-L1); the row again names the transfer as a declared outside theorem — **Stage 2 decides** | partly prior art (`[GwynStavrianos2022]` Lemma 2; Kruskal 2008; the direction toward seven is `[OAIMath2026]`'s transfer restricted); the disc form for weak colourings not found in print |

**This project's, proved by hand, not yet formalized (each now in a Lean module in flight, not held):**

| # | result | source | status | attribution |
|---|---|---|---|---|
| 9 | `χ_Bor(ℚ_p²) ≥ 1 + (p+1)/(2√p)` for every `p ≡ 3 (mod 4)`, so no bound uniform in `p`; `χ_Bor = 4, 5, 5` at 7, 11, 19; `6 ≤ χ_Bor(ℚ₂₃²) ≤ 8` | row 75; `CLOSED-QUESTIONS.md` § 1.8 | [hand] for the bound (no second derivation filed, `plans/POROS-2026-10-13-number-field-findings.md` § 3.3 rank 4); values [cert] (exact certificates, standalone checker) + six hand links; level two at 11 [kernel] | answers `[BardestaniMallahiKarai2017]` Question 1 (no); the chain is `[Madore2015]` Prop. 3.8, the spectral bound theirs (Thm 2.5, after BDOV); ours the bound at levels ≥ 2, the certificates, the values. Not searched: MathSciNet, Russian literature |
| 10 | `Cay(Λ, S)`, `Λ` f.g. torsion-free abelian: three-colourable ⟺ a character puts `S` in `[1/3, 2/3]` ⟺ a periodic three-colouring exists; periodic three-colourings dense | row 79; `CLOSED-QUESTIONS.md` § 2.4 | [hand], two independent derivations; the ⟹ [kernel] (FS131-LJ1) | questions `[Ellenberg2018]` (MathOverflow), Gibbs and Mixon (Polymath16), `[CGHO2025bg]` Question 6.2, `[AbrishamiEtAl2025]` Problem 4.6 at `χ = 3`; the height lift Chandgotia's; density at standard generators expected folklore, not claimed |

**Named in prose, not as table rows:** the hand work on six against seven for measurable colourings (rows 132–167, mostly
[hand], one mind each), pointed to `ROADMAP.md`; the hand results whose modules are in flight (row 123's quadratic family, row
129's field clause, row 100's ring lemma) in the explanations of rows 1 and 5.

**Other people's results the library checks (context table):** `4 ≤ χ(ℝ²)` (classical, the Moser spindle); `5 ≤ χ(ℝ²) ≤ 7`
(de Grey 2018, Heule; the seven-colouring classical; "ours is the certificate", row 33); `6 ≤ χ(ℝ²) ≤ 7` (`[OAIMath2026]`, on its
axiom); `χ(ℝ²) = χ_m⁰(ℝ²)` (`[OAIMath2026]` Thm 1.3, its transfer ported; the other direction's argument `[GwynStavrianos2022]`);
`χ(ℝ²) = χ_m(ℝ²)` (`[Davies2026]` Lemma B.1 composed with the transfer); `m₁(ℝ²) ≤ 0.2470` (`[AmbrusEtAl2023]` Thm 1; the route
ours); `χ(ℚ(√3,√11)²) = 4` (`[Fischer1994]`; the kernel proof and its 𝔽₄ colouring ours); `χ(F²) ≤ L(F)` (Moorhouse, Manturov,
Madore); `χ(ℚ²) = 2` (Woodall); `χ(F(t)²) = χ(F²)` (`[Fischer1990]` Thm 6).

### 1.4 Findings so far, to be settled by Stage 2's prints

- **F1.** `LEDGER.md` rows 130, 131 and 161 call `Outside.OAI158.proper_to_borel_weak` a declared outside theorem ("imported as the
  outside theorem", "on … the declared outside theorem … alone", "on those three and the declared outside theorem"); `LEAN.md` §
  Trust ledger, Ported outside proofs, and `CLAUDE.md` § Where the problem stands say its proof was ported at FS131-LP1 and "the
  twelve records that rested on it are clean". The kernel's print decides (`ROADMAP.md`: "Where the ledger and the kernel disagree,
  the kernel's print is the authority").
- **F2.** `README.md` § What the library assumes says "33 hypotheses, taken in 108 (hypothesis, theorem) pairs"; `CLAUDE.md` §
  Trust ledger says 109, and `scripts/assumptions-ledger.txt` holds 109 `TAKES` lines.
- **F3.** `README.md`'s audit counts (11,284 records at 2026-10-15) are older than `CLAUDE.md` § Trust ledger's (11,398 records,
  10,747 clean, 77 imported, 5 purchases, 569 axiom-free, at FS131-ICO2 on 2026-10-16).
- **F4.** `LEDGER.md` row 104's *Not claimed* says "`χ(ℚ(L)²) = 2` needs `χ(ℚ²) = 2` in the kernel, row 63's missing instance";
  row 63 holds `χ(ℚ²) = 2` in the kernel since FS131-LU1. A stale clause; a correction owed to the ledger.
