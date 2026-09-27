# FS110-YB4 — blind verification of the construction side's round 4 (FS110-Y4), the `d = 2` seam

*Job FS110-YB4, blind verifier (Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/YB110-verify-construction.md` with its instance block
`data/fs110/briefs/YB4-110-instance.md` and `data/fs110/briefs/STANDING-RULES.md`. Scope: the section "§ Continuation — FS110-Y4" of
`plans/FS110-Y-construction.md`, whose theorem list and fragment formulas (§11.3, §11.4) the instance quotes. Working files:
`data/fs110/fs110-yb4/`; tools `tools/fs110_yb4_*.py`; scratch `scratchpad/fs110-yb4/`.*

## Theorems this phase proved

*(filled at each stage; one line per theorem, its grade and address)*

## Fence log

- **Touch 1 (12:1x UTC, disclosed).** To learn why `data/fs110/claims.md` had changed on disk after my start, I ran
  `git log --oneline -3 -- data/fs110/claims.md`, which printed three commit subjects of the owner's claim-list commits, one of them
  ("FS-110: claims 8 second update") after my start-up snapshot. `git log` beyond the snapshot is fenced; no other commit subject or
  content was seen. The file itself is my reading, and I read its second update to §8.
- **Permitted read (disclosed).** To check the instance's quotation of the side's §11.3–§11.4 (standing rule 5), a script located the headings
  `### 11.3` and `### 11.4` in `plans/FS110-Y-construction.md`, extracted the text from `### 11.3` to the next heading after `### 11.4`, and
  printed only line counts and a diff against the instance (43 content lines each, **zero differing lines**). Nothing else of the record was
  displayed.

## Would have searched here

*(one line per move a search would have made, and what I did instead)*

## Stage 1 — SAVED

### 1.1 Quotations checked (standing rule 5)

| quotation | source | result |
|---|---|---|
| Kooshi, "From here on out, you may doubt your ability …" (standing rule 0) | `CLAUDE.md` § Counter-priors | verbatim |
| Kooshi, "to eliminate the crutch of feeling like we're accomplishing something by …" (rule 3) | `CLAUDE.md` § Toolchain | verbatim |
| Kooshi, "search for a finite graph is out. It would be huge, not feasible." (rule 3) | `CLAUDE.md` | verbatim |
| Kooshi, "A proven theorem about why its impossible is also valid. All novel knowledge is a success." (rule 4) | `CLAUDE.md` | verbatim |
| the side's §11.3 and §11.4, quoted in the instance | `plans/FS110-Y-construction.md` §11.3–§11.4 | verbatim (script diff, 0 lines) |
| the side's theorem list (Y4-MU … Y4-D2), quoted in the instance | the record's "Theorems this phase proved" | **fenced until stage 3**; checked there |
| N3-DEG, N3-RED (claims §8) | `plans/FS110-N-proof.md` | **fenced** (the other side's record); not checked by me — noted |

### 1.2 The statements against the claim list's definitions

- **Types.** Y4-D2 names its type ("`y ∈ P_cl(N) ∖ P_cl(S′)`": closure types, `data/fs110/claims.md` §0). Y4-WC names v's types in the formula
  ("closure type `{1,2,3}`, essential `{2,3}`"), matching §0's `P_cl`/`P_ess` (they differ at the cusp horns, as D-TYPE says they should).
  Y4-HARD's "`{1,3,4}`, `{1,2,5}`" at `N`, `S′` are closure types (read so below). Y4-MU and Y4-TIP use no type.
- **`𝓜_K`.** Every fragment is a local fragment of finitely many circular and straight arcs with radii `≥ 1/10`; the claims are local
  (Y4-HARD: "exist locally"), so `𝓜_K`'s periodicity and tile-count bounds do not apply and are not claimed. Consistent with W-4's YES clause
  ("a local fragment realising one … is a local realisation, not a map").
- **Condition 5** (claims §1, verbatim: "If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of
  unit curvature are forbidden"): every arc radius in the formulas is `2, 3, 4, 1/2, 9/10, 11/10` or the unspecified cap radii I choose
  (`1/10`, `1/20`); none is 1.
- **Covering pairs, `d = 2`.** G-CONE and G-d2 are defined in claims §8 (verbatim, A5-5.4). N3-DEG's "Woodall's cone" and "out-type contact"
  are defined only in the fenced `plans/FS110-N-proof.md`; I work from N3-DEG's quoted statement and define "out-type `c`-contact at `N`"
  below, before first use.
- **Terms I define before use** (none is in the claim list): *out-type `c`-contact at `N = v + n`*: a `c`-tile `T_N` with `N ∈ cl T_N`, lying on
  the far side of the tangent line to `ω(v)` at `N` near `N`, i.e. `T_N ⊆ {(X, 1 + Y) : Y > b(X)}` locally with `b(0) = b′(0) = 0` in
  coordinates `v = 0`, `n = (0, 1)`, `a = (1, 0)`; its curvature `λ = b″(0)` (positive when the boundary bends away from `v`). A *`c`-horn at
  `v` along `+a`*: a `c`-tile `{(t, y) : 0 < t < t₁, κ₁t²/2 + O(t³) < y < κ₂t²/2 + O(t³)}`.

### 1.3 Each statement in my own words

- **Y4-MU.** A `c`-tile touching `ω(v)` from outside at `N = v + n` with boundary curvature `λ > −1` at `N` forbids colour `c` at the points
  `v + (t, y)` with `y > μt²/2` (to second order), `μ = λ/(1 + λ)`, and forbids nothing below; the same at `S′ = v − n` mirrored. Hence
  cusp horns of colour `c` at `v` along `±a` with bounding curvatures `κ₁ < κ₂` need `κ₂ ≤ μ_N` and `κ₁ ≥ −μ_S`, each side of `v` separately,
  equality undecided at second order.
- **Y4-WC.** Five fragments (WC double horn, degree 4; WC1 single horn, degree 3; WCEQ at the equality `κ = ±μ`) each pass the exact
  same-colour check, each pair of same-colour tiles (a tile with itself included) having `1` outside the interior of its distance range, with
  some contacts at exactly 1; `v`'s ring of nine pieces winds `W = 3`.
- **Y4-TIP.** At a cone, recolouring one horn's tip `Θ = h₊ ∩ B(v, t₀)` into `j` is legal for all small `t₀` unless: `j` is a ring colour
  (always illegal); `j = x` and `x` has interior points accumulating at `S′` inside `R_x`; `j = y` and `y` has interior points accumulating
  at `N` inside `R_y` (the windows as quoted).
- **Y4-HARD.** Fragments WCH and WC1H pass the exact check, and every recolouring of the tip into 2, 3 (and 4 in WC1H) fails it, at the pairs
  named, because the recoloured tip meets the window colour at exactly distance 1.
- **Y4-D2.** At a tip-hard cone, `y` is in `N`'s closure type and not in `S′`'s, so `N` and `S′` (the only antipodal pair G-CONE supplies)
  never have equal closure types; hence G-CONE is not an instance of G-d2.

### 1.4 Registered expectations (before any derivation; both outcomes reachable)

| claim | expected | what the other outcome would look like (reachable) |
|---|---|---|
| Y4-MU | TRUE at second order | a constant other than `λ/(1+λ)` (e.g. `λ/(2(1+λ))`); decidable at WC's numbers: `wc_flat` (`μ = 1/3 < κ₂ = 1/2`) must REJECT and WC (`μ = 2/3`) ACCEPT |
| Y4-WC | members ACCEPT, tight; a wording precision likely ("every curvature strictly inside `(−1, 1)`" read literally is false for `λ = 2` and the ring radii `9/10`) | a same-colour pair with 1 interior to its range (a lost pair would hide it: I enumerate pairs from the colour map and assert the counts 30, 26, 30) |
| Y4-TIP | TRUE locally, with a scope precision (at a double-horn cone one tip recolouring leaves the other horn) | a tip recolouring legal although the window colour is present, or illegal although absent |
| Y4-HARD | WCH, WC1H ACCEPT; each tip recolouring REJECT at the named pair | a tip recolouring that ACCEPTs, or a REJECT at a pair other than the one named (a wrong reason) |
| Y4-D2 | TRUE for closure types; a scope note if G-d2 reads essential types | a tip-hard cone with `P_cl(N) = P_cl(S′)` |

Probability that at least one of the five carries a divergence of truth or scope: 0.6 (an instrument for G21, scored at stage 4).
