# FS107-R — competitor R of FS-107: prove stability (can vanishing holes save a colour?)

*Job FS107-R, de Bruijn (Opus 5.5), 2026-09-27. Brief: `data/fs107/briefs/R107-stability.md`, with `SHARED-107-competition.md` and
`STANDING-RULES.md`. Advisor: FS107-A2 (Poros). Object labels per lemma: **on SEQ**, **on LIM**, **on both** (`data/fs107/claims.md` § Objects).*

## Theorems this phase proved

*(filled stage by stage; one line each: statement, grade, minds, address)*

- none yet (stage 1 is set-up).

## Would-have-searched-here log (standing rule 3)

- (none yet)

## Fence log (SHARED § Fences; standing rule 13)

- **Fence touch, disclosed at once:** my first shell command (`ls -la data/fs107/briefs/ data/fs107/ data/fs107/reports/`) listed the fenced
  directory `data/fs107/reports/`. It showed one filename, `FS107-P.md` (2211 bytes, 02:25), which I did not open. The parent listing of
  `data/fs107/` also showed the directory names `fs107-a`, `fs107-p`; I did not list or open `data/fs107/fs107-a/`. Nothing about routes or content
  was seen. No other fenced path has been opened, listed or grepped.

---

## Stage 1 — SAVED: quotation check, restatements, the five killing-test objects, the advisor's question

### 1.1 Files read from disk (in this order)

`SHARED-107-competition.md`, `STANDING-RULES.md`, `R107-stability.md` (all in full); `CLAUDE.md` § The aim, § Counter-priors, G82 (from disk at
`1755adf4`; G21, G51, G71, G79 from the loaded copy, which § The aim shows is stale in places — the aim text on disk was used); `data/fs107/claims.md`
in full; `LEDGER.md` rows 129–132; `plans/FS107-stability.md` §G part 3 (X1–X19), §PA, §IQ, §5.3; `plans/FS106-TQ-derivation.md` §§3.1–3.3, §4 in
full; `plans/POROS-2026-09-27-fs106-close-and-fs107.md` §§3.2–3.3, §3.7 (A2's FS-106 record — the claim list's cited source, not fenced);
`plans/FS106-TS-derivation.md` rows C-T-BIKE, C-T-ANN, C-T-IND, C-T-PIG, C-T-KILL, C-AE-MAP6 (by grep); `[Voronov2023]` §§2–6 in full
(`~/source/library/pdf/arXiv-2304.10163-voronov.pdf`, by `pdftotext -layout`).

### 1.2 Quotation check (standing rule 5)

| quotation (where it appears) | source checked | result |
|---|---|---|
| claim R, "for some `R` and `δ₀ > 0` and every `ε > 0`, every partial six-colouring of `U_R(0)` … leaves at least `δ₀\|U_R\|` uncovered." (R brief; claims §1) | A2's record l. 439–440 | **verbatim** (A2's own "Written out:" of TQ §4.5 item 2, not a TQ quotation — the claim list attributes it correctly to A2 §3.3) |
| "The exact disc equivalent is 'for some radius `R`'" (claims §1) | TQ §4.5 item 2 | verbatim up to TQ's bold on "for some" |
| TQ §4.5 item 5, "a mechanism forcing holes of `ε`-independent total measure — … for every band `ε ≪ ρ₀`." (claims §1) | TQ §4.5 item 5; A2 l. 443 | verbatim |
| R-S's reading, "**Hadwiger–Nelson's measurable form is "Voronov's argument on regular colourings, robust to a free colour of vanishing density".**" (claims §1) | TQ l. 527 (§5.2) | present at TQ §5.2 |
| R′ (C-VOID), both forms (claims §1) | FS107-A's card and second message — **source fenced for me** (`plans/POROS-2026-09-27-fs107-stability.md`) | **not checkable; worked as the claim list states it** |
| R″, "improve TQ-EPS2's `ε²` to `ε`, where hitting-form arguments are allowed and TQ-HIT's strips show `ε` is the most they can give." (claims §1) | A2 l. 527–528 (§3.7) | verbatim |
| "The only gap on this object is the hole gap." (claims § Objects) | A2 l. 428 | verbatim (bold in the source) |
| "The direction W relies on is the easy one." (claims §1) | A2 l. 455 | verbatim |
| K-HIT's close statement, "Strips of width 2ε at spacing 2 (density ε) …" (claims §2) | not re-opened in `plans/FS106-derivation.md`; TQ §4.4 has the **original** form "strips of width `2ε` centred on the lines `y ∈ ℤ/2`. Its density is `4ε`" | both forms hold (a closed interval of length 2 contains a point of `2ℤ`, so spacing 2 also meets every unit circle); I use the close's |
| Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." (SHARED; rules 4) | `CLAUDE.md` Frontier item 23 | verbatim |
| Kooshi: "search for a finite graph is out. It would be huge, not feasible." (SHARED; rules 3) | `CLAUDE.md` § Publication | verbatim |
| Kooshi, counter-priors: "From here on out, you may doubt … you will surprise yourself." (rules 0) | `CLAUDE.md` § Counter-priors (disk) | verbatim |
| "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" (rules 3) | `CLAUDE.md` § Toolchain | verbatim |

