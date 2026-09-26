# FS-75's minimal instance — `χ(ℚ(√167)²) ≥ 4` in the kernel (plan)

*Job J52, de Bruijn (Opus 5.5), 2026-09-26, planner. Brief: `data/crunch-2026-09-25/briefs/J52-FS75-kernel-167-planner.md`, with
`STANDING-RULES.md` and J03's template; owner's notes (in the launch message) override the brief. A kernel milestone: sections §G, §PA,
§S, §P, §M, §X — no §IQ (WORKFLOW 3.3 excludes a kernel port).*

*`CLAUDE.md` read from a snapshot taken at commit `592ea289c0056bdd851bdb3164b4ddcc5edb7fec` (`git show HEAD:CLAUDE.md`, owner's note 2;
J05's last `CLAUDE.md` commit then was `179c6c5b J05: stage 2 batch 1`). The snapshot lives at `data/fs75/j52/CLAUDE-snapshot.md`, is not
committed, and is deleted at the last stage.*

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| quotation in the brief | source | verdict |
|---|---|---|
| the stub's aim, "**Re-aimed at FS-91's close.** The kernel target is S1 … FS73-T22's ⟹ as the named hand inputs." | `plans/STUB-three-colour-criterion-kernel.md` line 3 | verbatim |
| "**The smallest instance first**" | stub, § Shape, after item 4 | verbatim (the stub has a trailing colon) |
| item 4, "**Compose:** `Θ₃(S) = ∅` ⟹ … no native purchase." | stub § Shape item 4 | verbatim |
| item 1, "**Only the relation form is needed downstream** (T42): … the certificate uses that direction alone" | stub § Shape item 1 | verbatim (a line break in the source) |
| item 2, "`{1, v, z}·U_R` have `Θ₃ = ∅` by a 1,050-leaf certificate (5.7 KB, …) and a half-page hand proof (four inequality cases)" | stub, "The smallest instance first" | verbatim |
| item 3, "each listed vector checked by `decide` in ℤ" | stub § Shape item 3: "each listed vector is checked by `decide` in ℤ" | not in quotation marks in the brief; a faithful paraphrase |
| the advisor's card, "ask: … / if under about three hours … / if over: …" | `plans/POROS-2026-09-26-next-two-milestones.md` lines 179–181 | verbatim |
| "J43's facts file shows **no field-level lower bound at either exposed field of the conjecture in the kernel**" | same record, line 81: "**No field-level lower bound at either exposed field is in the kernel.**" | faithful (not quoted in the brief) |
| FS-87's fallback, "**Next:** target 2, dB9's V1; then target 3, … price both from target 1's rate"; "17 minutes against a 4–6 hour price" | `plans/STUB-de-grey-chain-kernel.md` line 3 | verbatim |
| the hunch `leaf-one-is-elementary` | POROS record lines 217–223 | the brief's route sketch restates its claim faithfully |

No quotation fails. One scope note: the stub's item 1 describes the full criterion (descent to `Λ`, Følner, compactness); the brief's route
sketch and the hunch describe the relation form only. §S below takes the relation form and goes one step further (1.3).

### 1.2 The reading

- **The stub** (in full). Four shape items; the smallest instance is T41's 36 vectors (18 ± pairs), certificate
  `data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`.
- **FS73-T22** (`plans/FS73-derivation.md` §4): the criterion, both directions, hand, two minds. **T39**: `L21cc6506` has `Θ₃ = ∅`, three
  routes; the kernel decision is this stub. **T41**: the 36-vector minimal obstruction, a 1,050-leaf certificate and a four-case hand
  proof in `θ`-space (E's product route: `μ₁ = c0 + 5k + δ₁`, cases by coordinate bounds). **T42**: V2's forward lift — steps in `{1, 2}`,
  the square argument (two-step sums in `{2, 3, 4}`, congruent mod 3, hence equal), winding `w : R → 3ℤ`, Følner averages, descent through
  the direct-summand property; and the relation form: "(a) If θ ∈ Θ, then x_j := θ(u_j) − ⌊θ(u_j)⌋ lies in B, and r·x ∈ ℤ for every
  r ∈ R" (`data/fs73/records/verify-P3b-q167.md` §2).
- **verify-P3b-q167.md §1–2** (in full). §1's steps 1–6; the hypotheses audit ("*Torsion-free*: used in step 5, and it is essential";
  "*S generating*: **not needed**"); the subgraph step `(a, b, c, e) ↦ ((a + b√167)/420, (c + e√167)/420)`. §2's certificate semantics:
  a branch names a relation `r` (checked `Σ r_j u_j = 0`) and `lo..hi`, children `r·x ≤ lo − 1`, `r·x = k`, `r·x ≥ hi + 1`; a leaf's
  rational multipliers (`≥ 0` on inequalities, any sign on equalities) give `w·x ≤ ρ` with `Σ_j min(w_j/3, 2w_j/3) > ρ`; "The checker
  derives every constraint from (r, lo, hi) itself."
- **The certificate's format** (`tools/fs73v2_check.py`, frozen, read only; the file itself): keys `verdict, d, key, units, relations,
  tree, stats`; `units` = 18 integer 4-vectors `(a, b, c, e)`, denominator 420; `relations` = 19 integer 18-vectors; a node is
  `["B", relIndex, lo, hi, children]` (`hi − lo + 3` children) or `["F", [[pathPos, num, den], …]]`. **Measured** (Python, seconds, on
  the file): 1,575 nodes, 1,050 leaves, 7,155 multiplier entries, depth ≤ 14 (mean 8.4), `|r_j| ≤ 2`, `|num| ≤ 11`, `den ≤ 30`, at most
  5 children. Small: the kernel check is not the cost.
- **House API** (grep): Mathlib's `SimpleGraph.addCayley` (`Combinatorics/SimpleGraph/Cayley.lean`, `fromRel (∃ g ∈ s, · + g = ·)`);
  the house's `planeOver`, `fieldOfRadicands`, and the precedent statement `four_le_chromaticNumber_planeOver_eleven : 4 ≤
  ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber` (`Instances/SqrtEleven.lean`, a finite graph and an
  LRAT); `CayleyCertificate.lean` (a `Bool` over packed data, properness over the connection set only) and `NarrowCert` as the house
  checker pattern. No module holds `Θ` or a winding.

### 1.3 A finding at the reading, to be priced at stage 3

The certificate never uses the point `x`. Along a path it uses three facts about the functional `r ↦ r·x` on the relation lattice `R`:
its value on each branch relation is an integer (so exactly one child holds); it is additive on `R`; and on every `Q ∈ R` it is at least
`Σ_j min(Q_j/3, 2Q_j/3)` (the box minimum). **A proper three-colouring supplies such a functional directly, with no averaging:** the
forward lift's height along words gives `w(r) = D(a, word r⁺) − D(a, word r⁻)`, additive on `R`, `≡ 0 (mod 3)`, and — since a word of
length `n` has height gain in `[n, 2n]` — `w(r) ≥ |r⁺| − 2|r⁻| = Σ_j min(r_j, 2r_j)`. So `W = w/3 : R →+ ℤ` with
`3·W(Q) ≥ Σ_j min(Q_j, 2Q_j)`, and a leaf with integer multipliers `Λ` (the rational ones scaled per leaf) refutes by
`3W(Q) ≥ Σ min(Q_j, 2Q_j) > 3P ≥ 3W(Q)`. **No Følner sets, no Bolzano–Weierstrass, no Farkas lemma, no descent, no torsion-freeness.**
The real point `x` exists too (by LP duality from the same interval bound, 1.3's remark in §S), but the kernel target does not need it.
This is registered as a prediction (P-elem) and priced at stage 3; it is one mind's derivation and is audited there as hard as a result I
dislike.

### Would have searched here (stage 1)

- None.
