# FS-102 — the fallback write-up: measure rigidity for the unit-vector group, and the local–global conjecture's main clause through five (stub)

*Minted 2026-09-26 by consolidation job C3b (brief `data/consolidation-2026-09-26/briefs/C3b-claims-stubs.md`, item 3), at the owner's ruling
under the stub rule (WORKFLOW step 2: every future milestone lives as a stub) and Kooshi's word that the write-up is the fallback. Rank 14′ in
`plans/FRONTIER-STUBS.md` (the argument is in `data/consolidation-2026-09-26/C3b-record.md`; Kooshi's to move). **Solver column: none** — a
write-up, no finite-witness search at any stage. Read first: `CLAUDE.md` § The mission, "Publication" (the rule and its third bullet);
`LEDGER.md` rows 120–123 and 127 in full; `CLOSED-QUESTIONS.md` §1.7, §2.6, §3; `plans/FS100-derivation.md` §3–§4; `plans/FS100-X24R-prior-art.md`
(the prior-art gate); `plans/STUB-theorem-B-writeup.md` §3–§4 (FS-20's credit table and naming problem, the template).*

## Kooshi's words (2026-09-26, verbatim; `CLAUDE.md` § The mission and § Publication)

- *"The publication rule half fires. This is 100% worthy of a writeup, but I want to be greedy and push to see how far we can get on our own."*
- *"writing this up will be our fallback if we feel like we can't progress"*
- *"If we end up at a wall which collapses HN to another known open problem, that in itself would be a writeup."*
- His reading of what the result is: "We have now reduced hadwiger-nelson to 5,6,7 *algebraically* rather than by a witness object. That is far
  more valuable than de Grey's 2018 graph IMHO."
- The target it is the fallback for: *"We now have a real foundation to reach for 6 (or prove that no field is 6 colorable, which would be
  fascinating) and potentially answer the HN problem definitively."*

So this milestone does not run by default: the project pushes toward six first (FS-59 at rank 1 and the stubs aimed at six), and this stub is
what runs when that push stalls, or when Kooshi calls it. The third quotation names a second trigger: a wall that reduces Hadwiger–Nelson to
another known open problem would be a write-up of its own (a different paper, not this one).

## Mission, in plain language

Colour the points of the plane so that no two points at distance exactly 1 share a colour; how many colours are needed? Restrict the
coordinates to a field `F` of real numbers (for example all numbers `a + b√47` with `a, b` rational) and ask the same question for the plane
over `F`. Every such plane is part of the real plane, so a lower bound for any `F` is a lower bound for the whole problem.

This project conjectured (the local–global conjecture, `CLAUDE.md` G48) that the answer over a number field is read off its small primes:
`χ(F²) = L(F)`, the least chromatic number among a short list of finite "residue" planes the field's primes supply, whenever that number is
small. The 2026-09-26 work proved the conjecture's main clause up to five colours, at [hand] grade, and the write-up is that proof:

1. **Measure rigidity for the unit-vector group** (`LEDGER.md` row 120): *"for every real number field `F` with `R_F = O′` (row 100 — every
   `F` without a ramified stable dyadic place), every `U_F`-invariant finite positive measure on `R̂` with `τ(E) = 0` is a multiple of Haar
   measure (MR(F))."* Grade: *"[hand; PE-2 two derivations blind to each other (X02D, X02V), EL2021 Thm 1.2 by statement (external, in print;
   its proof in EL2021 §§2–9, unread here); EF_F⁺ two derivations blind to each other (X01D, X12B) and a checking reading (X01V, after its blind
   GAP, withdrawn as its own error); MR a composition, three minds]"*.
2. **`χ(ℚ(√47)²) = 5`** (row 121): *"the local–global conjecture's cheapest exposed five-clause is met."* A finite triangle-free five-chromatic
   unit-distance graph over ℚ(√47) exists by de Bruijn–Erdős; *"none is exhibited"*, and exhibiting one is not pursued (Kooshi's ruling closing
   FS-84: *"I'm not interested in taking the time to find a triangle free graph. That's incidental to the goal."*).