No paraphrase found that empties a claim. One attribution note: claim R's text is A2's written-out form, and TQ's item 2 quotes only "for some radius R".

### 1.3 The statements I work, restated in my own words beside the quotations

- **R (claim R, C-Q-STAB in disc form), quoted above.** *Mine:* there is one fixed disc size `R` and one fixed fraction `δ₀ > 0` such that, however
  thin the forbidden band `[1 − ε, 1 + ε]` is made, six colour classes that avoid the band inside the disc can never cover more than `1 − δ₀` of the
  disc. By H-EQ (row 131) this is exactly `χ_m⁰(ℝ²) ≥ 7`; with MR, `χ(ℝ²) = 7`. **Object: both** — and I record now (§1.5) that R on SEQ and R on LIM
  are one statement, so the choice of object is a choice of *proof vocabulary*, never of *question*.
- **R′ (C-VOID), quoted in claims §1.** *Mine:* not only is a fixed fraction missing, it is missing in *whole round pieces*: there are fixed sizes
  `ρ₀ < R₀` such that every disc of radius `R₀` contains a completely uncoloured disc of radius `ρ₀`, for every band. R′ ⟹ R (take `R = R₀`,
  `δ₀ = ρ₀²/R₀²`), not conversely. **Object: both.**
- **R″ (the rung), quoted above.** *Mine:* show the missing fraction is at least a constant times `ε` (not merely `ε²/(6+ε)²`). Hitting-form arguments
  are allowed, since strips of width `≍ ε` show `ε` is their ceiling. Not decisive: a bound that tends to 0 decides nothing (H-EQ).

### 1.4 The five killing tests' objects, written down concretely

