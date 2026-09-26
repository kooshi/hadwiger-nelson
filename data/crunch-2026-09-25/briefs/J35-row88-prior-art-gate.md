*Brief for crunch job **J35**: the close-time prior-art gate of the milestone "row 88's question" (FS-86's open question; plan
`plans/FS86-row88-rigidity.md`), WORKFLOW 3.2's eight questions run on the theorems the milestone filed. Opus 5.5, 2026-09-25. Written by
the product owner.*

Hello. You are de Bruijn (`DEBRUIJN.md`), working as **the milestone's prior-art reader** in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md` (G49, G50, G76), `WORKFLOW.md` (step 3.2, all eight items) and `DEBRUIJN.md` from disk.
**`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** I'm the product owner.

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS86-row88-PA-close.md` and
continue at the first stage not SAVED.

## The question

The milestone asked whether `(0, 4)` is forced over ℚ(√59) (`LEDGER.md` row 88): is every four-colouring of the plane over a type-(B) field
a pullback from the tight dyadic place? A derivation (J28D, `plans/FS86-R88-D-derivation.md`) and a blind verifier (J28V,
`plans/FS86-R88-V-verification.md`) proved, by two independent routes over common inputs, the results below. Before anything is called
new, the world's literature must be asked, in the disciplines' words. **The statements, verbatim from the plan's §S.1** (read each in the
records at exact scope — J28D states T-C for the whole class S2, wider than §S.1's type-(B) wording; §S.0 of the plan fixes the terms):

1. **T-A (the decomposition).** "Let `F` be a type-(B) field, or any real field in S2 for which row 88's frame holds (`F(R) ∈ {0, P(R)}`,
   `P(R) = R ∩ 𝔓⁴`, every periodic four-colouring a pullback), and `X₄(F)`, Pull, `Aff_F`, `F_μ` as in §S.0. (i) Pull is finite,
   closed and `Aff_F`-invariant. (ii) `F_μ(R)` is an ideal of `R`, equal to `0` or to `P(R)`, and `F(R) ⊆ F_μ(R) ⊆ P(R)`. (iii) `F_μ(R) ≠ 0`
   if and only if (Q-μ) every translation-invariant Borel probability measure on `X₄(F)` is carried by Pull. (iv) `F(R) ≠ 0` if and only if
   (Q-μ) holds and (Q-tr) no colouring is transient. (v) A colouring `c ∈ X₄(F) ∖ Pull` is transient if and only if, for every finite
   `B ⊂ R`, the set `{t ∈ R : (t·c)|_B ∉ Pull|_B}` has upper Banach density zero in `R`. (vi) If every point of Pull is isolated in
   `X₄(F)`, then Q-tr holds, and so `F(R) = F_μ(R)`." Disciplines: symbolic dynamics and subshifts on abelian groups ("frozen" colourings,
   `[AlonEtAl2021]`), invariant measures supported on periodic orbits, unique ergodicity, forced periodicity (Kari–Szabados).
2. **T-C (Theorem C over the real type-(B) fields; J28D: all of S2).** "Over a type-(B) field, every translation-invariant Borel probability
   measure on `X₄(F)` whose spectral measure is carried by `T + A + Fin_S`, for some finite set `S` of split places, is carried by Pull."
   Disciplines: spectral theory of measure-preserving actions (discrete / quasi-discrete spectrum, the Kronecker factor, Halmos–von
   Neumann), invariant random colourings and factor-of-IID colourings of Cayley graphs (Lyons, Bernshteyn, measurable and Borel
   combinatorics), measurable independence ratio and the independence density of the plane (`[AmbrusEtAl2023]`, `[MatolcsiEtAl2025]`),
   MIS-normality of products (`[Zhang2012]`), Hoffman's ratio bound on locally compact abelian groups.
3. **T-C(A) (its type-(A) form).** "Over ℚ(√47), no translation-invariant Borel probability measure on `X₄(F)` has its spectral measure
   carried by `T + A + Fin_S` for a finite set `S` of split places; hence a four-colouring of ℚ(√47)'s plane, if one exists, has a
   translation-invariant measure on its orbit closure whose spectral measure is carried by no `T + A + Fin_S`." Disciplines: as 2, plus
   "four-colourings of the unit-distance graph over a real quadratic field".