3. **The main clause through five** (row 123): *"for every real number field `F`, `χ(F²) ≥ min(L(F), 5)`, so `χ(F²) = L(F)` whenever
   `L(F) ≤ 5`"*, with the instances `χ = 5` at ℚ(√143), ℚ(√311), ℚ(√335), every squarefree `d ≡ 47, 143, 167 (mod 168)` with `L = 5`,
   `χ(ℚ(√3,√5)²) = 5`, and `χ(ℚ(√167)²) ≥ 5`.
4. **Where the other routes stop** (row 122), optional as a section: the one-sided flip needs a quantitative T-C(A); equidistribution is false;
   the classical `ℤ²` hypothesis is false.
5. **The corollary Kooshi's reading names:** `χ(ℝ²) ≥ 5` with no witness object, since a subfield's plane is a subgraph of the real plane's
   (`CLAUDE.md` § Where the problem stands, "The problem").

## The publication rule — it half fires

`CLAUDE.md` § Publication lists what clears the bar; the third kind is *"a result that answers a question the literature has independently and
repeatedly posed, whatever its size"*, whose ledger is `CLOSED-QUESTIONS.md`. Kooshi ruled that it **half fires** for rows 121–123
(`CLOSED-QUESTIONS.md` §2.6, "a candidate; the rule half fires"). The questions answered, in row 121's words: *"`[Moorhouse2010slides]`'s "What
about χ(ℚ(√47)²)?"; the existence half of `[Soifer2024]` Open Problem 55.1, non-constructively (55.1 asks to construct; 55.2 open);
`[ExooIsmailescu2019]`'s smallest-subfield question in part"*; and, through five, `[Fischer1990]` §1's question (row 123's prior art, quoted
in row 99; `CLOSED-QUESTIONS.md` §2.6).

## Prior-art state (a debt list, not a clearance)

- **The gate ran and found nothing** (X24R, row 121): *"not found in print (X24R, 2026-09-26: zbMATH listings of twelve posers and fifteen
  abstract queries, arXiv with a positive control, the Polymath16 threads held and live to 2026-09-24, `[Soifer2024]` chs. 11 and 55; the only
  triangle-free five-chromatic unit-distance graph in print is in ℝ³, de Grey 2026, Zbl 1581.05080)"*. MR is not found under its discipline's
  names; its nearest, `[LacaWarren2018]`'s "generalized Furstenberg conjecture", is the finitely generated case and open (row 120). EL2021 §2 and
  §4.1–§4.3 were read (X24R): *"So PE-2's step is not in EL2021, and neither is EF_F⁺."*
- **Blocking, before any draft (G50):** `[Johnson2000]` and `[Johnson2006]` are unread — **Kooshi, acquiring** (`BIBLIOGRAPHY.md` § R.6).
  Until they are read, novelty is "not found", never "first" (rows 121, 123).