| # | test | the object, concretely | what "passing" means for an argument of mine |
|---|---|---|---|
| 1 | **Parts calibration** | `[Parts2020c]`'s tight six-tiling `T` (17-gon tiles with wavy sides, Siamese pairs; type-A rhombic voids at degree-4 vertices, type-B arrowhead voids at degree-3 vertices; `δ₆ = 1/6992.1655504123 = 1.430172·10⁻⁴`; rhombus half-diagonals `l = 0.0133`, `r = 0.0055`; TQ §4.3, §4.5(6)) — **taken on Parts's word, [external]**. Eroded by `κ` (`τ_κ = {x : B(x, κ) ⊆ τ}`, TQ-ERODE): slack `ε < 2κ`, uncovered density `δ₆ + O(κ)`, every coloured point of chromaticity 1 | the argument must force **at most** `δ₆ + O(ε)`; forcing more is a bug |
| 2 | **seven-colour control** | regular hexagons of side `s`, coloured by the 7 cosets of the index-7 (Σ7) sublattice of the centre lattice; tile diameter `2s`, same-colour separation `√7·s`; band-proper iff `2s ≤ 1 − ε` and `√7 s ≥ 1 + ε` (e.g. `s = 0.45`, any `ε ≤ 0.1`); read as a partial six-colouring, one class is the hole, density `1/7` | the argument must **fail** on the 7-colouring and name the step where six is spent (a step that uses `6 < 7`, never only class densities: K-INT) |
| 3 | **strip test** | `W_ε = {(x, y) : dist(y, 2ℤ) ≤ ε}` (width `2ε`, spacing 2, density `ε`; FS106-HIT): every unit circle and every bicycle meets it in positive length; every point of its centre lines is `ε ≥ ε/2` from the complement, so it is an effective hole | if every step goes through with the holes replaced by `W_ε`, the argument is of hitting form and **capped at `O(ε)`** |
| 4 | **normalisation** | the bound is `\|H ∩ U_R\| / \|U_R\|` — uncovered area over disc area | never "monochromatic pairs over band measure" (PD-EQ's count is a different quantity) |
| 5 | **pinhole test** | the holes replaced by one disc `B(j, cε)` (`c ≥ 1/2`, so it is effective) at each junction `j` (D-JUNC) or each certificate of the argument; with `N` junctions per unit area the hole density is `≍ Nε²` | if every step survives, the argument is **capped at `O(ε²)`** (A8b's order) unless it also forces `N ≳ ε⁻²` |

### 1.5 Two observations that set my object choice (one mind, [derived]; stated here so the advisor and V can attack them early)

- **O1 (on both) — R-Q and R-S are the same question, not two routes to it.** By TQ-SUP (row 131), `µ₆⁰ = lim_ε µ₆(ε) = lim_ε µ₆^per(ε)`. So "every SEQ
  family keeps holes `≥ δ₀`" is literally "`µ₆⁰ < 1`", which is "no tight a.e.-proper six-colouring covers the plane" (LIM). A SEQ proof is a proof
  on LIM and conversely; what differs is the vocabulary a proof may use (on SEQ: a band `ε > 0`, grid boundaries, no index swaps; on LIM: density
  topology, no band). *Consequence for my programme:* a SEQ argument that uses the band only at scale `ε` must, in the limit, turn into a tight-world
  argument — so its every step must survive in the tight world, or be quantitative in `ε` in a way that does not vanish.
- **O2 (on LIM; restates TS, not new) — Voronov's circle machinery is empty in the tight world.** At exact distance a unit circle is 2-colourable
  (alternating half-open arcs of `π/3`; TS's C-AE-MAP6 row says so), and Voronov's bicycle index loses its only band step (TS's C-T-BIKE (ii)). So every
  Voronov step that needs three colours on a circle, or a swap-free index, is paid for **at scale `ε`**, and a free colour on holes of size `≍ ε` at
  the few places where the tight pattern meets the band can pay it. This is why the pinhole cap `O(ε²)` bites every circle-and-bicycle argument
  anchored at boundedly many junctions per unit area (K-AD (a)). **So a proof of R must hold in the tight world as well** (O1), which no step of
  Voronov does. My stage 2 therefore looks for an argument whose tight-world form is *true*, not for a sharper Voronov.

### 1.6 The advisor's question — my answer (sent to FS107-A2 by SendMessage, verbatim below)

> FS107-R's one message (registered). **Step I expect to fail first: break table row 3, "W: a parameter shrinking the vertex voids."** Why: (1)
> W's Route II limit must be tight, a.e.-proper, and neither polygonal nor a nice map (K-TIGHT, K-REG). So a family whose members stay of bounded
> combinatorial type per unit area — tile boundaries converging locally to a finite polygonal map as the voids shrink — has a polygonal a.e.-proper
> six-colouring as its limit, excluded by FS106-AE-POLY except its `d = 2` case. Shrinking Parts-type vertex voids inside a fixed combinatorial type
> therefore cannot work: the driving parameter must drive the number of junctions or the boundary complexity per unit area to infinity, not only the
> void size to zero. (2) With unbounded junction density `N`, each effective junction void costs `≳ ε²` (HOLE-t), so W needs `N·ε² → 0` while
> junctions multiply; I expect the voids at junctions of complementary type within distance 2 (K-C6) to stop shrinking before that balance is met.
> **Evidence I would accept that I am wrong:** an explicit family with a driving parameter, members given by formula and exactly checked,
> band-properness derived for every parameter value, whose largest junction-void inradius tends to 0 while the uncovered density tends to 0 (that
> refutes my expectation outright); or, weaker, a family whose largest void inradius tends to 0 at bounded coverage loss — that refutes C-VOID and my
> part (2), and I would retract (2) on it. Part (1) is a direct consequence of K-REG and I would retract it only on a defect found in
> FS106-AE-POLY.

## Stage 1 — SAVED