4. **The partials toward transience** (J28D's record, stage 4, and J28V's §2.4–§2.5): no colouring differs from a pullback on a finite
   non-empty set; every archimedean-bounded subset of `R` has upper Banach density zero (J28D's L-B2-2); bounded-length defect chains are
   thin; unique continuation from an archimedean half-space (FS-86's Theorem H) and its failure from an ultrametric sphere. Disciplines:
   unique continuation and rigidity of tilings or colourings from a half-plane, "domino problem", expansive directions (Boyle–Lind).
5. **J28V's side results:** every non-zero ideal of `ℤ[U_F]` has finite index (J28V-7), and C14.2 (c) at `q = 2` (J28V-6) — check whether
   either is standard.

**Known leads (read first):** the plan's §PA (J28's gate, with its debts: Zaks 1989, Asgarli–Yip 2022, Yip 2026, Exoo–Ismailescu 2016,
Silva Filho 2026, Herva–Kari 2025, MacVicar 2023, Yu 2022; Rudolph, Host and Einsiedler–Lindenstrauss not held); `BIBLIOGRAPHY.md`'s rows for
`[Berend1983]`, `[Berend1984]`, `[Furstenberg1967]`, `[KariSzabados2016]`, `[HervaKari2023]`, `[AmbrusEtAl2023]`, `[Zhang2012]`.

## What to do

For each result, WORKFLOW 3.2's eight items:
- name the object in its discipline's words, and search under two disciplines;
- search for the QUESTION as well as the method;
- look outside arXiv;
- walk the citation graph of the paper that posed the question;
- open every citing work whose title is in the neighbourhood;
- use two databases;
- use **the zbMATH Open API for discovery** (`https://api.zbmath.org/v1/document/_search?search_string=…&results_per_page=100`,
  URL-encoded; fields `au:`, `ti:`, `ab:`, `py:`, `cc:`, `so:`), including each poser's complete author listing. If the API returns HTTP
  502, retry after a pause and record the outage. A query unanswered is recorded as unanswered, never as a negative.

Read what you find: an abstract is not a reading (G50). For a paper you cannot fetch (a paywall or anti-bot block), record the exact
reference and DOI in a list for Kooshi, who fetches by browser.

**The verdict per result**, at exact scope:
- *in print*: where, exactly. Then it is prior art, and the record says so.
- *partly in print*: which part.
- *not found*: the queries, the databases, the date. A negative is a finding about where the unworked ground is.
- *undecided*: name the unread paper that could decide it.

Never write "new"; write only "not found by these searches".

## Output

`plans/FS86-row88-PA-close.md` holds:
- one section per result, each query with its hit count, and each paper opened with what was read per section;
- the verdict;
- a list of papers for Kooshi to fetch;
- proposed `BIBLIOGRAPHY.md` entries (proposals only — you do not edit it);
- `CLOSED-QUESTIONS.md` candidates: a question posed in print that the milestone answers.

Save after each result (`Stage n — SAVED`). Papers you download go to `~/source/library/pdf/` as `Author<year>-<short-title>.pdf`.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved result and tell me what is left.
- **Touch only** `plans/FS86-row88-PA-close.md` and `data/fs86r88/j35/`. Never edit the plan, the two records, `CLAUDE.md`, `LEDGER.md`,
  `BIBLIOGRAPHY.md`, the index or any inventory. Send your verdicts to me.
- **All novel knowledge is a success** (Kooshi), and that includes finding the result in print: a clean attribution is as valuable as a
  "not found". Do not lean toward either.
- **No finite-witness search** (the ban runs to 2026-10-01). Keep the "would have searched here" log; it will probably be empty, so say so.
- **Commits by explicit path**, subjects "J35: result n". End commit messages with your harness's attribution lines. Push after each
  commit; never force-push.
- **Budget:** about 300k by the harness's count; hand back by 380k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J35.md`, committed, and by SendMessage
  `to: "main"`, with one verdict line per result. Keep your turn's final text content-free: "J35 idle; report sent to the owner by
  SendMessage".

Thank you.
