# FS-66 — does the residue ceiling drop up the tower? The second level of a residue plane, at one colour fewer

> **CLOSED 2026-09-21 — answered NO wherever it can be certified.** The milestone (`plans/FS66-residue-tower-drop.md`,
> `plans/FS66-phase2-certificate.md`, `plans/FS66-tower-conjecture.md`; `CLAUDE.md` row 75, G66) found that the residue ceiling does not
> drop up the tower at 7, 11, 19 or 23: `χ(UD(ℤ/121,2)) = 5` in the Lean kernel, and exact all-levels certificates refuse three colours at
> 7, four at 11 and 19 and five at 23 at **every** level. So the pilot below is answered (not four-colourable), the ask at `UD(ℤ/529,2)`
> below can never land, `α(UD(𝔽₂₃,2)) ≤ 97`, and the `p`-adic Hadwiger–Nelson question is answered (`CLOSED-QUESTIONS.md` §1.8). **What
> stays open is whether the ratio is exactly constant** — FS-68, `plans/STUB-tower-never-rises.md`. §3 below still carries a
> correction record from before the milestone. This stub is kept as the question's statement.

*Minted 2026-09-20 by the product owner of FS-61, out of a conversation with Kooshi about how to approach ℚ(√167) (FS-59), which
has only ever been attacked from the lower-bound side. Written for a reader with no conversation memory. Read beside: `CLAUDE.md`
G48 (the local–global conjecture), G45 (a residue configuration lifts only if it is a shadow), G54 (tight or slack; towers), rows
52–54, 66–67; `plans/STUB-four-colours-167.md` (FS-59); `plans/FS38-residue-tower.md` (which built the level-two graph at 11 and
asked it five-colour questions only); `plans/FS61-quadratic-census.md` (whose `L = 5` brackets this could close).*

---

## 1. The question, in plain language

Every ceiling this project holds on the plane over a number field `F` comes from one move: reduce coordinates modulo a prime `𝔓`
of `F(i)` that complex conjugation fixes, landing in a finite plane, and colour that. The **local bound** `L(F)` — the quantity the
local–global conjecture says `χ(F²)` equals — is the best such ceiling, and **as defined everywhere in this repository, and in the
conjecture's source note (`reference/ChatGPT-local-global-tightness-conjecture/`, checked 2026-09-20: residue graphs at stable
primes, no higher level mentioned), it uses the FIRST level only**: the plane over the residue field `𝔽_q`.

But reduction modulo `𝔓²` is a graph homomorphism too (`unitQuadrance.map`: a ring map induces a map of unit-distance graphs; unit
vectors are `𝔓`-integral because `−1` is not a square in the residue field). For a prime `p ≡ 3 (mod 4)` that is unramified of
degree one in `F`, the target is

> `G₂(p) = UD(ℤ/p², 2)`: `p⁴` vertices, degree `p(p+1)` — 14,641 and 132 at `p = 11`; 279,841 and 552 at `p = 23`.

Reduction `G₂ → G₁ = UD(𝔽_p, 2)` is a homomorphism, so **`χ(F²) ≤ χ(G₂) ≤ χ(G₁)`**, and the pulled-back colouring shows the second
inequality. **Nothing we hold shows it is an equality.** Structurally `G₂` is a *sparse lift*: fibres of `G₂ → G₁` have `p²` points
and no internal edges, and over each edge of `G₁` the two fibres are joined by a `p`-regular bipartite graph (the second digits of
adjacent points differ by a point of one affine line of `𝔽_{p²}`, direction `ū·i`), where a pulled-back colouring must respect the
*complete* bipartite graph — `G₂` has `1/p` of the blow-up's edges.

**The question: is `χ(G₂(p)) < χ(G₁(p))` for some usable `p`?** Equivalently, does the independence ratio rise up the tower past
`1/(χ(G₁) − 1)`? (It is non-decreasing up the tower — pull back an independent set — and capped by the Hoffman ratio, which is
constant up an inert tower, G54.)

## 2. Why it is open, and why every decided case says nothing

| prime, colours | tower | why it cannot drop there |
|---|---|---|
| 3, three | constant | the plane is Hoffman-tight at three colours; every level's floor is 3 (row 67's 3-adic control) |
| 2 (inert), four | constant | Hoffman-tight at four; `P_m` stabilises at level 4 (row 67) |
| 7, four | constant | the certified four-chromatic 297-point graph over ℚ(√23) maps into every level (7 splits in ℚ(√23)) |
| 11 **ramified**, five | constant | Heule-510 lives in ℚ(√3,√5,√11), where 11 ramifies — but that level-two ring is `𝔽₁₁[ε]/(ε²)`-like, **not** `ℤ/121` |
| **11 unramified, four** | **open** | `4 ≤ χ(UD(ℤ/121,2)) ≤ 5`: the floor is ℚ(√47)'s certified 169-point graph (11 splits in ℚ(√47): `47 ≡ 5² (mod 11)`); Hoffman permits four (ratio bound `34.55/121 = 0.2855 > 1/4`); level one's true ratio is `28/121 = 0.2314 < 1/4`, so four colours need the ratio to rise about 8 % |
| **23 unramified, five** | **open** | `4 ≤ χ(UD(ℤ/529,2)) ≤ 8`; level one's ratio is between `87/529 = 0.164` (found) and `105/529 = 0.1985` (certificate, row 71); five colours need `≥ 0.2` |
| 19, four; 43, 47 at five | open | same shape |

