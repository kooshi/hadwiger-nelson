# FS110-YB — blind verification of the construction side (FS110-Y, FS110-Y2)

*Job FS110-YB, de Bruijn (Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/YB110-verify-construction.md` with its instance block
`data/fs110/briefs/YB110-instance.md` and `data/fs110/briefs/STANDING-RULES.md`. I edit only this file, `data/fs110/fs110-yb/` and
`tools/fs110_yb_*.py`. Grades are `CLAUDE.md` § Notation's. Every statement of the side is quoted from the instance block, which quotes the side's
record; that quotation is checked against the record at stage 4, after my verdicts are committed.*

## Theorems this phase proved

*(one line each, grade and address; filled stage by stage)*

## Would-have-searched-here log

- Y-BIKE-3C: I would have scanned the offsets `(φ, ψ)` of the two circles' 60° grids for a colouring whose cross curve passes through grid vertices
  (the case my argument leaves open). Instead: one candidate was derived by hand (a grid vertex at a point of the cross curve with `θ + η = 240°`,
  its swap partner then also a vertex) and checked at one `d`; the rest is recorded as a GAP (§3.6).

## Fence log

- No fenced path opened. `git log` read only as the start-up snapshot and my own commits.

## Stage 1 — SAVED: quotations, definitions, restatements, registered expectations

### 1.1 Quotation check (standing rule 5)

| quotation | source checked | result |
|---|---|---|
| the side's theorem tables and the four formulas (instance block) | `plans/FS110-Y-construction.md` | **fenced until stage 3**; checked at stage 4 |
| C-T-TAN, "Let `k = 6`, `\|u − v\| < 2` … the configuration does not occur" | `plans/FS106-TS-derivation.md` l. 258 | verbatim |
| TS-U, "a unit-arc boundary with colours `c \| c′` puts `c` in the wedge facing it …" | TS l. 15 | verbatim |
| K-CHR4, "**GAP** — proved for `\|P(x)\| ≥ 5` off a null set; `\|P(x)\| = 4` open" | TS §5 (l. 271) | verbatim |
| C-T-BIKE, "**GAP — undecided here**; the step named: …" | TS l. 258 table | verbatim |
| Cusp, "**a cusp is a cone point whose tile has angle 0**: its colour has density 0 …" | `plans/FS107-VW-verification.md` l. 285–287 | verbatim up to list punctuation (the source's first bullet is joined to the sentence) |
| V5, "**But a bichromatic vertex of degree `≥ 4` has a two-element type** …" | VW l. 210 | verbatim |
| `𝓜_K`, "periodic designs with at most `K` circular or straight arcs per tile …" | `plans/FS107-derivation.md` l. 11 | verbatim |
| Townsend ⅔π, "So the counterexample is right, and **sharp at `2π/3`**. It uses a boundary that is a **unit arc**" | `plans/FS106-V-verification.md` l. 374 | verbatim |
| Siamese, "two distinct tiles of one colour have all cross-distances `≥ 1`, or all `≤ 1` …" | claims.md cites `plans/FS107-stability.md` l. 348 | **mis-addressed**: l. 348 there is a staffing row; the sentence is verbatim at `plans/FS106-TQ-derivation.md` l. 348 (correction owed to `data/fs110/claims.md`) |
| A-EXACT, A-CIRC, A-SIX, C-TAN-POS (advisor's words) | `plans/POROS-2026-09-27-fs110-tangency-seam.md` | fenced to me; not checked |

### 1.2 Do the statements use the claim list's definitions?

| id | finding |
|---|---|
| Y-AEX, Y-CIRC, Y-TYPE | closure types `P_cl` named; consistent with §0 and §1b |
| Y-SIX | A-SIX's statement; consistent |
| Y-BLOCK | uses A-EXACT's `B_u(s)`; the shapes are the side's own vocabulary ("T1", "T2", "escape"), consistent with §2; **its "Hence C-TAN-POS TRUE" follows only from a complete list, and completeness "is not claimed"** — flagged for stage 2 |
| Y-T2W | "a pair saved at `w₀` by T2" — covering pair of unnamed type size; "`P(u)`" of unnamed kind — flagged |
| Y-BIKE-3C | "the bicycle" is C-T-BIKE's `T₁(u) ∪ T₁(v)`; "six-arc three-cycle colouring of each circle" is undefined in the table; I read it as: each circle cut into six arcs coloured `a, b, c, a, b, c` in circular order (either orientation), one palette of three colours for both circles |
| Y2-W4, Y2-W4e | "covering pair" per §0 (sizes (3, 3) or (2, 4)); "`P(u)`" of unnamed kind beside "`P_cl(w)`" — flagged; "no arc of `Γ` at `w`" read as Y2-W4's hypothesis (neither `ω(u)` nor `ω(v)` runs along a boundary into `w`) |
| Y2-S1, Y2-S1i | "(S1)" is the owner's configuration (fenced note); I read it from Y2-S1's parenthesis: a bowtie at `u` with boundary unit arcs of `ω(u)` through `w, w′`, a generic trivalent partner `v`, `w, w′` two-colour edge points |
| Y2-T2F, Y2-BB, Y2-MX | fragments; "tight" = some same-colour pair has 1 as an endpoint of its range (§0, D-SLACK, read on a fragment) |
| Y2-LAT | "one candidate, not the question" — scope stated |

### 1.3 Restatements (my words)

- **Fragments S1, T2, BB, MX:** finite families of open tiles, each bounded by segments and circular arcs with vertices in ℚ(√3), coloured by the
  given map; claimed: for every same-colour pair (a tile with itself included), 1 is not interior to the exact range of cross-distances, and some
  pair has an endpoint exactly 1.
- **Y2-W4:** where two circles `ω(u)`, `ω(v)` of a covering pair cross at `w` through tile interiors, the four half-branches at `w` carry four
  colours: the two `ω(v)`-branches carry two different colours of `u`'s type (the one inside `ω(u)` a colour that faces `w` at `u`, the other one
  that faces away), and symmetrically; hence `w` has at least four closure colours; and `ω(w)` near `u` is coloured by the leftover colour of `u`.
- **Y2-W4e:** (i) if `u` escapes strongly at `w`, then `ω(w)` near `v` is one colour or boundary; (ii) at a (2, 4) pair `ω(w)` runs along
  boundaries at the two-colour vertex.
- **Y2-S1i:** in any realisation of (S1) with `w` an edge point: the unit arc's two sides are `u`'s facing and away colours; `u`'s third colour
  fills both side cones (strong escape); where the arc stops on `ω(u)` there is a vertex with a colour of `v`'s type.
- **Y-T2W:** if T2 saves the pair at `w₀`, then `w₀` is a vertex of degree `≥ 4`, `ω(u)`, `ω(v)` alternate there, and the two `u`-colours at `w₀`
  are `u`'s inner arc colour (Siamese with it) and an outer colour (outer contact).
- **Y-BLOCK:** a list of shapes of `B_u(s) ∩ B(w₀, c)`; with it, C-TAN-POS at the level of disjointness.
- **Y-BIKE-3C:** no three-colouring of the bicycle whose restriction to each circle is a six-arc three-cycle pattern, for any `d ∈ (1, 2)`.
- **Y2-LAT:** the translation-invariant triangular-lattice extension of `BB` fails at its four-colour points.

### 1.4 Registered expectations (before any derivation; both outcomes named reachable)

| item | expected | P | the other outcome is reachable because |
|---|---|---|---|
| S1, T2, BB, MX rebuilt | ACCEPT, tight, each | 0.85 each | a closing segment of a tile can leave its angular sector, a quadrant square of side `1/10` can reach a blocking wedge, and a contact can sit on the wrong side of 1 at second order (T1 against T2) |
| Y2-W4 | first two clauses TRUE; the "one colour" clause MISSTATED at (2, 4) sizes or when `w` carries a third colour of `u` | 0.6 | the clause is a set difference whose size is not fixed by the hypotheses |
| Y2-W4e | TRUE, possibly weaker than what follows | 0.6 | it depends on Y2-W4's third clause |
| Y2-S1i | TRUE at (3, 3) | 0.65 | the arc's end can be a colour change along `ω(u)` rather than a vertex of `P(v)` |
| Y-T2W | TRUE under Y2-W4's hypothesis; GAP otherwise | 0.55 | T2 does not by definition exclude a unit arc of `ω(u)` into `w₀` |
| Y-BLOCK's "hence" | GAP at completeness | 0.7 | the shapes may be exhaustive after all |
| Y-BIKE-3C | TRUE or GAP | 0.5 | a colouring whose cross curve passes through grid vertices is not excluded by a band argument |
| Y2-LAT | TRUE for its candidate | 0.6 | the over-constraint may be a counting slip |

## Stage 1 — SAVED
