# FS129-MA1 — pass 2 of the cross-application audit, lane A (the arithmetic era): the record

*Job FS129-MA1, brief `data/fs129/briefs/FS129-MA1-pass2.md`; a `general-purpose` agent on Opus reading Ephodos's identity
(`.claude/skills/ephodos/SKILL.md` in full, then `.claude/agents/ephodos.md` from `# Ephodos in lean-dir — the workflow` to its end). Plan:
`plans/FS129-cross-application-audit.md` § 3 Stage 3. Writes only this file, `data/fs129/ma1/`, `tools/fs129_ma1_*.py` and
`data/fs129/reports/FS129-MA1.md`. Started 2026-10-03 23:42 UTC. A successor, FS129-MA2, continues from the last SAVED stage
(`plans/FS129-close-inventory.md` item 52).*

## Theorems this phase proved

*(filled at each saved stage)*

## Stage 1 — SAVED (readback, registered expectations)

### 1.1 Readback of the brief's quotations (standing rule 3)

Checked by script (exact substring, 2026-10-03 23:45 UTC):

| quotation | source named | found |
|---|---|---|
| "Right after this close, we'll be refining the workflow again... File that as a special case stub for after the workflow refinements." (full text) | `plans/STUB-cross-application-audit.md` § The request | verbatim |
| "1. yes, we don't want O(N^2) here. 2. Yes, keep to the cap, … so it'll pick up the latest changes." (full text) | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "Also a note for the whole plan that not only are "hubs" important, but deep "roots", … even if it has only one offshoot" (full text) | `plans/FS129-cross-application-audit.md` § 1 | verbatim |
| "where else can we use that identity?" | `plans/FS116-close-inventory.md` item 142 | verbatim (Kooshi, 2026-10-03 17:49 UTC) |

No mismatch; no finding about the brief. The brief's inventory references (items 41, 51, 52) say what the brief says they say.

### 1.2 What I had read when I registered

