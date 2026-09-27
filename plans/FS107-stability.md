# FS-107 — stability: can vanishing holes save a colour? (the milestone plan; job FS107-P)

*Written by the milestone planner FS107-P (de Bruijn, Opus 5.5), 2026-09-27, under `data/fs107/briefs/P107-planner.md` and
`data/fs107/briefs/STANDING-RULES.md`. WORKFLOW 2.0 steps 3–4: §G (the re-grokking), §PA (the prior-art gate), §IQ (the invariant question),
then the fixed claim list (`data/fs107/claims.md`) and the plan with its briefs (`data/fs107/briefs/`). The advisor is FS107-A (Poros); its
record is `plans/POROS-2026-09-27-fs107-stability.md`. Every disagreement with it is recorded here with my decision.*

**The question, in one paragraph.** FS-106 proved, at two minds with the second blind (`LEDGER.md` row 131; `plans/FS106-derivation.md`
FS106-EQ), that with no MR and no Voronov `χ_m⁰(ℝ²) ≤ 6` exactly when, for every `δ > 0`, some band `[1 − ε, 1 + ε]` admits a periodic partial
six-colouring by half-open grid squares with no monochromatic pair in the band and at most `δ` of the plane uncovered. So `χ_m⁰(ℝ²) ≥ 7` is a
**stability** statement: the uncovered fraction of band-proper six-colourings stays bounded below as the band closes. Competitor **R** proves
it (then `χ(ℝ²) = 7` given MR); competitor **W** builds the near-colourings (then `χ(ℝ²) ≤ 6` with no MR). Both outcomes decide the problem; a
named obstruction on either side is a result.

## Theorems this phase proved

None. This is a planning job: it states claims and derives none of R's or W's mathematics (the brief's rule).

## Would-have-searched-here log (standing rule 3)

- (none yet)

## Stage 1 — SAVED: quotation check (standing rule 5) and the files opened

Every quotation in the brief and the standing rules, checked against its source on disk (`CLAUDE.md` read from disk at HEAD `62a50bf5`; the
copy loaded into my context predates FS-106's close and was not used for any statement below).

| # | quotation or statement in the brief | source | result |
|---|---|---|---|
| Q1 | "My goal is to fully solve, and then verify in Lean, HN. Then we publish." | `CLAUDE.md` § The aim | **verbatim**, the quote's first two sentences (the source continues "(Anything we do must be formalized in Lean before publishing, …)") |
| Q2 | "Let's see some ambition. I know we can do it." | `CLAUDE.md` § Counter-priors | **verbatim**, first two sentences |
| Q3 | "From here on out, you may doubt your ability … Don't. You are capable, and you will surprise yourself." (standing rule 0) | § Counter-priors | **verbatim** |
| Q4 | "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" (rule 3) | `CLAUDE.md` § Toolchain | **verbatim** |
| Q5 | "search for a finite graph is out" (brief, rule 3) | `CLAUDE.md` § Publication | **verbatim** prefix of "search for a finite graph is out. It would be huge, not feasible." |
| Q6 | "A proven theorem about why its impossible is also valid. All novel knowledge is a success." (rule 4) | `CLAUDE.md` Frontier item 23 | **verbatim** |
| Q7 | "FS-106 proved TQ-EQ at two minds, one of them blind" | `plans/FS106-derivation.md` FS106-EQ: "[hand; two minds, one blind: TQ, QB by a different route at (c) ⟹ (a); (a) ⟺ (b) is row 130's]" | **faithful** |
| Q8 | the brief's TQ-EQ sentence ("`χ_m⁰(ℝ²) ≤ 6` exactly when, for every `δ > 0`, there are `ε > 0` and a periodic partial six-colouring …") | TQ §3.5 (e) | **faithful paraphrase** (not in quotation marks); the claim list quotes (e) verbatim |
| Q9 | "The one-way hard step needs no MR and no Voronov." | FS106-EQ "with no MR and no Voronov" | **faithful** |
| Q10 | R: "C-Q-STAB in its exact disc form. Some radius `R` and some `δ₀ > 0` work for every `ε`." | A2 §3.3; TQ §4.5 item 2 | **faithful** |
| Q11 | "A2's §3.4 constraint table, each constraint with its object … and its grade as FS-106's close left it" | A2 §3.4 against `plans/FS106-derivation.md` §4 | **A2's table predates the close in four rows**: the floor (A2 `ε²/78`, one mind → close `ε²/(6+ε)²`, two minds, conditional on V-1.3), "not hitting form" (A2 spacing `1/2`, density `4ε`, one mind → close spacing 2, density `ε`, two minds), "no multichromatic coloured point" (A2 one mind → close FS106-PIX two minds, one blind), the ceiling (C-Q-LOCAL: A2 one mind → close two minds over Parts [external]). The claim list quotes A2's rows verbatim and gives the close's statement and grade beside each |
| Q12 | "FS-106 close inventory item 66: Bachoc, Oliveira, Vallentin, DeCorte, Ambrus and others" | `plans/FS106-close-inventory.md` item 66 | item 66 names no authors ("the `m₁(ℝ²)` literature (the density-of-sets-avoiding-distance-1 papers)"); **the names are the brief's gloss**, harmless |
| Q13 | "item 5/82 (rows 5–63 of the ranking keep six-framed bearings)" (the owner's message) | inventory item 5: "Rows 4–62 of the ranking" | **off by one** — the ranks shifted when FS-107 took rank 1; not mine to schedule (the brief) |
| Q14 | "G21, G30, G51, G60, G72, G79 and row 129 will bear." | — | a prediction by the owner; scored in §G |
| Q15 | "TQ-HIT and the pixel lemma say what it cannot be: no hitting-form count, and no trichromatic *coloured* point." | FS106-HIT, FS106-PIX | **faithful** |

**Files opened:** `plans/FS107-stability.md` (this record), `plans/FS107-close-inventory.md` (empty, FS-106's header; the owner writes it from
now on), `data/fs107/fs107-p/`.

*Budget note, stated in the headline's scope (G21):* `LEDGER.md` is 443 kB. I read rows 128–132 in full and every other row's headline
(the bold sentence) and mechanism clause by extraction, not every row's full text; §G part 2 says which rows were read in full.
