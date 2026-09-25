*Brief for crunch job **J22**, milestone M3 (FS-64 at five colours over ℚ(√167)), blind verifier. Opus 5.5, 2026-09-25. Written by J06
(`plans/M3-exotic-colourings.md` §S) **before any claim of J21's existed** (FS-89's V-A: a fixed list, written first).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the blind verifier of J21's claims**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** The owner (the orchestrating session) coordinates and forwards what the phases below say.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`,
and continue at the first stage not SAVED. Redo nothing saved.

**No children.** Do not use the Agent tool, a fork, a workflow or anything else that starts another agent (`CLAUDE.md` § Delegation —
one level deep). The reason: staffing is Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows
your context, stop at a saved stage and say what is left; that is a good report, never a failure.

## The question, and why blind

M3's second question is FS-64 at five colours over ℚ(√167): can a colouring read off finitely many local coordinates of the field
through measurable windows five-colour its plane? FS-86 excluded four colours there by a count (FS86-CL1); at five the count fails at
the real places. A five-colour window colouring would falsify the conjecture's prediction of at least six at ℚ(√167); a proof that
none exists removes one more kind of falsifier. A derivation agent (J21) attacks it; you verify its claims blind.

You are blind so that your verdicts are a second derivation from the statements, not a re-reading of one. The seventh run's lesson
(`plans/PROTOCOL-competitor-and-advisor.md` §3): a blind verifier's value is in the fixed list and in re-derivation; it cannot supply a
missing idea, and the lemma-statement phase (B2) is the cheap fallback that turns a stall into a verification. **Every verdict counts
equally** (standing rule 4): TRUE, FALSE with a counterexample, or GAP with the missing step named. Audit a claim you like as hard as one
you dislike.

## The statements (verbatim; your fixed list)

**Definitions for Q2 (J21's and J22's briefs quote these, and FS86-Cx-C14 and FS86-CL1 verbatim):** `F = ℚ(√167)`; `S` a finite set
of places of `F`; for `v ∈ S`, `G_v = F_v²` and `T_v = {(x, y) ∈ F_v² : x² + y² = 1}`; `G_S = ∏_{v ∈ S} G_v`, `T_S = ∏_{v ∈ S} T_v`,
`Γ_S = Cay(G_S, T_S)`; `ι_S : F² → G_S` the diagonal embedding. A **measurable window `k`-colouring over `S`** is a map
`W : G_S → [k]` whose classes are Haar-measurable and which is proper on every edge of `Γ_S` (`W(g) ≠ W(g + t)` for all `g ∈ G_S`,
`t ∈ T_S`); each `r ↦ W(ι_S(r) + t)` is then a proper `k`-colouring of `F²`. (C14's own format also allows finite levels at finite
places and C14′'s "proper off a null set"; a derivation says which format each claim covers — a.e.-properness does not give properness on
the countable set `ι_S(F²) + t`.)

**The fixed list.** Each claim below is quoted verbatim from `plans/M3-exotic-colourings.md` §S (a file you may not open; this list is
the whole of what you need from it). J21 may prove some, refute some, or stall; your verdicts are per claim, whatever it claims.

- **D0** — "A measurable window five-colouring over `S = {∞₁}` is exactly a proper five-colouring of the unit-distance graph of `ℝ²`
  with Lebesgue-measurable classes; for every finite `S` containing a real place, a measurable proper five-colouring of that graph pulls
  back to a measurable window five-colouring over `S`. Hence no measurable window five-colouring over any `S` containing a real place
  implies `χ_µ(ℝ²) ≥ 6`."
- **D1** — "For every finite set `S` of places of ℚ(√167) containing no real place, if every local graph `Γ_v`, `v ∈ S`, has
  measurable independence ratio `< 1/5`, then no measurable window five-colouring over `S` exists."
- **D1-fac** — "At ℚ(√167) the local graph has measurable independence ratio `< 1/5` at 23 (FS-66's all-levels certificate), at every
  stable odd place `p ≥ 59` (the level-one Hoffman ratio, constant up the inert tower), at the ramified place 167 (Lemma P), and at every
  odd split place (C14.2 (c))."
- **D1-43** — "The 43-adic local graph of ℚ(√167) has measurable independence ratio `< 1/5`."
- **D1-2** — "Each dyadic place of ℚ(√167) (split in `F(i)/F`) has local graph of measurable independence ratio `< 1/5`."
- **D1-3** — "At ℚ(√167) the place above 3 is split in `F(i)/F`, so FS-64's configuration (ii) contributes a factor of measurable
  independence ratio 0."
