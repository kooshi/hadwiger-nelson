*Brief for crunch job **J21**, milestone M3 (FS-64 at five colours over ℚ(√167)), derivation. Opus 5.5, 2026-09-25. Written by J06
(`plans/M3-exotic-colourings.md` §S, §M, §PA.1).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the derivation agent for M3's second question**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** The owner (the orchestrating session) coordinates and reviews by artifact.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against `git log -- <record>`,
and continue at the first stage not SAVED. Redo nothing saved.

**No children.** Do not use the Agent tool, a fork, a workflow or anything else that starts another agent (`CLAUDE.md` § Delegation —
one level deep). The reason: staffing is Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows
your context, stop at a saved stage and say what is left; that is a good report, never a failure.

## The question, and why now

The conjecture this project holds (`CLAUDE.md` G48) predicts that the plane over ℚ(√167) needs at least six colours; four is proven
(`LEDGER.md` rows 79, 82). A falsifier must be a colouring of the whole plane local at no prime. Row 96 removed the character
colourings at five colours; FS-86's C14 and CL1 removed the measurable window colourings at four. **Your question: can a measurable
window colouring over finitely many places five-colour ℚ(√167)'s plane?** At five the count fails at the real places (Croft's
`m₁ ≥ 0.22936 > 1/5`).

**What the planner's reframe found, which sets your targets** (§PA.1 of the plan; read it): the question's simplest slice, `S = {∞₁}`,
is exactly a measurable five-colouring of `ℝ²`, and the measurable chromatic number of the plane is open in print (`[KechrisMarks2020]`
§4.7, verbatim: "the unit distance graph on R², … is known to have 5 ≤ χ(U) ≤ χ_µ(U) ≤ χ_B(U) ≤ 7, … but the exact values of χ(U),
χ_µ(U), χ_B(U) are unknown"). So **a "no" over every set of places containing a real place would prove `χ_µ(ℝ²) ≥ 6`** — an open
problem, posed on Polymath16 with a Falconer-type reduction (fourth thread, quoted in §PA.1). **You are not asked to prove that.** Your
targets are D0–D4 below: the corner stated as a theorem, the finite-place count with its two gaps, a pullback theorem (a measurable
instance of Kechris–Marks's Problem 4.23, Borel Hedetniemi) or its named obstruction, and the format's positive controls.

**Every outcome counts** (standing rule 4): a construction of a five-colour window colouring (it would falsify the conjecture), a
reduction, a no-go of a named format, or a stall at a named step. Do not lean toward a yes.

## The statements (verbatim, from `plans/M3-exotic-colourings.md` §S)

**Definitions for Q2 (J21's and J22's briefs quote these, and FS86-Cx-C14 and FS86-CL1 verbatim):** `F = ℚ(√167)`; `S` a finite set
of places of `F`; for `v ∈ S`, `G_v = F_v²` and `T_v = {(x, y) ∈ F_v² : x² + y² = 1}`; `G_S = ∏_{v ∈ S} G_v`, `T_S = ∏_{v ∈ S} T_v`,
`Γ_S = Cay(G_S, T_S)`; `ι_S : F² → G_S` the diagonal embedding. A **measurable window `k`-colouring over `S`** is a map
`W : G_S → [k]` whose classes are Haar-measurable and which is proper on every edge of `Γ_S` (`W(g) ≠ W(g + t)` for all `g ∈ G_S`,
`t ∈ T_S`); each `r ↦ W(ι_S(r) + t)` is then a proper `k`-colouring of `F²`. (C14's own format also allows finite levels at finite
places and C14′'s "proper off a null set"; a derivation says which format each claim covers — a.e.-properness does not give properness on
the countable set `ι_S(F²) + t`.)

- **D0.** "A measurable window five-colouring over `S = {∞₁}` is exactly a proper five-colouring of the unit-distance graph of `ℝ²`
  with Lebesgue-measurable classes; for every finite `S` containing a real place, a measurable proper five-colouring of that graph pulls
  back to a measurable window five-colouring over `S`. Hence no measurable window five-colouring over any `S` containing a real place
  implies `χ_µ(ℝ²) ≥ 6`."
- **D1.** "For every finite set `S` of places of ℚ(√167) containing no real place, if every local graph `Γ_v`, `v ∈ S`, has
  measurable independence ratio `< 1/5`, then no measurable window five-colouring over `S` exists."
- **D1-fac.** "At ℚ(√167) the local graph has measurable independence ratio `< 1/5` at 23 (FS-66's all-levels certificate), at every
  stable odd place `p ≥ 59` (the level-one Hoffman ratio, constant up the inert tower), at the ramified place 167 (Lemma P), and at every
  odd split place (C14.2 (c))."
- **D1-43.** "The 43-adic local graph of ℚ(√167) has measurable independence ratio `< 1/5`." (or: open, with the missing step named)
- **D1-2.** "Each dyadic place of ℚ(√167) (split in `F(i)/F`) has local graph of measurable independence ratio `< 1/5`." (or: open,
  named)
- **D1-3.** "At ℚ(√167) the place above 3 is split in `F(i)/F`, so FS-64's configuration (ii) contributes a factor of measurable
  independence ratio 0."
- **D2(a).** "Let `A` be the unit-distance graph of `ℝ²` and `B` a product of finitely many of ℚ(√167)'s finite places' local graphs,
  every factor of `B` of measurable independence ratio `< 1/5`. Then `A × B` has a measurable proper five-colouring iff `A` does." (or
  its failure, at a named step)
- **D2(b).** The same with `A` the categorical product of the unit-distance graphs of `ℝ²` at the two real places.
- **D3.** "`χ_µ(Γ_{∞₁} × Γ_{∞₂}) = χ_µ(Γ_{∞₁})`" (or the named obstruction)
- **D4.** "C9's colouring `⌊4θ⌋` over ℚ(√11) is a measurable window four-colouring over `{∞, 7}` that is not a pullback from one
  factor; and the hexagonal seven-colouring is a measurable window seven-colouring over `{∞₁}` of every real field." (the format's
  inhabitants)

