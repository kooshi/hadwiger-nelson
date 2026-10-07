JOB EXT-OAI3 — DONE   harness≈ not readable from inside the job (own≈350k)

RESULT:
- **Nothing else in the release is on the problem itself.** Of the other 371 families, none claims anything on the chromatic number of the plane, its measurable or almost-everywhere form, a field's or a finite plane's chromatic number, a finite unit-distance graph's, or the density of a unit-distance-avoiding set. Family 158 stands alone. (All 372 family titles and catalogue sentences and all 722 manuscript titles read; keyword sweep with a planted-phrase control that fires.)
- **Tier A, five families, read at their statements, none a frontier-changer**: 172 (finite Euclidean Ramsey configurations classified by a tensor condition over the coordinate field; Lean in the release), 156 (Borsuk fails in dimension nine; Lean; added by my widening), 073 (Falconer's distance conjecture, every dimension; Lean), 166 (distinct distances in dimension ≥ 3; manuscript only), 167 (weak pinned distances, Lean; unit distances `O(n^{4/3−δ})`, Lean status contradictory in the release's own note). 172 and 156 carry method this project can use; for 073, 166, 167 I found no lever and say why.
- **Tier B, three hits, each partial**:
  - B1 — the release's Lean proves `‖sum ψ a b‖^4 ≤ 3 * (Fintype.card F : ℝ)^3` for the same Kloosterman sum this project's one declared axiom bounds (three files importing only Mathlib, inside family 021's folder). It is the elementary `q^{3/4}` bound, not Weil's; it gives every floor this project takes from Weil once `q > 3(k − 1)⁴` (243, 768, 1,875, 3,888 for refusing 4, 5, 6, 7 colours, against Weil's 34, 62, 98, 142), leaving a finite list of residue fields. [external; Lean in the release, read by text, not built here]
  - B2 — FS-76's C3-aper (`[Ellenberg2018]`'s question; `[AbrishamiEtAl2025]` Problem 4.6): **answered no at some colour count in rank 3, given family 155** (a tile of `ℤ³` with no periodic tiling), and in some large rank given `[GreenfeldTao2024]` (recalled, not read) — through this job's one entry. Nothing at four colours; nothing on a unit-distance lattice.
  - B3 — family 015's Lean folder (886 files, 87,763 lines) names the entropy and leafwise-measure machinery of Einsiedler–Katok and Einsiedler–Katok–Lindenstrauss: the toolkit FS-113 needs, not the theorem this project imports. Headers only read.
- **`tile-colouring`: TRUE, [hand], one mind** — for an abelian group `A`, a subgroup `P` and a finite `F` of `k` points, `Cay(A, (F − F) ∖ {0})` has a proper `P`-invariant `k`-colouring if and only if `F` has a `P`-invariant tiling complement. Two exact controls (767 cases on `ℤ/n`, `n ≤ 9`), each fired on its own planted fault (181 and 6); derive gate PASS, 0 failures, 1 warning (prior art owed).
- **Tier C: no hit.** No statement on `LEDGER.md` § The claim list appears in any family but 158 (28-pattern sweep in the claim list's vocabulary beside the full reading).
- **Tier D: fourteen rows named, not studied** (record § 4.3).
- **The framing, attacked (record § 4.4)**: the thing with most bearing on this project's own programme is not a result but the release's Lean library as infrastructure — planar topology (418 files under family 071's folder), finite-perimeter sets and regularity (321), entropy and leafwise measures (886), Kloosterman sums — at Lean 4.34.1 under Apache-2.0, with no `sorry` and no `axiom` declaration by text. Its own catalogue grades it `review: status: unchecked`, and the pins are 1,502 Mathlib commits apart, so each piece is a port to be built and audited as family 158 was.
- **What the release says of its own checking**: 235 of 372 families have a Lean note; 162 papers are listed as having "a formalized main result"; 405 comparator challenges exist and 178 are in the catalogue's main-results list. "Has Lean" means three different things there, and each row of the record says which.

RECORD: `plans/EXT-OAI3-review.md` (stages 1–5 saved)   COMMITS: `eec0f0ff` (stage 1), `7d15b20e` (stage 2), `9596d280` (stages 3–4), `0ee7a8be` (stage 5), `a12113b1` (two corrections), and this report's commit; all pushed to `main`. Working files: `data/external/oai3/` (index, sweeps, controls, the check script, the gate's output). Nothing was written into `/home/kooshi/source/math`, nothing from it was run, and nothing left this machine but four read-only queries to the zbMATH API, which returned HTTP 503.

INVENTORY:
- result — the sweep's negative: no other family on the problem itself — record § 2.2
- result — Tier A's five families with verbatim statements and Lean status — record §§ 2.2, 3.1–3.3
- result — B1, the elementary Kloosterman bound in the release's Lean, statement verbatim, cone of three Mathlib-only files — record § 4.1; `/home/kooshi/source/math/lean/OAI/NumberTheory/Jacobsthal/Primes/KloostermanPrimeBound.lean`
- result — B2, C3-aper false at some colour count given family 155 or `[GreenfeldTao2024]` — record § 4.1, § 4.5
- result — `tile-colouring`, [hand], one mind, two controls — record § 4.5; `data/external/oai3/tile_colour_check.py`
- result — B3, family 015's Lean as FS-113's toolkit — record § 4.1
- result — the Lean library as infrastructure, by need, five folders counted — record § 4.4
- prediction scored — E1 met (0.7), E2 not met (0.08), E3 met (0.3), E4 not met (0.15), E5 met (0.85); Brier 0.126; the miss is E3, priced as "a family proves a hypothesis" when the hits came from below the headline results and from an undrawn consequence — record § 5.2
- prior-art debt — `tile-colouring`: the link between the periodic tiling conjecture and periodic colourings of difference-set Cayley graphs is unsearched (zbMATH API returned 503 to four queries, 2026-10-07); `[GreenfeldTao2024]` is held by review only and must be read before its half of B2 is cited — record § 4.1 B2
- correction owed — `BIBLIOGRAPHY.md` row `[OAIMath2026]`: "Every other family (371): listed in the catalogue only, unread" is no longer the state; draft D1 — record § 5.1
- correction owed — `BIBLIOGRAPHY.md` row `[GreenfeldTao2024]` and the stub `plans/STUB-four-colour-inheritance.md`: both carry C3-aper as open with no colour count attached; drafts D3, D4 — record § 5.1
- stub to mint or re-aim — FS-76 (four-colour inheritance): question 1 becomes a threshold question, question 2's two-sided scheme cannot exist for every `k`; draft D4
- stub to mint or re-aim — FS-113 (measure rigidity in Lean): bearing line, draft D5; `plans/STUB-six-by-the-nerve.md`: bearing line on family 156, draft D7
- stub to mint or re-aim — a candidate with no stub: remove the declared Kloosterman axiom by the elementary bound plus a finite list of residue fields; draft D6 is its trust-ledger line, to be filed only if the kernel lane takes it
- stub to mint or re-aim — a candidate with no stub: a survey of the release's Lean library by this project's needs (planar topology for the map argument, finite perimeter, entropy), for the kernel lane's planner — record § 4.4
- generalization — a new instance of G92 (the bibliography had the tiling–colouring link as an analogy; read at its argument it is an equivalence for one graph); draft D9
- question for another lane — kernel lane: is the finite list between Weil's threshold and `3(k − 1)⁴` affordable in the kernel (exact Kloosterman sums at each usable `q` up to 243, 768 or 1,875)? I did not price it.
- question for another lane — asking lane: does family 172's tensor criterion have a fixed-dimension, fixed-colour form — which configurations over a field `F` are monochromatic in every `k`-colouring of `F²` — record § 3.1
- statement defect — the release's `lean/docs/167.md` says both that the unit-distance theorem "is not included" and that the formalization proves it; the catalogue's main-results list omits it and `FalconerAllDimensions`; reported, not resolved
- slip — the brief: "eleven reasoning summaries" is eleven files for ten subjects — record § 1.1
- slip — mine: my second message quoted "Weil's 59"; 59 is an exact-spectrum figure (G44), Weil's own threshold for refusing five colours is `q > 62`; corrected in the record (commit `a12113b1`)
- slip — mine: stages 3 and 4 were written together and saved in one commit, not one each
- slip — mine: my second message's control figures (0 mismatches; 181 under the fault) are from the control before I split it by direction; the record's two controls print 0 and 0, and 181 and 6 under their faults

HELD FOR THE COORDINATOR:
- Whether B2 is announced anywhere before its two debts are paid: family 155 is unaudited here, and the Greenfeld–Tao half rests on a paper nobody here has read. As it stands it is "[hand], one mind, over an outside theorem at the release's own grade".
- Whether the Kloosterman route (B1) and the library survey (§ 4.4) become jobs: both are the kernel lane's to price; I recommend the survey first, since it decides how much of the backlog's planar topology and finite-perimeter work is a port.
- Nine drafts in record § 5.1 await filing or declining; D6 is conditional on the kernel lane's answer, and D8 says no line is owed to the claim list.
- A full reading or Lean audit of any family is a job of its own; by bearing I would order them 155 (it carries B2), then 156's §§ 3–5 for the nerve route, then 172.