- **D2(a)** — "Let `A` be the unit-distance graph of `ℝ²` and `B` a product of finitely many of ℚ(√167)'s finite places' local graphs,
  every factor of `B` of measurable independence ratio `< 1/5`. Then `A × B` has a measurable proper five-colouring iff `A` does."
- **D2(b).** The same with `A` the categorical product of the unit-distance graphs of `ℝ²` at the two real places.
- **D3** — "`χ_µ(Γ_{∞₁} × Γ_{∞₂}) = χ_µ(Γ_{∞₁})`"
- **D4** — "C9's colouring `⌊4θ⌋` over ℚ(√11) is a measurable window four-colouring over `{∞, 7}` that is not a pullback from one
  factor; and the hexagonal seven-colouring is a measurable window seven-colouring over `{∞₁}` of every real field."

Where J21 states a claim in a different form, the owner forwards the exact text at B2; you verify the fixed list's form and say
whether the two agree.

## Read first, from disk (the verified inputs)

- `plans/FS86-derivation.md` §9: FS86-Cx-C14 (C14.1–C14.4), VC-C2, VC-C3, Cx-C14p, Cx-C14K and FS86-CL1, verbatim there; CL1 is
  graded "[hand, one mind (the close planner)]" and requires the split places of `S` odd ("C14.2 (c) at `p = 2` is **not checked**").
- `plans/FS86-derivation.md` Lemma P and C9 (FS86-Cx-C9); `LEDGER.md` rows 69, 75, 92, 94, 95, 96; `plans/FS66-derivation.md` T8.
- `[Zhang2012]` Thm 1.8 and Prop. 1.7 (held; `BIBLIOGRAPHY.md`); `[KechrisMarks2020]` §4.6–§4.7
  (`~/source/library/pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf`); `[AmbrusEtAl2024]`'s `m₁(ℝ²) ≤ 0.2470` and Croft's
  `m₁ ≥ 0.22936` (external, second-hand: carry them as such).

## Fenced until your B1 verdicts are committed (and B2's, for everything but the lemma statements the owner forwards)

- J21's record `plans/M3-S1D-windows-five.md`, `data/m3/j21/`, `tools/crunch_j21_*.py`, its brief
  (`data/crunch-2026-09-25/briefs/J21-M3-windows-five-derivation.md`) and its report;
- the M3 plan `plans/M3-exotic-colourings.md` (it carries routes) and the close inventory `plans/M3-close-inventory.md`;
- commits whose subject begins "J21:" (do not `git show` them); any record the owner has not named here.
If you open a fenced file by accident, say so in your record at once; it is a slip to report, not a failure to hide.

## Stages

1. **The quotation check and C0** (about 40k): check each quotation in this brief against its source where you can open the source (the
   fixed list's source is fenced: record that), and a probability per claim before any derivation. **Save.**
2. **Phase B1, blind** (about 150k): attempt each claim from its statement alone, by your own route; a verdict per claim — TRUE, FALSE
   (with the counterexample), or GAP (the missing step named verbatim). The deciding claim first. **Save**, and report the B1 verdicts to
   the owner by SendMessage, one line each.
3. **Phase B2, the lemma statements** (about 100k; only if B1 left a GAP): the owner forwards J21's lemma statements **without
   proofs**; re-derive each from its statement, and re-assemble. **Save.**
4. **Phase B3, the divergence table** (about 50k): now read J21's record; one line per divergence of truth, scope, route or wording;
   and **read each final statement aloud against the informal claim** (`CLAUDE.md` § The standard of evidence). **Save, then report.**

**Theorems this phase proved:** your record carries that heading, one line per theorem, with its grade and address.

## Record and paths

- **Record:** `plans/M3-S1V-windows-five.md`. **Working files:** `data/m3/j22/`. **Tools:** `tools/crunch_j22_*.py`, each with a
  planted fault watched to fire; never edit another job's tools.
- **The ban** (to 2026-10-01): no search for a finite witness; exact arithmetic of seconds that checks a derived claim is in. Keep the
  **"would have searched here" log** in your record.
- **Commits** by explicit path, subjects "J22: stage n". **Budget:** about 350k in the harness's count; hand back by 420k.
- **Report:** standing rule 9's form, to `data/crunch-2026-09-25/reports/J22.md`, committed, and sent to `"main"` by SendMessage;
  the RESULT line gives a verdict per claim. Your turn's final text: "J22 idle; report sent to the owner by SendMessage".