**The source statements, verbatim** (`plans/FS86-derivation.md` §9; line breaks of the source joined):

**FS86-Cx-C14 — C14, the measurable-window no-go: for every S2 field and every finite set `S` of places containing the tight place `𝔓` (archimedean, odd stable at full level, split, `𝔓` at any finite level `m`), every proper four-colouring `W` of `Γ_S = Cay(G_S, T_S)` (`T_S` the product of the local circles) with measurable classes is `c ∘ π_𝔓` at every point, for one four-colouring `c` of `P_m` — a single pullback on all of `G_S` (C's sharpening of "finitely many cosets": the index is 1) — so every plane colouring `r ↦ W(ι_S(r) + t)` is periodic and local at `𝔓`, for every `t` (= VC-C1). [hand; two derivations (Coxeter seat III; C blind, the same route); inputs: at every real place AmbrusEtAl2023 Thm 1 (m₁(ℝ²) ≤ 0.2470; external, computer-assisted, published; not re-checked here), V3's all-levels bounds (FS-66's certificates at 11 and 19; Lemma P), row 67, Zhang 2012 Prop. 1.7]**

**FS86-CL1 — The type-(A) corollary: over ℚ(√47) and ℚ(√167), no four-colouring of the plane is a measurable window colouring over a finite set `S` of places whose split places are odd (`W` proper on `Γ_S`, or off a null set as in C14′); likewise for every real field with no stable dyadic place and every stable place of all-levels ratio `< 1/4`. [hand, one mind (the close planner), from C14.1–C14.3 (two derivations) and the all-levels ratios; external input AmbrusEtAl2023 at real places]**

CL1's scope sentence: "**Not implied:** anything about non-measurable colourings or infinitely many places, so nothing toward `χ ≥ 5` at ℚ(√47) beyond excluding this format of falsifier; and nothing at five colours, where the count fails at the real place (Croft 1967's `m₁ ≥ 0.22936 > 1/5`, restated in `[AmbrusEtAl2024]`'s row), so FS-59's five-colour question and FS-64's aim at ℚ(√167) are untouched."

`plans/FS86-derivation.md` line 72: **FS86-LP — Lemma P: on every odd stable residue tower, unramified or ramified, a character new at level `m` has `|λ| ≤ 2p^{m−1}`; so Hoffman's ratio is `max(h(Γ_p), 2/(p+3))` at every level, and FS-66's fibre-density inequality and its certificates bound every level of a ramified tower too (= Poros (plan) C4 for the ramified 59; = inventory item 12's ramified-base constant ratio). [hand + tools exact (FFT at five towers; bound attained on the ramified ones); Poros (plan) (ramified 59, Hoffman), B1 blind (every odd tower, with the certificate extension)]**

## Read first, from disk

- `plans/FS86-derivation.md` §9 in full (C14, VC-C2, VC-C3, C14′, C14-K, CL1), FS86-LP (Lemma P), FS86-Cx-C9; the proof records it
  cites (`plans/FS86-C-Coxeter.md` round 2 step 5; `plans/FS86-V-C-verification.md` VC-14).
- `LEDGER.md` rows 69 (five refused at 43: `α ≤ 365` against 370), 75 (23's all-levels bound `97.984637` against 529/5), 92, 94, 95,
  96; `plans/FS66-derivation.md` T8 (a measurable independent set's Haar supremum is the tower's independence-ratio limit).
- `[Zhang2012]` Thm 1.8 and Prop. 1.7 (held); `[KechrisMarks2020]` §4.6–§4.7
  (`~/source/library/pdf/KechrisMarks-descriptive-graph-combinatorics-2020.pdf`); the Polymath16 fourth thread
  (`~/source/library/notes/polymath16-threads-1-18-text.txt`, Mixon, 5 May 2018: the MCNP ≥ 6 criterion, and Tao's description of
  Falconer's "edge vertex").
- `plans/M3-exotic-colourings.md` "The milestone in the theory's terms", §PA.1 and §M (the obligation tree for D1 and D2, and the named
  hard step).

## The planner's routes and checks (routes, not claims)

- **D1-3:** 3 is inert in ℚ(√167) (`167 ≡ 2 mod 3`) and `i ∈ 𝔽₉`, so `i ∈ F_3`: the place is split in `F(i)/F`. Confirm, and state what
  C14.2 (c) gives there.
- **D1-43, the planner's one-line check:** the level-one Hoffman ratio at 43 is `0.21376` (least eigenvalue `−11.9622` on degree 44, a
  float computation of the character sums by the planner; re-derive it), above 1/5; at 59 it is `0.19912`, at 23 `0.24908`. Lemma P keeps
  the Hoffman ratio `max(h(Γ_p), 2/(p+3))` at every level, so **Hoffman cannot close 43**; the fibre-share relaxation that could is FS-66's
  instrument, priced at 84 GPU-days and banned. A hand route needs an inequality sharper than Hoffman's at 43 that survives every level;
  otherwise name D1-43 open.
- **D2(a), the obligation tree (§M):** "⟸" is the pullback. "⟹" by induction on the number of colours with `A` generalised to its
  measurable induced subgraphs `A′`: some class has relative density `≥ 1/j > β`; **if** an independent set of `A′ × B` of relative
  density `> β` is almost everywhere a cylinder `I × B` (a measurable stability form of Zhang's Thm 1.8(i)), removing it closes the
  induction. **The named hard step:** Zhang's theorem is for vertex-transitive factors, and `A′` leaves that class after the first step.
  Attack that step first; a counterexample to the cylinder lemma for non-transitive `A′` is itself a finding (the obstruction to D2).
- **D3:** the diagonal map `ℝ² → ℝ² × ℝ²` is a homomorphism but its image is null, so the finite-graph argument for `χ(G × G) = χ(G)`
  does not transfer measurably; say whether Falconer's argument does.
- **D4:** C9's `θ = (2x + 3y)/7` at one stable place above 7 of ℚ(√11) (7 splits there), with an archimedean term below `1/28`.

## Stages

1. **The quotation check and C0** (about 60k): every quotation above against its source, logged; a probability per claim (D0, D1,
   D1-fac, D1-43, D1-2, D1-3, D2(a), D2(b), D3, D4) before any derivation. **Save.**
2. **D0 and D1** (about 80k): the corner as a theorem; the count (C14.1 + C14.3 at five colours); the factor table D1-fac; D1-3; D1-2
   (C14.2 (c) at `p = 2`); D1-43 attempted or named. **Save.**
3. **D2 and D3** (about 100k): the pullback theorem, or its obstruction named at a step; the two real places. **Save.**
4. **D4, claims and the reviewer's view** (about 40k): the positive controls as members of the format; the claim list, each with its
   grade, address and the exact format it covers (proper everywhere, or C14′'s off-a-null-set); C0 scored. **Save, then report.**

**Theorems this phase proved:** your record carries that heading, one line per theorem, with its grade and address.

## Record and paths

- **Record:** `plans/M3-S1D-windows-five.md`. **Working files:** `data/m3/j21/`. **Tools:** `tools/crunch_j21_*.py`, each with a
  planted fault watched to fire.
- **The ban** (to 2026-10-01): no search, no LP oracle, no relaxation; exact arithmetic of seconds that checks a derived claim is in.
  Keep the **"would have searched here" log** in your record.
- **Carry each external number with its kind** (`CLAUDE.md`, "carry what a number measures"): Croft's 0.22936 is a construction's density
  (a lower bound on `m₁`); `[AmbrusEtAl2024]`'s 0.2470 an external computer-assisted upper bound, unaudited here (job J26 audits it);
  C14.2 (c) a limit. Keep CL1's qualifiers ("split places odd", "one mind") in every summary sentence.
- **Commits** by explicit path, subjects "J21: stage n". **Budget:** about 350k in the harness's count; hand back by 420k.
- **Report:** standing rule 9's form, to `data/crunch-2026-09-25/reports/J21.md`, committed, and sent to `"main"` by SendMessage; RESULT
  gives each claim TRUE / FALSE / GAP-at-step. Your turn's final text: "J21 idle; report sent to the owner by SendMessage".