- **Owed beside them:** `[Sataev1975]` (the zero-entropy method's first form, unheld, unread); Johnson's nonlacunary theorem (`[JohnsonA1992]`,
  review only), whose shape PE-2 transposes; EL2021's proof (§§3, 5–9 unread), on which PE-2 rests by statement.
- **The lesson this gate must not repeat:** FS-20's result was in print since 1994 in a proceedings volume no citation graph reaches
  (`[Fischer1994]`; G49). Re-run WORKFLOW 3.2 item 8 (every poser's full zbMATH author listing, their vocabulary against abstracts) at the
  opening, for the value `χ(ℚ(√47)²) = 5`, for "the chromatic number of the plane over a number field", and for MR.

## The naming rule (a first-class deliverable)

`CLAUDE.md` § Publication: *"every working term in this repository is coined in-house and appears in no paper — the mechanism G49 says hid the
prior art — so the manuscript's vocabulary is a design problem with a ban list"*; `BIBLIOGRAPHY.md` §E is the translation table. Rows 120–123
are written in coined shorthand — MR, SP-Cor, T-C(A), CLS, A⁺, R-U, PE-2, EF_F⁺, "the wall", "stable place", "4-thick", `L(F)` itself. At the
opening, list every such term the draft needs, find or add its row in §E in the discipline's words (ergodic theory of algebraic actions,
solenoids and adeles; graph homomorphisms and Hoffman's bound; unit-distance graphs), and write the manuscript in those words only.

## The artifact shape

`CLAUDE.md` § Publication: *"At any write-up, adopt the zeta-23 artifact shape: a tiny trusted `comparator/` surface (Challenge statements with
`sorry`) over the whole edifice as untrusted Solution, verified by `leanprover/comparator` (statement equivalence, axiom whitelist, kernel
replay; its nanoda run is the independent-kernel publication gate)."* The kernel today (row 127): *"The main clause through five in the kernel, conditional on named
hypotheses: `min(L(F), 5) ≤ χ(F²)` for every real number field"*, with *"`χ(ℚ(√47)²) ≤ 5` unconditionally"*; *"The composition is the kernel's; every link it
names is [hand] and stays so."* So the Challenge surface can hold the headline today only as a conditional statement; FS-101 is the route that
shrinks the named hypotheses. **Whether the write-up waits for FS-101, or goes out at [hand] with the kernel's conditional composition named,
is Kooshi's call.**

## Deliverables

1. A manuscript: rows 120, 121, 123 as the paper's theorems, row 122 as the section on routes that stop, each result at its ledger grade and
   with its count of minds; the derivation (G80's mechanism: `U_F` has polynomially many elements of bounded height, which no finitely
   generated subgroup has) as the paper's spine, the fields as its examples (the programme's rule, `CLAUDE.md` § The mission).
2. A credit table in FS-20's form (`plans/STUB-theorem-B-writeup.md` §3): Einsiedler–Lindenstrauss Thm 1.2, Einsiedler–Fish's pigeonhole,
   Hoffman and the ratio bound, the residue colouring (row 52), `[Madore2015]`, `[Moorhouse2010]`, `[Fischer1990]`, GPT Astra's chain theorem
   and prime inversion (G55), and everything row 120's and row 123's prior-art cells name.
3. The naming table (§E rows added) and the ban list.
4. The `comparator/` surface, its Challenge statements matching the manuscript's theorems word for word.

## Registered expectations (to be registered with priors at the opening, both outcomes reachable)

- The Johnson papers hold no value of `χ(F²)` at five for a real field without √3 (the killing outcome: they do, and the paper re-scopes
  as FS-20 did).
- A second blind read of the chain, written for the manuscript, finds no broken link (the killing outcome: a link fails, and the affected
  row's grade drops before anything is written).

## Failure clauses

- **Prior art found:** the value or MR in print — record it in the credit table, re-scope to what is ours (the kernel form, the class
  statement, the mechanism), and correct rows 120–123 at the close.
- **A link breaks:** the write-up stops; the row is corrected first (standing rule: a rung that does not land is reported as not landed).
- **The six push lands first:** this stub is superseded by the write-up the six result would need (§ Publication's first bullet).

## Provisional bearings (to be replaced by the re-grokking at the opening)

G49 (the prior-art gate, and Fischer 1994 as its warning), G50 (the Johnson papers block the opening), G80 (the mechanism the paper
explains), G48 (the conjecture whose main clause this is), G55 (the chain theorem, the other route to five over `K`), G72 and G79 (the result
came through the structural question and an example invariant — say so in the paper's account of method), G21 (the grades travel with the
claims). Stubs: FS-20 (the Theorem B paper — one naming table for both), FS-101 (the kernel port), FS-63 (the second-discipline vocabulary),
FS-23 (the citation graph).

## Bearing on χ ≥ 6

None. It is the fallback if the push toward six stalls, and it states the foundation the six hunt now stands on.

## Rank

14′ in `plans/FRONTIER-STUBS.md`: just below the three stubs aimed at six at ℚ(√167) (FS-59 at 1, FS-64 at 12, FS-96 at 14), so every live
six stub over the conjecture's widest gap comes before it, as Kooshi's "push … first" asks; the prime keeps every other rank number stable.
Kooshi's to move.