The brief; the identity in full and the lane workflow from its heading to its end; `plans/STANDING-RULES.md`; the plan; the stub (with
Poros's card and bearing); `plans/FS129-close-inventory.md` in full; `data/fs129/demand-judged.md` §§ 1–2 (homonyms, no-gos);
`plans/FS129-OA1-audit.md` in full; `plans/FS129-OR1-audit.md`'s theorem list, its mechanical-half note and its cross-era line. **Not yet read:**
any grokking body, any derivation file, the index's statements files, `[Falconer1981]`.

### 1.3 Registered expectations (before reading the corpus; scored at FS129-Z1)

My prior: lane A's mechanisms are discrete and arithmetic (residue maps, finite planes, compulsions in finite graphs, spectral bounds,
field towers). Pass 1 found that they bear on the regularity era only where a finite configuration is "seen" by a measurable colouring
(Falconer's boundary points; correlations). Inside the arithmetic era, the likeliest unapplied mechanisms are the compulsion toolkit and
the residue/finite-plane reductions applied to a field or a configuration their milestone did not name; the 17 unmentioned grokkings are
the likeliest hiding place, but also the likeliest to be narrow.

| id | expectation | value |
|---|---|---|
| MA1-E1 | mechanisms I reach in this job (of 70) | expected 22; range 12–35 |
| MA1-E2 | of those reached, mechanisms that bear somewhere unapplied (a composition, a miss or a near miss with its failing hypothesis named, beyond pass 1's) | expected 6; P(≥ 3) = 0.6 |
| MA1-E3 | compositions derived (block entries) | expected 4; range 1–8 |
| MA1-E4 | misses of the FS116-Y4 kind (a milestone worked a step the mechanism would have shortened or emptied) | expected 1.5; P(≥ 1) = 0.55 |
| MA1-E5 | `[Falconer1981]` Lemmas 1–4 differ materially from FS103-M's quotation (a difference that changes what FS129-OA1-FALC-RED may use) | P = 0.15 |
| MA1-E6 | a composition of this pass changes the bearing on the answer (item 31's open list or the top three) | P = 0.06 |
| MA1-E7 | a held result found false on reading | P = 0.03 |
| MA1-E8 | cross-era bearings (a lane-A mechanism on a regularity-era site) found beyond pass 1's | expected 1; P(≥ 1) = 0.45 |
| MA1-E9 | of the 17 unmentioned grokkings, the share that bears somewhere unapplied | expected 0.2 |

These are instruments for G21, never caps.

## Stage 2 — SAVED (`[Falconer1981]` Lemmas 1–4 against the paper, before anything builds on FS129-OA1-FALC-RED)

*Read: `~/source/library/papers/falconer-1981-realization-distances-measurable-subsets-covering-Rn-jcta-31-184-189.pdf`, pp. 185–188, as page
images (the text layer is OCR and garbles symbols: it reads `r > ½` as "r > 4"), 2026-10-03 23:55 UTC; against `plans/FS103-M-derivation.md`
§ 1.2 and FS129-OA1-FALC-RED's `uses only:` and argument (`plans/FS129-OA1-audit.md` § 2.3).*

### 2.1 Each lemma as the paper gives it

| item | page | the paper's statement (transcribed from the page image) | FS103-M § 1.2's quotation | difference |
|---|---|---|---|---|
| **Lemma 1** | p. 185 | "Let E be a non-empty subset of Rⁿ with v(E) = 0, where v denotes n-dimensional Lebesgue measure, and let C be a finite or countable configuration of distinct points in Rⁿ. Then there exists a rigid motion p such that p(C) ∩ E is a single point. Further, if x is a given point of C, we may choose p such that for almost all (in the sense of the usual rotational measure) rotations ρ of p(C) about p(x) we have that ρ(p(C)) ∩ E = {p(x)}." Proof: "An obvious modification to the proof of Lemma 3 in Croft [1] suffices." | a parenthetical paraphrase: "a rigid motion `ρ` of a countable configuration `C` meets a given null set `E` in exactly one point, "for almost all … rotations"" | **one that matters for the argument, not the statement** (§ 2.2): the lemma supplies the motion, so the point of `E` at which `x` lands is the lemma's, not the user's. Nothing in it lets one fix a point `e ∈ E` first and rotate about `e` (that form can fail: a null `E` may contain a circle about `e` of radius `|v − x|`) |
| **Lemma 2** | p. 185 (proof continues on p. 186) | "Let S be a measurable subset of Rⁿ with v(S) > 0 and v(Rⁿ\S) > 0 then (i) ∂S is non-empty and v(∂S) = 0, (ii) S̃ is a Borel set." Definitions (p. 185): metrical boundary, "those points of Rⁿ at which the Lebesgue density of S either fails to exist, or exists and has a value other than 0 or 1"; essential part, "those points of Rⁿ where the Lebesgue density of S exists and equals 1" | verbatim | none. FS129-OA1-FALC-RED's gloss "Lemma 2 (E non-empty and null; at a point of E at least two classes are present — FS103-M's D2)" attributes to Lemma 2 two facts it does not state: `E` non-empty follows from (i) applied to a class of positive measure and positive co-measure (if none exists one class is co-null and holds unit pairs); "two classes at a point of `E`" is the proof of Theorem 2's "(at least)" step (p. 188) and FS103-M's D2 (`plans/FS103-M-derivation.md` l. 252), a derivation: with finitely many disjoint covering classes, if `x` lay in only one metrical boundary, the other densities would exist and be 0, so that class's would be 1 and `x ∈ S̃` — not in `E` |
| **the null set** | p. 186 | "Now let S₁,…, S_k be disjoint measurable subsets of Rⁿ with union equal to Rⁿ. If E = Rⁿ\⋃ᵏⱼ₌₁ S̃ⱼ then E is the aggregate of the metrical boundaries of the Sⱼ." | verbatim | none. Lemma 3 is stated under this hypothesis — **disjoint** classes; Theorem 2's "covered by" sets are made disjoint first (standard, and harmless: a subset of a unit-free set is unit-free) |
| **Lemma 3** | p. 186 | "Suppose that x₁,…, x_M are points in Rⁿ such that x₁ ∈ E, say x₁ ∈ ∂S₁ ∩ ⋯ ∩ ∂S_r, and xᵢ ∈ S̃_{k(i)} for 2 ≤ i ≤ M. Then for every j (1 ≤ j ≤ r) there exists a small translation p such that p(x₁) ∈ Sⱼ, and p(xᵢ) ∈ S_{k(i)} if 2 ≤ i ≤ k." Proof: "See Croft [1], proof of Theorem 8." | verbatim, including the paper's misprint "2 ≤ i ≤ k" for "2 ≤ i ≤ M" | none. The conclusion lands in `Sⱼ` and `S_{k(i)}`, not in the essential parts; `j` ranges only over the classes whose metrical boundary holds `x₁`; one translation per `j`, existence only (FS103-M's table already records this against the 2005 exposition) |
| **Lemma 4** | p. 187 | "Let T be a circle of radius r > ½ in R², and let θ = 2 sin⁻¹(1/2r) be an irrational multiple of π. Suppose that R² is divided into sets Sⱼ in such a way that almost all points of T (in the sense of circular measure) belong to either S̃₁ or S̃₂, say. Then there exists some pair of points in R² at unit distance apart either both in S₁ or both in S₂." | a parenthetical paraphrase, accurate in every hypothesis | none in content. "Divided into sets" is read with the measurable partition of p. 186: the proof uses Lemma 2(ii) (Borel `S̃`) and Lemma 3. FALC-RED's "arcsin(1/(2r))/π irrational" is equivalent to "θ an irrational multiple of π" (θ/π = 2 arcsin(1/(2r))/π) |
| Theorems 1, 2 | pp. 186, 188 | as FS103-M quotes | verbatim | none |

### 2.2 What this does to FS129-OA1-FALC-RED

**The statement stands; its argument needs one reordering, which the paper's own proof of Theorem 2 already makes.** FALC-RED's argument
reads: "By Lemma 2 pick `x₁ ∈ E`, with two classes, say 1 and 2, present at `x₁`. Place `H` with `a` at `x₁`; by Lemma 1, for almost every
rotation `R` about `x₁` every other vertex `v` lies at a density point of some class `k(v)`." That uses Lemma 1 at a point of `E` chosen in
advance, which Lemma 1 does not supply. The repair, in the order of p. 188 ("Lemma 1 allows us to assume that the configuration … is
positioned so that x₁ ∈ E … Assume (without loss of generality) that x₁ lies in the metrical boundaries of (at least) the sets S₁ and S₂"):
apply Lemma 1 to `C = V(H)` with `x = a`, obtaining a rigid motion `p` with `p(a) ∈ E` and, for almost every rotation `ρ` about `p(a)`,
`ρ(p(H)) ∩ E = {p(a)}`; then `p(a)` lies in at least two metrical boundaries by the derivation in § 2.1's Lemma 2 row (D2), say `∂S₁ ∩ ∂S₂`;
the rest of FALC-RED's argument runs unchanged with `x₁ = p(a)` and vertices `ρ(p(v))`. Every other use matches the paper: Lemma 3 with
`x₁ ∈ ∂S₁ ∩ ∂S₂` and `j ∈ {1, 2}`, its conclusion in `S_{k(i)}` (enough: no `Sⱼ` holds a unit pair, so `k` is proper on `H − a` and `N(a)`
avoids 1 and 2); Lemma 4 with the hypothesis on `S̃₁ ∪ S̃₂` exactly as FALC-RED's last step produces it.

**Finding (for FS129-Z1 and for FS129-OA1-FALC-RED's `uses only:` line; a correction of wording, no grade moves):** FALC-RED's `uses only:`
should read Lemma 1 as "a rigid motion `p` of a countable configuration with `p(x) ∈ E` and almost every rotation about `p(x)` meeting `E`
only at `p(x)`", Lemma 2(i) for `E ≠ ∅`, and FS103-M-D's D2 for the two classes at `p(x)` — not "Lemma 2 … at a point of `E` at least two
classes are present". FS103-M's quotations of Lemmas 2 and 3, of the null-set sentence and of Theorems 1–2 are verbatim; its Lemma 1
paraphrase is the one place a reader could take the stronger, unstated form. **MA1-E5 (registered P = 0.15 for a material difference): not
met** — no difference changes what FALC-RED may conclude; one changes the order of its argument.

### 2.3 Relay received (from the coordinator, lane R's pass 1, 2026-10-03)

Lane R reports FS129-OA1-RINGWIND as FS110-Y3-GP's and FS110-N2-RING's mechanism in a per-hexagon normalisation (a merge for pass 3), the
winding jump at `(u, p, v)` on `ω(y)` not computed, and FS129-OR1-BEND3 making the three-colour semi-hub's ring free of arcs of `Γ`, so that
FS-110's ring results apply to it. Folded into this record's G71 section (whether the mechanism bears anywhere else unapplied).
