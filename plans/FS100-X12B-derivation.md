# FS-100 X12B — a blind second derivation of EF_F⁺ (and EF_F)

*Job X12B of the ×2×3 crunch (2026-09-26). Coxeter, Opus 5.5. Brief:
`data/crunch-2026-09-26-x2x3/briefs/X12B-ef-plus-blind-derivation.md` (with `STANDING-RULES.md`). Product owner: "main".
Blind: none of the fenced files was opened (fence log below).*

## Stage 1 — SAVED (11:12 UTC)

### 1.1 The quotation check (standing rule 5)

| quotation in the brief | source | result |
|---|---|---|
| EF_F⁺, "For every real number field `F`: every `U`-invariant finite positive Borel measure `μ` … (No ergodicity; one element; the conclusion `T + A ⊆ E`.)" | `plans/FS100-X01D-derivation.md` line 194 | **not checked** — the source is fenced for this job; checking it would break the blind. Taken as the brief states it. |
| EF_F, "For every real number field `F`: every `U`-invariant, `U`-ergodic probability measure `μ` on `R̂` such that `h_μ(u) = 0` for some non-torsion `u ∈ U` satisfies `μ(E) = 1`." | `plans/CRUNCH-2026-09-26-x2x3-queue.md` §2, list X01 (line 62–63) | **verbatim match** |
| Notation "`F ⊆ ℝ` a real number field, `L = F(i)`, `U = U_F` … `E = ⋃_S (T + A + Fin_S)`" | queue §2, lines 53–55 | match in substance; the brief writes "`R̂` its Pontryagin dual" and "`A` the archimedean ones" where the queue has "`R̂` its dual" and "`A(R_F)`" — no change of meaning |
| Einsiedler–Fish, ETDS 30 (2010) 151–157 | queue §2 line 70 (Zbl 1189.37005) | match |

Einsiedler–Fish main theorem, verbatim (Thm 1.2, p. 1 of arXiv:0804.3586v2, read in full, all 8 pp.): "Let α > 0 and let Σ ⊂ N be a
multiplicative semigroup with lim inf_{N→∞} #(Σ ∩ [1, N])/N^α > 0. Let µ be an ergodic Σ-invariant Borel probability measure on T = R/Z.
Then either µ is supported on a finite number of points or µ is Lebesgue measure." Its zero-entropy half is Lemma 3.2: "Under the
assumptions of Theorem 1.2, if hµ(Tp) = 0 for some p ∈ Σ, then the measure µ has finite support." (Lemma 3.2 uses ergodicity only in its last
line, "By ergodicity, we get that µ has a finite support"; before that it proves µ has atoms carrying ≥ 1/2.)

### 1.2 C0 (standing rule: before any derivation)

**Slip, logged:** I formed a first sketch of the route while reading the paper, before writing these numbers down, so they are a
reconstruction of my reading at the moment I finished the brief, not a sealed prior. At that moment: **P(EF_F⁺ TRUE) ≈ 0.45, P(EF_F TRUE) ≈ 0.55**
(the brief's hard point — a zero-entropy element sees only its own places — looked like it could leave a non-`E` measure at the other split
places; EF_F⁺'s strengthening to `T + A` looked like it could fail on `Fin_S` pieces).

### Fence log

No fenced file opened. `plans/CRUNCH-2026-09-26-x2x3-queue.md`: only §2 (lines 51–101) was printed, after a heading listing
(`grep -n "^## "`), which shows headings only.

### Would-have-searched-here log

(none yet)
