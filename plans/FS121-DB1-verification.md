# FS121-DB1 — a blind second mind on C121-ENDS, C121-OUT, C121-PER and C121-LRA-LINE

*Job FS121-DB1 (Ephodos, verification form; Opus 5.5), brief `data/fs121/briefs/FS121-DB1-verify.md`, started 2026-09-29 05:45 UTC.
The four statements are FS-121's frozen list's (`data/fs121/claims.md` § 2), each quoted verbatim in its `verification:` block. Blind, the
same model as the minds whose work this record compares against once its verdicts are committed. Addresses in this record resolve from
`plans/`.*

## Theorems this phase proved

All in the setting of an honest saturated a.e.-proper colouring in D-NF satisfying REG-J′, any number of colours; addresses in § 2.

- **DB1-L1** — at the centre of a unit interface arc, the inner colour's directions lie in the closed facing cone, the outer's in the away
  cone, and neither enters the two side cones [hand, one mind; FS112-U1's cones re-derived in the saturated setting] — § 2.2.
- **DB1-L3** — at a point of Σ no colour occupies two sectors of positive angle, with cusps allowed at the point and elsewhere [hand, one
  mind; W-NOREP localised: it adds the partner at a unit arc's centre on either side and the partner present only as a cusp] — § 2.3.
- **DB1-L4** — the centre of a unit arc of kind both lies in Σ and carries at least four distinct colours, with no condition on densities
  [derived from DB1-L1, DB1-L3; one mind] — § 2.4.
- **DB1-L5** — the centre of a tangent-type unit arc carrying the outer colour and not the inner lies in Σ, with at least two further
  positive-angle sectors of pairwise distinct colours: three distinct colours, with no condition on densities [derived from DB1-L1, DB1-L3;
  one mind] — § 2.4.
- **DB1-L6, DB1-L7** — the chain inward ends, off finitely many normals, at a unit arc whose centre carries its outer colour; the unit parallel
  outward of a tangent-type arc is, at every point off Σ, a tangent-type interface of radius one more, with REG-J′ unused [hand, one mind; over
  M2-INTRAD step (1)] — § 2.5.
- **The verdicts** — C121-ENDS, C121-OUT, C121-PER TRUE; C121-LRA-LINE TRUE under the author's reading (a), GAP under reading (b) [hand, one
  mind each here, blind to the first derivation] — § 2.6; the density conditions of ENDS and PER idle (thin truths) — § 2.7.

## Would-have-searched-here log (standing rule 5)

- None. No move of this job is a search: every check is a hand derivation or an exact identity on a formula-given object (R7, one cusp
  instance), with its answer fixed before it ran.
- Would have searched here: for a saturated colouring with a curved tangent interface or with LRA, to test C121-OUT's and C121-LRA-LINE's
  classes on an object. Did not: the ban, and the object is C121-CURVED's and C121-NOLRA's question (other jobs'); the attacks say that no
  object tests these classes.

## Fence log (standing rule 8)

- 2026-09-29 05:47 UTC. `ls plans/ | grep -E "FS121|…"` and `ls data/fs121/` printed the names `plans/FS121-close-inventory.md`,
  `plans/FS121-map-step.md` and the directory names `briefs d1 o1 reports`: names only. No fenced file was opened and no content was
  shown. Disclosed for completeness.
- The session's opening git status showed recent commit subjects (`FS-116, FS-121: round 1 briefs`, `FS121-O1: report`, `FS121-O1:
  stage 5`, …): neutral subjects, no content.

## Stage 1 — SAVED: readback, what was given, the registered expectations

### 1.1 Files read, in order (all open to this job)

1. The brief, in full; `plans/STANDING-RULES.md`, in full; my agent file (the identity already loaded).
2. The frozen list `data/fs121/claims.md`, in full: §§ 0–4. **This includes the other claims of the list** (C121-R2-FOUR,
   C121-CURVED, C121-NOLRA, C121-SAT6, C121-REGJ) and their *not claimed*, *Inhabitant* and *Role* lines, which show what the list's
   author expects: that an (R2) centre may carry exactly three colours (R2-FOUR is posed as open), and that no curved tangent inhabitant
   and no LRA inhabitant are held.
3. The held inputs' homes: `plans/FS111-M-regularity.md` lines 176–500 (§§ 2–5.4: M-SATC, M-SLACKFREE, R7, M-DEADLOCK, M-PINCH, M-C11,
   M-EXTREME, M-COVER-SC, M-HALF, M-POLAR, REG-J's verdict, M-REDUCE-I); `plans/FS111-M2-regularity.md` §§ 4.1–4.4 (M2-INTRAD with its
   proof, M2-REDUCE-A, M2-DISCK7); `plans/FS111-derivation.md`, the entries M-PINCH, M-C11, W-NOBEND, W-NOREP, W-NEG, W-SQ9, W-HEX9,
   W-KB-DIR, W-LADDER, W-HEXSAT, M2-INTRAD, M2-REDUCE-A, M4-LADDER, M4-CUT, M4-HC, M4-MOVE and § The named gaps; `plans/FS111-W-wild.md`
   §§ 2.1–2.4 (W-C11, W-NOREP's proof, W-LADDER); `plans/FS112-derivation.md` lines 1–30 and the entries FS112-U1, N3-NOBOTH, N3-FAIL;
   `plans/FS112-N-proof.md` N3-NOBOTH's proof (lines 725–740); `plans/FS112-NB3-verification.md` § NB3-NOBOTH; the top of
   `data/fs111/claims.md`.
4. Preloaded at launch: `CLAUDE.md` (its § The aim and the Frontier's item 31 describe route M, rows 139–141 and the stuck ray) and the
   grokkings, among them **G84** (contact; ladders of unit parallels) and **G85** ("Saturated interfaces have integer radii … What escapes
   is radii → ∞, FS-115's stuck ray").

### 1.2 Given (the cut, recorded as it happened)

- **The statements**, verbatim, with their *not claimed*, *Colours* and *Inhabitant* lines, and the list's definitions and held inputs.
- **No verdict, sketch or route for any of the four** was in the brief; it says "Derive or refute each" and names TRUE, FALSE, GAP and
  MISSTATED as results. The brief's framing sentence "two of these statements say so of their own class" (the vacuity rule) is given.
- **The held derivations** that these statements visibly build on — M-PINCH, M-C11, M2-INTRAD (its proof text includes the sentence
  "*Not proved:* that only finitely many `n` occur near a point … This is FS-112's stuck ray in another form" and "a radius-2 arc would sit
  concentric with a unit arc of kind both"), W-NOREP and its proof, FS112-N3-NOBOTH and FS112-U1 — were read before any derivation of
  mine. They are the list's inputs, open by the brief; a route through them is not a route I brought, and the `method:` lines say where
  mine departs.
- **What I knew before:** nothing of these four statements; the grokkings G84–G85 and CLAUDE.md's Frontier.

### 1.3 Readback (standing rule 3)

`python3 tools/fs121_db1_quotes.py` (output `data/fs121/db1/quotes.out`, exit 0): the brief's four quotations occur verbatim, whitespace
aside, in the frozen list (4 of 4); the list's §§ 0–1 quotations occur verbatim in their open sources (15 of 15; the sixteenth, FS-116's
qualification, has a fenced source and was not checked). With `--plant` (output `data/fs121/db1/quotes_plant.out`, exit 1) one character is
changed in one quotation of each part, and both are reported missing: the check fires. **No mismatch: nothing to report about the brief.**

derivation: DB1-readback
  statement: the brief's four quoted statements occur verbatim, whitespace aside, in data/fs121/claims.md, and every checkable quotation in that list's sections 0 and 1 occurs verbatim in its open source
  uses only: string comparison after collapsing whitespace
  not claimed: anything about the truth of the statements; the quotation of FS-116's opening, whose source is fenced for this job
  argument: § 1.3 Readback (standing rule 3)
  verdict: derived
  grade: computed over: the brief's four quoted blocks and the frozen list's sections 0 and 1 (16 quotations, 15 checkable)
  minds: 1
  model: C121-ENDS's block, 864 characters, found
  prior art: known: the frozen list itself — a textual check, not mathematics
  handoff: none — a readback for the coordinator

control: db1-quotes
  of: DB1-readback — every quotation found; the fault changes one character in one quotation of each part
  run: python3 ../tools/fs121_db1_quotes.py --summary
  expect: failures: 0
  fault: python3 ../tools/fs121_db1_quotes.py --summary --plant

### 1.4 The question sent (2026-09-29 05:58 UTC, to "main")

C121-LRA-LINE's "an interface curve with normal ν there" has two readings at a point of Σ where several interface curves meet: **(a)** ν is
the normal of the curve that carries the accumulating pieces; **(b)** ν is the normal of any interface curve through `x₀`. Off Σ they agree.
Asked which is meant, with two smaller wording points (C121-ENDS's "carrying at least three colours", distinct or counted by sectors;
"tile" in (R2)'s definition inside a saturated colouring), where both readings lead to the same verdict. Keryx acknowledged at 01:03 and
relayed the author's answers (FS121-O1, verbatim as Keryx quoted them), received 01:07, before any derivation in this record:

> "1. C121-LRA-LINE: reading (a). ν is the normal at x₀ of the interface curve on which the accumulating pieces lie, taken as the one-sided
> limit if x₀ ends that curve. It is not the normal of any other curve through x₀.
>
> 2. C121-ENDS, the (R2) branch: the first clause, "at least three colours", counts sectors. It means the outer colour and at least two
> further sectors, of colours other than the arc's two side colours, where those two sectors may carry one colour twice. Distinctness is
> claimed only in the second clause, "at least three distinct colours when no colour at z has density 0".
>
> 3. (R2)'s "an inner-colour tile along the radius-2 circle over the whole arc": your reading is the one meant. It is the inner colour's
> region lying just beyond the radius-2 arc along the whole arc, possibly in several components, not one single component."

So reading (a) counts for C121-LRA-LINE's verdict (reading (b) is recorded too), and the (R2) branch's first clause counts sectors. The
author's answers fix meanings only; they carry no verdict.

### 1.5 Registered expectations (written 2026-09-29 06:05 UTC, before any derivation is written in this record)

*Honest timing:* these are **informed** priors. Before writing them I had read the inputs' homes (§ 1.1) and spent some time reasoning
about the four statements in my head, so they are not naive. They are fixed here, in their own words, before any argument is written.

| statement | expected verdict | probability | likeliest break |
|---|---|---|---|
| C121-ENDS | derived (TRUE) | 0.75 | the clause "at least four when no colour at z has density 0": it needs a no-repeated-colour lemma at a point of Σ. W-NOREP is held only "at a cone vertex of a saturated map without cusps", and its case (ii) uses the density of the partner at the centre of a unit arc. A partner that is only a cusp, at distance 1 from `z`, is where it would fail — GAP there |
| C121-OUT | derived (TRUE) | 0.85 | points of Σ along the successive outer parallels, in case they cut the angular window instead of removing single normals |
| C121-PER | derived (TRUE) | 0.75 | its (Q) clause, which is ENDS's weak step; and the step "doubly periodic with ¬LRA ⟹ finitely many radii" |
| C121-LRA-LINE | derived (TRUE) under reading (a); a GAP under reading (b) | 0.7 | a point `x₀` of Σ where the accumulating pieces lie on a curve whose normal is not the ν named |

Planned route, written before deriving: work in the local picture that REG-J′ gives (finitely many arcs at each point of Σ, curvilinear
sectors between them), and derive the colour counts at a centre from properness straddles, not from maps. Where a held input is used
outside its stated scope, derive the scope's extension or name the gap.

Stage 1 committed: see `git log -- plans/FS121-DB1-verification.md`.

## Stage 2 — SAVED: the four derivations, the attacks, the verdicts

*Setting throughout: `f` an honest a.e.-proper `k`-colouring in D-NF, saturated, satisfying REG-J′; `k` arbitrary (no step below uses a
colour count). "Carries `j`" means lies in `supp S_j` (the list's § 0). All straddles are in the Fubini form: if `Q ⊆ S_j` has positive
measure and for each `q ∈ Q` the unit circle about `q` meets a set `T` with `|T ∖ S_j| = 0` in positive length, then the monochromatic
unit pairs of `j` have positive `Leb ⊗ σ` measure (for a.e. `q` the circle misses the null set `T ∖ S_j` up to length 0, by Fubini),
contradicting a.e.-properness. Inputs used at their filed grades: M-PINCH [derived, three minds], M-C11 [derived, three minds], M2-INTRAD
[derived, two minds; its finiteness step one], I-D1 [hand, one mind], M-HALF [hand, one mind], M-HULL2 and M-EXTREME [hand, one mind],
M-REDUCE-I's local-finiteness step [derived, one mind].*

### 2.1 DB1-L0 — the local picture at a point of Σ (from REG-J′; nothing new)

Under REG-J′, every bounded set meets finitely many interface arcs (M-REDUCE-I's proof: each region has diameter `≤ 1` by M-HULL2, every
maximal arc ends at points of Σ by M-EXTREME, and REG-J′ bounds the arcs at each). So for `p ∈ Σ` there is `r₀ > 0` with `B(p, r₀) ∩ Σ =
{p}` and every interface arc meeting `B(p, r₀)` ending at `p`; each has curvature `≤ 1` (M-C11), hence a tangent at `p`. The components of
`B(p, r₀)` minus these arcs (**sectors**) contain no essential boundary point, so each is a.e. one colour (a set with empty essential
boundary in a connected open set is null or full there). A sector between arcs with distinct tangents has **positive angle** and positive
density at `p`; between arcs with one tangent it is a **cusp** (density 0 at `p`, still carried). The colours carried at `p` are the
sectors' colours. For a colour `c` write `D_c(p)` for its **directions** at `p`: the closed angular intervals of its sectors, and its cusps'
tangents.

### 2.2 DB1-L1 — the cones at the centre of a unit arc (FS112-U1's cones, re-derived in the saturated setting)

*Statement.* Let `J ⊆ ∂B(z, 1)` be an interface arc over an open window `W` of directions of length `ℓ ∈ (0, 2π)`, with colour `a` inside
and `b` outside along `J` off Σ. If `z` carries `a`, then `D_a(z) ⊆ F := {d : d·e ≥ 0 ∀ e ∈ W}` (the closed facing cone, width `π − ℓ`);
if `z` carries `b`, then `D_b(z) ⊆ A := {d : d·e ≤ 0 ∀ e ∈ W} = −F`. The two open **side cones** `S₁, S₂` (the rest, width `ℓ` each, cyclic
order `F, S₁, A, S₂`) contain no direction of `a` or `b`.

*Proof.* Let `d ∈ D_b(z)` with `d·e_w > 0` for some `w ∈ W` (open, so wlog `J ∋ z + e_w` off Σ). On the ball `N` of (H1), (H2) at
`x = z + e_w`, M-PINCH makes `S_b ∩ N` a.e. the outside of `∂B(z, 1)`: a strip `T = {z + (1 + τ)e_θ : |θ − w| < β, 0 < τ < τ₀} ⊆ S_b`
a.e. The `b`-material near `z` in a narrow cone `K ∋ d` (with `d′·e_w ≥ κ > 0` on `K`) has positive measure in every ball about `z`. For
`q` there, `|z + (1 + τ)e_θ − q| = 1` at `τ ≈ (q − z)·e_θ ∈ (0, τ₀)` for `|q − z|` small, continuously in `θ`: the unit circle about `q`
crosses `T` in positive length. Straddle: contradiction. For `a`, the same with the strip `{z + (1 − τ)e_θ}` inside `J` and
`τ ≈ −(q − z)·e_θ`. ∎

### 2.3 DB1-L3 — at a point of Σ no colour has two sectors of positive angle (W-NOREP, localised; cusps allowed)

*Statement.* Under the setting, at every `p ∈ Σ`, no colour occupies two sectors of positive angle. No hypothesis on cusps, at `p` or
elsewhere.

*Proof.* Let `G₁ ≠ G₂` be positive-angle sectors of colour `γ` at `p`. `p` is an essential boundary point with `γ ∈ P(p)`, so M-HALF gives
`G₁` angle `θ₁ ≤ π`. Let `r` be an edge of `G₁` (an arc from `p`), `t` its tangent at `p`, `n` its normal at `p` pointing out of `G₁`, and
`H_r = {d : d·n ≤ 0}`. **Claim: `D_γ ∩ G₂ ⊆ H_r`**, i.e. `G₂` has no direction `d′` with `d′·n > 0`. Suppose it has; then an open subcone of
`G₂` has `d̃·n ≥ κ > 0`, and `δ = p + ρd̃` (`ρ` small) is a positive-measure set of `γ`-points. Parametrise `r` by arclength `s ∈ (0, s₀)`.
Radius-1 pieces of `r` near `p` are finitely many: their centres lie in Σ (L4, L5 below: a unit arc's centre is never a regular point) at
distance about 1 from `p`, so they are finitely many, and `r` cannot return to a unit circle it has left (a piece of radius `≥ 2`, or one
curving away, keeps `|c − y|² − 1` convex while outside, by the curvature bound). So for `s₀` small one of two cases holds on `(0, s₀)`.

- **Case T** — no point of `r` has `γ`'s contact at a single fixed point: every point is of PINCH's tangent type with `γ`-contact
  `Π(s) = x(s) + n(s)` (then `|κ| ≤ 1/2` a.e., radius `≥ 2` by M2-INTRAD, or `κ = −1`, a unit arc curving into `G₁`). By M2-INTRAD's step (1)
  (re-derived: `Π ⊆ supp S_γ`, `Π ∩ S̃_γ = ∅` by I-D1, and at `Π(s) ∉ Σ` the near side has density 0 for `γ` by the straddle against `G₁`), `Π`
  is off Σ an interface with `γ` filling its far side locally. With `κ ≤ 1/2` or `κ = −1`, `(x(s) − p)·n(s) = −∫₀ˢ κ (σ + O(σ²)) dσ ≥ −s²/4`,
  so `|Π(s) − p|² − 1 ≥ s²/2 (1 + o(1))`. Then `|Π(s) − δ|² = 1 + A(s) − 2ρ d̃·n + O(ρs + ρ²)` with `A(s) ≥ s²/2`: below 1 as `s → 0⁺`, above
  1 at `s = C√ρ`. So `|Π(s*) − δ| = 1` at some `s* ∈ (0, C√ρ)`, with `Π(s*) ∉ Σ` once `ρ` is small (the points of Σ on `Π` are finitely many
  and, but for `p + n`, at `s` bounded below). Just below `s*` the unit circle about `δ` runs at depth `1 − |Π(s) − δ| ∈ (0, small)` beyond
  `Π` — inside `γ` — along a positive length. Straddle against `G₂`: contradiction.
- **Case K** — `r` on `(0, s₀)` is an arc of `∂B(y, 1)` whose centre `y` carries `γ` (the split case with `γ` either side, or the tangent
  radius-1 case whose `γ`-contact is the centre; these are the only ways a single point is `γ`'s contact). `y ∈ Σ` (L1 confines `γ` at `y` to
  a cone of width `< π`), so L0 applies at `y`. **(K−)** `y = p − n`, `γ` inside `r`: by L1 at `y`, `D_γ(y) ⊆ F_y ⊆ {m : m·n ≥ 0}`; its boundary
  ray on `p`'s side is `t`. **(K+)** `y = p + n`, `γ` outside `r`: `D_γ(y) ⊆ A_y ⊆ {m : m·n ≥ 0}`; its boundary ray on `p`'s side is `−t`.
  *Non-degenerate* (some direction `m ∈ D_γ(y)` with `m·n > 0`: every positive-angle sector at `y` has one, and so does every cusp not tangent
  to `±t`): for `q = y + εm̃`, `|q − δ|² = 1 ∓ 2ε m̃·n ± 2ρ d̃·n + O(ε² + ρ² + ερ)` (upper signs K−, lower K+) — first-order terms of opposite
  sign, so the circle about each such `q` crosses `G₂` near `p` in positive length. Straddle: contradiction. *Degenerate* (`γ` at `y` only as
  cusps tangent to `t` in K−, to `−t` in K+): a cusp's bounding arcs have curvature `≤ 1` and are tangent at `y` to the unit circle about `p`;
  written as graphs over that tangent, `sin` of the slope angle has derivative `≤ 1`, the circle's exactly 1, so they lie outside the open
  unit disc about `p`, and so does the cusp. Its points `q` therefore have `|q − p| = 1 + s`, `s > 0` off a null set. In K−, near `p` the unit
  circle about `q` is `η ≈ λμ − μ²/2 − s` (in the frame `v = μt + ηn`, `λ ≈ |q − y|`) against `r`'s `η_r ≈ −μ²/2`: for `μ ∈ (s/2λ, s/λ)` it
  runs inside `G₁` at angular depth `≤ λ` — a straddle against `G₁` itself, whatever `G₂` is. In K+ the circle about `q` is
  `η ≈ s + λμ + μ²/2`: it passes at height `≈ s` over `p`, through every direction of `{d : d·n > 0}` at distance `≈ s/sin φ`, hence through
  `G₂`'s subcone. Straddle: contradiction. (Exact at one instance each: `tools/fs121_db1_cusp.py`, control `db1-cusp`.)

So `G₂ ⊆ H_r` for both edges `r₁, r₂` of `G₁`. As `θ₁ ≤ π`, `H_{r₁} ∩ H_{r₂}` is `G₁`'s closed cone; `G₂`, of positive angle and disjoint
from `G₁`'s interior, cannot lie in it. ∎

*Where cusps were allowed:* an edge of `G₁` may border a cusp of another colour (then PINCH at `r`'s points works inside tiny balls, and
nothing changes); cusps at `y` are the degenerate case. What the proof does need is that `G₁` and `G₂` both have positive angle — a colour
repeated as a sector and a cusp at `p` is not excluded, and the statement does not say it is.

### 2.4 DB1-L4 and DB1-L5 — what the centre of a unit arc carries

**DB1-L4** (FS112-N3-NOBOTH, saturated form, with four distinct colours). *If a unit arc `J` as in L1 is of kind both (`z` carries `a` and
`b`), then `z ∈ Σ` and `z` carries at least four distinct colours; two of them are carried in positive-angle sectors meeting the side cones.*
*Proof.* L1: `D_a(z) ⊆ F`, `D_b(z) ⊆ A`; `F` nonempty forces `ℓ ≤ π`. `z ∈ Σ`: otherwise `z` is a density point (then a carried colour has
density 0 there, a cusp point, in Σ) or a regular interface point whose two colours are half-planes in the blow-up, which `F` and `A`
(width `< π`) cannot hold. By L0, `S₁` and `S₂` (open, width `ℓ > 0`) are covered, up to finitely many rays, by positive-angle sectors, whose
colours are not `a` or `b` (L1). A single sector meeting both `S₁` and `S₂` would contain all of `F` or all of `A` in its open angle, hence a
direction of `a` or of `b`: impossible. So a sector `X₁` meeting `S₁` and a sector `X₂` meeting `S₂` are distinct, and by L3 their colours
differ. `{a, b, c(X₁), c(X₂)}`: four distinct colours. ∎

**DB1-L5** (the centre of an (R2) arc). *If `J` is of PINCH's tangent type with centre `z` carrying `b` and not `a`, then `z ∈ Σ` and at least
two positive-angle sectors at `z` carry colours other than `a` and `b`, pairwise distinct by L3: `z` carries at least three distinct colours.*
*Proof.* `D_b(z) ⊆ A` (L1); `a` is absent near `z`. `z ∈ Σ` as in L4 (`b` is confined to a cone of width `π − ℓ < π`). The open cone
`O = S¹ ∖ A` has width `π + ℓ > π` and is covered, up to finitely many rays, by positive-angle sectors of colours `≠ a, b`, each of angle `≤ π`
(M-HALF). So at least two sectors meet `O`, and by L3 no two positive-angle sectors share a colour. ∎

### 2.5 DB1-L6 and DB1-L7 — the chain inward and the parallel outward

**DB1-L6** (the chain toward the centre). *Let `J` be an interface arc of finite radius `n` (a circular arc about `c` over a window `W`). Off
the finitely many normals through points of Σ, the concentric arcs of radii `n − 1, …, 1` over `W` are interface arcs, each of PINCH's
tangent type while its radius is `≥ 2`; the last, `J₁`, is a unit arc centred at `z = c`, and `z` carries `J₁`'s outer colour.*
*Proof.* A radius `≥ 2` excludes the split type (split makes the local interface one unit arc: M-C11 (iii)), so the arc is tangent type, and
its unit parallel toward `c` — a regular concentric arc of radius one less — is, off Σ, an interface arc (M2-INTRAD (1); at a point `p′` of the
parallel that is the radial image of a point of Σ but not itself in Σ: `p′ ∈ supp` of the partner colour by closure; if it were a density-1
point of that colour, the colour on the parallel's near side would be carried at `p′` with density 0, putting `p′` in Σ; so `p′` is an
essential boundary point off Σ and, by (H1), (H2) and M-C11, the interface through it contains the parallel). Induct down to radius 1. At a
point `x ∈ J₁` off Σ, with inner colour `α` and outer `β`: split gives `z` carrying both; tangent gives the unit disc tangent at `x` on the
inner side, `B(z, 1)`, inside `S_α`, whose centre is `β`'s contact: `z` carries `β`. ∎ The bad normals are finite in number (each point of
Σ other than `c` lies on one ray from `c`), so "off a null set of normals" holds with a finite set.

**DB1-L7** (the parallel outward). *The unit parallel away from the centre of a tangent-type interface arc of radius `n ∈ {1, 2, …} ∪ {∞}`
is, at each of its points off Σ, a tangent-type interface point, on the concentric arc of radius `n + 1` over the same window.* *Proof.* As
L6 on the outer side: the outer parallel lies in `supp S_a` (`a` the inner colour, whose contact is `x + ν`), misses `S̃_a` (I-D1); at a point
off Σ it is an essential boundary point (the same closure argument covers the radial images of points of Σ), where (H1), (H2) and M-C11 make
the interface through it contain the parallel, of radius `n + 1 ≥ 2`, hence not split. ∎ *This step uses REG-J′ nowhere*; REG-J′ enters only
to make the points of Σ on each parallel finitely many, so that the family is over the whole window.

### 2.6 The four statements

**C121-ENDS — TRUE.** By L6, off finitely many normals the chain ends at a unit arc `J₁` centred at `z`, and `z` carries `J₁`'s outer colour.
If `z` carries the inner colour too, `J₁` is of kind both by definition, and by L4 `z ∈ Σ` carries at least four distinct colours in at least
four sectors (so it is a vertex: at least four arcs end there) — so `J₁` is (Q), whether or not a colour has density 0 at `z`. If not, no
point of `J₁` is split (split puts both colours at the centre), so `J₁` is tangent type throughout, and by L7 the radius-2 parallel is, off
Σ, an interface of the inner colour with the inner colour beyond it along the whole arc — (R2), in the author's reading of "tile" (§ 1.4) —
and by L5 `z ∈ Σ` carries the outer colour and at least two further positive-angle sectors of other colours (the first clause, which counts
sectors) of pairwise distinct colours (at least three distinct colours, with or without density-0 colours at `z`). **Both density conditions
are idle** (a thin truth, § 2.7); the statement as written holds.

**C121-OUT — TRUE.** L7 is the first clause. Iterating it over the window `W` (radii `n + 1 ≥ 2` stay tangent type) gives arcs of radii
`n, n + 1, n + 2, …` over `W`, each an interface off the finitely many points of Σ it meets (REG-J′'s local finiteness in each bounded set);
toward the centre the family ends (L6), so it is one-sided. For `n = ∞` the family is two-sided (SQ9's ladder).

**C121-PER — TRUE.** A curved tangent-type interface would carry radii `n, n + 1, n + 2, …` (C121-OUT): infinitely many radii. So with finitely
many radii every curved interface is split, hence a unit arc of kind both (M-C11 (iii)); an (R2) arc is a unit arc whose centre does not
carry the inner colour, so it is not split, so it is tangent type and excluded. By L4 every such centre carries at least four colours: every
curved interface is (Q), whether or not a colour has density 0 at its centre (the condition is idle, § 2.7). *In particular:* a doubly
periodic colouring with infinitely many radii has interface pieces of radii `n_i → ∞`; translating each by a period into a compact fundamental
domain gives pieces of the same radii meeting it, which accumulate at a point: LRA. So doubly periodic with ¬LRA gives finitely many radii.

**C121-LRA-LINE — TRUE under reading (a)** (the author's, § 1.4); **not derived under reading (b)** (GAP; no counterexample). Let pieces
`J_i` of radii `n_i → ∞` lie on the interface curve `Γ` and accumulate at `x₀`, `ν` the normal of `Γ` at `x₀` (one-sided if `x₀` ends `Γ`;
`Γ`'s tangent extends to its ends since `|κ| ≤ 1`). Fix `k ∈ ℤ` and take `n_i ≥ |k| + 2`. Choose `x_i ∈ J_i` with `x_i → x₀`; then
`ν(x_i) → ν`. The `k`-fold unit parallel of `J_i` on the side of `ν` is concentric with it, of radius `n_i ± k ≥ 2` at every step, so by L6
(toward `J_i`'s centre) or L7 (away) it is, off finitely many points of Σ, a tangent-type interface piece; moving `x_i` by less than `1/i`
along `J_i` avoids those points. So `x_i + kν(x_i) → x₀ + kν` lie on interface pieces of radii `n_i ± k → ∞`: pieces of radii tending to
infinity accumulate at `x₀ + kν`. ∎ Off Σ only one interface curve passes through `x₀` (by (H1), (H2) and L0's local finiteness), so there
the two readings agree. Under (b), at `x₀ ∈ Σ` with the pieces on `Γ` and another curve `Γ′` through `x₀` with normal `ν′ ≠ ±ν`, the pieces'
parallels accumulate at `x₀ + kν`, not at `x₀ + kν′`, and nothing held puts pieces there: GAP at "the pieces lie on the curve whose normal
is `ν`". No refutation is possible without a saturated colouring with LRA, and none is held.

### 2.7 Attacks — where each statement stops holding

**On C121-ENDS.**
1. *Smallest cases.* `n = 1` (the arc is `J₁`): both branches read directly. `ℓ` near 0: `S₁, S₂` thin but of positive width, still
   covered by positive-angle sectors: four colours stand. `ℓ = π`: `F` and `A` are rays, `a` and `b` cusps at `z`; the argument is unchanged.
   `ℓ > π`: `F = ∅`, so a kind-both centre is impossible, and for a tangent unit arc `A = ∅` too — `J₁`'s window is at most `π` either way.
2. *Each hypothesis removed.* Without **honest**: M2-DISCK7's cover (constant-width bodies, `k = 7`) has non-circular boundaries and a far
   parallel closing in two steps — no chain of unit arcs; the conclusion fails outside the class, so honesty is used (through PINCH's (in, in)
   exclusion). Without **saturated**: V0-WIG7's wiggled edges have non-integer curvature and no parallel interfaces. Without **REG-J′**: L0
   fails (no sector picture at `z`), and with it L3–L5 as proved; no counterexample is known.
3. *Where the attack succeeds — the nearest false statement.* "A kind-both centre has at least four colours **of positive density**"
   (`|P(z)| ≥ 4`) is **FALSE at R7**: at a lattice point the three ups have density `1/3` each and the three downs are cusps, so `|P(z)| = 3`
   while six colours are carried (`tools/fs121_db1_r7cones.py`: `carried 6 essential 3`, and the cone picture of L1 and L4 holds at all three
   arcs centred there). The statement's "carries" (support) is the count that holds; the essential multicolour is not.
4. *Thin truth.* The two clauses "at least four when no colour at `z` has density 0" and "at least three distinct colours when no colour at
   `z` has density 0" hold without their condition (L4, L5). R7 is an object outside the first condition's hypothesis (cusps of density 0 at
   every kind-both centre) that satisfies its conclusion (six colours). Local to L3: the condition would be needed only if a colour could
   repeat as two positive-angle sectors in the presence of cusps, and L3 excludes that.
5. *Not attacked:* whether any (R2) end exists (not claimed; no inhabitant); whether an (R2) centre carries four (C121-R2-FOUR, not mine).

**On C121-OUT.**
1. *`n = ∞`:* SQ9's flat edges carry their unit ladder on both sides (held, VM2-LAD-CTL, 48 of 48 edge-sides).
2. *Remove "tangent-type":* **FALSE for split arcs.** R7's Reuleaux arc of `U(0, 0)` about `v = (0, 0)` is split; its outer unit parallel,
   the radius-2 arc about `v`, passes through `(√3, 1)`, which is at distance `≠ 1` from every lattice point and strictly inside the up `U(1, 1)`
   (exact in `ℚ(√3)`: `tools/fs121_db1_r7parallel.py`, control `db1-r7-parallel`). The hypothesis is used, and the attack succeeds exactly at
   the neighbouring class.
3. *Remove REG-J′:* the first clause survives (L7 uses REG-J′ nowhere) — a **thin truth**: REG-J′ is idle for the first clause and used only
   for the "so" clause's whole window.
4. *Remove "honest":* M2-DISCK7 again — covers have no such family.
5. *Curved inhabitant:* none held at any `k` (the *Inhabitant* line says so); the class may be empty (C121-CURVED is open).

**On C121-PER.**
1. *Inhabitant:* R7 (doubly periodic, radii `{1}`, no LRA): every interface a split unit arc of kind both centred at a six-colour lattice point,
   no (R2): the conclusion holds. SQ9 and HEX9: no curved interface, vacuous.
2. *Nearest false statements:* "every interface is a unit arc of kind both" — FALSE at SQ9 (segments); the statement's "curved" is needed.
   "(Q) with four colours of positive density" — FALSE at R7 (`|P| = 3`), as for ENDS.
3. *Thin truth:* "where no colour has density 0 at an arc's centre" is idle (L4).
4. *Remove ¬LRA from the periodic clause:* the finiteness of radii would need LRA excluded otherwise; not examined (no periodic LRA object).

**On C121-LRA-LINE.**
1. *Reading (b):* at a point of Σ where two interface curves meet with different normals, the conclusion for the other curve's normal is not
   implied (§ 2.6) — the only place the statement's words allow more than the argument carries. Reading (a) is the author's.
2. *`k` large against `n_i`:* the parallels toward a piece's centre need `n_i > |k| + 1`; true along the sequence, so no loss.
3. *Pieces accumulating at `x₀` but not lying on the curve through it:* off Σ impossible (local finiteness); at Σ, reading (a) names the
   curve they lie on.
4. *Inhabitant:* none held (no saturated colouring has LRA); the statement is a reduction, and nothing here tests it on an object.

### 2.8 Self-audit before the commit (standing rule 4)

- **All four predictions met, at 0.7–0.85.** They were informed (§ 1.5 says so): I had reasoned through the inputs before writing them. By my
  procedure's own warning, a record whose predictions all come true has probably predicted what it had already seen. So the Brier score here
  measures little; the prediction's value was aiming the attack, and it did: the one weak step it named (the no-repeat step at a centre)
  became DB1-L3, the step that most needs a second reader.
- **The result I like is audited hardest.** DB1-L3 with cusps allowed makes both density conditions idle, which is a stronger conclusion than
  the author wrote. It rests on one mind (mine), on a second-order computation in its degenerate case (checked exactly at one instance by
  `db1-cusp`, not in general), and on the comparison step for cusp arcs. What falls with what: if only the cusps-at-`p` part fails, the
  thin truths fall and the verdicts stand as written. If Case K fails (a partner at a unit arc's centre, which can be a cusp even when no
  colour at `p` has density 0), the **(Q) clauses** of C121-ENDS ("at least four when no colour at z has density 0, so J_1 is (Q)") and of
  C121-PER become **GAP at the no-repeat step**: W-NOREP's own proof treats only the partner inside the arc, and assumes it has positive
  density (H-DEN). The rest of both verdicts does not use DB1-L3 and stands: the chain, the centre's outer colour, "at least four colours or
  a repeated colour" (the side cones' sectors), and the (R2) branch's two clauses (the sector count by M-HALF; three distinct colours when no
  colour at `z` has density 0, because consecutive sectors in the open cone then differ in colour).
- **Invention signal (G87):** none seen. The author's density conditions and DB1-L3 do not contradict each other: one is a sufficient
  hypothesis, the other says the hypothesis is not needed.

derivation: DB1-L1
  statement: at the centre z of a unit interface arc J over a window W of length ℓ, with colour a inside and b outside, the directions of a carried at z lie in the closed facing cone {d : d·e ≥ 0 for all e in W} and those of b in its negative; neither colour has a direction in the two open side cones
  uses only: M-PINCH at points of J off Σ (a strip of b outside, of a inside); a.e.-properness by the Fubini straddle
  not claimed: that z carries either colour; anything at points of J in Σ
  argument: § 2.2 DB1-L1 — the cones at the centre of a unit arc (FS112-U1's cones, re-derived in the saturated setting)
  verdict: derived
  grade: hand
  minds: 1
  model: R7 at the lattice point (0, 0): each up's corner sector equals the facing cone of its opposite arc, and the down across the arc is carried as a cusp in the away cone
  prior art: partly: FS112-U1 — the same cones at a unit arc's centre in a valid map (FS-112, two minds)
  handoff: none — a lemma of this record

control: db1-r7-cones
  of: DB1-L1 and DB1-L4 on R7 — at the lattice point (0, 0), the three unit arcs centred there: cones, carried and essential colours; the fault colours the ups by n mod 2 only
  run: python3 ../tools/fs121_db1_r7cones.py
  expect: arcs 3 cone-picture-ok 3 carried 6 essential 3
  fault: python3 ../tools/fs121_db1_r7cones.py --plant

derivation: DB1-L3
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ no colour occupies two sectors of positive angle, whatever cusps are present at the point or elsewhere
  uses only: DB1-L0's sector picture; M-HALF at the point; at each edge of the first sector, M-PINCH's two types — the tangent type's partner curve (M2-INTRAD step (1)) or a unit arc whose centre carries the colour (DB1-L1 there); the curvature bound 1 on cusp arcs (M-C11), by comparison with the unit circle
  not claimed: that a colour cannot occupy a sector and a cusp, or two cusps, at one point; anything without REG-J′
  argument: § 2.3 DB1-L3 — at a point of Σ no colour has two sectors of positive angle (W-NOREP, localised; cusps allowed)
  verdict: derived
  grade: derived from: DB1-L1
  minds: 1
  model: R7's lattice points (three ups of three distinct colours, three cusps); SQ9's vertices (four distinct colours)
  prior art: partly: FS111-W-NOREP — the statement for saturated maps without cusps (one mind); this form adds the partner at a unit arc's centre on either side and the partner seen only as a cusp
  handoff: de Bruijn — with M-PINCH and M-C11, if route M's colour counts at centres are formalised

control: db1-cusp
  of: DB1-L3 — the degenerate case: the unit circle about a cusp point at the partner meets the first sector (K−) or the second (K+); the fault puts the cusp inside the unit disc about the point, which the comparison step forbids
  run: python3 ../tools/fs121_db1_cusp.py
  expect: K- circle about the cusp point meets G1 at 9 of 9; K+ circle meets G2 at 9 of 9
  fault: python3 ../tools/fs121_db1_cusp.py --plant

derivation: DB1-L4
  statement: the centre z of a unit interface arc of kind both lies in Σ and carries at least four distinct colours, two of them in positive-angle sectors meeting the two side cones
  uses only: DB1-L1; DB1-L0; DB1-L3
  not claimed: four colours of positive density (false at R7, where three of the six are cusps); five colours
  argument: § 2.4 DB1-L4 and DB1-L5 — what the centre of a unit arc carries
  verdict: derived
  grade: derived from: DB1-L1, DB1-L3
  minds: 1
  model: R7 at the lattice point (0, 0): six colours carried, the side cones met by two ups of distinct colours
  prior art: partly: FS112-N3-NOBOTH — "at least four colours or a repeated colour" in valid maps (two minds); the repeated case is excluded here by saturation
  handoff: none — used by the verdicts on C121-ENDS and C121-PER

derivation: DB1-L5
  statement: the centre z of a tangent-type unit interface arc that carries its outer colour and not its inner lies in Σ and has at least two positive-angle sectors of colours other than the two side colours, of pairwise distinct colours, so z carries at least three distinct colours
  uses only: DB1-L1; DB1-L0; M-HALF; DB1-L3
  not claimed: four colours at such a centre (C121-R2-FOUR's question); that such an arc exists
  argument: § 2.4 DB1-L4 and DB1-L5 — what the centre of a unit arc carries
  verdict: derived
  grade: derived from: DB1-L1, DB1-L3
  minds: 1
  model: none held — no held saturated colouring has a tangent-type unit arc
  prior art: owed — no search run by this job; FS-111's queries on saturated colourings, "chromatic & plane & (measurable | map) & (tight | saturat* | maximal)" (7), found none of these objects
  handoff: none — used by the verdict on C121-ENDS

derivation: DB1-L7
  statement: the unit parallel away from the centre of a tangent-type interface arc of radius n (a positive integer, or infinite) is, at each of its points off Σ, a tangent-type interface point on the concentric arc of radius n + 1; REG-J′ is not used
  uses only: M-PINCH's tangent type (the inner colour's contact across the outer side); I-D1; (H1), (H2) and M-C11 at a point off Σ; Σ's cusp clause
  not claimed: the same for split arcs (false at R7, control db1-r7-parallel); that the family covers the whole window without REG-J′
  argument: § 2.5 DB1-L6 and DB1-L7 — the chain inward and the parallel outward
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9's flat edges (n infinite, both sides; held exact at 48 of 48 edge-sides)
  prior art: partly: FS111-M2-INTRAD step (1) — the same parallel (two minds); this record adds the radial images of points of Σ and that REG-J′ is idle
  handoff: none — used by the verdicts on C121-OUT and C121-LRA-LINE

control: db1-r7-parallel
  of: DB1-L7 — its not-claimed line: R7's split arc about (0, 0): its outer unit parallel passes through (√3, 1), strictly inside the up U(1, 1) and on no interface; the fault takes the arc itself (radius 1)
  run: python3 ../tools/fs121_db1_r7parallel.py
  expect: radius 2: lattice points checked 57; on an interface False; interior of U(1,1) True
  fault: python3 ../tools/fs121_db1_r7parallel.py --plant

derivation: DB1-L6
  statement: the chain of concentric unit parallels toward the centre of an interface arc of finite radius n is, off the finitely many normals through points of Σ, a chain of interface arcs of radii n − 1, …, 1, tangent type while the radius is at least 2; the last is a unit arc whose centre carries its outer colour
  uses only: M2-INTRAD step (1) on the concave side; M-C11 (iii) (split means radius 1); M-PINCH at the unit arc (split, or tangent with the outer colour's contact at the centre); the closure argument of DB1-L7 at radial images of points of Σ
  not claimed: that the centre carries the inner colour; anything along a normal through a point of Σ
  argument: § 2.5 DB1-L6 and DB1-L7 — the chain inward and the parallel outward
  verdict: derived
  grade: hand
  minds: 1
  model: R7 (n = 1: every arc is its own J₁, split, the centre carrying both colours)
  prior art: partly: FS111-M2-INTRAD step (2) — the same descent (two minds); this form names the centre's outer colour and the bad normals as finitely many
  handoff: none — used by the verdicts on C121-ENDS and C121-LRA-LINE

verification: C121-ENDS
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius ends, off a
    null set of normals, at a unit arc J_1 whose centre z carries J_1's outer colour; either z also carries J_1's inner colour — J_1 is of kind
    both and z is a vertex with at least four colours or a repeated colour, at least four when no colour at z has density 0, so J_1 is (Q) — or
    it does not — J_1 is (R2), and z is a point of Σ carrying at least three colours, and at least three distinct colours when no colour at z
    has density 0.
  given: the statement verbatim with its not claimed, Colours and Inhabitant lines; the frozen list's definitions and held inputs; the held inputs'
    homes in FS-111 and FS-112 (M-PINCH, M-C11, M2-INTRAD with its proof, W-NOREP with its proof, FS112-U1, FS112-N3-NOBOTH), read before
    deriving (§ 1.1–1.2); the author's answers on meaning (§ 1.4); no verdict, sketch or route of the first derivation
  committed: 2026-09-29 (this stage's commit, FS121-DB1: stage 2)
  predicted: derived — 0.75 — likeliest break: the clause "at least four when no colour at z has density 0", which needs a no-repeated-colour lemma at a
    point of Σ that W-NOREP gives only for maps without cusps
  verdict: derived
  method: the local sector picture at z under REG-J′ (DB1-L0), the cones at the centre re-derived by straddles (DB1-L1), a localised no-repeat lemma
    with cusps allowed (DB1-L3), then the colour counts (DB1-L4, DB1-L5) and the chain by M2-INTRAD step (1) (DB1-L6); the (Q) branch gets four
    distinct colours with no density condition; the first derivation's route is unknown to this mind until the comparison
  attack: § 2.7 Attacks — where each statement stops holding
  divergences: none — the comparison with the first derivation opens only after these verdicts are committed (stage 3)
  counterexamples: thin truth: R7 at a lattice point, which has cusps of density 0 at every kind-both centre and still carries six colours — local to the
    clause "at least four when no colour at z has density 0" (DB1-L4 needs no density condition); thin truth: every (R2) centre under DB1-L5 —
    local to the clause "at least three distinct colours when no colour at z has density 0", which holds without its condition
  minds: 1 — this record's derivation alone, blind to the first derivation; the count with it is stage 3's
  grade: hand

verification: C121-OUT
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, the unit parallel away from the centre of every tangent-type interface arc of
    radius n (n a positive integer, or infinite for a segment) is, off Σ, a tangent-type interface arc of radius n + 1; so every curved
    interface of tangent type lies in a one-sided infinite family of concentric interface arcs of radii n, n + 1, n + 2, … over one angular
    window.
  given: the statement verbatim with its not claimed, Colours and Inhabitant lines; the frozen list's definitions and held inputs; the held inputs'
    homes in FS-111 and FS-112 (M-PINCH, M-C11, M2-INTRAD with its proof, W-NOREP with its proof, FS112-U1, FS112-N3-NOBOTH), read before
    deriving (§ 1.1–1.2); the author's answers on meaning (§ 1.4); no verdict, sketch or route of the first derivation
  committed: 2026-09-29 (this stage's commit, FS121-DB1: stage 2)
  predicted: derived — 0.85 — likeliest break: points of Σ along the successive outer parallels cutting the angular window
  verdict: derived
  method: the outer parallel read at each of its points off Σ, the radial images of points of Σ included, by M-PINCH's tangent type, I-D1 and (H1),
    (H2) there (DB1-L7); iterated over the window with REG-J′'s local finiteness; the first derivation's route is unknown to this mind until the
    comparison
  attack: § 2.7 Attacks — where each statement stops holding
  divergences: none — the comparison with the first derivation opens only after these verdicts are committed (stage 3)
  counterexamples: thin truth: the first clause without REG-J′ — local to REG-J′, which DB1-L7 does not use; none refuting — the tangent-type hypothesis was
    removed and the statement fails at R7's split arc (control db1-r7-parallel), the class the statement excludes
  minds: 1 — this record's derivation alone, blind to the first derivation; the count with it is stage 3's
  grade: hand

verification: C121-PER
  statement: in an honest saturated colouring in D-NF satisfying REG-J′ whose interfaces carry only finitely many radii of curvature — in particular a
    doubly periodic one satisfying ¬LRA — every curved interface is a split unit arc of kind both and no (R2) arc occurs; where no colour has
    density 0 at an arc's centre, every such arc is (Q).
  given: the statement verbatim with its not claimed, Colours and Inhabitant lines; the frozen list's definitions and held inputs; the held inputs'
    homes in FS-111 and FS-112 (M-PINCH, M-C11, M2-INTRAD with its proof, W-NOREP with its proof, FS112-U1, FS112-N3-NOBOTH), read before
    deriving (§ 1.1–1.2); the author's answers on meaning (§ 1.4); no verdict, sketch or route of the first derivation
  committed: 2026-09-29 (this stage's commit, FS121-DB1: stage 2)
  predicted: derived — 0.75 — likeliest break: its (Q) clause (the no-repeat step), and "doubly periodic with ¬LRA gives finitely many radii"
  verdict: derived
  method: from C121-OUT (a curved tangent interface carries infinitely many radii) and M-C11 (iii); (Q) from DB1-L4; the periodic case by compactness
    of a fundamental domain; the first derivation's route is unknown to this mind until the comparison
  attack: § 2.7 Attacks — where each statement stops holding
  divergences: none — the comparison with the first derivation opens only after these verdicts are committed (stage 3)
  counterexamples: thin truth: R7 — local to the clause "where no colour has density 0 at an arc's centre", idle by DB1-L4
  minds: 1 — this record's derivation alone, blind to the first derivation; the count with it is stage 3's
  grade: hand

verification: C121-LRA-LINE
  statement: in an honest saturated colouring in D-NF satisfying REG-J′, if interface pieces of radii tending to infinity accumulate at a point x₀ of an
    interface curve with normal ν there, then pieces of radii tending to infinity accumulate at x₀ + kν for every integer k.
  given: the statement verbatim with its not claimed, Colours and Inhabitant lines; the frozen list's definitions and held inputs; the held inputs'
    homes in FS-111 and FS-112 (M-PINCH, M-C11, M2-INTRAD with its proof, W-NOREP with its proof, FS112-U1, FS112-N3-NOBOTH), read before
    deriving (§ 1.1–1.2); the author's answers on meaning (§ 1.4); no verdict, sketch or route of the first derivation
  committed: 2026-09-29 (this stage's commit, FS121-DB1: stage 2)
  predicted: derived — 0.7 — likeliest break: a point x₀ of Σ where the accumulating pieces lie on a curve whose normal is not the ν named (reading (b))
  verdict: derived
  method: the k-fold unit parallels of each accumulating piece, toward or away from its centre (DB1-L6, DB1-L7), with the normals converging along the
    curve; reading (a), the author's; under reading (b) a GAP at "the pieces lie on the curve whose normal is ν"; the first derivation's route
    is unknown to this mind until the comparison
  attack: § 2.7 Attacks — where each statement stops holding
  divergences: none — the comparison with the first derivation opens only after these verdicts are committed (stage 3)
  counterexamples: none — no saturated colouring with LRA is held, so no object tests either reading; reading (b) is a gap, not a refutation
  minds: 1 — this record's derivation alone, blind to the first derivation; the count with it is stage 3's
  grade: hand