Pointing toward a drop: the sparsity above; and **M59 / G45 already found that the 5-critical cores of the planes at 11 and 19 do not
lift modulo `p²`** (`Instances/LiftObstruction{11,19}.lean`) — obstructions to colouring level one that are absent from level two.
Pointing against: every decided case is constant (each for a reason absent here); a first hand attempt at a structured level-two
independent set (unions of parallel lines in the fibres over a one-direction support) gives ratio `≈ 0.12` at 11, worse than level
one. **No prior worth stating.**

## 3. What each outcome is worth

**A 4-colouring of `UD(ℤ/121, 2)`** (verified on every edge in plain arithmetic):
* **`χ(ℚ(√47)²) = 4`** — with FS-58/FS-61's certified lower bound; closes a census bracket (`4 ≤ χ ≤ 5`), and likewise every real
  quadratic field where 11 is split and the level-one bound is 5. (143 is *not* one: `11 | 143` ramifies — its level two is the other ring.)
* **The conjecture with level-one bounds is false**, at a case cheaper than ℚ(√167): it predicts 5 at ℚ(√47). The repair is forced:
  `L` must be the limit up the tower, `L_∞(F) = min_𝔓 lim_k χ(G_k(𝔓))` — the chromatic number of the `𝔓`-adic plane — and every
  statement built on level-one digits is re-derived: **"five refused at 23 ⟹ the conjecture predicts ≥ 6 at ℚ(√167)" is then unproven**,
  the window for six (G56) is a statement about level one only, and FS-59's main line becomes *five colours on `UD(ℤ/529, 2)`*,
  which would make `χ(ℚ(√167)²) ≤ 5` a theorem.
* A second colouring mechanism: every colouring we own is a first-level residue colouring or the hexagonal 7.

**Resistance** (no 4-colouring found; better, a refusal): evidence that local bounds survive up the tower, which makes the prediction
of six at ℚ(√167) more credible and is worth a sentence in G48. **What a refusal at level `k` does NOT say:** anything about level
`k + 1`, or about the `p`-adic plane. The tower's limit `lim_k χ(G_k)` is the **clopen** chromatic number of `ℤ_p²` (a finite clopen
colouring is constant mod `p^k`, and every edge of `G_k` Hensel-lifts), and `χ(plain) ≤ χ_Borel ≤ χ_clopen = lim_k χ(G_k) ≤ χ(G₁)`; the
plain number can be smaller, because a refutation's core in `G_k` need not lift to `ℤ_p` (G45). The conjecture lives at the plain end.
*(Correction record: this paragraph first claimed a certified level-two refusal would give a five-chromatic finite graph over `ℤ₁₁[i]`
"with no `√3` anywhere" — wrong twice: the core need not lift, and 3 is a square mod 11, so `ℤ₁₁` holds `√3` and these graphs have
triangles. Caught by FS-66's planner, 2026-09-20.)*

**Both outcomes are reachable on present knowledge** (§2's open rows), which is the check this file demands before any run.

## 4. Routes, cheapest first

* **R1 — a finder at 11, four colours.** Local search / SAT with the symmetry broken (pin an edge; precedence on the remaining two
  colours; `ω = 3` at 11 — 3 is a square mod 11 — so a triangle pins three). The graph is already built (`tools/` of FS-38; rebuild
  from the definition and cross-check degree 132 and the 1,932,612 directed edges recorded there). **Positive control first:** the
  same finder must 5-colour it without being handed the pulled-back colouring, and must 4-colour `UD(ℤ/49, 2)` (known `χ = 4`).
* **R2 — the independence ratio instead of the colouring.** An independent set of `UD(ℤ/121,2)` with ratio above level one's exact
  `28/121` proves the tower *rises*, which is the structural fact, at a fraction of the cost; `≥ 1/4` is necessary for four colours.
  At 23: a set of ratio above the certified `105/529` does the same against a certificate rather than a found set.
* **R3 — structure before search.** Fibre-wise description (§1): a level-two independent set is a choice of `A_x ⊆ 𝔽_{p²}` per
  level-one vertex with `(A_y − A_x)` missing one affine line per edge. Is there a character-sum or LP bound on this "line-avoiding"
  system that already equals level one's? That would close the question by theorem, in the negative.
* **R4 — 23 at five colours**, only if R1/R2 show a drop at 11. 279,841 vertices, 77 M edges: a finder job, plausibly the GPU's.

## 5. Prior art owed (WORKFLOW 3a) — NOT yet run

In the discipline's words, not ours: *chromatic number of unit-distance (unit-quadrance) graphs over `ℤ/p^r`* (`[MMST1998]` holds
their spectra — read for spectra, never for `χ`); *Cayley graphs over Galois rings*; *independence number of lifts / voltage graphs
of Cayley graphs*; *`p`-adic Hadwiger–Nelson / chromatic number of `ℚ_p²`* (the `p`-adic plane's measurable and plain chromatic
numbers — a real literature may exist). zbMATH API per item 8. **If the `p`-adic plane's chromatic number is known to equal the
residue plane's, this stub closes as prior art and G48 gains a citation.**

## 6. Bearing on χ(ℝ²) ≥ 6, stated honestly

None directly. It decides what the local–global conjecture *says* — whether its local bound is a first-level digit or a tower
limit — and therefore whether ℚ(√167) is predicted six at all. Under the 2026-09-17 target (the conjecture is the belief to attack
where it is cheapest), a cheaper exposed case than ℚ(√167) is worth running before ℚ(√167).

## 7. Expectations (to be registered at the subplan, both outcomes reachable)

* R1 finds a 4-colouring at 11: **no prior** (§2). * R2 finds a ratio above `28/121`: medium — sparsity makes *some* rise plausible
even if four colours stay out of reach. * If R2 finds no rise at all after a budget comparable to the one that attains `α = 28` at
level one in seconds: read as weak evidence for constancy (a null at a budget, G21).
